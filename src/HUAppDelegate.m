//
//  HUAppDelegate.m
//  Hues
//
//  Created by Zach Waugh on 2/17/09.
//  Copyright 2009 Giant Comet. All rights reserved.
//

#import "HUAppDelegate.h"

@implementation HUAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  [NSColorPanel setPickerMask:NSColorPanelAllModesMask];
	NSColorPanel *colorPanel = [NSColorPanel sharedColorPanel];
  [colorPanel setStyleMask:NSTitledWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask | NSResizableWindowMask];
	[colorPanel setTitle:@"Hues"];  
	[colorPanel setShowsAlpha:YES];
	[colorPanel setDelegate:self];
	[colorPanel setFloatingPanel:NO];
	[colorPanel setHidesOnDeactivate:NO];
	[colorPanel setShowsAlpha:YES];
	[colorPanel makeKeyAndOrderFront:nil];
}


- (void)awakeFromNib
{
  
}


// Make sure app quits after panel is closed
- (void)windowWillClose:(NSNotification *)notification
{
	[[NSApplication sharedApplication] terminate:nil];
}

@end
