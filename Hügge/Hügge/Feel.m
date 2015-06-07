//
//  Feel.m
//  Hügge
//
//  Created by Morten Kleveland on 08.06.15.
//  Copyright (c) 2015 Morten G. Kleveland. All rights reserved.
//

#import "Feel.h"

@implementation Feel

- (id)initWithTitle:(NSString *)feelTitle andDescription:(NSString *)feelDescription {
    self = [super init];
    if (self) {
        [self setFeelTitle:feelTitle];
        [self setFeelDescription:feelDescription];
    }
    return self;
}

@end
