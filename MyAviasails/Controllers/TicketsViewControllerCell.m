//
//  TicketsViewControllerCell.m
//  MyAviasails
//
//  Created by Валерий Макрогузов on 07.02.2021.
//

#import "TicketsViewControllerCell.h"
#import "DataManager.h"
#import "City.h"

@implementation TicketsViewControllerCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        [self setUpUI];
    }
    
    return self;
}

- (void)setUpUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.backgroundColor = [UIColor whiteColor];
    self.textLabel.textColor = [UIColor blackColor];
    self.detailTextLabel.textColor = [UIColor whiteColor];
}

- (void)setUpWithTicket:(Ticket *)ticket {
    NSMutableAttributedString *str = [NSMutableAttributedString new];
    [str appendAttributedString: [[NSAttributedString alloc] initWithString:@"from: " attributes:@{
        NSForegroundColorAttributeName: [UIColor systemGray2Color],
        NSFontAttributeName: [UIFont systemFontOfSize:14]
    }]];
    
    [str appendAttributedString:[[NSAttributedString alloc] initWithString:[DataManager.sharedInstance getCityByCode:ticket.from].name
                                                                attributes:@{
        NSForegroundColorAttributeName:[UIColor blackColor],
        NSFontAttributeName: [UIFont systemFontOfSize:20]
    }]];

    [str appendAttributedString:[[NSAttributedString alloc] initWithString:@" \n"]];

    [str appendAttributedString: [[NSAttributedString alloc] initWithString:@"to: " attributes:@{
        NSForegroundColorAttributeName: [UIColor systemGray2Color],
        NSFontAttributeName: [UIFont systemFontOfSize:14]
    }]];

    [str appendAttributedString: [[NSAttributedString alloc] initWithString:[DataManager.sharedInstance getCityByCode:ticket.to].name
                                                                 attributes:@{
        NSForegroundColorAttributeName: [UIColor blackColor],
        NSFontAttributeName: [UIFont systemFontOfSize:20]
    }]];
    
    self.textLabel.numberOfLines = 2;
    self.textLabel.attributedText = str;
    
    UILabel *accessoryLable = [UILabel new];
    accessoryLable.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ руб.", ticket.price.stringValue]
                                                                    attributes:@{
        NSForegroundColorAttributeName: [UIColor blackColor],
        NSFontAttributeName: [UIFont systemFontOfSize:20]
    }];
    [accessoryLable sizeToFit];
    
    int padding = 10;
    UIView *accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,
                                                                     accessoryLable.frame.size.width + 1.5 * padding,
                                                                     accessoryLable.frame.size.height)];
    
    accessoryLable.frame = CGRectMake(padding, 0,
                                      accessoryLable.frame.size.width,
                                      accessoryLable.frame.size.height);
    [accessoryView addSubview: accessoryLable];
    self.accessoryView = accessoryView;
}

@end
