//
//  MainViewController.h
//  MyAviasails
//
//  Created by Валерий Макрогузов on 13.01.2021.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "MBProgressHUD.h"

@class City;

typedef NS_ENUM(NSInteger, LocationType) {
    LocationTypeDestination,
    LocationTypeDeparture,
    LocationTypeNone
};

@protocol ChoosenCityRepresentable <NSObject>

@required
- (void)setCity:(City *)city to:(LocationType)type;

@end

@interface MainViewController: UIViewController<UITextFieldDelegate, ChoosenCityRepresentable>

@end

