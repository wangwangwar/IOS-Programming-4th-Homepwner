//
//  BNRDetailViewController.m
//  Homepwner
//
//  Created by wangwangwar on 14/11/6.
//  Copyright (c) 2014年 wangwangwar. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"

@interface BNRDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *SerialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation BNRDetailViewController

#pragma mark - Basic

- (void)setItem:(BNRItem *)item {
    _item = item;
    self.navigationItem.title = item.itemName;
}

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // When tap on other place except text field, keyboard will dismiss
    // automatically
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(tapDetected:)];
    [self.view addGestureRecognizer:tap];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.nameField.text = self.item.itemName;
    self.SerialNumberField.text = self.item.serialName;
    self.valueField.text = [NSString stringWithFormat:@"%d", self.item.valueInDollars];
    
    // make NSDateFormatter `static` for time-saving
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    
    self.dateLabel.text = [dateFormatter stringFromDate:self.item.dateCreated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Clear first responder
    [self.view endEditing:YES];
    
    // Save changes to item
    self.item.itemName = self.nameField.text;
    self.item.serialName = self.SerialNumberField.text;
    self.item.valueInDollars = [self.valueField.text intValue];
}

# pragma mark - Action

- (void)tapDetected:(id)sender {
    NSLog(@"Tapped");
    [self.valueField resignFirstResponder];
}

@end
