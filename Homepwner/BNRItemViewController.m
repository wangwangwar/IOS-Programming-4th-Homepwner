//
//  BNRItemViewController.m
//  Homepwner
//
//  Created by wangwangwar on 14/10/27.
//  Copyright (c) 2014年 wangwangwar. All rights reserved.
//

#import "BNRItemViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemViewController()

@property (nonatomic, strong) IBOutlet UIView *headerView;

@end

@implementation BNRItemViewController

- (instancetype)init {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        for (int i = 0; i < 5; i++) {
            [[BNRItemStore sharedStore] createItem];
        }
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [self init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[BNRItemStore sharedStore] allItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *item = items[indexPath.row];
    
    cell.textLabel.text = [item description];
    
    return cell;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[NSBundle mainBundle] loadNibNamed:@"HeaderView"
                                      owner:self
                                                 options:nil][0];
    }
    return _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    [self.tableView setTableHeaderView:self.headerView];
}

- (IBAction)addNewItem:(id)sender {
    
}

- (IBAction)toggleEditingMode:(id)sender {
    
}

@end
