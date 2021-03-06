//
//  Genre.h
//  Hügge
//
//  Created by Morten Kleveland on 07.06.15.
//  Copyright (c) 2015 Morten G. Kleveland. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Genre : NSObject

@property NSString* genreTitle;
@property NSString* genreDescription;

- (id)initWithTitle: (NSString*)genreTitle andDescription: (NSString*)genreDescription;

@end
