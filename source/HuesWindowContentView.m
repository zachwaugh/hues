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
	NSBezierPath *clipPath = [NSBezierPath bezierPathWithRoundedRect:self.bounds xRadius:RADIUS yRadius:RADIUS];
	
	[[NSColor colorWithCalibratedRed:0.969 green:0.969 blue:0.969 alpha:1.000] set];
	[clipPath fill];
	//NSRectFill(self.bounds);
	
//	NSImage *top = [NSImage imageNamed:@"popover-bg"];
//	NSRect topRect = NSMakeRect(0, self.bounds.size.height - top.size.height, self.bounds.size.width, top.size.height);
//	
//	[NSGraphicsContext saveGraphicsState];
//	[clipPath addClip];
//	NSDrawThreePartImage(topRect, top, top, top, NO, NSCompositeSourceOver, 1.0, [self isFlipped]);
//	[NSGraphicsContext restoreGraphicsState];
}

@end
