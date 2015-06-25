//
//  Tonality.m
//  Hügge
//
//  Created by Morten Kleveland on 07.06.15.
//  Copyright (c) 2015 Morten G. Kleveland. All rights reserved.
//

#import "Tonality.h"

@implementation Tonality

- (id)initWithTonality: (NSString*)tonality andDescription: (NSString*)tonalityDescription {
    self = [super init];
    if (self) {
        [self setTonality:tonality];
        [self setTonalityDescription:tonalityDescription];
    }
    return self;
}

@end
