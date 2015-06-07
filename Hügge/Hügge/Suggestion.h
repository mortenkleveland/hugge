//
//  Suggestion.h
//  Hügge
//
//  Created by Morten Kleveland on 07.06.15.
//  Copyright (c) 2015 Morten G. Kleveland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Genre.h"
#import "Tempo.h"
#import "TimeSignature.h"

@interface Suggestion : NSObject

@property Tempo *tempo;
@property Genre *genre;
@property TimeSignature *timeSignature;

- (id)init;

@end
