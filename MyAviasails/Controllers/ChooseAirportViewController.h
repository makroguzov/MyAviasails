//
//  ChooseAirportViewController.h
//  MyAviasails
//
//  Created by Валерий Макрогузов on 16.01.2021.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "ResultsPresenterTableViewController.h"
#import "MainViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChooseAirportViewController : UIViewController<UISearchResultsUpdating>

@property (weak, nonatomic) id<ChoosenAirportRepresentable> delegate;

- (instancetype)initWithChoosenAirportType:(ChoosenAirportType) chousenAirportType startLoc:(City *) city;

@end

NS_ASSUME_NONNULL_END
