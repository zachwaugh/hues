//
//  HuesColorWell.m
//  Hues
//
//  Created by Zach Waugh on 7/24/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesColorWell.h"

@implementation HuesColorWell

- (void)drawWellInside:(NSRect)insideRect
{
	[[NSColor colorWithPatternImage:[NSImage imageNamed:@"transparency"]] set];
	NSRectFill(self.bounds);
	
	[self.color set];
	NSRectFillUsingOperation(self.bounds, NSCompositeSourceOver);
	
	// light gray outer border
	[[NSColor colorWithCalibratedWhite:0.75 alpha:1.0] set];
	[[NSBezierPath bezierPathWithRect:NSInsetRect(self.bounds, 0.5, 0.5)] stroke];
	
	// white inner border
	[[NSColor whiteColor] set];
	[[NSBezierPath bezierPathWithRect:NSInsetRect(self.bounds, 1.5, 1.5)] stroke];
}

@end
