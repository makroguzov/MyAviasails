//
//  ChooseAirportViewController.h
//  MyAviasails
//
//  Created by Валерий Макрогузов on 16.01.2021.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChooseAirportViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating>

@property (weak, nonatomic) id<ChoosenAirportRepresentable> delegate;

-(instancetype) initWithChoosenAirportType:(ChoosenAirportType) chousenAirportType;

@end

NS_ASSUME_NONNULL_END
