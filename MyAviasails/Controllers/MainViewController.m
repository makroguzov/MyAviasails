//
//  MainViewController.m
//  MyAviasails
//
//  Created by Валерий Макрогузов on 13.01.2021.
//

#import "MainViewController.h"
#import "ChooseAirportViewController.h"
#import "City.h"

@interface MainViewController ()

@property (strong, nonatomic, nonnull) UITextField *chooseDepartTextField;
@property (strong, nonatomic, nonnull) UITextField *chooseDestTextField;
@property (strong, nonatomic, nonnull) UIButton *addDateButton;
@property (strong, nonatomic, nonnull) UIButton *choosePassangersAndClassButton;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];

    [self setUpUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    //[self.navigationController.navigationBar setTranslucent:YES];
    
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.title = @"Поиск";
    [self hideNavigationBar];
}

// MARK:- set up UI

-(void)setUpUI {

    // MARK: - textFieldsStackView
    
    UITextField *depTextField = [[UITextField alloc] init];
    [depTextField setLeftViewMode:UITextFieldViewModeAlways];
    [depTextField setLeftView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 70)]];
    [depTextField.heightAnchor constraintEqualToConstant:70].active = YES;
    [depTextField setTextAlignment:NSTextAlignmentLeft];
    [depTextField setTextColor: [UIColor systemGray4Color]];
    [depTextField setTintColor:[UIColor systemGray4Color]];
    
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
    [mainStackView addArrangedSubview:buttonsStackView];
    
    mainStackView.translatesAutoresizingMaskIntoConstraints = NO;
    [mainStackView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:self.view.frame.size.height / 3].active = YES;
    [mainStackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    //[mainStackView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    [mainStackView.widthAnchor constraintEqualToConstant:self.view.frame.size.width * 0.8].active = YES;
}


-(void)hideNavigationBar {
    [self.navigationController setToolbarHidden:YES animated:YES];
}

// MARK:- TextFIeld delegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    ChoosenAirportType type;
    if (textField == self.chooseDestTextField) {
        type = ChoosenAirportTypeDestination;
    } else {
        type = ChoosenAirportTypeDeparture;
    }

    ChooseAirportViewController *vc = [[ChooseAirportViewController alloc] initWithChoosenAirportType:type];
    vc.delegate = self;
    
    //[self.navigationController presentViewController:vc animated:YES completion:nil];
    //[self.navigationController popViewControllerAnimated:YES];
    [self.navigationController pushViewController:vc animated:YES];
    return NO;
}

// MARK:- ChoosenAirportRepresentable protocol

-(void)setAirport:(Airport *)airport to:(ChoosenAirportType)type {
    switch (type) {
        case ChoosenAirportTypeDeparture:
            break;
            
        case ChoosenAirportTypeDestination:
            break;
    }
}

@end
