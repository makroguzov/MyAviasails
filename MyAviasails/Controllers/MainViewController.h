//
//  MainViewController.h
//  MyAviasails
//
//  Created by Валерий Макрогузов on 13.01.2021.
//

#import <UIKit/UIKit.h>

@class Airport;

typedef enum {
    ChoosenAirportTypeDestination,
    ChoosenAirportTypeDeparture
    
} ChoosenAirportType;

@protocol ChoosenAirportRepresentable <NSObject>

@required
-(void)setAirport:(Airport *) airport to:(ChoosenAirportType) type;

@end



@interface MainViewController: UIViewController<UITextFieldDelegate, ChoosenAirportRepresentable>

@end

