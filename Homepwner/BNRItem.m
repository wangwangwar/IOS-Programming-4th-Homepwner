//
//  BNRItem.m
//  Homepwner
//
//  Created by wangwangwar on 14/10/27.
//  Copyright (c) 2014年 wangwangwar. All rights reserved.
//

#import "BNRItem.h"

@implementation BNRItem

- (void)setItemName:(NSString *)str {
    _itemName = str;
}

- (NSString *)itemName {
    return _itemName;
}

- (void)setSerialName:(NSString *)str {
    _serialName = str;
}

- (NSString *)serialName {
    return _serialName;
}

- (void)setValueInDollars:(int)v {
    _valueInDollars = v;
}
- (int)valueInDollars {
    return _valueInDollars;
}

- (NSDate *)dateCreated {
    return _dateCreated;
}

- (NSString *)description {
    NSString *descriptionString =
    [[NSString alloc] initWithFormat:@"%@ (%@): Worth $%d, recorded on %@",
     self.itemName,
     self.serialName,
     self.valueInDollars,
     self.dateCreated];
    return descriptionString;
}

- (instancetype)initWithItemName:(NSString *)name
                  valueInDollars:(int)value
                    serialNumber:(NSString *)serialNumber {
    self = [super init];
    if (self) {
        _itemName = name;
        _serialName = serialNumber;
        _valueInDollars = value;
        _dateCreated = [NSDate new];
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

@end