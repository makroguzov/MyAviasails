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



@interface ChooseAirportViewController ()

@property (nonatomic) ChoosenAirportType chosenAirportType;
@property (nonatomic) City *currentLocation;
@property (strong, nonatomic) MKMapView *mapView;
@end

@implementation ChooseAirportViewController


- (instancetype) initWithChoosenAirportType:(ChoosenAirportType) chousenAirportType startLoc:(City *) city {
    self = [super init];
    if (self) {
        self.chosenAirportType = chousenAirportType;
        self.currentLocation = city;
    }
    
    return self;
}

// MARK:- Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self setUpUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBar.prefersLargeTitles = NO;
    [self addCurentLocation];
    
    if (self.chosenAirportType == ChoosenAirportTypeDestination) {
        [self addAnnotations:DataManager.sharedInstance.cities];
    }
}

// MARK:- Set up UI

- (void)setUpUI {
    [self setUpMap];
    [self setUpViewTitle];
    [self setUpSerchController];
}

- (void)setUpMap {
    CGRect frame = CGRectMake(0, 0,
                              [UIScreen mainScreen].bounds.size.width,
                              [UIScreen mainScreen].bounds.size.height);
    
    self.mapView = [[MKMapView alloc] initWithFrame: frame];
    
    [self.mapView setRegion:[self getRegion] animated: YES];
    [self.view addSubview:self.mapView];
}

- (MKCoordinateRegion)getRegion {
    if (self.chosenAirportType == ChoosenAirportTypeDestination) {
        return MKCoordinateRegionMakeWithDistance(self.currentLocation.coordinate, 1000000, 100000);
    } else {
        return MKCoordinateRegionMakeWithDistance(self.currentLocation.coordinate, 10000, 10000);
    }
}

- (void)addAnnotations:(NSArray *)cities {
    for (City *city in cities) {
        if (city.code != self.currentLocation.code) {
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            annotation.title = city.name;
            annotation.coordinate = city.coordinate;
            [self.mapView addAnnotation:annotation];
        }
    }
}

- (void)addCurentLocation {
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.title = self.currentLocation.name;
    annotation.coordinate = self.currentLocation.coordinate;
    [self.mapView addAnnotation:annotation];
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
    UISearchController *searchController = [[UISearchController alloc]
                                            initWithSearchResultsController:[ResultsPresenterTableViewController new]];
    searchController.searchResultsUpdater = self;
    searchController.searchBar.placeholder = @"search ...";
        
    self.navigationItem.searchController = searchController;
    self.navigationItem.hidesSearchBarWhenScrolling = NO;
}

// MARK:- UISearchResultsUpdating

- (BOOL)isSearchBarEmpty {
    if (self.navigationItem.searchController.searchBar.text) {
        return NO;
    } else {
        return [self.navigationItem.searchController.searchBar.text compare:@""];
    }
}

- (BOOL)isFiltering {
    return self.navigationItem.searchController.isActive && !self.isSearchBarEmpty;
  }

- (void)updateSearchResultsForSearchController:(nonnull UISearchController *)searchController {
    UISearchBar *searchBar = searchController.searchBar;
    [self filterContentForSearchText:searchBar.text];
}

- (void)filterContentForSearchText:(NSString *)searchText {
    NSArray *cities = DataManager.sharedInstance.cities;
    NSArray *results = [cities filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:
                                                                  ^BOOL(City* city, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [city.name.lowercaseString containsString:searchText.lowercaseString] ;
    }]];
    ResultsPresenterTableViewController *resultsPresenter = (ResultsPresenterTableViewController*) self.navigationItem.searchController.searchResultsController;
    [resultsPresenter updateWith:results];
}

@end
