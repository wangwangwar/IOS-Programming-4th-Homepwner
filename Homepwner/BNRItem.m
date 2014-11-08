//
//  BNRItem.m
//  Homepwner
//
//  Created by wangwangwar on 14/10/27.
//  Copyright (c) 2014年 wangwangwar. All rights reserved.
//

#import "BNRItem.h"

@implementation BNRItem

#pragma mark - Initialization

- (instancetype)initWithItemName:(NSString *)name
                  valueInDollars:(int)value
                    serialNumber:(NSString *)serialNumber {
    self = [super init];
    if (self) {
        _itemName = name;
        _serialName = serialNumber;
        _valueInDollars = value;
        _dateCreated = [NSDate new];
        
        // Create an NSUUID object and get its string representation
        NSUUID *uuid = [NSUUID new];
        _itemKey = [uuid UUIDString];
    }
    
    return self;
}

- (instancetype)initWithItemName:(NSString *)name {
    self = [super init];
    if (self) {
        _itemName = name;
    }
    
    return self;
}

#pragma mark - Other
- (NSString *)description {
    NSString *descriptionString =
    [[NSString alloc] initWithFormat:@"%@ (%@): Worth $%d, recorded on %@",
     self.itemName,
     self.serialName,
     self.valueInDollars,
     self.dateCreated];
    return descriptionString;
}

#pragma mark - Class Methods

+ (instancetype)randomItem {
    NSArray *randomAdjectiveList = @[@"Fluffy", @"Rusty", @"Shiny"];
    NSArray *randomNounList = @[@"Bear", @"Spork", @"Mac"];
    
    NSInteger adjectiveIndex = arc4random() % [randomAdjectiveList count];
    NSInteger nounIndex = arc4random() % [randomNounList count];
    
    NSString *randomName = [[NSString alloc] initWithFormat:@"%@ %@", [randomAdjectiveList objectAtIndex:adjectiveIndex], [randomNounList objectAtIndex:nounIndex]];
    
    int randomValue = arc4random() % 100;
    
    NSString *randomSerialNumber = [[NSString alloc] initWithFormat:@"%c%c%c%c%c",
                                    'A' + arc4random() % 26,
                                    '0' + arc4random() % 10,
                                    'A' + arc4random() % 26,
                                    '0' + arc4random() % 10,
                                    'A' + arc4random() % 26];
    
    BNRItem *item = [[BNRItem alloc] initWithItemName:randomName valueInDollars:randomValue serialNumber:randomSerialNumber];
    
    return item;
}

@end