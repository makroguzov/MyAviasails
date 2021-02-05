//
//  AirportTableViewCell.m
//  MyAviasails
//
//  Created by Валерий Макрогузов on 16.01.2021.
//

#import "AirportTableViewCell.h"
#import "City.h"
#import "DataManager.h"

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

- (void)setUpWithCity:(City *)city {
    self.textLabel.text = city.name;
    
    Country *currentCountry = [DataManager.sharedInstance getCountryByCode:city.countryCode];
    self.detailTextLabel.text = currentCountry.name;
    

    UILabel *cityCodeLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    cityCodeLable.attributedText = [[NSAttributedString alloc] initWithString:city.code
                                                               attributes: @{
                                                                   NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                   NSFontAttributeName:[UIFont systemFontOfSize:20]
                                                               }];

    [self setAccessoryType:UITableViewCellAccessoryNone];
    [self setAccessoryView:cityCodeLable];
    [self.accessoryView sizeToFit];
}

@end
