//
//  TicketsViewControllerCell.h
//  MyAviasails
//
//  Created by Валерий Макрогузов on 07.02.2021.
//

#import <UIKit/UIKit.h>

#import "Ticket.h"

NS_ASSUME_NONNULL_BEGIN

@interface TicketsViewControllerCell : UITableViewCell

- (void)setUpWithTicket:(Ticket *)ticket;

@end

NS_ASSUME_NONNULL_END
