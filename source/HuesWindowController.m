//
//  HuesWindowController.m
//  Hues
//
//  Created by Zach Waugh on 11/28/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import "HuesWindowController.h"
#import "HuesLoupeController.h"
#import "HuesPreferences.h"
#import "HuesMixerViewController.h"
#import "HuesRGBViewController.h"
#import "HuesHSLMixerController.h"
#import "HuesColorSlider.h"
#import "HuesColorWheelViewController.h"
#import "HuesPalettesController.h"
#import "HuesScopeBarView.h"
#import "HuesColorParser.h"
#import "HuesColor.h"
#import "HuesColor+Formatting.h"
#import "INAppStoreWindow.h"

@interface HuesWindowController ()

@property (strong) HuesColor *color;
@property (strong) HuesMixerViewController *mixerController;

- (void)updateInterfaceWithColor:(HuesColor *)color;

@end

@implementation HuesWindowController

- (id)init
{
	self = [super initWithWindowNibName:@"HuesWindowController"];
	if (!self) return nil;
	
	_color = [HuesColor colorWithRed:1 green:1 blue:1 alpha:1];
	
	return self;
}

#pragma mark - Window delegate

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
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(colorFormatsUpdated:) name:HuesColorFormatsUpdatedNotification object:nil];
	
	self.scopeBar.delegate = self;
	self.scopeBar.titles = @[@"RGB", @"HSL", @"Color Wheel", @"Palettes"];
	
	[self updateFormatLabels];
	
	[self scopeBarDidSelectTabWithTitle:self.scopeBar.titles[[HuesPreferences lastSelectedTabIndex]]];
	[self updateInterfaceWithColor:self.color];
}

// Fix sheet having wrong position due to custom title bar
- (NSRect)window:(NSWindow *)window willPositionSheet:(NSWindow *)sheet usingRect:(NSRect)rect
{
	rect.origin.y = NSHeight(window.frame) - 34.0f;
	return rect;
}

- (void)hideWindow
{
	[self.window orderOut:nil];
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
  HuesColor *color = notification.object;
	self.color = color;
	[self copyPrimary:nil];
	
	[self.mixerController updateInterfaceWithColor:color];
  [self updateInterfaceWithColor:color];
}

- (void)updateInterfaceWithColor:(HuesColor *)color
{
	self.colorWell.color = color.deviceColor;
	
  // Setup overlay text attributes
  NSShadow *shadow = [[NSShadow alloc] init];
  [shadow setShadowColor:[NSColor colorWithCalibratedWhite:1.0 alpha:0.5]];
  [shadow setShadowOffset:NSMakeSize(0, -1)];
  
	NSDictionary *attributes = @{NSFontAttributeName: [NSFont fontWithName:@"HelveticaNeue" size:13.0], NSShadowAttributeName: shadow};
	
  NSAttributedString *primary = [[NSAttributedString alloc] initWithString:[self stringForPrimaryFormat] attributes:attributes];
  NSAttributedString *secondary = [[NSAttributedString alloc] initWithString:[self stringForSecondaryFormat]  attributes:attributes];
  
	self.primaryFormat.attributedStringValue = primary;
	self.secondaryFormat.attributedStringValue = secondary;
	
	NSInteger selectedIndex = [self.alternateFormats indexOfSelectedItem];
	[self.alternateFormats removeAllItems];
	
	NSArray *formats = [HuesPreferences colorFormats];

	for (NSDictionary *format in formats) {
		NSString *value = [self.color stringWithFormat:format[@"format"]];
		[self.alternateFormats addItemWithTitle:value];
	}
	
	[self.alternateFormats selectItemAtIndex:(selectedIndex != -1) ? selectedIndex : 2];
}

- (void)colorFormatsUpdated:(NSNotification *)notification
{
	[self updateFormatLabels];
}

- (void)updateFormatLabels
{
	NSArray *formats = [HuesPreferences colorFormats];
	NSDictionary *primaryFormat = formats[0];
	NSDictionary *secondaryFormat = formats[1];
	
	self.primaryFormatLabel.stringValue = primaryFormat[@"name"];
	self.primaryFormat.stringValue = [self.color stringWithFormat:primaryFormat[@"format"]];
	
	self.secondaryFormatLabel.stringValue = secondaryFormat[@"name"];
	self.secondaryFormat.stringValue = [self.color stringWithFormat:secondaryFormat[@"format"]];
	
	NSInteger selectedIndex = [self.alternateFormats indexOfSelectedItem];
	[self.alternateFormats removeAllItems];
	
	for (NSDictionary *format in formats) {
		NSString *value = [self.color stringWithFormat:format[@"format"]];
		[self.alternateFormats addItemWithTitle:value];
	}
	
	[self.alternateFormats selectItemAtIndex:(selectedIndex != -1) ? selectedIndex : 2];
}

- (NSString *)stringForPrimaryFormat
{
	NSArray *formats = [HuesPreferences colorFormats];
	NSString *format = formats[0][@"format"];
	
	return [self.color stringWithFormat:format];
}

- (NSString *)stringForSecondaryFormat
{
	NSArray *formats = [HuesPreferences colorFormats];
	NSString *format = formats[1][@"format"];
	
	return [self.color stringWithFormat:format];
}

#pragma mark - Clipboard

- (void)copyPrimary:(id)sender
{
	[self copyToClipboard:[self stringForPrimaryFormat]];
}

- (void)copySecondary:(id)sender
{
	[self copyToClipboard:[self stringForSecondaryFormat]];
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

- (void)selectTabAtIndex:(NSInteger)index
{
	[self.scopeBar selectTabAtIndex:index];
	[self scopeBarDidSelectTabWithTitle:self.scopeBar.titles[index]];
}

#pragma mark - Loupe

- (void)showLoupe:(id)sender
{
	[[HuesLoupeController sharedController] showLoupe];
}

#pragma mark - Color input

- (void)controlTextDidChange:(NSNotification *)notification
{
	NSTextField *field = notification.object;
	NSString *value = field.stringValue;
	HuesColor *newColor = [HuesColorParser parseColorFromString:value];
	
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
	HuesColor *newColor = [HuesColorParser parseColorFromString:value];
	
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
	} else if ([title isEqualToString:@"HSL"]) {
		[self loadMixerWithClass:[HuesHSLMixerController class]];
	} else if ([title isEqualToString:@"Color Wheel"]) {
		[self loadMixerWithClass:[HuesColorWheelViewController class]];
	} else if ([title isEqualToString:@"Palettes"]) {
		[self loadMixerWithClass:[HuesPalettesController class]];
	}
}

@end
