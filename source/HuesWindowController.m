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

@interface HuesWindowController ()

@property (retain) NSColor *color;

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
	
	[self updateInterfaceWithColor:self.color];
}

- (void)windowDidResignKey:(NSNotification *)notification
{
	//[self hideWindow];
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
  [self updateInterfaceWithColor:color];
}

- (void)updateInterfaceWithColor:(NSColor *)color
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
	[self.alternateFormats addItemsWithTitles:@[[color hues_hsb]]];
	[self.alternateFormats.menu addItem:[NSMenuItem separatorItem]];
	[self.alternateFormats addItemsWithTitles:@[[color hues_NSColorCalibratedRGB], [color hues_NSColorCalibratedHSB], [color hues_NSColorDeviceRGB], [color hues_NSColorDeviceHSB]]];
	[self.alternateFormats.menu addItem:[NSMenuItem separatorItem]];
	[self.alternateFormats addItemsWithTitles:@[[color hues_UIColorRGB], [color hues_UIColorHSB]]];
	
	
	CGFloat redComponent = [color redComponent];
	CGFloat greenComponent = [color greenComponent];
	CGFloat blueComponent = [color blueComponent];
	
	int red = (int)(redComponent * 255.0);
	int green = (int)(greenComponent * 255.0);
	int blue = (int)(blueComponent * 255.0);
	int alpha = (int)([color alphaComponent] * 100.0);
	
	// RGBA
	
	self.redField.stringValue = [NSString stringWithFormat:@"%d", red];
	self.redSlider.intValue = red;
	self.redSlider.startColor = [NSColor colorWithCalibratedRed:0 green:greenComponent blue:blueComponent alpha:1.0];
	self.redSlider.endColor = [NSColor colorWithCalibratedRed:1 green:greenComponent blue:blueComponent alpha:1.0];
	
	self.greenField.stringValue = [NSString stringWithFormat:@"%d", green];
	self.greenSlider.intValue = green;
	self.greenSlider.startColor = [NSColor colorWithCalibratedRed:redComponent green:0 blue:blueComponent alpha:1.0];
	self.greenSlider.endColor = [NSColor colorWithCalibratedRed:redComponent green:1 blue:blueComponent alpha:1.0];
	
	self.blueField.stringValue = [NSString stringWithFormat:@"%d", blue];
	self.blueSlider.intValue = blue;
	self.blueSlider.startColor = [NSColor colorWithCalibratedRed:redComponent green:greenComponent blue:0 alpha:1.0];
	self.blueSlider.endColor = [NSColor colorWithCalibratedRed:redComponent green:greenComponent blue:1 alpha:1.0];
	
	self.alphaField.stringValue = [NSString stringWithFormat:@"%d%%", alpha];
	self.alphaSlider.intValue = alpha;
	self.alphaSlider.startColor = [NSColor whiteColor];
	self.alphaSlider.endColor = [NSColor colorWithCalibratedRed:redComponent green:greenComponent blue:blueComponent alpha:1.0];
	
	// HSL
	self.hueField.stringValue = [NSString stringWithFormat:@"%d%%", (int)(color.hueComponent * 360.0)];
	self.hueSlider.intValue = color.hueComponent * 360.0f;
	self.hueSlider.startColor = [NSColor colorWithCalibratedHue:0 saturation:color.saturationComponent brightness:color.brightnessComponent alpha:1.0];
	self.hueSlider.endColor = [NSColor colorWithCalibratedHue:1 saturation:color.saturationComponent brightness:color.brightnessComponent alpha:1.0];
	
	self.saturationField.stringValue = [NSString stringWithFormat:@"%d%%", (int)(color.saturationComponent * 100.0)];
	self.saturationSlider.intValue = color.saturationComponent * 100.0;
	self.saturationSlider.startColor = [NSColor colorWithCalibratedHue:color.hueComponent saturation:0 brightness:color.brightnessComponent alpha:1.0];
	self.saturationSlider.endColor = [NSColor colorWithCalibratedHue:color.hueComponent saturation:1 brightness:color.brightnessComponent alpha:1.0];
	
	self.lightnessField.stringValue = [NSString stringWithFormat:@"%d%%", (int)(color.brightnessComponent * 100.0)];
	self.lightnessSlider.intValue = color.brightnessComponent * 100.0;
	self.lightnessSlider.startColor = [NSColor colorWithCalibratedHue:color.hueComponent saturation:color.saturationComponent brightness:0 alpha:1.0];
	self.lightnessSlider.endColor = [NSColor colorWithCalibratedHue:color.hueComponent saturation:color.saturationComponent brightness:1 alpha:1.0];
}

#pragma mark - Sliders/Fields

