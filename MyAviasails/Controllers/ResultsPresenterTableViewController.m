//
//  ResultsPresenterTableViewController.m
//  MyAviasails
//
//  Created by Валерий Макрогузов on 04.02.2021.
//

#import "ResultsPresenterTableViewController.h"

@interface ResultsPresenterTableViewController ()

@property(nonatomic, strong) NSArray *results;

@end

@implementation ResultsPresenterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setUpTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.prefersLargeTitles = NO;
}

- (void)updateWith:(NSArray *)results {
    self.results = results;
    [self.tableView reloadData];
}

- (void)setUpTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        
    self.tableView.rowHeight = 50;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor blackColor];

    [self.tableView registerClass:AirportTableViewCell.class forCellReuseIdentifier:AIRPORT_CELL_REUSE_IDENTIFIER];
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
@end
