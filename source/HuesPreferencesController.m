//
//  HuesPreferencesController.m
//  Hues
//
//  Created by Zach Waugh on 12/27/10.
//  Copyright 2010 Giant Comet. All rights reserved.
//

#import "HuesPreferencesController.h"
#import "HuesPreferences.h"
#import "MASShortcutView.h"
#import "MASShortcutView+UserDefaults.h"
#import "MASShortcut+UserDefaults.h"
#import "MASShortcut+Monitoring.h"

NSString * const HuesGeneralToolbarIdentifier = @"general";
NSString * const HuesAdvancedToolbarIdentifier = @"advanced";

@implementation HuesPreferencesController


- (void)awakeFromNib
{
  self.currentToolbarIdentifier = HuesGeneralToolbarIdentifier;
  [self.toolbar setSelectedItemIdentifier:HuesGeneralToolbarIdentifier];
  [[self window] setTitle:@"General"];
  self.currentView = self.generalView;
	
	self.loupeShortcutView.associatedUserDefaultsKey = HuesLoupeShortcutKey;
}

- (void)toolbarItemSelected:(id)sender
{
  NSString *identifier = [sender itemIdentifier];
  
  if ([identifier isEqualToString:self.currentToolbarIdentifier]) return;
  
  self.currentToolbarIdentifier = identifier;
  [self.toolbar setSelectedItemIdentifier:identifier];
  
  if ([identifier isEqualToString:HuesGeneralToolbarIdentifier]) {
    [[self window] setTitle:@"General"];
    self.currentView = self.generalView;
  } else if ([identifier isEqualToString:HuesAdvancedToolbarIdentifier]) {
    [[self window] setTitle:@"Advanced"];
    self.currentView = self.advancedView;
  }
}

- (void)setCurrentView:(NSView *)aView
{
  NSRect newFrame = [[self window] frame];
  newFrame.size.height = [aView frame].size.height + ([[self window] frame].size.height - [self.view frame].size.height);
  newFrame.origin.y += ([self.view frame].size.height - [aView frame].size.height);
  
  [_currentView removeFromSuperview];
  [[self window] setFrame:newFrame display:YES animate:YES];
  [self.view addSubview:aView];
  
  _currentView = aView;
}

@end
