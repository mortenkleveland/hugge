//
//  TimeSignature.m
//  Hügge
//
//  Created by Morten Kleveland on 07.06.15.
//  Copyright (c) 2015 Morten G. Kleveland. All rights reserved.
//

#import "TimeSignature.h"

@implementation TimeSignature

- (id)initWithTimeSignature:(NSString *)timeSignature andDescription:(NSString *)timeSignatureDescription {
    self = [super init];
    if (self) {
        [self setTimeSignature:timeSignature];
        [self setTimeSignatureDescription:timeSignatureDescription];
    }
    return self;
}

@end
