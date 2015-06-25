//
//  Tempo.h
//  
//
//  Created by Morten Kleveland on 07.06.15.
//
//

#import <Foundation/Foundation.h>

@interface Tempo : NSObject

@property NSString *tempo;
@property NSString *tempoDescription;

- (id)init;
- (id)initWithTempo: (NSString*)tempo andDescription: (NSString*)description;

@end
