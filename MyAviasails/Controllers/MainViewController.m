//
//  MainViewController.m
//  MyAviasails
//
//  Created by Валерий Макрогузов on 13.01.2021.
//

#import "MainViewController.h"
#import "ChooseAirportViewController.h"
#import "City.h"
#import "Airport.h"
#import "DataManager.h"
#import "AviasalesAPIManager.h"
#import "LocationManager.h"
#import "TicketsViewController.h"

@interface MainViewController ()


@property (strong, nonatomic) City *destination;
@property (strong, nonatomic) City *departure;
@property (strong, nonatomic, nonnull) City *currentCyty;

@property (strong, nonatomic, nonnull) UITextField *chooseDepartTextField;
@property (strong, nonatomic, nonnull) UITextField *chooseDestTextField;
@property (strong, nonatomic, nonnull) UIButton *addDateButton;
@property (strong, nonatomic, nonnull) UIButton *choosePassangersAndClassButton;
@property (strong, nonatomic, nonnull) UIButton *searchButton;

@property (strong, nonatomic, nonnull) LocationManager *locationManager;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Поиск";

    self.view.backgroundColor = [UIColor blackColor];
    [self setUpUI];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.prefersLargeTitles = YES;
}

- (void)loadData {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Загружаем данные. Определяем местоположение";
    hud.label.numberOfLines = 2;
    
    [[DataManager sharedInstance] loadData:^{
        self.locationManager = [[LocationManager alloc] initWithComplition:^(CLLocation * _Nonnull location) {
            City *nearestCity = [DataManager.sharedInstance getNearestCityTo:location];
            self.currentCyty = nearestCity;
            self.currentCyty.coordinate = location.coordinate;

            [self setCity:self.currentCyty to:LocationTypeDeparture];
            [hud hideAnimated:YES];
        }];
    }];
}

// MARK:- set up UI

