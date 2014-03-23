//
//  HuesColorDefines.h
//  Hues
//
//  Created by Zach Waugh on 8/1/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

typedef struct {
	CGFloat red;
	CGFloat green;
	CGFloat blue;
} HuesRGB;

typedef struct {
	CGFloat hue;
	CGFloat saturation;
	CGFloat lightness;
} HuesHSL;

typedef struct {
	CGFloat hue;
	CGFloat saturation;
	CGFloat brightness;
} HuesHSB;

// RGB
HuesRGB HuesRGBMake(CGFloat red, CGFloat green, CGFloat blue);
BOOL HuesRGBEqualToRGB(HuesRGB rgb, HuesRGB rgb2);
NSString * NSStringFromRGB(HuesRGB rgb);

// HSL
HuesHSL HuesHSLMake(CGFloat hue, CGFloat saturation, CGFloat lightness);
BOOL HuesHSLEqualToHSL(HuesHSL hsl, HuesHSL hsl2);
NSString * NSStringFromHSL(HuesHSL hsl);

// HSB
HuesHSB HuesHSBMake(CGFloat hue, CGFloat saturation, CGFloat brightness);
BOOL HuesHSBEqualToHSB(HuesHSB hsb, HuesHSB hsb2);
NSString * NSStringFromHSB(HuesHSB hsb);
