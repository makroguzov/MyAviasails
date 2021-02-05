//
//  ResultsPresenterTableViewController.m
//  MyAviasails
//
//  Created by Валерий Макрогузов on 04.02.2021.
//

#import "ResultsPresenterTableViewController.h"

@interface ResultsPresenterTableViewController ()

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray *results;
@property(nonatomic,strong) UIStackView *noResultsView;
@property(nonatomic,weak) id<ChoosenCityRepresentable> delegate;
@property(nonatomic,weak) UINavigationController *parentNavigationContreller;

@end

@implementation ResultsPresenterTableViewController

- (instancetype)initWithDelegate:(id<ChoosenCityRepresentable>)delegate andNavigationController:(UINavigationController *)navController{
    if (self = [super init]) {
        self.delegate = delegate;
        self.parentNavigationContreller = navController;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setUpTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.prefersLargeTitles = NO;
}

- (void)updateWith:(NSArray *)results {
    [self cleanTableView];
    
    if (results.count != 0) {
        [self.noResultsView setHidden:YES];
        self.results = results;
        [self.tableView reloadData];

    } else {
        if (!self.noResultsView) {
            [self setUpNoResultsCell];
        }
        [self.noResultsView setHidden:NO];
    }
}

- (void)cleanTableView {
    self.results = nil;
    [self.tableView reloadData];
}

- (void)setUpTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        
    self.tableView.delegate = self;
    self.tableView.dataSource= self;
    
    self.tableView.rowHeight = 50;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor blackColor];

    [self.tableView registerClass:AirportTableViewCell.class forCellReuseIdentifier:AIRPORT_CELL_REUSE_IDENTIFIER];
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.results.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    AirportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AIRPORT_CELL_REUSE_IDENTIFIER];
    if (self != nil) {
        [cell setUpWithCity:self.results[indexPath.row]];
        return cell;
    } else {
        return [[UITableViewCell alloc] init];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate setCity:self.results[indexPath.row] to:LocationTypeNone];
    [self.parentNavigationContreller popToRootViewControllerAnimated:YES];
}

- (void)setUpNoResultsCell {
    UILabel *lable = [UILabel new];
    lable.text = @"К сожалению не удалось найти никаких результатов";
    lable.textColor = [UIColor whiteColor];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.numberOfLines = 3;
    
    lable.translatesAutoresizingMaskIntoConstraints = NO;
    [lable.widthAnchor constraintEqualToConstant:self.view.frame.size.width - 200].active = YES;
    [lable sizeToFit];
    
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"motivacia"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [imageView.widthAnchor constraintEqualToConstant:self.view.frame.size.width - 200].active = YES;
    [imageView.heightAnchor constraintEqualToConstant:200].active = YES;
    [imageView sizeToFit];
    
    self.noResultsView = [UIStackView new];
    self.noResultsView.spacing = 20;
    self.noResultsView.axis =  UILayoutConstraintAxisVertical;
   
    [self.noResultsView addSubview:lable];
    [self.noResultsView addSubview:imageView];
    
    [self.view addSubview:self.noResultsView];
    self.noResultsView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.noResultsView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:100].active = YES;
    [self.noResultsView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-100].active = YES;
    [self.noResultsView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:200].active = YES;
    }
@end
