//
//  HuesRGBViewController.m
//  Hues
//
//  Created by Zach Waugh on 12/17/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import "HuesRGBViewController.h"
#import "HuesColorSlider.h"
#import "NSColor+Hues.h"
#import "HuesDefines.h"

@implementation HuesRGBViewController

- (id)init
{
	self = [super initWithNibName:@"HuesRGBViewController" bundle:nil];
	if (!self) return nil;
	
	return self;
}

- (void)updateInterfaceWithColor:(NSColor *)color
{
	self.color = color;
	CGFloat redComponent = color.redComponent;
	CGFloat greenComponent = color.greenComponent;
	CGFloat blueComponent = color.blueComponent;
	
	int red = (int)roundf(redComponent * 255.0);
	int green = (int)roundf(greenComponent * 255.0);
	int blue = (int)roundf(blueComponent * 255.0);
	int alpha = (int)roundf(color.alphaComponent * 100.0);
	
	self.redField.stringValue = [NSString stringWithFormat:@"%d", red];
	self.redSlider.intValue = red;
	self.redSlider.currentColor = color;
	self.redSlider.startColor = [NSColor colorWithCalibratedRed:0 green:greenComponent blue:blueComponent alpha:1.0];
	self.redSlider.endColor = [NSColor colorWithCalibratedRed:1 green:greenComponent blue:blueComponent alpha:1.0];
	
	self.greenField.stringValue = [NSString stringWithFormat:@"%d", green];
	self.greenSlider.intValue = green;
	self.greenSlider.currentColor = color;
	self.greenSlider.startColor = [NSColor colorWithCalibratedRed:redComponent green:0 blue:blueComponent alpha:1.0];
	self.greenSlider.endColor = [NSColor colorWithCalibratedRed:redComponent green:1 blue:blueComponent alpha:1.0];
	
	self.blueField.stringValue = [NSString stringWithFormat:@"%d", blue];
	self.blueSlider.intValue = blue;
	self.blueSlider.currentColor = color;
	self.blueSlider.startColor = [NSColor colorWithCalibratedRed:redComponent green:greenComponent blue:0 alpha:1.0];
	self.blueSlider.endColor = [NSColor colorWithCalibratedRed:redComponent green:greenComponent blue:1 alpha:1.0];
	
	self.alphaField.stringValue = [NSString stringWithFormat:@"%d", alpha];
	self.alphaSlider.intValue = alpha;
	self.alphaSlider.currentColor = color;
	self.alphaSlider.startColor = [NSColor whiteColor];
	self.alphaSlider.endColor = [NSColor colorWithCalibratedRed:redComponent green:greenComponent blue:blueComponent alpha:1.0];
}

#pragma mark - Sliders/Fields

- (IBAction)fieldChanged:(id)sender
{
	NSColor *newColor = nil;
	
	if (sender == self.redField) {
		newColor = [self.color hues_colorWithRed:(self.redField.integerValue / 255.0f)];
	} else if (sender == self.greenField) {
		newColor = [self.color hues_colorWithGreen:(self.greenField.integerValue / 255.0f)];
	} else if (sender == self.blueField) {
		newColor = [self.color hues_colorWithBlue:(self.blueField.integerValue / 255.0f)];
	} else if (sender == self.alphaField) {
		newColor = [self.color hues_colorWithAlpha:(self.alphaField.integerValue / 100.0f)];
	}
	
	[self updateColor:newColor];
}

- (IBAction)sliderChanged:(id)sender
{
	NSColor *newColor = nil;
	
	if (sender == self.redSlider) {
		newColor = [self.color hues_colorWithRed:(self.redSlider.floatValue / 255.0f)];
	} else if (sender == self.greenSlider) {
		newColor = [self.color hues_colorWithGreen:(self.greenSlider.floatValue / 255.0f)];
	} else if (sender == self.blueSlider) {
		newColor = [self.color hues_colorWithBlue:(self.blueSlider.floatValue / 255.0f)];
	} else if (sender == self.alphaSlider) {
		newColor = [self.color hues_colorWithAlpha:(self.alphaSlider.floatValue / 100.0f)];
	}
	
	[self updateColor:newColor];
}

#pragma mark - NSTextFieldDelegate

- (BOOL)control:(NSControl *)control textView:(NSTextView *)textView doCommandBySelector:(SEL)commandSelector
{
	NSInteger value = [textView.string integerValue];
	
	if (commandSelector == @selector(moveUp:) || commandSelector == @selector(moveRight:)) {
		textView.string = [NSString stringWithFormat:@"%ld", value + 1];
		textView.selectedRange = NSMakeRange(0, textView.string.length);
		[self fieldChanged:control];
		
		return YES;
	} else if (commandSelector == @selector(moveDown:) || commandSelector == @selector(moveLeft:)) {
		textView.string = [NSString stringWithFormat:@"%ld", value - 1];
		textView.selectedRange = NSMakeRange(0, textView.string.length);
		[self fieldChanged:control];
		
		return YES;
	}
	
	return NO;
}

@end
