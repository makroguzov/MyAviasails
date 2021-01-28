//
//  ChooseAirportViewController.m
//  MyAviasails
//
//  Created by Валерий Макрогузов on 16.01.2021.
//

#import "ChooseAirportViewController.h"
#import "MainViewController.h"
#import "AirportTableViewCell.h"
#import "Airport.h"
#import "DataManager.h"


#define AIRPORT_CELL_REUSE_IDENTIFIER @"airportCellReuseIdentifier"

@interface ChooseAirportViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *airports;
@property (nonatomic) ChoosenAirportType chosenAirportType;

@property (nonatomic, strong) NSArray *searchData;
@property (nonatomic, strong) UISearchController *searchController;

@end

@implementation ChooseAirportViewController


- (instancetype) initWithChoosenAirportType:(ChoosenAirportType) chousenAirportType {
    self = [super init];
    if (self) {
        self.chosenAirportType = chousenAirportType;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self setUpUI];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    self.view.backgroundColor = [UIColor blackColor];
    self.tableView.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBar.prefersLargeTitles = NO;
}


- (void)setUpUI {
    [self setUpTableView];
    [self setUpViewTitle];
    [self setUpSerchController];
}

- (void)setUpViewTitle {
    switch (self.chosenAirportType) {
        case ChoosenAirportTypeDestination:
            self.title = @"Куда";
            break;
            
        case ChoosenAirportTypeDeparture:
            self.title = @"Откуда";
            break;
    }
    
    self.navigationController.navigationBar.titleTextAttributes = @{
        NSForegroundColorAttributeName: [UIColor whiteColor]
    };
}

- (void)setUpSerchController {
    UISearchController *searchController = [[UISearchController alloc] init];
    searchController.searchResultsUpdater = self;
    searchController.obscuresBackgroundDuringPresentation = NO;
    searchController.searchBar.placeholder = @"search ...";
    searchController.searchBar.hidden = NO;
    
    self.searchController = searchController;
    
    self.navigationItem.searchController = searchController;
    self.navigationItem.hidesSearchBarWhenScrolling = NO;
    self.definesPresentationContext = YES;
}

- (void)setUpTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:AirportTableViewCell.class forCellReuseIdentifier:AIRPORT_CELL_REUSE_IDENTIFIER];
    
    [self.view addSubview:self.tableView];
}

- (void)loadData {
    [DataManager.sharedInstance loadData:^{
        NSArray *airports = [DataManager.sharedInstance airports];
        self.airports = [NSMutableArray arrayWithArray:airports];
        [self.tableView reloadData];
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isFiltering) {
        return self.searchData.count;
    } else {
        return [self.airports count];
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    AirportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AIRPORT_CELL_REUSE_IDENTIFIER];
    if (self != nil) {
        
        if (self.isFiltering) {
            [cell setUpWithAirport:self.searchData[indexPath.row]];
        } else{
            [cell setUpWithAirport:self.airports[indexPath.row]];
        }

        return cell;
    } else {
        return [[UITableViewCell alloc] init];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self.navigationController dismissViewControllerAnimated:YES completion:^{
//        [self.delegate setAirport:self.airports[indexPath.row] to:self.chosenAirportType];
//    }];
    
    [self.delegate setAirport:self.airports[indexPath.row] to:self.chosenAirportType];
    [self.navigationController popViewControllerAnimated:YES];
    //[self.navigationController dismissViewControllerAnimated:YES completion:nil];
    //[self dismissViewControllerAnimated:true completion:nil];
}

- (BOOL)isSearchBarEmpty {
    if (self.searchController.searchBar.text) {
        return NO;
    } else {
        return [self.searchController.searchBar.text compare:@""];
    }
}

- (BOOL)isFiltering {
    return self.searchController.isActive && !self.isSearchBarEmpty;
  }

- (void)updateSearchResultsForSearchController:(nonnull UISearchController *)searchController {
    UISearchBar *searchBar = searchController.searchBar;
    [self filterContentForSearchText:searchBar.text];
}

- (void)filterContentForSearchText:(NSString *)searchText {
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(Airport* evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject.name.lowercaseString containsString:searchText.lowercaseString] ;
    }];
    
    self.searchData = [self.airports filteredArrayUsingPredicate:predicate];
    [self.tableView reloadData];
}

@end
