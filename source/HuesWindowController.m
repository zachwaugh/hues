//
//  HuesWindowController.m
//  Hues
//
//  Created by Zach Waugh on 11/28/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import "HuesWindowController.h"
#import "HuesLoupeWindow.h"
#import "HuesLoupeView.h"
#import "NSColor+Hues.h"
#import "HuesPreferences.h"
#import "HuesColorSlider.h"
#import "INAppStoreWindow.h"
#import "HuesAppDelegate.h"
#import "HuesMixerViewController.h"
#import "HuesRGBViewController.h"
#import "HuesHSBViewController.h"
#import "HuesColorWheelViewController.h"
#import "HuesScopeBarView.h"
#import "HuesColorParser.h"
#import "HuesColorFormatter.h"

@interface HuesWindowController ()

@property (strong) NSColor *color;
@property (strong) HuesMixerViewController *mixerController;

- (void)updateInterfaceWithColor:(NSColor *)color;

@end

@implementation HuesWindowController

- (id)init
{
	self = [super initWithWindowNibName:@"HuesWindowController" owner:self];
	if (self) {
		_color = [NSColor colorWithCalibratedRed:1 green:1 blue:1 alpha:1];
	}
	
	return self;
}

- (void)windowDidLoad
{
	[super windowDidLoad];
	
	if ([HuesPreferences keepOnTop]) {
		[self.window setLevel:NSFloatingWindowLevel];
	}
	
	// Show window on all spaces
	[self.window setCollectionBehavior:NSWindowCollectionBehaviorCanJoinAllSpaces];
	
	// Setup custom window titlebar
	INAppStoreWindow *window = (INAppStoreWindow *)self.window;
	window.titleBarHeight = 34.0;
	
	NSView *titleBarView = window.titleBarView;
	NSImage *loupe = [NSImage imageNamed:@"magnifier"];
	NSRect buttonFrame = NSMakeRect(NSMaxX(titleBarView.bounds) - loupe.size.width - 10, NSMidY(titleBarView.bounds) - (loupe.size.height / 2.f), loupe.size.width, loupe.size.height);
	NSButton *button = [[NSButton alloc] initWithFrame:buttonFrame];
	[button setBordered:NO];
	[button setImage:loupe];
	[button setTarget:self];
	[button setButtonType:NSMomentaryChangeButton];
	[button setAction:@selector(showLoupe:)];
	button.autoresizingMask = (NSViewMinXMargin | NSViewMinYMargin);
	[titleBarView addSubview:button];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateColor:) name:HuesUpdateColorNotification object:nil];
	
	self.scopeBar.delegate = self;
	self.scopeBar.titles = @[@"RGB", @"HSB", @"Color Wheel"];
	
	[self loadMixerWithClass:[HuesRGBViewController class]];
	[self updateInterfaceWithColor:self.color];
}

- (void)hideWindow
{
	[self.window orderOut:nil];
}

- (void)showWindow:(id)sender
{
	[self.window makeKeyAndOrderFront:nil];
}

- (IBAction)toggleKeepOnTop:(id)sender
{
	BOOL keepOnTop = ![HuesPreferences keepOnTop];
	
	[self.window setLevel:(keepOnTop) ? NSFloatingWindowLevel : NSNormalWindowLevel];
	[HuesPreferences setKeepOnTop:keepOnTop];
}

// Called from loupe
- (void)updateColor:(NSNotification *)notification
{
  NSColor *color = notification.object;
	self.color = color;
	[self.mixerController updateInterfaceWithColor:color];
  [self updateInterfaceWithColor:color];
}

