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
#import "BNRDetailViewController.h"
#import "BNRItemCell.h"
#import "BNRImageStore.h"
#import "BNRImageViewController.h"

@interface BNRItemViewController() <UIPopoverControllerDelegate>

@property (nonatomic, strong) UIPopoverController *imagePopover;

@end

@implementation BNRItemViewController

#pragma mark - Initialization

- (instancetype)init {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Homepwner";
        
        // Create a new bar button item that will send
        // addNewItem: to BNRItemViewController
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
        navItem.rightBarButtonItem = bbi;
        
        // Left button item to edit
        navItem.leftBarButtonItem = self.editButtonItem;
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [self init];
}

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Load the BNRItemCell XIB
    UINib *cellNib = [UINib nibWithNibName:@"BNRItemCell" bundle:nil];
    // Register this NIB, which contains the cell
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"BNRItemCell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[BNRItemStore sharedStore] allItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BNRItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BNRItemCell"
                                                            forIndexPath:indexPath];
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *item = items[indexPath.row];
    
    cell.nameLabel.text = item.itemName;
    cell.serialNumberLabel.text = item.serialNumber;
    cell.valueLabel.text = [NSString stringWithFormat:@"$%d", item.valueInDollars];
    cell.thumbnailView.image = item.thumbnail;
    
    __weak BNRItemCell *weakCell = cell;
    cell.actionBlock = ^{
        NSLog(@"Going to show image for %@", item);
        
        BNRItemCell *strongCell = weakCell;
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            // If there is no image, we don't need to display anything
            UIImage *img = [[BNRImageStore sharedStore] imageForKey:item.itemKey];
            if (!img) {
                return;
            }
            
            // Make a rectangle for the frame of the thumbnail relative to
            // our table view
            CGRect rect = [self.view convertRect:strongCell.thumbnailView.bounds
                                        fromView:strongCell.thumbnailView];
            
            // Create a new BNRImageViewController and set its image
            BNRImageViewController *ivc = [BNRImageViewController new];
            ivc.image = img;
            
            // Present a 600 * 600 popover from the rect
            self.imagePopover = [[UIPopoverController alloc] initWithContentViewController:ivc];
            self.imagePopover.delegate = self;
            self.imagePopover.popoverContentSize = CGSizeMake(600.0, 600.0);
            [self.imagePopover presentPopoverFromRect:rect
                                               inView:self.view
                             permittedArrowDirections:UIPopoverArrowDirectionAny
                                             animated:YES];
        }
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *items = [[BNRItemStore sharedStore] allItems];
        BNRItem *item = items[indexPath.row];
        [[BNRItemStore sharedStore] removeItem:item];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [[BNRItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BNRDetailViewController *detailViewController =
    [[BNRDetailViewController alloc] initForNewItem:NO];
    
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *item = items[indexPath.row];
    detailViewController.item = item;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark - Popover controller delegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    self.imagePopover = nil;
}

#pragma mark - Actions

- (IBAction)addNewItem:(id)sender {
    BNRItem *newItem = [[BNRItemStore sharedStore] createItem];
    BNRDetailViewController *detailViewController =
    [[BNRDetailViewController alloc] initForNewItem:YES];
    
    detailViewController.item = newItem;
    
    detailViewController.dismissBlock = ^{
        [self.tableView reloadData];
    };
    
    UINavigationController *navController = [[UINavigationController alloc]
                                             initWithRootViewController:detailViewController];
    navController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:navController animated:YES completion:nil];
}

@end
