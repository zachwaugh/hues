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
#import "HuesSyncManager.h"
#import "MASShortcutView+UserDefaults.h"
#import "MASShortcut+UserDefaults.h"
#import "MASShortcut+Monitoring.h"
#import <HockeySDK/HockeySDK.h>

#ifndef APP_STORE
#import <Sparkle/Sparkle.h>
#define SPARKLE_FEED @"https://rink.hockeyapp.net/api/2/apps/6e6b92dcca1dbb0b4eb922bfa9942688"
#endif

@interface HuesAppDelegate () <BITHockeyManagerDelegate>

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
	
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	BITSystemProfile *bsp = [BITSystemProfile sharedSystemProfile];
	[nc addObserver:bsp selector:@selector(startUsage) name:NSApplicationDidFinishLaunchingNotification object:nil];
	[nc addObserver:bsp selector:@selector(stopUsage) name:NSApplicationWillTerminateNotification object:nil];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
#if BETA
#warning Beta is enabled
	[self checkForBetaExpiration];
#endif
	
#ifndef APP_STORE
	SUUpdater *updater = [SUUpdater sharedUpdater];
	updater.automaticallyChecksForUpdates = YES;
	updater.feedURL = [NSURL URLWithString:SPARKLE_FEED];
	updater.sendsSystemProfile = YES;
#else
	// Remove Sparkle menu in app store build
	[self.checkForUpdatesMenuItem.menu removeItem:self.checkForUpdatesMenuItem];
#endif
	
	// HockeyApp
	[[BITHockeyManager sharedHockeyManager] configureWithIdentifier:@"6e6b92dcca1dbb0b4eb922bfa9942688" companyName:@"Giant comet" delegate:self];
	[[BITHockeyManager sharedHockeyManager] startManager];
	
	[self configureApplicationPresentation];
	[self registerShortcuts];
	
	// Init sync stores
	//[HuesSyncManager sharedManager];
	
	[[NSUserNotificationCenter defaultUserNotificationCenter] setDelegate:self];
	[HuesPalettesManager sharedManager];
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
	[[HuesPalettesManager sharedManager] save];
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag
{	
	if (!flag) {
		[self.windowController showWindow:nil];
	}
	
	return YES;
}

- (void)awakeFromNib
{
  [HuesHistoryManager sharedManager].menu = self.historyMenu;
}

#pragma mark - Files

- (BOOL)application:(NSApplication *)sender openFile:(NSString *)filename
{
	if ([filename.pathExtension isEqualToString:@"hues"]) {
		[[HuesPalettesManager sharedManager] importFiles:@[filename]];
		return YES;
	} else {
		return NO;
	}
}

#pragma mark - Notification Center

- (BOOL)userNotificationCenter:(NSUserNotificationCenter *)center shouldPresentNotification:(NSUserNotification *)notification
{
	// Always deliver notifications, even if Hues is active
	return YES;
}

#pragma mark - Shortcuts

- (void)registerShortcuts
{
	// Global shortcut to show loupe
	[MASShortcut registerGlobalShortcutWithUserDefaultsKey:HuesLoupeShortcutKey handler:^{
		[[HuesLoupeController sharedController] showLoupe:self];
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
	HuesStatusItemView *statusView = [[HuesStatusItemView alloc] initWithFrame:NSZeroRect];
	
	self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:25];
	self.statusItem.view = statusView;
	statusView.statusItem = self.statusItem;
	statusView.target = self;
	statusView.action = @selector(toggleWindow:);
	statusView.altTarget = [HuesLoupeController sharedController];
	statusView.altAction = @selector(showLoupe:);
	statusView.menu = self.statusMenu;
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

#pragma mark - Actions

- (void)showLoupe:(id)sender
{
	[[HuesLoupeController sharedController] showLoupe:sender];
}

- (void)showPreferences:(id)sender
{
  if (!self.preferencesController) {
    self.preferencesController = [[HuesPreferencesController alloc] init];
  }
  
  [self.preferencesController showWindow:sender];
}

#pragma mark - Hockey SDK

- (void)showMainApplicationWindowForCrashManager:(BITCrashManager *)crashManager
{
	self.windowController = [[HuesWindowController alloc] init];
	[self.windowController showWindow:nil];
}

#pragma mark - Sparkle

#ifndef APP_STORE

- (void)checkForUpdates:(id)sender
{
  [[SUUpdater sharedUpdater] checkForUpdates:sender];
}

- (NSArray *)feedParametersForUpdater:(SUUpdater *)updater sendingSystemProfile:(BOOL)sendingProfile
{
	return [[BITSystemProfile sharedSystemProfile] systemUsageData];
}

#endif

#pragma mark - Beta

- (void)checkForBetaExpiration
{  
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
