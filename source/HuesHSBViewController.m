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
#import "HuesColor.h"

@implementation HuesHSBViewController

- (id)init
{
	self = [super initWithNibName:@"HuesHSBViewController" bundle:nil];
	if (!self) return nil;
	
	return self;
}

- (void)updateInterfaceWithColor:(HuesColor *)color
{
	self.color = color;
	NSColor *deviceColor = color.deviceColor;
	
	self.hueField.stringValue = [NSString stringWithFormat:@"%d", color.hues_hue];
	self.hueSlider.intValue = color.hues_hue;
	self.hueSlider.currentColor = deviceColor;
	self.hueSlider.color = deviceColor;
	
	self.saturationField.stringValue = [NSString stringWithFormat:@"%d", color.hues_HSBSaturation];
	self.saturationSlider.intValue = color.hues_HSBSaturation;
	self.saturationSlider.currentColor = deviceColor;
	self.saturationSlider.colors = @[[color colorWithHSBSaturation:0.0f].deviceColor, [color colorWithHSBSaturation:1.0f].deviceColor];
	
	self.brightnessField.stringValue = [NSString stringWithFormat:@"%d", color.hues_brightness];
	self.brightnessSlider.intValue = color.hues_brightness;
	self.brightnessSlider.currentColor = deviceColor;
	self.brightnessSlider.colors = @[[color colorWithBrightness:0.0f].deviceColor, [color colorWithBrightness:1.0f].deviceColor];
	
	self.alphaField.stringValue = [NSString stringWithFormat:@"%d", color.hues_alpha];
	self.alphaSlider.intValue = color.hues_alpha;
	self.alphaSlider.currentColor = deviceColor;
	self.alphaSlider.colors = @[[NSColor whiteColor], [color colorWithAlpha:1.0f].deviceColor];
}

- (IBAction)fieldChanged:(id)sender
{
	HuesColor *newColor = nil;
	
	if (sender == self.hueField) {
		newColor = [self.color colorWithHue:(self.hueField.integerValue / 360.0f)];
	} else if (sender == self.saturationField) {
		newColor = [self.color colorWithHSBSaturation:(self.saturationField.integerValue / 100.0f)];
	} else if (sender == self.brightnessField) {
		newColor = [self.color colorWithBrightness:(self.brightnessField.integerValue / 100.0f)];
	} else if (sender == self.alphaField) {
		newColor = [self.color colorWithAlpha:(self.alphaField.integerValue / 100.0f)];
	}
	
	[self updateColor:newColor];
}

- (IBAction)sliderChanged:(id)sender
{
	HuesColor *newColor = nil;
	
	if (sender == self.hueSlider) {		
		newColor = [self.color colorWithHue:(self.hueSlider.integerValue / 360.0f)];
	} else if (sender == self.saturationSlider) {
		newColor = [self.color colorWithHSBSaturation:(self.saturationSlider.integerValue / 100.0f)];
	} else if (sender == self.brightnessSlider) {
		newColor = [self.color colorWithBrightness:(self.brightnessSlider.integerValue / 100.0f)];
	} else if (sender == self.alphaSlider) {
		newColor = [self.color colorWithAlpha:(self.alphaSlider.integerValue / 100.0f)];
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
