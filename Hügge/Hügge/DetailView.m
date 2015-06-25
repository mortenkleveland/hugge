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
bool isLocked = false;
CGFloat hue, saturation, brightness, alpha;

- (void)handleSingleTap {
    if (isLocked) {
        self.backgroundColor = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
    } else {
        [self.backgroundColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
        self.backgroundColor = [UIColor colorWithHue:hue saturation:0.0 brightness:0.9 alpha:alpha];
    }
    isLocked = !isLocked;
}

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

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSUInteger numTaps = [[touches anyObject] tapCount];
    float delay = 0.1;
    if (numTaps < 2) {
        [self performSelector:@selector(handleSingleTap) withObject:nil afterDelay:delay];
        [self.nextResponder touchesEnded:touches withEvent:event];
    }
}

@end
