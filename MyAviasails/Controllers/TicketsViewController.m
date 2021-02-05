//
//  TicketsViewController.m
//  MyAviasails
//
//  Created by Валерий Макрогузов on 07.02.2021.
//

#import "TicketsViewController.h"

@interface TicketsViewController ()

@property (nonatomic, nonnull, strong) NSArray *tickets;

@end

@implementation TicketsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setUpUI];
}

- (instancetype)initWithTickets:(NSArray *)tickets {
    if (self = [super initWithStyle:UITableViewStyleInsetGrouped]) {
        self.tickets = tickets;
    }
    return self;
}


- (void)setUpUI {
    self.view.backgroundColor = [UIColor blackColor];
    self.title = @"Билеты";
    self.navigationController.navigationBar.titleTextAttributes = @{
        NSForegroundColorAttributeName: [UIColor whiteColor]
    };
    
    [self setUpTableView];
}

- (void) setUpTableView {
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor blackColor];
    
    [self.tableView registerClass:TicketsViewControllerCell.class forCellReuseIdentifier:IDENTIFIER];
}


// MARK:- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tickets.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TicketsViewControllerCell *cell = [self.tableView dequeueReusableCellWithIdentifier:IDENTIFIER];
    if (cell) {
        [cell setUpWithTicket:self.tickets[indexPath.section]];
        return cell;
    } else {
        return [UITableViewCell new];
    }
}

// MARK:- UITableViewDelegate


@end
