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
#import "HuesHistoryManager.h"
#import "HuesStatusItemView.h"
#import "HuesPalettesManager.h"
#import "HuesWindowController.h"
#import "HuesLoupeController.h"
#import "MASShortcutView+UserDefaults.h"
#import "MASShortcut+UserDefaults.h"
#import "MASShortcut+Monitoring.h"

@interface HuesAppDelegate ()

@property (strong) HuesWindowController *windowController;
@property (strong) HuesPreferencesController *preferencesController;
@property (strong) NSMenu *historyMenu;
@property (strong) NSStatusItem *statusItem;

- (void)configureApplicationPresentation;
- (void)registerShortcuts;

@end

@implementation HuesAppDelegate

- (void)applicationWillFinishLaunching:(NSNotification *)notification
{
  [HuesPreferences registerDefaults];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	[self checkForBetaExpiration];
	
	self.windowController = [[HuesWindowController alloc] init];
	[self.windowController showWindow:nil];
	
	[self configureApplicationPresentation];
	[self registerShortcuts];
	
	[[HuesPalettesManager sharedManager] palettes];
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
	[[HuesPalettesManager sharedManager] save];
}

- (void)awakeFromNib
{
  [HuesHistoryManager sharedManager].menu = self.historyMenu;
}

#pragma mark - Shortcuts

- (void)registerShortcuts
{
	// Global shortcut
	[MASShortcut registerGlobalShortcutWithUserDefaultsKey:HuesLoupeShortcutKey handler:^{
		[[HuesLoupeController sharedController] showLoupe];
	}];
}

#pragma mark - Presentation

- (void)configureApplicationPresentation
{
	HuesApplicationMode mode = [HuesPreferences applicationMode];
	
	if (mode == HuesDockAndMenuBarMode || mode == HuesMenuBarOnlyMode) {
		[self addStatusItem];
	}
	
	if (mode == HuesDockAndMenuBarMode || mode == HuesDockOnlyMode) {
		[self addDockIcon];
	}
}

- (void)addDockIcon
{
	[NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
}

#pragma mark - Status Item

- (void)addStatusItem
{
	self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:30];
	self.statusItem.target = self;
	self.statusItem.action = @selector(toggleWindow:);
	self.statusItem.image = [NSImage imageNamed:@"hues_menubar_normal"];
	self.statusItem.alternateImage = [NSImage imageNamed:@"hues_menubar_highlight"];
	self.statusItem.highlightMode = YES;
	
//	HuesStatusItemView *view = [[HuesStatusItemView alloc] initWithFrame:NSZeroRect];
//	view.target = self;
//	view.action = @selector(toggleWindow:);
//	view.menu = self.optionsMenu;
//	view.statusItem = self.statusItem;
//	self.statusItem.view = view;
}

- (void)toggleWindow:(id)sender
{
	if (![NSApp isActive] || [NSApp isHidden] || [self.windowController.window isMiniaturized] || ![self.windowController.window isVisible]) {
    [NSApp activateIgnoringOtherApps:YES];
    [self.windowController showWindow:nil];
  } else {
    [NSApp hide:self];
  }
}

- (void)showPreferences:(id)sender
{
  if (!self.preferencesController) {
    self.preferencesController = [[HuesPreferencesController alloc] init];
  }
  
  [self.preferencesController showWindow:sender];
}

#pragma mark - Beta

- (void)checkForBetaExpiration
{
#ifdef DEBUG
  NSLog(@"*** WARNING!!! Beta is enabled ***");
#endif
  
  NSDate *expiration = [NSDate dateWithNaturalLanguageString:BETA_EXPIRATION];
  
  if ([expiration earlierDate:[NSDate date]] == expiration) {
    NSAlert *alert = [NSAlert alertWithMessageText:@"This beta has expired. Thank you for being a tester." defaultButton:@"Cancel" alternateButton:@"Mac App Store" otherButton:@"Check for Updated Beta" informativeTextWithFormat:@"Check for an updated beta or visit the Mac App Store to download the release version."];
    
    NSInteger returnCode = [alert runModal];
    
    if (returnCode == NSAlertAlternateReturn) {
      [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:HUES_MAS_URL]];
    } else if (returnCode == NSAlertOtherReturn) {
      [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://giantcomet.com/hues/beta"]];
    }
    
    [NSApp terminate:self];
  }
}

@end
