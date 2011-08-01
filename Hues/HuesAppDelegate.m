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
#import "HuesHistoryManager.h"


@implementation HuesAppDelegate

@synthesize mainController, preferencesController, historyMenu;

- (void)applicationWillFinishLaunching:(NSNotification *)notification
{
  [HuesPreferences registerDefaults];
  [NSColorPanel setPickerMask:[HuesPreferences pickerMask]];
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  self.mainController = [[[HuesMainController alloc] init] autorelease];
}


- (void)awakeFromNib
{
  [HuesHistoryManager sharedManager].menu = self.historyMenu;
}


- (void)dealloc
{
  self.mainController = nil;
  self.preferencesController = nil;
	self.historyMenu = nil;
  
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

@end
