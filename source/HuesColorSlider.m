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
	self = [super initWithFrame:frameRect];
	if (!self) return nil;
	
	_colors = @[[NSColor whiteColor], [NSColor whiteColor]];
	_currentColor = [NSColor whiteColor];
	
	return self;
}

- (void)awakeFromNib
{
	NSColor *white = [NSColor whiteColor];
	self.colors = @[white, white];
	self.currentColor = [NSColor whiteColor];
}

- (void)setColors:(NSArray *)colors
{
	_colors = colors;
	[self setNeedsDisplay:YES];
}

- (void)setCurrentColor:(NSColor *)color
{
	_currentColor = color;
	[self setNeedsDisplay:YES];
}

- (NSGradient *)gradient
{
	return [[NSGradient alloc] initWithColors:self.colors];
}

+ (Class)cellClass
{
	return [HuesColorSliderCell class];
}

@end
