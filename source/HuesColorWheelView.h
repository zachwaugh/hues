//
//  HuesColorWheelView.h
//  Hues
//
//  Created by Zach Waugh on 12/17/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class HuesColor;

@protocol HuesColorWheelViewDelegate <NSObject>

- (void)colorWheelDidChangeSaturation:(CGFloat)saturation brightness:(CGFloat)brightness;

@end

@interface HuesColorWheelView : NSView

@property (nonatomic, strong) HuesColor *color;
@property (nonatomic, assign) IBOutlet id<HuesColorWheelViewDelegate> delegate;

@end
