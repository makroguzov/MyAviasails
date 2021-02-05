//
//  ChooseAirportViewController.m
//  MyAviasails
//
//  Created by Валерий Макрогузов on 16.01.2021.
//

#import "ChooseAirportViewController.h"
#import "Airport.h"
#import "MapPrice.h"

#import "AviasalesAPIManager.h"
#import "DataManager.h"

@interface ChooseAirportViewController ()

@property (nonatomic) LocationType locationType;
@property (nonatomic) City *currentLocation;
@property (strong, nonatomic) MKMapView *mapView;

@end

@implementation ChooseAirportViewController

- (UISegmentedControl *)segmentControl {
    return (UISegmentedControl *) self.navigationItem.titleView;
}


- (instancetype) initWithChoosenAirportType:(LocationType)chousenAirportType startLoc:(City *) city {
    self = [super init];
    if (self) {
        self.locationType = chousenAirportType;
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
    [self addCurentLocation];
    
    if (self.locationType == LocationTypeDestination) {
        [self addMapPrices];
    } else if (self.locationType == LocationTypeDeparture) {
        [self addCities];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.mapView removeAnnotations:self.mapView.annotations];
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
    self.mapView.delegate = self;
    
    [self.mapView setRegion:[self getRegion] animated: YES];
    [self.view addSubview:self.mapView];
}

- (MKCoordinateRegion)getRegion {
    if (self.locationType == LocationTypeDestination) {
        return MKCoordinateRegionMakeWithDistance(self.currentLocation.coordinate, 1000000, 100000);
    } else {
        return MKCoordinateRegionMakeWithDistance(self.currentLocation.coordinate, 10000, 10000);
    }
}

- (void)addCities {
    for (City *city in DataManager.sharedInstance.cities) {
        NSDictionary *cityDict = @{@"city": city};
        [self addAnnotation:cityDict];
    }
}

- (void)addMapPrices {
    [[AviasalesAPIManager sharedInstance] mapPricesFor:self.currentLocation withCompletion:^(NSArray *prices) {
        for (MapPrice *mapPrice in prices) {
            if (!mapPrice.destination) {
                continue;
            }
            
            NSMutableDictionary *annotationDict = [NSMutableDictionary dictionaryWithDictionary:@{@"city": mapPrice.destination}];
            if (mapPrice.value) {
                [annotationDict setObject:[NSString stringWithFormat:@"%ld", mapPrice.value] forKey:@"price"];
            }

            [self addAnnotation:annotationDict];
        }
    }];
}

- (void)addAnnotation:(NSDictionary*) element {
    City *city = [element objectForKey:@"city"];
    NSString *price = [element objectForKey:@"price"];
        
    if ( city && city.code != self.currentLocation.code) {
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        annotation.title = city.name;
        annotation.coordinate = city.coordinate;
            
        if (price) {
            annotation.subtitle = [NSString stringWithFormat:@"%@ руб.", price];
        }
        
        [self.mapView addAnnotation:annotation];
    }
}

- (void)addCurentLocation {
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.title = self.currentLocation.name;
    annotation.coordinate = self.currentLocation.coordinate;
    [self.mapView addAnnotation:annotation];
}

- (void)setUpViewTitle {
    switch (self.locationType) {
        case LocationTypeDestination:
            self.title = @"Куда";
            break;
            
        case LocationTypeDeparture:
            self.title = @"Откуда";
            break;
        case LocationTypeNone:
            break;
    }
    
    self.navigationController.navigationBar.titleTextAttributes = @{
        NSForegroundColorAttributeName: [UIColor whiteColor]
    };
}

- (void)setUpSerchController {
    
    ResultsPresenterTableViewController *presenter = [[ResultsPresenterTableViewController alloc]
                                                      initWithDelegate:self andNavigationController:self.navigationController];
    
    UISearchController *searchController = [[UISearchController alloc]
                                            initWithSearchResultsController:presenter];
    searchController.searchResultsUpdater = self;
    searchController.searchBar.placeholder = @"search ...";
        
    self.navigationItem.searchController = searchController;
    
    
    
    self.navigationItem.titleView = [[UISegmentedControl alloc] initWithItems:@[@"Города", @"Аэропорты"]];
    self.segmentControl.tintColor = [UIColor whiteColor];
    self.segmentControl.selectedSegmentIndex = 0;
}

// MARK:- MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    static NSString *identifier = @"MarkerIdentifier";
    
    MKMarkerAnnotationView *annotationView = (MKMarkerAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!annotationView) {
        annotationView = [[MKMarkerAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        
        annotationView.canShowCallout = YES;
        annotationView.calloutOffset = CGPointMake(-5.0, 5.0);
        
        UIButton *accessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
        annotationView.rightCalloutAccessoryView = accessoryView;
    }
    
    annotationView.annotation = annotation;
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    City *selectedCity = [DataManager.sharedInstance getNearestCityTo:[[CLLocation alloc]
                                                                       initWithLatitude:view.annotation.coordinate.latitude
                                                                       longitude:view.annotation.coordinate.longitude]];
    [self setCity:selectedCity to:LocationTypeNone];
    [self.navigationController popToRootViewControllerAnimated:YES];
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
    ResultsPresenterTableViewController *resultsPresenter = (ResultsPresenterTableViewController*) self.navigationItem.searchController.searchResultsController;
    [resultsPresenter updateWith:[self getFilteredResultsWith:searchText]];
}

- (NSArray *)getFilteredResultsWith:(NSString *)searchText {
    NSArray *results;
    
    switch (self.segmentControl.selectedSegmentIndex) {
        case 0: {
            NSArray *cities = DataManager.sharedInstance.cities;
            results = [cities filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:
                                                                          ^BOOL(City* city, NSDictionary<NSString *,id> * _Nullable bindings) {
                return [city.name.lowercaseString containsString:searchText.lowercaseString] ;
            }]];
            break;
        }
        case 1: {
            NSArray *airports = DataManager.sharedInstance.airports;
            results = [airports filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:
                                                                          ^BOOL(Airport* airport, NSDictionary<NSString *,id> * _Nullable bindings) {
                return [airport.name.lowercaseString containsString:searchText.lowercaseString] ;
            }]];
            break;
        }
    }
    return results;
}

// MARK:- ChoosenCityRepresentable
- (void)setCity:(City *)city to:(LocationType)type {
    [self.delegate setCity:city to:self.locationType];
}

@end
