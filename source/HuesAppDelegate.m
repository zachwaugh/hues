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
#import "HuesWindowController.h"
#import "HuesLoupeView.h"
#import "HuesLoupeWindow.h"
#import "MASShortcutView+UserDefaults.h"
#import "MASShortcut+UserDefaults.h"
#import "MASShortcut+Monitoring.h"

@interface HuesAppDelegate ()

@property (strong) HuesWindowController *windowController;
@property (strong) HuesPreferencesController *preferencesController;
@property (strong) NSMenu *historyMenu;
@property (strong) NSStatusItem *statusItem;
@property (strong) HuesLoupeWindow *loupeWindow;
@property (assign) id monitor;

- (void)configureApplicationPresentation;
- (void)registerShortcuts;
- (void)startEventMonitor;
- (void)stopEventMonitor;
- (void)observeNotifications;

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
	[self startEventMonitor];
	[self observeNotifications];
}

- (void)awakeFromNib
{
  [HuesHistoryManager sharedManager].menu = self.historyMenu;
}

- (void)observeNotifications
{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loupeWindowDidClose:) name:HuesLoupeWindowDidCloseNotification object:nil];
}

#pragma mark - Shortcuts

- (void)registerShortcuts
{
	// Global shortcut
	[MASShortcut registerGlobalShortcutWithUserDefaultsKey:HuesLoupeShortcutKey handler:^{
		[self showLoupe:nil];
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
	if ([self.windowController.window isVisible]) {
		[NSApp hide:nil];
		[self.windowController hideWindow];
	} else {
		[NSApp activateIgnoringOtherApps:YES];
		[self.windowController showWindow:nil];
	}
}

- (void)showPreferences:(id)sender
{
  if (self.preferencesController == nil) {
    self.preferencesController = [[HuesPreferencesController alloc] initWithWindowNibName:@"HuesPreferences"];
  }
  
  [self.preferencesController showWindow:sender];
}

#pragma mark - Loupe

- (IBAction)showLoupe:(id)sender
{
	NSPoint point = [NSEvent mouseLocation];
	NSRect loupeRect = NSMakeRect(round(point.x) - round(HuesLoupeSize / 2), round(point.y) - round(HuesLoupeSize / 2), HuesLoupeSize, HuesLoupeSize);
	
	//NSLog(@"showLoupe: %@, active: %d", NSStringFromRect(loupeRect), [NSApp isActive]);
	
	if (!self.loupeWindow) {
		self.loupeWindow = [[HuesLoupeWindow alloc] initWithFrame:loupeRect];
		self.loupeWindow.delegate = self;
	} else {
		[self.loupeWindow adjustLoupeWithOrigin:loupeRect.origin];
	}
	
  [self.loupeWindow show];
}

- (void)loupeWindowDidClose:(NSNotification *)notification
{

}

- (void)startEventMonitor
{
	self.monitor = [NSEvent addGlobalMonitorForEventsMatchingMask:NSMouseMovedMask handler:^(NSEvent *event ){
		if (self.loupeWindow && [self.loupeWindow isVisible]) {
			//NSLog(@"[monitor] sending mouseMoved: %@, app active: %d", NSStringFromPoint(event.locationInWindow), [NSApp isActive]);
			[self.loupeWindow mouseMoved:event];
		}
	}];
}

- (void)stopEventMonitor
{
	[NSEvent removeMonitor:self.monitor];
	self.monitor = nil;
}

#pragma mark - NSWindowDelegate

- (void)windowWillClose:(NSNotification *)notification
{
	//NSLog(@"windowWillClose: %@", notification.object);
}

- (void)windowDidBecomeKey:(NSNotification *)notification
{
	//NSLog(@"windowDidBecomeKey: %@", notification.object);
}

- (void)windowDidBecomeMain:(NSNotification *)notification
{
	//NSLog(@"windowDidBecomeMain: %@", notification.object);
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
