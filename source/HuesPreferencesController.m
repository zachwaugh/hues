//
//  HuesPreferencesController.m
//  Hues
//
//  Created by Zach Waugh on 12/27/10.
//  Copyright 2010 Giant Comet. All rights reserved.
//

#import "HuesPreferencesController.h"

NSString * const HuesGeneralToolbarIdentifier = @"general";
NSString * const HuesColorPickersToolbarIdentifier = @"colorpickers";
NSString * const HuesAdvancedToolbarIdentifier = @"advanced";

@implementation HuesPreferencesController

@synthesize currentToolbarIdentifier, currentView, toolbar, view, generalView, colorPickersView, advancedView;

- (void)dealloc
{
  self.currentToolbarIdentifier = nil;
  self.toolbar = nil;
  self.view = nil;
  self.generalView = nil;
  self.colorPickersView = nil;
  self.advancedView = nil;
  
  [super dealloc];
}


- (void)awakeFromNib
{
  self.currentToolbarIdentifier = HuesGeneralToolbarIdentifier;
  [self.toolbar setSelectedItemIdentifier:HuesGeneralToolbarIdentifier];
  [[self window] setTitle:@"General"];
  self.currentView = self.generalView;
}


- (void)toolbarItemSelected:(id)sender
{
  NSString *identifier = [sender itemIdentifier];
  
  if ([identifier isEqualToString:currentToolbarIdentifier]) return;
  
  self.currentToolbarIdentifier = identifier;
  [self.toolbar setSelectedItemIdentifier:identifier];
  
  if ([identifier isEqualToString:HuesGeneralToolbarIdentifier])
  {
    [[self window] setTitle:@"General"];
    self.currentView = self.generalView;
  }
  else if ([identifier isEqualToString:HuesColorPickersToolbarIdentifier])
  {
    [[self window] setTitle:@"Color Pickers"];
    self.currentView = self.colorPickersView;
  }
  else if ([identifier isEqualToString:HuesAdvancedToolbarIdentifier])
  {
    [[self window] setTitle:@"Advanced"];
    self.currentView = self.advancedView;
  }
}


- (void)setCurrentView:(NSView *)aView
{
  NSRect newFrame = [[self window] frame];
  newFrame.size.height = [aView frame].size.height + ([[self window] frame].size.height - [self.view frame].size.height);
  newFrame.origin.y += ([self.view frame].size.height - [aView frame].size.height);
  
  [currentView removeFromSuperview];
  [[self window] setFrame:newFrame display:YES animate:YES];
  [self.view addSubview:aView];
  
  currentView = aView;
}


@end
