//
//  DetailView.m
//  Hügge
//
//  Created by Morten Kleveland on 11.06.15.
//  Copyright © 2015 Morten G. Kleveland. All rights reserved.
//

#import "DetailView.h"

@implementation DetailView

double prevX, prevY;
bool firstTouch;

- (void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    firstTouch = YES;
}

- (void)touchesMoved:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    if (firstTouch) {
        prevX = touchLocation.x;
        prevY = touchLocation.y;
        firstTouch = NO;
    } else {
        CGRect newFrame = self.frame;
        newFrame.origin.x -= prevX - touchLocation.x;
        [self setFrame:newFrame];
        prevX = touchLocation.x;
    }
}

@end
