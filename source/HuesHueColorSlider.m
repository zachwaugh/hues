//
//  HuesHueColorSlider.m
//  Hues
//
//  Created by Zach Waugh on 12/17/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import "HuesHueColorSlider.h"

@implementation HuesHueColorSlider

- (void)setColor:(NSColor *)color
{
	_color = color;
	[self setNeedsDisplay:YES];
}

@end
