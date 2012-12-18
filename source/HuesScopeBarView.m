//
//  HuesScopeBarView.m
//  Hues
//
//  Created by Zach Waugh on 12/16/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import "HuesScopeBarView.h"

#define PADDING 10

@implementation HuesScopeBarView

- (void)drawRect:(NSRect)dirtyRect
{
  NSGradient *gradient = [[NSGradient alloc] initWithStartingColor:[NSColor colorWithCalibratedRed:0.925 green:0.925 blue:0.925 alpha:1.000] endingColor:[NSColor colorWithCalibratedRed:0.961 green:0.961 blue:0.961 alpha:1.000]];
	[gradient drawInRect:self.bounds angle:90];
	
	[[NSColor colorWithCalibratedRed:0.776 green:0.776 blue:0.776 alpha:1.000] set];
	NSRectFill((NSRect){0, 0, self.bounds.size.width, 1});
}

- (void)resizeSubviewsWithOldSize:(NSSize)oldSize
{
	CGFloat width = 0;
	
	for (NSView *view in self.subviews) {
		width += NSWidth(view.frame);
	}
	
	width += (PADDING * (self.subviews.count - 1));
	
	float x = round((self.bounds.size.width - width) / 2);
	
	for (NSView *view in self.subviews) {
		NSRect frame = view.frame;
		frame.origin.x = x;
		
		view.frame = frame;
		x += NSWidth(frame) + PADDING;
	}
}

@end
