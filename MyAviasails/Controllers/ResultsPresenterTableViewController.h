//
//  ResultsPresenterTableViewController.h
//  MyAviasails
//
//  Created by Валерий Макрогузов on 04.02.2021.
//

#import <UIKit/UIKit.h>

#import "AirportTableViewCell.h"
#import "ChooseAirportViewController.h"

#define AIRPORT_CELL_REUSE_IDENTIFIER @"airportCellReuseIdentifier"

NS_ASSUME_NONNULL_BEGIN


@protocol ChoosenCityRepresentable;

@interface ResultsPresenterTableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

- (instancetype)initWithDelegate:(id<ChoosenCityRepresentable>)delegate andNavigationController:(UINavigationController *)navController;
- (void)updateWith:(NSArray *)results;

@end

NS_ASSUME_NONNULL_END
