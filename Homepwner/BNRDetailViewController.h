//
//  BNRDetailViewController.h
//  Homepwner
//
//  Created by wangwangwar on 14/11/6.
//  Copyright (c) 2014年 wangwangwar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;

@interface BNRDetailViewController : UIViewController

@property (nonatomic, strong) BNRItem *item;
@property (nonatomic, copy) void (^dismissBlock)(void);

- (instancetype)initForNewItem:(BOOL)isNew;

@end
