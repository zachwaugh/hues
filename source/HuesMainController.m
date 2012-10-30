//
//  HuesMainController.m
//  Hues
//
//  Created by Zach Waugh on 12/27/10.
//  Copyright 2010 Giant Comet. All rights reserved.
//

// NSColorPanelWheelModeMask            - Color Wheel
// NSColorPanelGrayModeMask             - Color Sliders
// NSColorPanelRGBModeMask              - Color Sliders
// NSColorPanelCMYKModeMask             - Color Sliders
// NSColorPanelHSBModeMask              - Color Sliders
// NSColorPanelColorListModeMask        - Color Palettes
// NSColorPanelCustomPaletteModeMask    - Image Palettes
// NSColorPanelCrayonModeMask           - Crayons
// NSColorPanelAllModesMask             - All

#import "HuesMainController.h"
#import "HuesColorsView.h"
#import "HuesPreferences.h"
#import "HuesHistoryManager.h"
#import "HuesGlobal.h"
#import "NSColor+Hues.h"
#import "HuesLoupeView.h"
#import "HuesLoupeWindow.h"

@interface HuesMainController ()

- (void)copyToClipboard:(NSString *)value;
- (void)updateLabelsWithColor:(NSColor *)color;

@end

@implementation HuesMainController

- (id)init
{
  if ((self = [super init])) {
    self.colorPanel = [NSColorPanel sharedColorPanel];
    [self.colorPanel setStyleMask:NSTitledWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask | NSResizableWindowMask];
    [self.colorPanel setTitle:@"Hues"];
		[self.colorPanel setDelegate:self];
    [self.colorPanel setShowsAlpha:YES];
    [self.colorPanel setFloatingPanel:NO];
    [self.colorPanel setHidesOnDeactivate:NO];
    [self.colorPanel setShowsAlpha:YES];
    [self.colorPanel setTarget:self];
    [self.colorPanel setAction:@selector(colorChanged:)];
    [self.colorPanel makeKeyAndOrderFront:nil];
		[self.colorPanel setReleasedWhenClosed:NO];
    [self.colorPanel setMaxSize:NSMakeSize(800, FLT_MAX)];
		[self.colorPanel setCollectionBehavior:NSWindowCollectionBehaviorCanJoinAllSpaces];
		
		if ([HuesPreferences keepOnTop]) {
			[self.colorPanel setLevel:NSFloatingWindowLevel];
		}
    
    [NSBundle loadNibNamed:@"HuesColorsView" owner:self];
    
    [self updateLabelsWithColor:[self.colorPanel color]];
    
    [self.colorPanel setAccessoryView:self.colorsView];
    [self.colorsView setFrame:NSMakeRect(0, self.colorsView.frame.origin.y + 6, self.colorPanel.frame.size.width, self.colorsView.bounds.size.height)];
    
    //NSButton *button = (NSButton *)[self.colorPanel firstResponder];
    //[button setTarget:self];
    //[button setAction:@selector(showPicker:)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateColor:) name:HuesUpdateColorNotification object:nil];
  }
  
  return self;
}

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  self.colorPanel = nil;
  self.colorsView = nil;
  self.primaryFormat = nil;
  self.secondaryFormat = nil;

  [super dealloc];
}

- (void)colorChanged:(id)sender
{
	NSColor *color = [sender color];
  //NSLog(@"colorChanged: %@", color);
  [[HuesHistoryManager sharedManager] addColor:color];
 
  if ([HuesPreferences copyToClipboard]) {
    if ([HuesPreferences defaultRepresentation] == HuesHexRepresentation) {
      [self copyToClipboard:[color hues_hex]];
    } else if ([HuesPreferences defaultRepresentation] == HuesRGBRepresentation) {
      [self copyToClipboard:[color hues_rgb]];
    } else if ([HuesPreferences defaultRepresentation] == HuesHSLRepresentation) {
      [self copyToClipboard:[color hues_hsb]];
    }
  }
  
  [self updateLabelsWithColor:color];
}

- (void)updateColor:(NSNotification *)notification
{
  NSColor *color = [notification object];
  [self.colorPanel setColor:color];
  [self updateLabelsWithColor:color];
}

- (void)updateLabelsWithColor:(NSColor *)color
{
  // Setup overlay text attributes
  NSShadow *shadow = [[[NSShadow alloc] init] autorelease];
  [shadow setShadowColor:[NSColor colorWithCalibratedWhite:1.0 alpha:0.5]];
  [shadow setShadowOffset:NSMakeSize(0, -1)];
  
  NSAttributedString *hexString = [[[NSAttributedString alloc] initWithString:[color hues_hex] attributes:@{NSFontAttributeName: [NSFont fontWithName:@"Lucida Grande" size:16.0], NSShadowAttributeName: shadow}] autorelease];
  NSAttributedString *rgbString = [[[NSAttributedString alloc] initWithString:[color hues_rgb] attributes:@{NSFontAttributeName: [NSFont fontWithName:@"Lucida Grande" size:14.0], NSShadowAttributeName: shadow}] autorelease];
  
	[self.primaryFormat setAttributedStringValue:hexString];
  [self.secondaryFormat setAttributedStringValue:rgbString];
}

#pragma mark - Clipboard

- (void)copyPrimary:(id)sender
{
	[self copyToClipboard:[[[NSColorPanel sharedColorPanel] color] hues_hex]];
}

- (void)copySecondary:(id)sender
{
	[self copyToClipboard:[[[NSColorPanel sharedColorPanel] color] hues_rgb]];
}

- (void)copyAlternate:(id)sender
{
	[self copyToClipboard:[[[NSColorPanel sharedColorPanel] color] hues_hsl]];
}

- (void)copyToClipboard:(NSString *)string
{
	[[NSPasteboard generalPasteboard] clearContents];
	[[NSPasteboard generalPasteboard] writeObjects:@[string]];
}

#pragma mark - Loupe

- (void)showPicker:(id)sender
{
  NSPoint point = [NSEvent mouseLocation];
  
  HuesLoupeWindow *loupe = [[HuesLoupeWindow alloc] initWithContentRect:NSMakeRect(point.x - round(LOUPE_SIZE / 2), point.y - round(LOUPE_SIZE / 2), LOUPE_SIZE, LOUPE_SIZE) styleMask:0 backing:NSBackingStoreBuffered defer:YES];
  [[loupe contentView] addSubview:[[[HuesLoupeView alloc] initWithFrame:NSMakeRect(0, 0, LOUPE_SIZE, LOUPE_SIZE)] autorelease]];
  [loupe makeKeyAndOrderFront:nil];
}

#pragma mark - Color input

- (void)controlTextDidChange:(NSNotification *)notification
{
  if ([notification object] == self.primaryFormat) {
    NSString *value = [self.primaryFormat stringValue];
    NSColor *newColor = [NSColor hues_colorFromHex:value];
    
    if (newColor != nil) {
      [self updateLabelsWithColor:newColor];
      [self.colorPanel setColor:newColor];
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

#pragma mark - Window

- (void)showWindow:(id)sender
{
	[self.colorPanel makeKeyAndOrderFront:sender];
}

- (IBAction)toggleKeepOnTop:(id)sender
{
	BOOL keepOnTop = ![HuesPreferences keepOnTop];
	
	[self.colorPanel setLevel:(keepOnTop) ? NSFloatingWindowLevel : NSNormalWindowLevel];
	[HuesPreferences setKeepOnTop:keepOnTop];
}

- (void)toggleWindow
{

}

// Make sure app quits after panel is closed
- (void)windowWillClose:(NSNotification *)notification
{
	//[[NSApplication sharedApplication] terminate:nil];
}

@end
