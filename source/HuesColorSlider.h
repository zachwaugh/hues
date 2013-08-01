//
//  HuesColorSlider.h
//  Hues
//
//  Created by Zach Waugh on 12/14/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface HuesColorSlider : NSSlider

@property (strong, nonatomic) NSColor *currentColor;
@property (strong, nonatomic) NSArray *colors;

- (NSGradient *)gradient;

@end
