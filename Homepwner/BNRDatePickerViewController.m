//
//  BNRDatePickerViewController.m
//  Homepwner
//
//  Created by wangwangwar on 14/11/7.
//  Copyright (c) 2014年 wangwangwar. All rights reserved.
//

#import "BNRDatePickerViewController.h"
#import "BNRItem.h"

@interface BNRDatePickerViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation BNRDatePickerViewController

#pragma mark - View

- (void)viewDidLoad {
    self.datePicker.date = self.item.dateCreated;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.item.dateCreated = self.datePicker.date;
}
@end
