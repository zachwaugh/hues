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
#import "HuesColorFormattingPreferencesController.h"
#import "MASShortcutView.h"
#import "MASShortcutView+UserDefaults.h"
#import "MASShortcut+UserDefaults.h"
#import "MASShortcut+Monitoring.h"

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
  [self.toolbar setSelectedItemIdentifier:HuesGeneralToolbarIdentifier];
  self.window.title = @"General";	
	self.loupeShortcutView.associatedUserDefaultsKey = HuesLoupeShortcutKey;
}

- (void)toolbarItemSelected:(id)sender
{
  NSString *identifier = [sender itemIdentifier];
  
  if ([self.activeViewController.identifier isEqualToString:identifier]) return;
  
  [self.toolbar setSelectedItemIdentifier:identifier];
  
	NSViewController<HuesPreferencesViewControllerProtocol> *viewController = self.viewControllers[identifier];
	
	if (!viewController) {
		if ([identifier isEqualToString:HuesGeneralToolbarIdentifier]) {
			viewController = [[HuesColorFormattingPreferencesController alloc] init];
		} else if ([identifier isEqualToString:HuesColorFormatsToolbarIdentifier]) {
			viewController = [[HuesColorFormattingPreferencesController alloc] init];
		}
		
		self.viewControllers[identifier] = viewController;
	}
  
	self.activeViewController = viewController;
	self.window.title = viewController.title;
	self.currentView = viewController.view;
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
