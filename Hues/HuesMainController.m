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
#import "NSColor+Extras.h"
#import "HuesLoupeView.h"
#import "HuesLoupeWindow.h"

@interface HuesMainController ()

- (void)copyToClipboard:(NSString *)value;
- (void)updateLabelsWithColor:(NSColor *)color;

@end


@implementation HuesMainController

@synthesize colorPanel, colorsView, hexField, rgbLabel, hslLabel;

- (id)init
{
  if ((self = [super init]))
  {
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
    [self.colorPanel setMaxSize:NSMakeSize(FLT_MAX, FLT_MAX)];
    
    [NSBundle loadNibNamed:@"HuesColorsView" owner:self];
    
    [self updateLabelsWithColor:[self.colorPanel color]];
    
    [self.colorPanel setAccessoryView:self.colorsView];
    [self.colorsView setFrame:NSMakeRect(0, [self.colorsView frame].origin.y + 6, [self.colorPanel frame].size.width, [self.colorsView bounds].size.height)];
    
//    NSButton *button = (NSButton *)[self.colorPanel firstResponder];
//    [button setTarget:self];
//    [button setAction:@selector(showPicker:)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateColor:) name:HuesUpdateColorNotification object:nil];
  }
  
  return self;
}


- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  self.colorPanel = nil;
  self.colorsView = nil;
  self.hexField = nil;
  self.rgbLabel = nil;
  
  [super dealloc];
}


- (void)colorChanged:(id)sender
{
	NSColor *color = [sender color];
  //NSLog(@"colorChanged: %@", color);
  [[HuesHistoryManager sharedManager] addColor:color];
 
  if ([HuesPreferences copyToClipboard])
  {
    if ([HuesPreferences defaultRepresentation] == HuesHexRepresentation)
    {
      [self copyToClipboard:[color hues_hex]];
    }
    else if ([HuesPreferences defaultRepresentation] == HuesRGBRepresentation)
    {
      [self copyToClipboard:[color hues_rgb]];
    }
    else if ([HuesPreferences defaultRepresentation] == HuesHSLRepresentation)
    {
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
  NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:shadow, NSShadowAttributeName, [NSFont fontWithName:@"Lucida Grande" size:14.0], NSFontAttributeName, nil];
  
  NSAttributedString *hexString = [[[NSAttributedString alloc] initWithString:[color hues_hex] attributes:attributes] autorelease];
  NSAttributedString *rgbString = [[[NSAttributedString alloc] initWithString:[color hues_rgb] attributes:attributes] autorelease];
  NSAttributedString *hslString = [[[NSAttributedString alloc] initWithString:[color hues_hsl] attributes:attributes] autorelease];
  
	[self.hexField setAttributedStringValue:hexString];
  [self.rgbLabel setAttributedStringValue:rgbString];
  [self.hslLabel setAttributedStringValue:hslString];
}


- (void)copyHex:(id)sender
{
	[self copyToClipboard:[[[NSColorPanel sharedColorPanel] color] hues_hex]];
}


- (void)copyRGB:(id)sender
{
	[self copyToClipboard:[[[NSColorPanel sharedColorPanel] color] hues_rgb]];
}


- (void)copyHSL:(id)sender
{
	[self copyToClipboard:[[[NSColorPanel sharedColorPanel] color] hues_hsl]];
}


- (void)copyToClipboard:(NSString *)value
{
	[[NSPasteboard generalPasteboard] declareTypes:[NSArray arrayWithObject:NSStringPboardType] owner:self];
	[[NSPasteboard generalPasteboard] setString:value forType:NSStringPboardType];
}


- (void)showPicker:(id)sender
{
  NSPoint point = [NSEvent mouseLocation];
  
  HuesLoupeWindow *loupe = [[HuesLoupeWindow alloc] initWithContentRect:NSMakeRect(point.x - 100, point.y - 100, 201, 201) styleMask:0 backing:NSBackingStoreBuffered defer:YES];
  [loupe setContentView:[[[HuesLoupeView alloc] initWithFrame:NSMakeRect(0, 0, 201, 201)] autorelease]];
  [loupe makeKeyAndOrderFront:nil];
}


#pragma mark - Color input

- (void)controlTextDidChange:(NSNotification *)notification
{
  if ([notification object] == self.hexField)
  {
    NSString *value = [self.hexField stringValue];
    NSColor *newColor = [NSColor hues_colorFromHex:value];
    
    if (newColor != nil)
    {
      [self updateLabelsWithColor:newColor];
      [self.colorPanel setColor:newColor];
    }
  }
}


// Make sure app quits after panel is closed
- (void)windowWillClose:(NSNotification *)notification
{
	[[NSApplication sharedApplication] terminate:nil];
}

@end
