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

@property (nonatomic) NSMutableArray *itemsWorthMoreThan50;
@property (nonatomic) NSMutableArray *itemsOther;

@end

@implementation BNRItemViewController

- (instancetype)init {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        for (int i = 0; i < 5; i++) {
            [[BNRItemStore sharedStore] createItem];
        }
    }
    
    NSArray *allItems = [[BNRItemStore sharedStore] allItems];
    self.itemsWorthMoreThan50 = [NSMutableArray new];
    self.itemsOther = [NSMutableArray new];
    
    // Separate them into ">50" and "other"
    for (int i = 0; i < [allItems count]; i++) {
        BNRItem *item = [allItems objectAtIndex:i];
        NSLog(@"%@ %d", item, [item valueInDollars]);
        if ([item valueInDollars] > 50) {
            [self.itemsWorthMoreThan50 addObject:item];
        } else {
            [self.itemsOther addObject:item];
        }
    }
    
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [self init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [self.itemsWorthMoreThan50 count];
    } else {
        return [self.itemsOther count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    BNRItem *item;
    if (indexPath.section == 0) {
        item = self.itemsWorthMoreThan50[indexPath.row];
    } else {
        item = self.itemsOther[indexPath.row];
    }
    
    cell.textLabel.text = [item description];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return @[@">50", @"other"];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @">50";
    } else {
        return @"other";
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

@end
