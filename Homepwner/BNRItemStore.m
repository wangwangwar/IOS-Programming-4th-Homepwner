//
//  BNRItemStore.m
//  Homepwner
//
//  Created by wangwangwar on 14/10/27.
//  Copyright (c) 2014年 wangwangwar. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface BNRItemStore()

@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation BNRItemStore

#pragma mark - Initialization

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +BNRItemStore sharedStore]" userInfo:nil];
    return nil;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        NSString *path = [self itemArchivePath];
        _privateItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        // If the array hadn't been saved previously, create a new empty one
        if (!_privateItems) {
            _privateItems = [NSMutableArray new];
        }
    }
    return self;
}

#pragma mark - Operations

- (NSArray *)allItems {
    return _privateItems;
}

- (BNRItem *)createItem {
    BNRItem *item = [BNRItem new];
    [self.privateItems addObject:item];
    return item;
}

- (void)removeItem:(BNRItem *)item {
    // Remove image from Image Store
    [[BNRImageStore sharedStore] deleteImageForKey:item.itemKey];
    [self.privateItems removeObjectIdenticalTo:item];
}

- (void)moveItemAtIndex:(NSUInteger)fromIndex
                toIndex:(NSUInteger)toIndex {
    if (fromIndex == toIndex) {
        return;
    }
    
    BNRItem *item = self.privateItems[fromIndex];
    [self.privateItems removeObjectAtIndex:fromIndex];
    [self.privateItems insertObject:item atIndex:toIndex];
}

#pragma mark - Archiver and Unarchiver

- (NSString *)itemArchivePath {
    NSArray *documentDirectories =
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories firstObject];
    
    return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
}

- (BOOL)saveChanges {
    NSString *path = [self itemArchivePath];
    // Return YES on success
    return [NSKeyedArchiver archiveRootObject:self.privateItems toFile:path];
}

#pragma mark - Class Method

+ (instancetype)sharedStore {
    static BNRItemStore *sharedStore = nil;
    
    // Thread safe
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStore = [[self alloc] initPrivate];
    });
    
    return sharedStore;
}

@end
