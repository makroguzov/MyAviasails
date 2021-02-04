//
//  LocationManager.m
//  MyAviasails
//
//  Created by Валерий Макрогузов on 04.02.2021.
//

#import "LocationManager.h"

@interface LocationManager ()

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;
@property (strong, nonatomic) void (^complition)(CLLocation *location);

@end


@implementation LocationManager

- (instancetype)init {
    if (self = [super init]) {
        self.locationManager = [CLLocationManager new];
        self.locationManager.delegate = self;
        
        [self.locationManager requestAlwaysAuthorization];
        return self;
    }
    return self;
}

- (instancetype)initWithComplition:(void (^)(CLLocation *location))complition {
    if (self = [super init]) {
        self.locationManager = [CLLocationManager new];
        self.locationManager.delegate = self;
        self.complition = complition;

        [self.locationManager requestAlwaysAuthorization];
        return self;
    }
    return self;
}

- (void)locationManagerDidChangeAuthorization:(CLLocationManager *)manager {
    if (manager.authorizationStatus == kCLAuthorizationStatusAuthorizedAlways ||
        manager.authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
            [self.locationManager startUpdatingLocation];
        }
    else if (manager.authorizationStatus != kCLAuthorizationStatusNotDetermined) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Упс!"
                                                                                     message:@"Не удалось определить текущий город!"
                                                                              preferredStyle: UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"Закрыть" style:(UIAlertActionStyleDefault) handler:nil]];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if (!self.currentLocation) {
        self.currentLocation = [locations firstObject];
        [self.locationManager stopUpdatingLocation];
        self.complition(self.currentLocation);
    }
}

- (CLLocation *)getCurrentLocation {
    return self.currentLocation;
}

@end
