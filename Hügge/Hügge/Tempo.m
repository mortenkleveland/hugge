//
//  Tempo.m
//  
//
//  Created by Morten Kleveland on 07.06.15.
//
//

#import "Tempo.h"

@implementation Tempo

- (id)init {
    self = [super init];
    return self;
}

- (id)initWithTempo: (NSString*)tempo andDescription: (NSString*)tempoDescription {
    self = [self init];
    if (self) {
        [self setTempo:tempo];
        [self setTempoDescription:tempoDescription];
    }
    return self;
}

@end
