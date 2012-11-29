//
//  HuesPopoverWindow.m
//  Hues
//
//  Created by Zach Waugh on 11/28/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import "HuesPopoverWindow.h"

@implementation HuesPopoverWindow

- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)styleMask backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag
{
	//styleMask = (NSNonactivatingPanelMask | NSUtilityWindowMask);
	
	self = [super initWithContentRect:contentRect styleMask:styleMask backing:bufferingType defer:flag];
	
	if (self) {
		[self setOpaque:NO];
		[self setBackgroundColor:[NSColor clearColor]];
		[self setMovableByWindowBackground:YES];
		//[self setMovable:NO];
		[self setCollectionBehavior:NSWindowCollectionBehaviorCanJoinAllSpaces];
		//[self setFloatingPanel:YES];
	}
	
	return self;
}

- (BOOL)canBecomeKeyWindow
{
	return YES;
}

- (BOOL)canBecomeMainWindow
{
	return YES;
}

@end
