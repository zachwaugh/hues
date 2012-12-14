//
//  HuesColorSlider.m
//  Hues
//
//  Created by Zach Waugh on 12/14/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import "HuesColorSlider.h"
#import "HuesColorSliderCell.h"

@implementation HuesColorSlider

- (void)setStartColor:(NSColor *)startColor
{
	_startColor = [startColor retain];
	[self setNeedsDisplay:YES];
}

- (void)setEndColor:(NSColor *)endColor
{
	_endColor = [endColor retain];
	[self setNeedsDisplay:YES];
}

+ (Class)cellClass
{
	return [HuesColorSliderCell class];
}

@end
