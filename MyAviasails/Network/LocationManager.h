//
//  LocationManager.h
//  MyAviasails
//
//  Created by Валерий Макрогузов on 04.02.2021.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocationManager : NSObject<CLLocationManagerDelegate>

- (instancetype)initWithComplition:(void (^)(CLLocation *location))complition;
- (CLLocation *)getCurrentLocation;

@end

NS_ASSUME_NONNULL_END
