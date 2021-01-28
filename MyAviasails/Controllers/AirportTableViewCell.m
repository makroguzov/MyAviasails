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
    self.textLabel.text = airport.code;
    self.detailTextLabel.text = [[airport.name stringByAppendingString:@", "] stringByAppendingString:airport.countryCode];
}

@end
