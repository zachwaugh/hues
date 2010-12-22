//
//  HUAppDelegate.m
//  Hues
//
//  Created by Zach Waugh on 2/17/09.
//  Copyright 2009 Giant Comet. All rights reserved.
//

#import "HuesAppDelegate.h"
#import "HuesColorsView.h"
#import "NSColor+Extras.h"

@implementation HuesAppDelegate

@synthesize colorsView, hexLabel;

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


- (void)dealloc
{
	self.colorsView = nil;
	self.hexLabel = nil;
	
	[super dealloc];
}


- (void)awakeFromNib
{
	//[[NSColorPanel sharedColorPanel] setAccessoryView:self.colorsView];
}

- (void)changeColor:(id)sender
{
	NSColor *color = [sender color];
	
	[self.hexLabel setStringValue:[color hues_hexadecimal]];
	NSLog(@"hex: %@, rgb: %@", [color hues_hexadecimal], [color hues_rgb]);
}


- (void)copyHex:(id)sender
{
	[[NSPasteboard generalPasteboard] declareTypes:[NSArray arrayWithObject:NSStringPboardType] owner:self];
	[[NSPasteboard generalPasteboard] setString:[[[NSColorPanel sharedColorPanel] color] hues_hexadecimal] forType:NSStringPboardType];
}


- (void)copyRGB:(id)sender
{
	[[NSPasteboard generalPasteboard] declareTypes:[NSArray arrayWithObject:NSStringPboardType] owner:self];
	[[NSPasteboard generalPasteboard] setString:[[[NSColorPanel sharedColorPanel] color] hues_rgb] forType:NSStringPboardType];
}


// Make sure app quits after panel is closed
- (void)windowWillClose:(NSNotification *)notification
{
	[[NSApplication sharedApplication] terminate:nil];
}

@end
