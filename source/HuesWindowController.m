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
	
	// Setup custom window titlebar
	INAppStoreWindow *window = (INAppStoreWindow*)self.window;
	window.titleBarHeight = 34.0;
	
	NSView *titleBarView = window.titleBarView;
	NSImage *loupe = [NSImage imageNamed:@"loupe-button"];
	NSRect buttonFrame = NSMakeRect(NSMaxX(titleBarView.bounds) - loupe.size.width - 10, NSMidY(titleBarView.bounds) - (loupe.size.height / 2.f), loupe.size.width, loupe.size.height);
	NSButton *button = [[NSButton alloc] initWithFrame:buttonFrame];
	[button setBordered:NO];
	[button setImage:loupe];
	[button setTarget:self];
	[button setAction:@selector(showLoupe:)];
	button.autoresizingMask = (NSViewMinXMargin | NSViewMinYMargin);
	[titleBarView addSubview:button];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateColor:) name:HuesUpdateColorNotification object:nil];
	
  if ([HuesPreferences keepOnTop]) {
		[self.window setLevel:NSFloatingWindowLevel];
	}
	
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
	NSLog(@"updateColor: %@", notification);
  NSColor *color = [notification object];
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
  
  NSAttributedString *hexString = [[NSAttributedString alloc] initWithString:[color hues_hex] attributes:@{NSFontAttributeName: [NSFont fontWithName:@"Lucida Grande" size:16.0], NSShadowAttributeName: shadow}];
  NSAttributedString *rgbString = [[NSAttributedString alloc] initWithString:[color hues_rgb] attributes:@{NSFontAttributeName: [NSFont fontWithName:@"Lucida Grande" size:14.0], NSShadowAttributeName: shadow}];
  
	[self.primaryFormat setAttributedStringValue:hexString];
  [self.secondaryFormat setAttributedStringValue:rgbString];
	
	[self.alternateFormats removeAllItems];
	
	[self.alternateFormats addItemsWithTitles:@[[color hues_hsl]]];
	[self.alternateFormats addItemsWithTitles:@[[color hues_hsb]]];
	[self.alternateFormats.menu addItem:[NSMenuItem separatorItem]];
	[self.alternateFormats addItemsWithTitles:@[[color hues_NSColorCalibratedRGB], [color hues_NSColorCalibratedHSB], [color hues_NSColorDeviceRGB], [color hues_NSColorDeviceHSB]]];
	[self.alternateFormats.menu addItem:[NSMenuItem separatorItem]];
	[self.alternateFormats addItemsWithTitles:@[[color hues_UIColorRGB], [color hues_UIColorHSB]]];

}

#pragma mark - Clipboard

- (void)copyPrimary:(id)sender
{
	[self copyToClipboard:[self.color hues_hex]];
}

- (void)copySecondary:(id)sender
{
	[self copyToClipboard:[self.color hues_rgb]];
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
	self.mixerController.view.frame = self.mixerContainerView.bounds;
	[self.mixerContainerView addSubview:self.mixerController.view];
}

- (IBAction)changeMixerTab:(id)sender
{
	NSString *title = [sender title];
	
	if ([title isEqualToString:@"RGB"]) {
		[self loadMixerWithClass:[HuesRGBViewController class]];
	} else if ([title isEqualToString:@"HSB"]) {
		[self loadMixerWithClass:[HuesHSBViewController class]];
	} else if ([title isEqualToString:@"Color Wheel"]) {
		[self loadMixerWithClass:[HuesColorWheelViewController class]];
	}
}

#pragma mark - Loupe

- (void)showLoupe:(id)sender
{
	[(HuesAppDelegate *)[NSApp delegate] showLoupe:sender];
}

#pragma mark - Color input

- (void)controlTextDidChange:(NSNotification *)notification
{
  if (notification.object == self.primaryFormat) {
    NSString *value = [self.primaryFormat stringValue];
    NSColor *newColor = [NSColor hues_colorFromHex:value];
    
    if (newColor != nil) {
      [self updateInterfaceWithColor:newColor];
    }
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

@end
