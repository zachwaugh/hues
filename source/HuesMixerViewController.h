//
//  HuesMixerViewController.h
//  Hues
//
//  Created by Zach Waugh on 12/17/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface HuesMixerViewController : NSViewController

@property (strong) NSColor *color;

- (void)updateInterfaceWithColor:(NSColor *)color;
- (void)updateColor:(NSColor *)color;

@end
