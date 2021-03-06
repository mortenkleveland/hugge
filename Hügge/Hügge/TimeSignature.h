//
//  TimeSignature.h
//  Hügge
//
//  Created by Morten Kleveland on 07.06.15.
//  Copyright (c) 2015 Morten G. Kleveland. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeSignature : NSObject

@property NSString* timeSignature;
@property NSString* timeSignatureDescription;

- (id)initWithTimeSignature: (NSString*)timeSignature andDescription: (NSString*)timeSignatureDescription;

@end
