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

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.nameField.text = self.item.itemName;
    self.SerialNumberField.text = self.item.serialName;
    self.valueField.text = [NSString stringWithFormat:@"%d", self.item.valueInDollars];
    
    // make NSDateFormatter `static` for time-saving
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter) {
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    
    self.dateLabel.text = [dateFormatter stringFromDate:self.item.dateCreated];
}

@end
