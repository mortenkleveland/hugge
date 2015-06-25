//
//  Tonality.h
//  Hügge
//
//  Created by Morten Kleveland on 07.06.15.
//  Copyright (c) 2015 Morten G. Kleveland. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tonality : NSObject

@property NSString* tonality;
@property NSString* tonalityDescription;

- (id)initWithTonality: (NSString*)tonality andDescription: (NSString*)tonalityDescription;

@end
