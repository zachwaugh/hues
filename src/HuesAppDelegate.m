//
//  HUAppDelegate.m
//  Hues
//
//  Created by Zach Waugh on 2/17/09.
//  Copyright 2009 Giant Comet. All rights reserved.
//

#import "HuesAppDelegate.h"
#import "HuesPreferences.h"
#import "HuesPreferencesController.h"
#import "HuesMainController.h"


@implementation HuesAppDelegate

@synthesize mainController, preferencesController;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  [HuesPreferences registerDefaults];
  self.mainController = [[[HuesMainController alloc] init] autorelease];
}


- (void)dealloc
{
  self.mainController = nil;
  self.preferencesController = nil;
	
	[super dealloc];
}


- (void)showPreferences:(id)sender
{
  if (self.preferencesController == nil)
  {
    self.preferencesController = [[[HuesPreferencesController alloc] initWithWindowNibName:@"HuesPreferences"] autorelease];
  }
  
  [self.preferencesController showWindow:sender];
}


// Make sure app quits after panel is closed
- (void)windowWillClose:(NSNotification *)notification
{
	[[NSApplication sharedApplication] terminate:nil];
}

@end
