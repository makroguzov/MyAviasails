//
//  ChooseAirportViewController.h
//  MyAviasails
//
//  Created by Валерий Макрогузов on 16.01.2021.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "MainViewController.h"
#import "ResultsPresenterTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ChoosenCityRepresentable;

@interface ChooseAirportViewController : UIViewController<UISearchResultsUpdating, ChoosenCityRepresentable, MKMapViewDelegate>

@property(nonatomic,weak) id<ChoosenCityRepresentable> delegate;

- (instancetype)initWithChoosenAirportType:(LocationType)chousenAirportType startLoc:(City *) city;

@end

NS_ASSUME_NONNULL_END
