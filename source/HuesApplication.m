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

- (void)sendEvent:(NSEvent *)theEvent
{
	[super sendEvent:theEvent];

	if (theEvent.type == NSMouseMoved) {
		if ([self.mainWindow isKindOfClass:[HuesLoupeWindow class]]) {
			//NSLog(@"sending mouseMoved: %@ - %@", NSStringFromPoint([theEvent locationInWindow]), [self mainWindow]);
			[self.mainWindow sendEvent:theEvent];
		}
	}
}

@end
