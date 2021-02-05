//
//  TicketsViewController.h
//  MyAviasails
//
//  Created by Валерий Макрогузов on 07.02.2021.
//

#import <UIKit/UIKit.h>

#import "TicketsViewControllerCell.h"


#define IDENTIFIER @"TicketsViewControllerCell"

NS_ASSUME_NONNULL_BEGIN

@interface TicketsViewController : UITableViewController

- (instancetype)initWithTickets:(NSArray *)tickets;

@end

NS_ASSUME_NONNULL_END
