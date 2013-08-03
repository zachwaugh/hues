//
//  HuesColorWheelViewController.m
//  Hues
//
//  Created by Zach Waugh on 12/17/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import "HuesColorWheelViewController.h"
#import "HuesColorWheelView.h"
#import "HuesColor.h"

@interface HuesColorWheelViewController ()

@end

@implementation HuesColorWheelViewController

- (id)init
{
	self = [super initWithNibName:@"HuesColorWheelViewController" bundle:nil];
	if (!self) return nil;
	
	return self;
}

- (void)updateInterfaceWithColor:(HuesColor *)color
{
	self.color = color;
	self.colorWheelView.color = color;
	[self.hueView updateColor:color];
}

#pragma mark - HuesColorWheelViewDelegate

- (void)colorWheelDidChangeSaturation:(CGFloat)saturation brightness:(CGFloat)brightness
{	
	HuesColor *color = [HuesColor colorWithHue:self.color.hue saturation:saturation brightness:brightness alpha:self.color.alpha];
	[self updateColor:color];
}

#pragma mark - HuesColorWheelHueViewDelegate

- (void)hueChanged:(CGFloat)hue
{
	HuesColor *color = [self.color colorWithHue:hue];
	[self updateColor:color];
}

@end
