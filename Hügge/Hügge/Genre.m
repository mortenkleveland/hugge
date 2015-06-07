//
//  Genre.m
//  Hügge
//
//  Created by Morten Kleveland on 07.06.15.
//  Copyright (c) 2015 Morten G. Kleveland. All rights reserved.
//

#import "Genre.h"

@implementation Genre

- (id)initWithTitle:(NSString *)genreTitle andDescription:(NSString *)genreDescription {
    self = [super init];
    if (self) {
        [self setGenreTitle:genreTitle];
        [self setGenreDescription:genreDescription];
    }
    return self;
}

@end
