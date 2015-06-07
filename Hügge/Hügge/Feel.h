//
//  Feel.h
//  Hügge
//
//  Created by Morten Kleveland on 08.06.15.
//  Copyright (c) 2015 Morten G. Kleveland. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Feel : NSObject

@property NSString *feelTitle;
@property NSString *feelDescription;

- (id)initWithTitle:(NSString *)feelTitle andDescription:(NSString *)feelDescription;

@end
