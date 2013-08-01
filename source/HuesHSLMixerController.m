//
//  HuesHSLMixerController.m
//  Hues
//
//  Created by Zach Waugh on 7/17/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesHSLMixerController.h"
#import "HuesColorSlider.h"
#import "HuesHueColorSlider.h"
#import "HuesColor.h"

@interface HuesHSLMixerController ()

@end

@implementation HuesHSLMixerController

- (id)init
{
	self = [super initWithNibName:@"HuesHSLMixerController" bundle:nil];
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
	
	self.saturationField.stringValue = [NSString stringWithFormat:@"%d", color.hues_saturation];
	self.saturationSlider.intValue = color.hues_saturation;
	self.saturationSlider.currentColor = deviceColor;
	self.saturationSlider.colors = @[[color colorWithSaturation:0].deviceColor, [color colorWithSaturation:1.0f].deviceColor];
	
	self.lightnessField.stringValue = [NSString stringWithFormat:@"%d", color.hues_lightness];
	self.lightnessSlider.intValue = color.hues_lightness;
	self.lightnessSlider.currentColor = deviceColor;
	self.lightnessSlider.colors = @[[color colorWithLightness:0.0f].deviceColor, [color colorWithLightness:0.5f].deviceColor, [color colorWithLightness:1.0f].deviceColor];
	
	self.alphaField.stringValue = [NSString stringWithFormat:@"%d", color.hues_alpha];
	self.alphaSlider.intValue = color.hues_alpha;
	self.alphaSlider.currentColor = deviceColor;
	self.alphaSlider.colors = @[[NSColor whiteColor], [color colorWithAlpha:1.0].deviceColor];
}

- (IBAction)fieldChanged:(id)sender
{
	HuesColor *newColor = nil;
	
	if (sender == self.hueField) {
		newColor = [self.color colorWithHue:(self.hueField.integerValue / 360.0f)];
	} else if (sender == self.saturationField) {
		newColor = [self.color colorWithSaturation:(self.saturationField.integerValue / 100.0f)];
	} else if (sender == self.lightnessField) {
		newColor = [self.color colorWithLightness:(self.lightnessField.integerValue / 100.0f)];
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
		newColor = [self.color colorWithSaturation:(self.saturationSlider.integerValue / 100.0f)];
	} else if (sender == self.lightnessSlider) {
		newColor = [self.color colorWithLightness:(self.lightnessSlider.integerValue / 100.0f)];
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
