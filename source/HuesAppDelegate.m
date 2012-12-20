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
	
	NSLog(@"showLoupe: %@, active: %d", NSStringFromRect(loupeRect), [NSApp isActive]);
  self.loupeWindow = [[HuesLoupeWindow alloc] initWithContentRect:loupeRect styleMask:0 backing:NSBackingStoreBuffered defer:YES];
	self.loupeWindow.delegate = self;
	[self.loupeWindow makeKeyAndOrderFront:self];
}

- (void)loupeWindowDidClose:(NSNotification *)notification
{
	self.loupeWindow = nil;
}

- (void)startEventMonitor
{
	self.monitor = [NSEvent addGlobalMonitorForEventsMatchingMask:NSMouseMovedMask handler:^(NSEvent *event ){
		if (self.loupeWindow) {
			NSLog(@"[monitor] sending mouseMoved: %@, app active: %d", NSStringFromPoint(event.locationInWindow), [NSApp isActive]);
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
	NSLog(@"windowWillClose: %@", notification.object);
}

- (void)windowDidBecomeKey:(NSNotification *)notification
{
	NSLog(@"windowDidBecomeKey: %@", notification.object);
}

- (void)windowDidBecomeMain:(NSNotification *)notification
{
	NSLog(@"windowDidBecomeMain: %@", notification.object);
}

@end
