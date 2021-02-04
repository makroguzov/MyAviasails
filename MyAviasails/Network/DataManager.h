//
//  DataManager.h
//  MyAviasails
//
//  Created by Валерий Макрогузов on 18.01.2021.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Country.h"
#import "City.h"
#import "Airport.h"

NS_ASSUME_NONNULL_BEGIN

#define kDataManagerLoadDataDidComplete @"DataManagerLoadDataDidComplete"

typedef enum DataSourceType {
    DataSourceTypeCountry,
    DataSourceTypeCity,
    DataSourceTypeAirport
} DataSourceType;


typedef struct SearchRequest {
    __unsafe_unretained NSString *origin;
    __unsafe_unretained NSString *destionation;
    __unsafe_unretained NSDate *departDate;
    __unsafe_unretained NSDate *returnDate;
} SearchRequest;


@interface DataManager : NSObject

+ (instancetype)sharedInstance;
- (void)loadData:(void (^)(void))complition;

- (City *)cityForIATA:(NSString *)iata;

- (Country *)getCountryBy:(NSString *)code;
- (City *)getCityBy:(NSString *)code;

- (City *)getNearestCityTo:(CLLocation *)location;

@property (nonatomic, strong, readonly) NSArray *countries;
@property (nonatomic, strong, readonly) NSArray *cities;
@property (nonatomic, strong, readonly) NSArray *airports;

@end

NS_ASSUME_NONNULL_END
