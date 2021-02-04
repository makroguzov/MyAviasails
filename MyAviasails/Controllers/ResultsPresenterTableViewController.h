//
//  ResultsPresenterTableViewController.h
//  MyAviasails
//
//  Created by Валерий Макрогузов on 04.02.2021.
//

#import <UIKit/UIKit.h>

#import "AirportTableViewCell.h"


#define AIRPORT_CELL_REUSE_IDENTIFIER @"airportCellReuseIdentifier"


NS_ASSUME_NONNULL_BEGIN

@interface ResultsPresenterTableViewController : UITableViewController

- (void)updateWith:(NSArray *)results;

@end

NS_ASSUME_NONNULL_END
