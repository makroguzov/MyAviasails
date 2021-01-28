//
//  AirportTableViewCell.m
//  MyAviasails
//
//  Created by Валерий Макрогузов on 16.01.2021.
//

#import "AirportTableViewCell.h"
#import "Airport.h"

@implementation AirportTableViewCell

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        [self setUpUI];
    }
    
    return self;
}

-(void) setUpUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.backgroundColor = [UIColor blackColor];
    self.textLabel.textColor = [UIColor whiteColor];
    self.detailTextLabel.textColor = [UIColor whiteColor];
}

- (void)setUpWithAirport:(Airport *)airport {
    self.textLabel.text = [[airport.name stringByAppendingString:@", "] stringByAppendingString:airport.countryCode];

    UILabel *airportCodeLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    airportCodeLable.attributedText = [[NSAttributedString alloc] initWithString:airport.code
                                                               attributes: @{
                                                                   NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                   NSFontAttributeName:[UIFont systemFontOfSize:20]
                                                               }];

    [self setAccessoryType:UITableViewCellAccessoryNone];
    [self setAccessoryView:airportCodeLable];
}

@end
