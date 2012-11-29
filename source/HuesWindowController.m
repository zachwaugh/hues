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

@interface HuesWindowController ()

@property (retain) NSColor *color;

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
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateColor:) name:HuesUpdateColorNotification object:nil];
	
  if ([HuesPreferences keepOnTop]) {
		//[self.window setLevel:NSFloatingWindowLevel];
	}
	
	[self updateLabelsWithColor:self.color];
}

- (void)windowDidResignKey:(NSNotification *)notification
{
	[self hideWindow];
}

- (void)hideWindow
{
	[self.window orderOut:nil];
}

- (void)showWindow:(id)sender
{
	[self.window makeKeyAndOrderFront:nil];
}

// Called from loupe
- (void)updateColor:(NSNotification *)notification
{
	NSLog(@"updateColor: %@", notification);
  NSColor *color = [notification object];
	self.color = color;
  [self updateLabelsWithColor:color];
}

- (void)updateLabelsWithColor:(NSColor *)color
{
	self.colorWell.color = color;
	
  // Setup overlay text attributes
  NSShadow *shadow = [[[NSShadow alloc] init] autorelease];
  [shadow setShadowColor:[NSColor colorWithCalibratedWhite:1.0 alpha:0.5]];
  [shadow setShadowOffset:NSMakeSize(0, -1)];
  
  NSAttributedString *hexString = [[[NSAttributedString alloc] initWithString:[color hues_hex] attributes:@{NSFontAttributeName: [NSFont fontWithName:@"Lucida Grande" size:16.0], NSShadowAttributeName: shadow}] autorelease];
  NSAttributedString *rgbString = [[[NSAttributedString alloc] initWithString:[color hues_rgb] attributes:@{NSFontAttributeName: [NSFont fontWithName:@"Lucida Grande" size:14.0], NSShadowAttributeName: shadow}] autorelease];
  
	[self.primaryFormat setAttributedStringValue:hexString];
  [self.secondaryFormat setAttributedStringValue:rgbString];
	
	[self.alternateFormats removeAllItems];
	
	[self.alternateFormats addItemsWithTitles:@[[color hues_hsl]]];
	[self.alternateFormats.menu addItem:[NSMenuItem separatorItem]];
	[self.alternateFormats addItemsWithTitles:@[[color hues_NSColorCalibratedRGB], [color hues_NSColorCalibratedHSB], [color hues_NSColorDeviceRGB], [color hues_NSColorDeviceHSB]]];
	[self.alternateFormats.menu addItem:[NSMenuItem separatorItem]];
	[self.alternateFormats addItemsWithTitles:@[[color hues_UIColorRGB], [color hues_UIColorHSB]]];
	
	int red = (int)([color redComponent] * 255.0);
	int green = (int)([color greenComponent] * 255.0);
	int blue = (int)([color blueComponent] * 255.0);
	int alpha = (int)([color alphaComponent] * 100.0);
	
	self.redField.stringValue = [NSString stringWithFormat:@"%d", red];
	self.redSlider.intValue = red;
	
	self.greenField.stringValue = [NSString stringWithFormat:@"%d", green];
	self.greenSlider.intValue = green;
	
	self.blueField.stringValue = [NSString stringWithFormat:@"%d", blue];
	self.blueSlider.intValue = blue;
	
	self.alphaField.stringValue = [NSString stringWithFormat:@"%d%%", alpha];
	self.alphaSlider.intValue = alpha;
}

#pragma mark - RGB sliders

- (IBAction)sliderChanged:(id)sender
{
	NSLog(@"sliderChanged: %@", sender);
	NSColor *newColor = nil;
	
	if (sender == self.redSlider) {
		newColor = [NSColor colorWithCalibratedRed:(self.redSlider.floatValue / 255.0f) green:[self.color greenComponent] blue:[self.color blueComponent] alpha:[self.color alphaComponent]];
	} else if (sender == self.greenSlider) {
		newColor = [NSColor colorWithCalibratedRed:[self.color redComponent] green:(self.greenSlider.floatValue / 255.0f) blue:[self.color blueComponent] alpha:[self.color alphaComponent]];
	} else if (sender == self.blueSlider) {
		newColor = [NSColor colorWithCalibratedRed:[self.color redComponent] green:[self.color greenComponent] blue:(self.blueSlider.floatValue / 255.0f) alpha:[self.color alphaComponent]];
	} else if (sender == self.alphaSlider) {
		newColor = [NSColor colorWithCalibratedRed:[self.color redComponent] green:[self.color greenComponent] blue:[self.color blueComponent] alpha:(self.alphaSlider.floatValue / 100.0f)];
	}

	self.color = newColor;
	[self updateLabelsWithColor:newColor];
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

#pragma mark - Loupe

- (void)showLoupe:(id)sender
{
  NSPoint point = [NSEvent mouseLocation];
  
  HuesLoupeWindow *loupeWindow = [[HuesLoupeWindow alloc] initWithContentRect:NSMakeRect(point.x - round(LOUPE_SIZE / 2), point.y - round(LOUPE_SIZE / 2), LOUPE_SIZE, LOUPE_SIZE) styleMask:0 backing:NSBackingStoreBuffered defer:YES];
	HuesLoupeView *loupeView = [[[HuesLoupeView alloc] initWithFrame:NSMakeRect(0, 0, LOUPE_SIZE, LOUPE_SIZE)] autorelease];
  [loupeWindow.contentView addSubview:loupeView];
  [loupeWindow orderFront:nil];
	[loupeWindow makeKeyWindow];
	//[loupeWindow makeKeyAndOrderFront:self];
	[loupeWindow makeFirstResponder:loupeView];
}

#pragma mark - Color input

- (void)controlTextDidChange:(NSNotification *)notification
{
  if (notification.object == self.primaryFormat) {
    NSString *value = [self.primaryFormat stringValue];
    NSColor *newColor = [NSColor hues_colorFromHex:value];
    
    if (newColor != nil) {
      [self updateLabelsWithColor:newColor];
      //[self.colorPanel setColor:newColor];
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
