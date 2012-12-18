//
//  HuesColorWheelHueView.h
//  Hues
//
//  Created by Zach Waugh on 12/17/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol HuesColorWheelHueViewDelegate <NSObject>

- (void)hueChanged:(CGFloat)hue;

@end

@interface HuesColorWheelHueView : NSView

@property (weak) IBOutlet id<HuesColorWheelHueViewDelegate> delegate;

@end