- (void)updateInterfaceWithColor:(NSColor *)color
{
	self.colorWell.color = color;
	
  // Setup overlay text attributes
  NSShadow *shadow = [[NSShadow alloc] init];
  [shadow setShadowColor:[NSColor colorWithCalibratedWhite:1.0 alpha:0.5]];
  [shadow setShadowOffset:NSMakeSize(0, -1)];
  
	NSDictionary *attributes = @{NSFontAttributeName: [NSFont fontWithName:@"HelveticaNeue" size:13.0], NSShadowAttributeName: shadow};
	
  NSAttributedString *primary = [[NSAttributedString alloc] initWithString:[HuesColorFormatter stringForColorWithDefaultFormat:self.color] attributes:attributes];
  NSAttributedString *secondary = [[NSAttributedString alloc] initWithString:[HuesColorFormatter stringForColorWithSecondaryFormat:self.color] attributes:attributes];
  
	self.primaryFormat.attributedStringValue = primary;
	self.secondaryFormat.attributedStringValue = secondary;
	
	[self.alternateFormats removeAllItems];
	
	NSArray *formats = [HuesPreferences colorFormats];
	
	for (NSDictionary *format in formats) {
		NSString *value = [HuesColorFormatter stringForColor:self.color withFormat:format[@"format"]];
		[self.alternateFormats addItemsWithTitles:@[value]];
	}
}

#pragma mark - Clipboard

- (void)copyPrimary:(id)sender
{
	[self copyToClipboard:[HuesColorFormatter stringForColorWithDefaultFormat:self.color]];
}

- (void)copySecondary:(id)sender
{
	[self copyToClipboard:[HuesColorFormatter stringForColorWithSecondaryFormat:self.color]];
}

- (void)copyAlternate:(id)sender
{
	NSMenuItem *item = [self.alternateFormats selectedItem];
	[self copyToClipboard:item.title];
}

- (void)copyToClipboard:(NSString *)string
{
	[[NSPasteboard generalPasteboard] clearContents];
	[[NSPasteboard generalPasteboard] writeObjects:@[string]];
}

#pragma mark - Mixer tabs

- (void)loadMixerWithClass:(Class)class
{
	if (self.mixerController) {
		[self.mixerController.view removeFromSuperview];
		self.mixerController = nil;
	}
	
	self.mixerController = [[class alloc] init];
	self.mixerController.color = self.color;
	NSView *mixerView = self.mixerController.view;
	mixerView.frame = self.mixerContainerView.bounds;
	[self.mixerContainerView addSubview:mixerView];	
}

#pragma mark - Loupe

- (void)showLoupe:(id)sender
{
	[(HuesAppDelegate *)[NSApp delegate] showLoupe:sender];
}

#pragma mark - Color input

- (void)controlTextDidChange:(NSNotification *)notification
{
	NSTextField *field = notification.object;
	NSString *value = field.stringValue;
	NSColor *newColor = [HuesColorParser parseColorFromString:value];
	
	if (newColor != nil) {
		self.color = newColor;
		[self updateInterfaceWithColor:newColor];
		[self.mixerController updateInterfaceWithColor:newColor];
	}
}

- (void)didUpdateColorText:(id)sender
{
	NSTextField *field = sender;
	NSString *value = field.stringValue;
	NSColor *newColor = [HuesColorParser parseColorFromString:value];
	
	if (newColor != nil) {
		self.color = newColor;
		[self updateInterfaceWithColor:newColor];
		[self.mixerController updateInterfaceWithColor:newColor];
	}
}

#pragma mark - Menu Validation

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem
{
	if (menuItem.action == @selector(toggleKeepOnTop:)) {
		[menuItem setState:([HuesPreferences keepOnTop]) ? NSOnState : NSOffState];
	}
	
	return YES;
}

#pragma mark - HuesScopeBarViewDelegate

- (void)scopeBarDidSelectTabWithTitle:(NSString *)title
{
	if ([title isEqualToString:@"RGB"]) {
		[self loadMixerWithClass:[HuesRGBViewController class]];
	} else if ([title isEqualToString:@"HSB"]) {
		[self loadMixerWithClass:[HuesHSBViewController class]];
	} else if ([title isEqualToString:@"Color Wheel"]) {
		[self loadMixerWithClass:[HuesColorWheelViewController class]];
	}
}

@end
