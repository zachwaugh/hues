//
//  HuesMixerViewController.h
//  Hues
//
//  Created by Zach Waugh on 12/17/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class HuesColor;

@interface HuesMixerViewController : NSViewController

@property (strong) HuesColor *color;

- (void)updateInterfaceWithColor:(HuesColor *)color;
- (void)updateColor:(HuesColor *)color;

@end
