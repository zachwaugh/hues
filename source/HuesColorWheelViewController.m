//
//  HuesColorWheelViewController.m
//  Hues
//
//  Created by Zach Waugh on 12/17/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import "HuesColorWheelViewController.h"
#import "HuesColorWheelView.h"

@interface HuesColorWheelViewController ()

@end

@implementation HuesColorWheelViewController

- (id)init
{
	self = [super initWithNibName:@"HuesColorWheelViewController" bundle:nil];
	if (!self) return nil;
	
	return self;
}

- (void)updateInterfaceWithColor:(NSColor *)color
{
	self.color = color;
	self.colorWheelView.color = color;
}

#pragma mark - HuesColorWheelViewDelegate

- (void)colorWheelDidChangeSaturation:(CGFloat)saturation brightness:(CGFloat)brightness
{
	if (brightness <= 0) brightness = 0.00001;
	if (brightness > 1) brightness = 1;
	if (saturation <= 0) saturation = 0.00001;
	if (saturation > 1) saturation = 1;
	
	//NSLog(@"colorWheelDidChangeSaturation: %f brightness: %f, hue: %f", saturation, brightness, self.color.hueComponent);
	NSColor *color = [NSColor colorWithCalibratedHue:self.color.hueComponent saturation:saturation brightness:brightness alpha:self.color.alphaComponent];
	//NSLog(@"(after) colorWheelDidChangeSaturation: %f brightness: %f, hue: %f", self.color.saturationComponent, self.color.brightnessComponent, self.color.hueComponent);

	[self updateColor:color];
}

#pragma mark - HuesColorWheelHueViewDelegate

- (void)hueChanged:(CGFloat)hue
{
	NSColor *color = [NSColor colorWithCalibratedHue:hue saturation:self.color.saturationComponent brightness:self.color.brightnessComponent alpha:self.color.alphaComponent];
	[self updateColor:color];
}

@end
