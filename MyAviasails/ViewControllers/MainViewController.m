//
//  MainViewController.m
//  MyAviasails
//
//  Created by Валерий Макрогузов on 13.01.2021.
//

#import "MainViewController.h"
#import "SecondViewController.h"

@interface MainViewController ()

@property UIView *myView;
@property UILabel *myLable;
@property UIButton *muButton;
@property UITextField * myTextField;

@end

@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
}

- (void)configUI {
    [self addView];
    [self addLable];
    [self addTextField];
    [self addButton];
}

- (void)addView {
    UIView *view = [[UIView alloc] init];
    
    view.backgroundColor = [UIColor yellowColor];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.myView = view;
    [self.view addSubview:view];

    [view.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:100].active = YES;
    [view.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [view.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [view.heightAnchor constraintEqualToConstant:100].active = YES;
    view.translatesAutoresizingMaskIntoConstraints = NO;    
}

- (void)addLable {
    UILabel *lable = [[UILabel alloc] init];
    
    lable.text = @"Hello";
    lable.font = [UIFont systemFontOfSize:24 weight:15];
    lable.textColor = [UIColor yellowColor];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.myLable = lable;
    [self.view addSubview:lable];

    [lable.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:20].active = YES;
    [lable.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-20].active = YES;
    [lable.topAnchor constraintEqualToAnchor:self.myView.bottomAnchor constant:30].active = YES;
    [lable.heightAnchor constraintEqualToConstant:50].active = YES;
}

- (void)addTextField {
    UITextField *textFild = [[UITextField alloc] init];
    
    textFild.borderStyle = UITextBorderStyleRoundedRect;
    textFild.placeholder = @"Enter your text ...";
    textFild.font = [UIFont systemFontOfSize:20 weight:15];
    textFild.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.myTextField = textFild;
    [self.view addSubview:textFild];

    [textFild.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:20].active = YES;
    [textFild.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-20].active = YES;
    [textFild.topAnchor constraintEqualToAnchor:self.myLable.bottomAnchor constant:30].active = YES;
    [textFild.heightAnchor constraintEqualToConstant:100].active = YES;
}

- (void)addButton {
    UIButton *button = [[UIButton alloc] init];
    
    [button setTitle:@"next" forState:UIControlStateNormal];
    [button addTarget:nil action:@selector(goToNextViewController) forControlEvents:UIControlEventTouchUpInside];
    button.tintColor = [UIColor yellowColor];
    button.backgroundColor = [UIColor blueColor];
    button.layer.cornerRadius = 10;
    button.clipsToBounds = YES;
    button.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.muButton = button;
    [self.view addSubview:button];

    [button.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [button.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-300].active = YES;
    [button.widthAnchor constraintEqualToConstant:100].active = YES;
    [button.heightAnchor constraintEqualToConstant:50].active = YES;
}

- (void)goToNextViewController {
    SecondViewController *nextVC = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

@end
