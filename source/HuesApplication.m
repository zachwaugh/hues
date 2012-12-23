//
//  HuesApplication.m
//  Hues
//
//  Created by Zach Waugh on 11/1/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import "HuesApplication.h"
#import "HuesLoupeWindow.h"

@implementation HuesApplication

- (void)sendEvent:(NSEvent *)event
{
	[super sendEvent:event];

	if (event.type == NSMouseMoved) {
		if ([self.mainWindow isKindOfClass:[HuesLoupeWindow class]]) {
			//NSLog(@"[application] sending mouseMoved: %@, app active: %d", NSStringFromPoint(event.locationInWindow), [NSApp isActive]);
			[self.mainWindow sendEvent:event];
		}
	}
}

@end
