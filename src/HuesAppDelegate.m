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


@interface HuesAppDelegate ()

- (void)copyToClipboard:(NSString *)value;

@end



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
	[self copyToClipboard:[color hues_hexadecimal]];
	
	//[self.hexLabel setStringValue:[color hues_hexadecimal]];
	//NSLog(@"hex: %@, rgb: %@", [color hues_hexadecimal], [color hues_rgb]);
}


- (void)copyHex:(id)sender
{
	[self copyToClipboard:[[[NSColorPanel sharedColorPanel] color] hues_hexadecimal]];
}


- (void)copyRGB:(id)sender
{
	[self copyToClipboard:[[[NSColorPanel sharedColorPanel] color] hues_rgb]];
}


- (void)copyToClipboard:(NSString *)value
{
	[[NSPasteboard generalPasteboard] declareTypes:[NSArray arrayWithObject:NSStringPboardType] owner:self];
	[[NSPasteboard generalPasteboard] setString:value forType:NSStringPboardType];
}


// Make sure app quits after panel is closed
- (void)windowWillClose:(NSNotification *)notification
{
	[[NSApplication sharedApplication] terminate:nil];
}

@end
