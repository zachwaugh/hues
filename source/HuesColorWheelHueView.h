//
//  HuesColorWheelHueView.h
//  Hues
//
//  Created by Zach Waugh on 12/17/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class HuesColor;

@protocol HuesColorWheelHueViewDelegate <NSObject>

- (void)hueChanged:(CGFloat)hue;

@end

@interface HuesColorWheelHueView : NSView

@property (unsafe_unretained) IBOutlet id<HuesColorWheelHueViewDelegate> delegate;

- (void)updateColor:(HuesColor *)color;

@end
