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

typedef enum {
    ChoosenAirportTypeDestination,
    ChoosenAirportTypeDeparture
    
} ChoosenAirportType;

@protocol ChoosenAirportRepresentable <NSObject>

@required
- (void)setCity:(City *)city to:(ChoosenAirportType)type;

@end



@interface MainViewController: UIViewController<UITextFieldDelegate, ChoosenAirportRepresentable>

@end

