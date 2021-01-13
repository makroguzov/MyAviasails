//
//  SecondViewController.m
//  MyAviasails
//
//  Created by Валерий Макрогузов on 13.01.2021.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@property UITextView *mytextView;
@property UIImageView *myImageView;

@property UIStackView *muStackView;
@property UISegmentedControl *mySegmentedControl;
@property UISlider *mySlider;
@property UIActivityIndicatorView *myActivityIndicatorView;
@property UIProgressView *myProgressView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configUI];
}

-(void)configUI {
    [self addTextView];
    [self addImageView];
    [self addStackView];
}

-(void)addTextView {
    UITextView *textView = [[UITextView alloc] init];
        
    textView.font = [UIFont systemFontOfSize:20 weight:15];
    textView.backgroundColor = [UIColor blueColor];
    textView.textColor = [UIColor whiteColor];
    textView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.mytextView = textView;
    [self.view addSubview:textView];

    [textView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [textView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:100].active = YES;
    [textView.heightAnchor constraintEqualToConstant:300].active = YES;
    [textView.widthAnchor constraintEqualToConstant:self.view.frame.size.width / 2].active = YES;
}

-(void)addImageView {
    UIImageView *imageView = [[UIImageView alloc] init];
    
    imageView.backgroundColor = [UIColor lightGrayColor];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView setImage: [UIImage systemImageNamed:@"aqi.low"]];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;

    self.myImageView = imageView;
    [self.view addSubview:imageView];

    [imageView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [imageView.topAnchor constraintEqualToAnchor:self.mytextView.topAnchor].active = YES;
    [imageView.leftAnchor constraintEqualToAnchor:self.mytextView.rightAnchor].active = YES;
    [imageView.heightAnchor constraintEqualToAnchor:self.mytextView.heightAnchor].active = YES;
}

-(void)addStackView {
    UIStackView *stackView = [[UIStackView alloc] init];
    
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.alignment = UIStackViewAlignmentFill;
    stackView.distribution = UIStackViewDistributionEqualSpacing;
    stackView.spacing = 10;
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
     
    [self addSegmentedControlTo:stackView];
    [self addSliderTo:stackView];
    [self addActivityIndicatorViewTo:stackView];
    [self addProgressViewTo:stackView];
    
    self.muStackView =stackView;
    [self.view addSubview:stackView];

    [stackView.topAnchor constraintEqualToAnchor:self.myImageView.bottomAnchor constant:100].active = YES;
    [stackView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:40].active = YES;
    [stackView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-40].active = YES;
    [stackView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-200].active = YES;
}

-(void)addSegmentedControlTo:(UIStackView *)stackView {
    UISegmentedControl *segControl = [[UISegmentedControl alloc] initWithItems:@[@"YES", @"NO"]];
   
    segControl.tintColor = [UIColor yellowColor];
    segControl.selectedSegmentIndex = 0;
    
    self.mySegmentedControl = segControl;
    [stackView addArrangedSubview:segControl];
}

-(void)addSliderTo:(UIStackView *)stackView {
    UISlider *slider = [[UISlider alloc] init];
    
    slider.value = 0.5;
    slider.tintColor = [UIColor yellowColor];
    
    self.mySlider = slider;
    [stackView addArrangedSubview:slider];
}

-(void)addActivityIndicatorViewTo:(UIStackView *)stackView {
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] init];
    
    activityIndicator.frame = CGRectMake(0, 0, 20, 100);
    activityIndicator.hidesWhenStopped = YES;
    [activityIndicator startAnimating];
    
    self.myActivityIndicatorView = activityIndicator;
    [stackView addArrangedSubview: activityIndicator];
}

-(void)addProgressViewTo:(UIStackView *)stackView {
    UIProgressView *progressView = [[UIProgressView alloc] init];
    
    progressView.progress = 0.8;
    progressView.tintColor = [UIColor yellowColor];
    
    self.myProgressView = progressView;
    [stackView addArrangedSubview:progressView];
}

@end