- (void)setUpUI {

    // MARK: - textFieldsStackView
    
    UITextField *depTextField = [[UITextField alloc] init];
    [depTextField setLeftViewMode:UITextFieldViewModeAlways];
    [depTextField setLeftView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 70)]];
    [depTextField.heightAnchor constraintEqualToConstant:70].active = YES;
    [depTextField setTextAlignment:NSTextAlignmentLeft];
    [depTextField setTextColor: [UIColor systemGray4Color]];
    [depTextField setTintColor:[UIColor systemGray4Color]];
    
    UIButton *depRightViewButton = [UIButton new];
    [depRightViewButton setImage:[UIImage systemImageNamed:@"location.fill"] forState:UIControlStateNormal];
    [depRightViewButton setTintColor:[UIColor systemBlueColor]];
    [depRightViewButton addTarget:self action:@selector(setCurrentCytyAction) forControlEvents:UIControlEventTouchUpInside];
    [depRightViewButton sizeToFit];
    
    UIView *depRightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,
                                                                 2 * depRightViewButton.frame.size.width,
                                                                     depRightViewButton.frame.size.height)];
    [depRightView addSubview:depRightViewButton];
    depTextField.rightViewMode = UITextFieldViewModeAlways;
    depTextField.rightView = depRightView;
    
    depTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Откуда"
                                                                         attributes:@{
                                                                             NSForegroundColorAttributeName:
                                                                                 [UIColor systemGray2Color],
                                                                             NSFontAttributeName:
                                                                                 [UIFont systemFontOfSize:18]
                                                                         }];
    depTextField.delegate = self;
    self.chooseDepartTextField = depTextField;
    
    
    
    UITextField *destTextField = [[UITextField alloc] init];
    [destTextField setLeftViewMode:UITextFieldViewModeAlways];
    [destTextField setLeftView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 70)]];
    [destTextField.heightAnchor constraintEqualToConstant:70].active = YES;
    [destTextField setTextAlignment:NSTextAlignmentLeft];
    [destTextField setTextColor: [UIColor systemGray4Color]];
    [destTextField setTintColor:[UIColor systemGray4Color]];
        
    UIButton *destRightViewButton = [UIButton new];
    [destRightViewButton setImage:[UIImage systemImageNamed:@"delete.left.fill"] forState:UIControlStateNormal];
    [destRightViewButton setTintColor:[UIColor systemBlueColor]];
    [destRightViewButton addTarget:self action:@selector(resetDestination) forControlEvents:UIControlEventTouchUpInside];
    [destRightViewButton sizeToFit];

    UIView *destRightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,
                                                                 2 * destRightViewButton.frame.size.width,
                                                                     destRightViewButton.frame.size.height)];
    [destRightView addSubview:destRightViewButton];
    destTextField.rightViewMode = UITextFieldViewModeAlways;
    destTextField.rightView = destRightView;

    
    destTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Куда"
                                                                         attributes:@{
                                                                             NSForegroundColorAttributeName:
                                                                                 [UIColor systemGray2Color],
                                                                             NSFontAttributeName:
                                                                                 [UIFont systemFontOfSize:18]
                                                                         }];
    destTextField.delegate = self;
    self.chooseDestTextField = destTextField;
    
    UIStackView *textFieldsStackView = [[UIStackView alloc] init];
    textFieldsStackView.alignment = UIStackViewAlignmentFill;
    textFieldsStackView.distribution = UIStackViewDistributionFill;
    textFieldsStackView.axis = UILayoutConstraintAxisVertical;
    textFieldsStackView.spacing = 0;
    
    textFieldsStackView.layer.cornerRadius = 10;
    textFieldsStackView.backgroundColor = [UIColor whiteColor];

    
    [textFieldsStackView addArrangedSubview:depTextField];
    [textFieldsStackView addArrangedSubview:destTextField];
    
    // MARK: - buttonsStackView
    
    UIButton *addDateButton = [[UIButton alloc] init];
    addDateButton.layer.cornerRadius = 10;
    
    [addDateButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"Выбрать даты"
                                                               attributes: @{
                                                                   NSForegroundColorAttributeName:
                                                                       [UIColor systemGray2Color],
                                                                   NSFontAttributeName:
                                                                       [UIFont systemFontOfSize:14]
                                                               }] forState:UIControlStateNormal];
    
    [addDateButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [addDateButton setImage:[UIImage systemImageNamed:@"calendar"] forState:UIControlStateNormal];
    [addDateButton setBackgroundColor:[UIColor whiteColor]];
    [addDateButton.heightAnchor constraintEqualToConstant:40].active = YES;
    [addDateButton sizeToFit];
    self.addDateButton = addDateButton;

    
    UIButton *choosePassangersAndClassButton = [[UIButton alloc] init];
    choosePassangersAndClassButton.layer.cornerRadius = 10;

    [choosePassangersAndClassButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"Пассажиры и класс"
                                                               attributes: @{
                                                                   NSForegroundColorAttributeName:
                                                                       [UIColor systemGray2Color],
                                                                   NSFontAttributeName:
                                                                       [UIFont systemFontOfSize:14]
                                                               }] forState:UIControlStateNormal];
    
    [choosePassangersAndClassButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [choosePassangersAndClassButton setImage:[UIImage systemImageNamed:@"person"] forState:UIControlStateNormal];
    [choosePassangersAndClassButton setBackgroundColor:[UIColor whiteColor]];
    [choosePassangersAndClassButton.heightAnchor constraintEqualToConstant:40].active = YES;
    [choosePassangersAndClassButton sizeToFit];
    self.choosePassangersAndClassButton = choosePassangersAndClassButton;
    
    UIStackView *buttonsStackView = [[UIStackView alloc] init];
    buttonsStackView.alignment = UIStackViewAlignmentFill;
    buttonsStackView.distribution = UIStackViewDistributionFillProportionally;
    buttonsStackView.axis = UILayoutConstraintAxisHorizontal;
    buttonsStackView.backgroundColor = [UIColor blackColor];
    buttonsStackView.spacing = 10;

    [buttonsStackView addArrangedSubview:addDateButton];
    [buttonsStackView addArrangedSubview:choosePassangersAndClassButton];
    
    // MARK: - mainStackView
    
    UIStackView *mainStackView = [[UIStackView alloc] init];
    [self.view addSubview:mainStackView];

    [mainStackView addArrangedSubview:textFieldsStackView];
    mainStackView.alignment = UIStackViewAlignmentFill;
    mainStackView.distribution = UIStackViewDistributionFill;
    mainStackView.axis = UILayoutConstraintAxisVertical;
    mainStackView.backgroundColor = [UIColor blackColor];
    mainStackView.spacing = 20;
    
    [mainStackView addArrangedSubview:textFieldsStackView];
    //[mainStackView addArrangedSubview:buttonsStackView];
    
    mainStackView.translatesAutoresizingMaskIntoConstraints = NO;
    [mainStackView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:self.view.frame.size.height / 3].active = YES;
    [mainStackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [mainStackView.widthAnchor constraintEqualToConstant:self.view.frame.size.width * 0.8].active = YES;
    
    
    // MARK:- searchButton;

    UIButton *searchButton = [UIButton new];
    [self.view addSubview:searchButton];
    
    searchButton.backgroundColor = [UIColor whiteColor];
    searchButton.layer.cornerRadius = 20;
    
    [searchButton setEnabled:NO];
    [searchButton setTitle:@"Найти билеты" forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [searchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    
    searchButton.translatesAutoresizingMaskIntoConstraints = NO;
    [searchButton.topAnchor constraintEqualToAnchor:mainStackView.bottomAnchor constant:30].active = YES;
    [searchButton.widthAnchor constraintEqualToConstant:self.view.frame.size.width * 0.8].active = YES;
    [searchButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [searchButton.heightAnchor constraintEqualToConstant:60].active = YES;

    self.searchButton = searchButton;
}

// MARK: Actions

- (void)setCurrentCytyAction{
    [self setCity:self.currentCyty to:LocationTypeDeparture];
}

- (void)resetDestination {
    self.destination = nil;
    self.chooseDestTextField.attributedText = nil;
    self.chooseDestTextField.text = nil;
}

- (void)searchButtonDidTap:(UIButton *)sender {
    [[AviasalesAPIManager sharedInstance] ticketsWithRequest:[self getSearchRequest]
                                              withCompletion:^(NSArray *tickets) {
        if (tickets.count > 0) {
            TicketsViewController *ticketsVC = [[TicketsViewController alloc] initWithTickets:tickets];
            [self.navigationController pushViewController:ticketsVC animated:YES];
        } else {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Увы!"
                                                                                     message:@"По данному направлению билетов не найдено"
                                                                              preferredStyle: UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"Закрыть" style:(UIAlertActionStyleDefault) handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
}

- (SearchRequest)getSearchRequest {
    SearchRequest searchRequest;
    searchRequest.origin = self.departure.code;
    searchRequest.destionation = self.destination.code;
    searchRequest.departDate = nil;
    searchRequest.returnDate = nil;
    return searchRequest;
}

// MARK:- TextFIeld delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    LocationType type;
    
    if (textField == self.chooseDestTextField) {
        type = LocationTypeDestination;
    } else {
        type = LocationTypeDeparture;
    }

    ChooseAirportViewController *vc = [[ChooseAirportViewController alloc]
                                       initWithChoosenAirportType:type startLoc:self.departure];
    vc.delegate = self;
    
    [self.navigationController pushViewController:vc animated:YES];
    return NO;
}

// MARK:- ChoosenCityRepresentable protocol

- (void)setCity:(City *)city to:(LocationType)type {
    switch (type) {
        case LocationTypeDeparture:
            self.departure = city;
            [self addLeftLableViewToTextField:self.chooseDepartTextField withText:[NSMutableString stringWithString: @"from"]];
            [self writeCity:city to:self.chooseDepartTextField];
            break;
            
        case LocationTypeDestination:
            self.destination = city;
            [self addLeftLableViewToTextField:self.chooseDestTextField withText:[NSMutableString stringWithString: @"to"]];
            [self writeCity:city to:self.chooseDestTextField];
            break;
        case LocationTypeNone:
            break;
    }
    
    if (self.departure && self.destination) {
        [self.searchButton setEnabled:YES];
    }
}

- (void)addLeftLableViewToTextField:(UITextField *)textField withText:(NSMutableString *)text {
    UILabel *lable = [UILabel new];
    
    [text appendString:@": "];
    lable.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithString:text]
                                                           attributes:@{
                                                               NSForegroundColorAttributeName:
                                                                   [UIColor systemGray2Color],
                                                               NSFontAttributeName:
                                                                   [UIFont systemFontOfSize:12]
                                                           }];
    [lable sizeToFit];
    
    CGFloat padding = 10;
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,
                                                                lable.frame.size.width + 1.5 * padding,
                                                                lable.frame.size.height)];
    lable.frame = CGRectMake(padding, 0,
                             lable.frame.size.width,
                             lable.frame.size.height);
    [leftView addSubview:lable];
    textField.leftView = leftView;
}

-(void)writeCity:(City *)city to:(UITextField *)textField {
    textField.attributedText = [[NSAttributedString alloc] initWithString:city.name
                                                               attributes: @{
                                                                   NSForegroundColorAttributeName:[UIColor blackColor],
                                                                   NSFontAttributeName:[UIFont systemFontOfSize:18]
                                                               }];
}

@end
