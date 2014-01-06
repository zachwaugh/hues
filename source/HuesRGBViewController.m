//
//  HuesRGBViewController.m
//  Hues
//
//  Created by Zach Waugh on 12/17/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import "HuesRGBViewController.h"
#import "HuesColorSlider.h"
#import "HuesColor.h"
#import "HuesDefines.h"

@implementation HuesRGBViewController

- (id)init
{
	self = [super initWithNibName:@"HuesRGBViewController" bundle:nil];
	if (!self) return nil;
	
	return self;
}

- (void)updateInterfaceWithColor:(HuesColor *)color
{
	self.color = color;
	NSColor *deviceColor = color.color;
	
	self.redField.stringValue = [NSString stringWithFormat:@"%d", color.hues_red];
	self.redSlider.intValue = color.hues_red;
	self.redSlider.currentColor = deviceColor;
	self.redSlider.colors = @[[color colorWithRed:0.0f alpha:1.0f].deviceColor, [color colorWithRed:1.0f alpha:1.0f].deviceColor];
	
	self.greenField.stringValue = [NSString stringWithFormat:@"%d", color.hues_green];
	self.greenSlider.intValue = color.hues_green;
	self.greenSlider.currentColor = deviceColor;
	self.greenSlider.colors = @[[color colorWithGreen:0.0f alpha:1.0f].deviceColor, [color colorWithGreen:1.0f alpha:1.0f].deviceColor];
	
	self.blueField.stringValue = [NSString stringWithFormat:@"%d", color.hues_blue];
	self.blueSlider.intValue = color.hues_blue;
	self.blueSlider.currentColor = deviceColor;
	self.blueSlider.colors = @[[color colorWithBlue:0.0f alpha:1.0f].deviceColor, [color colorWithBlue:1.0f alpha:1.0f].deviceColor];
	
	self.alphaField.stringValue = [NSString stringWithFormat:@"%d", color.hues_alpha];
	self.alphaSlider.intValue = color.hues_alpha;
	self.alphaSlider.currentColor = deviceColor;
	self.alphaSlider.colors = @[[deviceColor colorWithAlphaComponent:0.0f], [color colorWithAlpha:1.0f].deviceColor];
}

#pragma mark - Sliders/Fields

- (IBAction)fieldChanged:(id)sender
{
	HuesColor *newColor = nil;
	
	if (sender == self.redField) {
		newColor = [self.color colorWithRed:(self.redField.integerValue / 255.0f)];
	} else if (sender == self.greenField) {
		newColor = [self.color colorWithGreen:(self.greenField.integerValue / 255.0f)];
	} else if (sender == self.blueField) {
		newColor = [self.color colorWithBlue:(self.blueField.integerValue / 255.0f)];
	} else if (sender == self.alphaField) {
		newColor = [self.color colorWithAlpha:(self.alphaField.integerValue / 100.0f)];
	}
	
	[self updateColor:newColor];
}

- (IBAction)sliderChanged:(id)sender
{
	HuesColor *newColor = nil;
	
	if (sender == self.redSlider) {
		newColor = [self.color colorWithRed:(self.redSlider.floatValue / 255.0f)];
	} else if (sender == self.greenSlider) {
		newColor = [self.color colorWithGreen:(self.greenSlider.floatValue / 255.0f)];
	} else if (sender == self.blueSlider) {
		newColor = [self.color colorWithBlue:(self.blueSlider.floatValue / 255.0f)];
	} else if (sender == self.alphaSlider) {
		newColor = [self.color colorWithAlpha:(self.alphaSlider.floatValue / 100.0f)];
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
