//
//  HuesHSBViewController.m
//  Hues
//
//  Created by Zach Waugh on 12/17/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import "HuesHSBViewController.h"
#import "HuesColorSlider.h"
#import "HuesHueColorSlider.h"
#import "NSColor+Hues.h"

@implementation HuesHSBViewController

- (id)init
{
	self = [super initWithNibName:@"HuesHSBViewController" bundle:nil];
	if (self) {
		// Initialization code here.
	}
	
	return self;
}

- (void)updateInterfaceWithColor:(NSColor *)color
{
	self.color = color;
	
	self.hueField.stringValue = [NSString stringWithFormat:@"%d", (int)(color.hueComponent * 360.0)];
	self.hueSlider.intValue = color.hueComponent * 360.0f;
	self.hueSlider.currentColor = color;
	self.hueSlider.color = color;
	
	self.saturationField.stringValue = [NSString stringWithFormat:@"%d", (int)(color.saturationComponent * 100.0)];
	self.saturationSlider.intValue = color.saturationComponent * 100.0;
	self.saturationSlider.currentColor = color;
	self.saturationSlider.startColor = [NSColor colorWithCalibratedHue:color.hueComponent saturation:0 brightness:color.brightnessComponent alpha:1.0];
	self.saturationSlider.endColor = [NSColor colorWithCalibratedHue:color.hueComponent saturation:1 brightness:color.brightnessComponent alpha:1.0];
	
	self.brightnessField.stringValue = [NSString stringWithFormat:@"%d", (int)(color.brightnessComponent * 100.0)];
	self.brightnessSlider.intValue = color.brightnessComponent * 100.0;
	self.brightnessSlider.currentColor = color;
	self.brightnessSlider.startColor = [NSColor colorWithCalibratedHue:color.hueComponent saturation:color.saturationComponent brightness:0 alpha:1.0];
	self.brightnessSlider.endColor = [NSColor colorWithCalibratedHue:color.hueComponent saturation:color.saturationComponent brightness:1 alpha:1.0];
	
	self.alphaField.stringValue = [NSString stringWithFormat:@"%d", (int)(color.alphaComponent * 100.0)];
	self.alphaSlider.intValue = (int)(color.alphaComponent * 100.0);
	self.alphaSlider.currentColor = color;
	self.alphaSlider.startColor = [NSColor whiteColor];
	self.alphaSlider.endColor = [NSColor colorWithCalibratedHue:color.hueComponent saturation:color.saturationComponent brightness:color.brightnessComponent alpha:1.0];
}

- (IBAction)fieldChanged:(id)sender
{
	NSColor *newColor = nil;
	
	if (sender == self.hueField) {
		newColor = [NSColor colorWithCalibratedHue:(self.hueField.integerValue / 360.0f) saturation:self.color.saturationComponent brightness:self.color.brightnessComponent alpha:self.color.alphaComponent];
	} else if (sender == self.saturationField) {
		newColor = [NSColor colorWithCalibratedHue:self.color.hueComponent saturation:(self.saturationField.integerValue / 100.0f) brightness:self.color.brightnessComponent alpha:self.color.alphaComponent];
	} else if (sender == self.brightnessField) {
		newColor = [NSColor colorWithCalibratedHue:self.color.hueComponent saturation:self.color.saturationComponent brightness:(self.brightnessField.integerValue / 100.0f) alpha:self.color.alphaComponent];
	} else if (sender == self.alphaField) {
		newColor = [NSColor colorWithCalibratedRed:[self.color redComponent] green:[self.color greenComponent] blue:[self.color blueComponent] alpha:(self.alphaField.integerValue / 100.0f)];
	}
	
	[self updateColor:newColor];
}

- (IBAction)sliderChanged:(id)sender
{
	NSColor *newColor = nil;
	
	if (sender == self.hueSlider) {
		newColor = [NSColor colorWithCalibratedHue:(self.hueSlider.floatValue / 360.0f) saturation:self.color.saturationComponent brightness:self.color.brightnessComponent alpha:self.color.alphaComponent];
	} else if (sender == self.saturationSlider) {
		newColor = [NSColor colorWithCalibratedHue:self.color.hueComponent saturation:(self.saturationSlider.floatValue / 100.0f) brightness:self.color.brightnessComponent alpha:self.color.alphaComponent];
	} else if (sender == self.brightnessSlider) {
		newColor = [NSColor colorWithCalibratedHue:self.color.hueComponent saturation:self.color.saturationComponent brightness:(self.brightnessSlider.floatValue / 100.0f) alpha:self.color.alphaComponent];
	} else if (sender == self.alphaSlider) {
		newColor = [NSColor colorWithCalibratedRed:[self.color redComponent] green:[self.color greenComponent] blue:[self.color blueComponent] alpha:(self.alphaSlider.floatValue / 100.0f)];
	}
	
	[self updateColor:newColor];
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
