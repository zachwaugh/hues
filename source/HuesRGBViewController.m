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
	CGFloat redComponent = [color redComponent];
	CGFloat greenComponent = [color greenComponent];
	CGFloat blueComponent = [color blueComponent];
	
	int red = (int)(redComponent * 255.0);
	int green = (int)(greenComponent * 255.0);
	int blue = (int)(blueComponent * 255.0);
	int alpha = (int)([color alphaComponent] * 100.0);
	
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
	
	self.alphaField.stringValue = [NSString stringWithFormat:@"%d", alpha];
	self.alphaSlider.intValue = alpha;
	self.alphaSlider.startColor = [NSColor whiteColor];
	self.alphaSlider.endColor = [NSColor colorWithCalibratedRed:redComponent green:greenComponent blue:blueComponent alpha:1.0];
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
	}
	
	[self updateColor:newColor];
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
		
		return YES;
	} else if (commandSelector == @selector(moveDown:) || commandSelector == @selector(moveLeft:)) {
		textView.string = [NSString stringWithFormat:@"%ld", value - 1];
		textView.selectedRange = NSMakeRange(0, textView.string.length);
		
		return YES;
	}
	
	return NO;
}

@end
