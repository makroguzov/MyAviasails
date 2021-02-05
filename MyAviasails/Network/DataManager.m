//
//  DataManager.m
//  MyAviasails
//
//  Created by Валерий Макрогузов on 18.01.2021.
//

#import "DataManager.h"

@interface DataManager()

@property (nonatomic, strong) NSMutableArray *countriesArray;
@property (nonatomic, strong) NSMutableArray *citiesArray;
@property (nonatomic, strong) NSMutableArray *airportsArray;
@end


@implementation DataManager

+ (instancetype)sharedInstance {
    static DataManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DataManager alloc] init];
    });
    
    return instance;
}

- (void)loadData:(void (^)(void))complition {
    if (![self isExistData]) {
        [self loadNewData:complition];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            complition();
        });
    }
}

- (BOOL)isExistData {
    return self.countries.count != 0 && self.cities.count != 0 && self.airports.count != 0;
}

- (void)loadNewData:(void (^)(void))complition {
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), ^{
                
        NSArray *countriesJsonArray = [self arrayFromFileName:@"countries" ofType:@"json"];
        self.countriesArray = [self createObjectsFromArray:countriesJsonArray withType: DataSourceTypeCountry];
        
        NSArray *citiesJsonArray = [self arrayFromFileName:@"cities" ofType:@"json"];
        self.citiesArray = [self createObjectsFromArray:citiesJsonArray withType: DataSourceTypeCity];
        
        NSArray *airportsJsonArray = [self arrayFromFileName:@"airports" ofType:@"json"];
        self.airportsArray = [self createObjectsFromArray:airportsJsonArray withType: DataSourceTypeAirport];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:kDataManagerLoadDataDidComplete object:nil];
        });
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            complition();
        });
        
        NSLog(@"Complete load data");
    });
}


- (NSMutableArray *)createObjectsFromArray:(NSArray *)array withType:(DataSourceType)type {
    NSMutableArray *results = [NSMutableArray new];
    
    for (NSDictionary *jsonObject in array) {
        if (type == DataSourceTypeCountry) {
            Country *country = [[Country alloc] initWithDictionary: jsonObject];
            [results addObject: country];
        }
        else if (type == DataSourceTypeCity) {
            City *city = [[City alloc] initWithDictionary: jsonObject];
            [results addObject: city];
        }
        else if (type == DataSourceTypeAirport) {
            Airport *airport = [[Airport alloc] initWithDictionary: jsonObject];
            [results addObject: airport];
        }
    }
    
    return results;
}

- (NSArray *)arrayFromFileName:(NSString *)fileName ofType:(NSString *)type {
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:type];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
}

- (NSArray *)countries {
    return _countriesArray;
}

- (NSArray *)cities {
    return _citiesArray;
}

- (NSArray *)airports {
    return _airportsArray;
}

- (Country *)getCountryByCode:(NSString *)code {
    return [self.countries filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(Country * _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject.code isEqual:code];
    }]].firstObject;
}

- (City *)getCityByCode:(NSString *)code {
    return [self.cities filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(City*  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject.code isEqual:code];
    }]].firstObject;
}


- (City *)getNearestCityTo:(CLLocation *)location {
    return [self.cities sortedArrayUsingComparator:^NSComparisonResult(City*  _Nonnull obj1, City*  _Nonnull obj2) {
        NSNumber *dist1 = [[NSNumber alloc] initWithDouble:[[[CLLocation alloc] initWithLatitude:obj1.coordinate.latitude longitude:obj1.coordinate.longitude] distanceFromLocation:location]];
        NSNumber *dist2 = [[NSNumber alloc] initWithDouble:[[[CLLocation alloc] initWithLatitude:obj2.coordinate.latitude longitude:obj2.coordinate.longitude] distanceFromLocation:location]];
        return [dist1 compare:dist2];
    }].firstObject;
}

- (City *)cityForIATA:(NSString *)iata {
    if (iata) {
        for (City *city in _citiesArray) {
            if ([city.code isEqualToString:iata]) {
                return city;
            }
        }
    }
    
    return nil;
}

@end
