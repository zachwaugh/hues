//
//  HuesPreferencesController.m
//  Hues
//
//  Created by Zach Waugh on 12/27/10.
//  Copyright 2010 Giant Comet. All rights reserved.
//

#import "HuesPreferencesController.h"
#import "HuesPreferences.h"
#import "HuesPreferencesViewControllerProtocol.h"
#import "HuesGeneralPreferencesController.h"
#import "HuesColorFormattingPreferencesController.h"

NSString * const HuesGeneralToolbarIdentifier = @"general";
NSString * const HuesColorFormatsToolbarIdentifier = @"formats";

@interface HuesPreferencesController ()

@property (strong) NSMutableDictionary *viewControllers;
@property (strong) NSViewController<HuesPreferencesViewControllerProtocol> *activeViewController;

@end

@implementation HuesPreferencesController

- (id)init
{
	self = [super initWithWindowNibName:@"HuesPreferencesController"];
	if (!self) return nil;
	
	_viewControllers = [[NSMutableDictionary alloc] init];
	
	return self;
}

- (void)awakeFromNib
{
	self.window.title = @"General";
	
	HuesGeneralPreferencesController *generalController = [[HuesGeneralPreferencesController alloc] init];
	self.viewControllers[HuesGeneralToolbarIdentifier] = generalController;
	self.activeViewController = generalController;
	self.currentView = generalController.view;
  [self.toolbar setSelectedItemIdentifier:HuesGeneralToolbarIdentifier];
}

- (void)toolbarItemSelected:(id)sender
{
  NSString *identifier = [sender itemIdentifier];
  
  if ([self.activeViewController.identifier isEqualToString:identifier]) return;
  
  [self.toolbar setSelectedItemIdentifier:identifier];
  
	NSViewController<HuesPreferencesViewControllerProtocol> *viewController = self.viewControllers[identifier];
	
	if (!viewController) {
		if ([identifier isEqualToString:HuesGeneralToolbarIdentifier]) {
			viewController = [[HuesGeneralPreferencesController alloc] init];
		} else if ([identifier isEqualToString:HuesColorFormatsToolbarIdentifier]) {
			viewController = [[HuesColorFormattingPreferencesController alloc] init];
		}
		
		self.viewControllers[identifier] = viewController;
	}
  
	self.currentView = viewController.view;
	self.activeViewController = viewController;
	self.window.title = viewController.title;
}

- (void)setCurrentView:(NSView *)view
{
  NSRect newFrame = self.window.frame;
  newFrame.size.height = view.frame.size.height + (self.window.frame.size.height - self.view.frame.size.height);
	newFrame.size.width = view.frame.size.width;
  newFrame.origin.y += (self.view.frame.size.height - view.frame.size.height);
  
  [self.activeViewController.view removeFromSuperview];
  [self.window setFrame:newFrame display:YES animate:YES];
  [self.view addSubview:view];
}

@end
