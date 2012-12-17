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

- (id)initWithFrame:(NSRect)frameRect
{
	if ((self = [super initWithFrame:frameRect])) {
		_startColor = [NSColor whiteColor];
		_endColor = [NSColor whiteColor];
	}
	
	return self;
}

- (void)awakeFromNib
{
	self.startColor = [NSColor whiteColor];
	self.endColor = [NSColor whiteColor];
}

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

- (NSGradient *)gradient
{
	return [[NSGradient alloc] initWithStartingColor:self.startColor endingColor:self.endColor];
}

+ (Class)cellClass
{
	return [HuesColorSliderCell class];
}

@end
