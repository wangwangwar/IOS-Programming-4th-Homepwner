//
//  BNRImageViewController.m
//  Homepwner
//
//  Created by wangwangwar on 14/11/23.
//  Copyright (c) 2014年 wangwangwar. All rights reserved.
//

#import "BNRImageViewController.h"

@interface BNRImageViewController () 

@end

@implementation BNRImageViewController

- (void)loadView {
    UIImageView *iv = [UIImageView new];
    iv.contentMode = UIViewContentModeScaleAspectFit;
    self.view = iv;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // We must cast the view to UIImageView so the compiler knows it
    // is okay to send it setImage:
    UIImageView *iv = (UIImageView *)self.view;
    [iv setImage:self.image];
}

@end
