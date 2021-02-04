//
//  AirportTableViewCell.h
//  MyAviasails
//
//  Created by Валерий Макрогузов on 16.01.2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class City;

@interface AirportTableViewCell : UITableViewCell

- (void)setUpWithCity:(City *)city;

@end

NS_ASSUME_NONNULL_END
