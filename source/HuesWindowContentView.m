//
//  HuesWindowContentView.m
//  Hues
//
//  Created by Zach Waugh on 11/28/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import "HuesWindowContentView.h"

#define RADIUS 5

@implementation HuesWindowContentView

- (void)drawRect:(NSRect)dirtyRect
{
	CGFloat bottomHeight = [self.window contentBorderThicknessForEdge:NSMinYEdge];
	NSRect rect = NSMakeRect(0, bottomHeight, self.bounds.size.width, self.bounds.size.height - bottomHeight);
	
	NSBezierPath *clipPath = [NSBezierPath bezierPathWithRect:rect];
	[[NSColor colorWithCalibratedRed:0.969 green:0.969 blue:0.969 alpha:1.000] set];
	[clipPath fill];
}

@end