- (IBAction)fieldChanged:(id)sender
{
	NSColor *newColor = nil;
	
	if (sender == self.redField) {
		newColor = [NSColor colorWithCalibratedRed:(self.redField.integerValue / 255.0f) green:[self.color greenComponent] blue:[self.color blueComponent] alpha:[self.color alphaComponent]];
	} else if (sender == self.greenField) {
		newColor = [NSColor colorWithCalibratedRed:[self.color redComponent] green:(self.greenField.integerValue / 255.0f) blue:[self.color blueComponent] alpha:[self.color alphaComponent]];
	} else if (sender == self.blueField) {
		newColor = [NSColor colorWithCalibratedRed:[self.color redComponent] green:[self.color greenComponent] blue:(self.blueField.integerValue / 255.0f) alpha:[self.color alphaComponent]];
	} else if (sender == self.alphaField) {
		newColor = [NSColor colorWithCalibratedRed:[self.color redComponent] green:[self.color greenComponent] blue:[self.color blueComponent] alpha:(self.alphaField.integerValue / 100.0f)];
	} else if (sender == self.hueField) {
		newColor = [NSColor colorWithCalibratedHue:(self.hueField.integerValue / 360.0f) saturation:self.color.saturationComponent brightness:self.color.brightnessComponent alpha:self.color.alphaComponent];
	} else if (sender == self.saturationField) {
		newColor = [NSColor colorWithCalibratedHue:self.color.hueComponent saturation:(self.saturationField.integerValue / 100.0f) brightness:self.color.brightnessComponent alpha:self.color.alphaComponent];
	} else if (sender == self.lightnessField) {
		newColor = [NSColor colorWithCalibratedHue:self.color.hueComponent saturation:self.color.saturationComponent brightness:(self.lightnessField.integerValue / 100.0f) alpha:self.color.alphaComponent];
	}
	
	self.color = newColor;
	[self updateInterfaceWithColor:newColor];
}

- (IBAction)sliderChanged:(id)sender
{
	NSColor *newColor = nil;
	
	if (sender == self.redSlider) {
		newColor = [NSColor colorWithCalibratedRed:(self.redSlider.floatValue / 255.0f) green:[self.color greenComponent] blue:[self.color blueComponent] alpha:[self.color alphaComponent]];
	} else if (sender == self.greenSlider) {
		newColor = [NSColor colorWithCalibratedRed:[self.color redComponent] green:(self.greenSlider.floatValue / 255.0f) blue:[self.color blueComponent] alpha:[self.color alphaComponent]];
	} else if (sender == self.blueSlider) {
		newColor = [NSColor colorWithCalibratedRed:[self.color redComponent] green:[self.color greenComponent] blue:(self.blueSlider.floatValue / 255.0f) alpha:[self.color alphaComponent]];
	} else if (sender == self.alphaSlider) {
		newColor = [NSColor colorWithCalibratedRed:[self.color redComponent] green:[self.color greenComponent] blue:[self.color blueComponent] alpha:(self.alphaSlider.floatValue / 100.0f)];
	} else if (sender == self.hueSlider) {
		newColor = [NSColor colorWithCalibratedHue:(self.hueSlider.floatValue / 360.0f) saturation:self.color.saturationComponent brightness:self.color.brightnessComponent alpha:self.color.alphaComponent];
	} else if (sender == self.saturationSlider) {
		newColor = [NSColor colorWithCalibratedHue:self.color.hueComponent saturation:(self.saturationSlider.floatValue / 100.0f) brightness:self.color.brightnessComponent alpha:self.color.alphaComponent];
	} else if (sender == self.lightnessSlider) {
		newColor = [NSColor colorWithCalibratedHue:self.color.hueComponent saturation:self.color.saturationComponent brightness:(self.lightnessSlider.floatValue / 100.0f) alpha:self.color.alphaComponent];
	}

	self.color = newColor;
	[self updateInterfaceWithColor:newColor];
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
	[loupeWindow makeKeyAndOrderFront:self];
	[loupeWindow makeFirstResponder:loupeView];
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


#pragma mark - NSTextFieldDelegate

- (BOOL)control:(NSControl *)control textView:(NSTextView *)textView doCommandBySelector:(SEL)commandSelector
{	
	NSInteger value = [textView.string integerValue];
	
	if (commandSelector == @selector(moveUp:)) {
		textView.string = [NSString stringWithFormat:@"%ld", value + 1];
		textView.selectedRange = NSMakeRange(0, textView.string.length);
		
		return YES;
	} else if (commandSelector == @selector(moveDown:)) {
		textView.string = [NSString stringWithFormat:@"%ld", value - 1];
		textView.selectedRange = NSMakeRange(0, textView.string.length);
		
		return YES;
	}
	
	return NO;
}

@end
