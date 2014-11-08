//
//  BNRImageStore.m
//  Homepwner
//
//  Created by wangwangwar on 14/11/8.
//  Copyright (c) 2014年 wangwangwar. All rights reserved.
//

#import "BNRImageStore.h"

@interface BNRImageStore()

@property (nonatomic, strong) NSMutableDictionary *dictionary;

@end

@implementation BNRImageStore

+ (instancetype)sharedStore {
    static BNRImageStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}

#pragma mark - Initialization

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[BNRImageStore sharedStore]" userInfo:nil];
    return nil;
}

- (instancetype)initPrivate {
    self = [super init];
    
    if (self) {
        _dictionary = [NSMutableDictionary new];
    }
    
    return self;
}

#pragma mark - Operations

- (void)setImage:(UIImage *)image forKey:(NSString *)key {
    self.dictionary[key] = image;
}

- (UIImage *)imageForKey:(NSString *)key {
    return self.dictionary[key];
}

- (void)deleteImageForKey:(NSString *)key {
    [self.dictionary removeObjectForKey:key];
}

@end