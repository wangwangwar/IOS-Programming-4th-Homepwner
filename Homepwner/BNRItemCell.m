//
//  BNRItemCell.m
//  Homepwner
//
//  Created by wangwangwar on 14/11/22.
//  Copyright (c) 2014年 wangwangwar. All rights reserved.
//

#import "BNRItemCell.h"

@implementation BNRItemCell

- (IBAction)showImage:(id)sender {
    if (self.actionBlock) {
        self.actionBlock();
    }
}

@end
