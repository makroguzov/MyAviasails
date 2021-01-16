//
//  MainViewController.m
//  MyAviasails
//
//  Created by Валерий Макрогузов on 13.01.2021.
//

#import "MainViewController.h"

#define ROW_HEIGHT 70
#define BUTTONS_HEIGHT 50

@interface MainViewController ()

@property (strong, nonatomic, nonnull) UIButton *chooseDepartButton;
@property (strong, nonatomic, nonnull) UIButton *chooseDestButton;
@property (strong, nonatomic, nonnull) UIButton *addDateButton;
@property (strong, nonatomic, nonnull) UIButton *choosePassangersAndClassButton;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor lightGrayColor];
    [self setUpUI];
}

-(void)setUpUI {
    UIButton *destButt = [[UIButton alloc] init];
    [destButt.heightAnchor constraintEqualToConstant:70].active = YES;
    [self setUpChosoeDestButton:destButt];
    
    
    UIButton *depButt = [[UIButton alloc] init];
    [depButt.heightAnchor constraintEqualToConstant:70].active = YES;
    [self setUpChooseDepartButton:depButt];
    
    
    UIStackView *subStack = [[UIStackView alloc] init];
    [subStack.heightAnchor constraintEqualToConstant:50].active = YES;
    [self setUpSubStackView:subStack];

    
    UIStackView *mainStackView = [[UIStackView alloc] init];
    [self setUpMainStackView:mainStackView];
    [self.view addSubview:mainStackView];

    [mainStackView addArrangedSubview:depButt];
    [mainStackView addArrangedSubview:destButt];
    [mainStackView addArrangedSubview:subStack];
    
    mainStackView.translatesAutoresizingMaskIntoConstraints = NO;
    [mainStackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [mainStackView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    [mainStackView.widthAnchor constraintEqualToConstant:self.view.frame.size.width * 0.8].active = YES;
}

-(void)setUpChooseDepartButton:(UIButton *) button {
    self.chooseDepartButton = button;
    
    [button setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
    [button setTitleColor:[UIColor systemGray4Color] forState:normal];
    [button setTitle:@"Откуда" forState:UIControlStateNormal];
}

-(void)setUpChosoeDestButton:(UIButton *) button {
    self.chooseDestButton = button;

    [button setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
    [button setTitleColor:[UIColor systemGray4Color] forState:normal];
    [button setTitle:@"Куда" forState:UIControlStateNormal];
}

-(void)setUpSubStackView:(UIStackView *) stackView {
    stackView.alignment = UIStackViewAlignmentFill;
    stackView.distribution = UIStackViewDistributionFill;
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.spacing = 5;
    
    UIButton *addDateButton = [[UIButton alloc] init];
    [self setUpAddDateButton:addDateButton];
    
    UIButton *chosePassangersAndClassButton = [[UIButton alloc] init];
    [self setUpChoosePassangersAndClassButton:chosePassangersAndClassButton];
    
    
    [stackView addArrangedSubview:addDateButton];
    [stackView addArrangedSubview:chosePassangersAndClassButton];
}

-(void)setUpAddDateButton:(UIButton *) button {
    self.addDateButton = button;
    
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    [button setTitleColor:[UIColor systemGray4Color] forState:normal];
    [button setTitle:@"Выбрать даты" forState:UIControlStateNormal];
    [button setImage:[UIImage systemImageNamed:@"calendar"] forState:UIControlStateNormal];
}

-(void)setUpChoosePassangersAndClassButton:(UIButton *) button {
    self.choosePassangersAndClassButton = button;
    
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    [button setTitleColor:[UIColor systemGray4Color] forState:normal];
    [button setTitle:@"Пассажиры и класс" forState:UIControlStateNormal];
    [button setImage:[UIImage systemImageNamed:@"person"] forState:UIControlStateNormal];
}

-(void)setUpMainStackView:(UIStackView *) stackView {
    stackView.alignment = UIStackViewAlignmentFill;
    stackView.distribution = UIStackViewDistributionFill;
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.spacing = 0;
    
    stackView.layer.cornerRadius = 10;
    stackView.backgroundColor = [UIColor whiteColor];
}

@end
