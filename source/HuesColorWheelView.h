//
//  HuesColorWheelView.h
//  Hues
//
//  Created by Zach Waugh on 12/17/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol HuesColorWheelViewDelegate <NSObject>

- (void)colorWheelDidChangeSaturation:(CGFloat)saturation brightness:(CGFloat)brightness;

@end

@interface HuesColorWheelView : NSView

@property (strong, nonatomic) NSColor *color;
@property (weak) IBOutlet id<HuesColorWheelViewDelegate> delegate;

@end
