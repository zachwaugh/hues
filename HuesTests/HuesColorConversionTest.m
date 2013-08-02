//
//  HuesColorConversionTest.m
//  Hues
//
//  Created by Zach Waugh on 7/20/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesColorConversionTest.h"
#import "HuesColorConversion.h"

@implementation HuesColorConversionTest

- (void)testHuesRGBEqualToRGB
{
	HuesRGB rgb = HuesRGBMake(0, 0, 0);
	HuesRGB rgb2 = HuesRGBMake(0, 0, 0);
	
	expect(HuesRGBEqualToRGB(rgb, rgb2)).to.beTruthy();
	
	rgb = HuesRGBMake(1, 1, 1);
	expect(HuesRGBEqualToRGB(rgb, rgb2)).to.beFalsy();
	
	rgb2 = HuesRGBMake(1, 1, 0.9);
	expect(HuesRGBEqualToRGB(rgb, rgb2)).to.beFalsy();
	
	rgb = HuesRGBMake(0.2, 0.4, 0.6);
	rgb2 = HuesRGBMake(0.2, 0.4, 0.6);
	expect(HuesRGBEqualToRGB(rgb, rgb2)).to.beTruthy();
}

- (void)testHSLToRGB
{
	HuesHSL hsl = HuesHSLMake(0, 1, 0.5);
	HuesRGB rgb = HuesHSLToRGB(hsl);
	HuesRGB expected = HuesRGBMake(1, 0, 0);
	
	expect(HuesRGBEqualToRGB(rgb, expected)).to.beTruthy();
	
	hsl = HuesHSLMake(.5833333, 0.5, 0.4);
	rgb = HuesHSLToRGB(hsl);
	expected = HuesRGBMake(0.2, 0.4, 0.6);
	
	expect(HuesRGBEqualToRGB(rgb, expected)).to.beTruthy();
	
	hsl = HuesHSLMake(300 / 360.0f, 100 / 100.0f, 85 / 100.0f);
	rgb = HuesHSLToRGB(hsl);
	expected = HuesRGBMake(255 / 255.0f, 179 / 255.0f, 255 / 255.0f);
	
	expect(HuesRGBEqualToRGB(rgb, expected)).to.beTruthy();
	
	hsl = HuesHSLMake(0.8333333f, 1.0f, 0.85f);
	rgb = HuesHSLToRGB(hsl);
	expected = HuesRGBMake(1.0f, 0.7019f, 1.0f);
	
	expect(HuesRGBEqualToRGB(rgb, expected)).to.beTruthy();
}

- (void)testRGBToHSL
{
	HuesRGB rgb = HuesRGBMake(1, 1, 1);
	HuesHSL hsl = HuesRGBToHSL(rgb);
	HuesHSL expected = HuesHSLMake(0, 0, 1);
	
	expect(HuesHSLEqualToHSL(hsl, expected)).to.beTruthy();
	
	rgb = HuesRGBMake(1, 0, 0);
	hsl = HuesRGBToHSL(rgb);
	expected = HuesHSLMake(0, 1, 0.5);
	expect(HuesHSLEqualToHSL(hsl, expected)).to.beTruthy();
	
	rgb = HuesRGBMake(0, 0.5, 0);
	hsl = HuesRGBToHSL(rgb);
	expected = HuesHSLMake(120.0f / 360.0f, 1.0, 0.250f);
	expect(HuesHSLEqualToHSL(hsl, expected)).to.beTruthy();
	
	rgb = HuesRGBMake(0.704f, 0.187f, 0.897f);
	hsl = HuesRGBToHSL(rgb);
	expected = HuesHSLMake(283.7f / 360.0f, 0.775f, 0.542f);
	expect(HuesHSLEqualToHSL(hsl, expected)).to.beTruthy();
	
	rgb = HuesRGBMake(0.931f,	0.463f, 0.316f);
	hsl = HuesRGBToHSL(rgb);
	expected = HuesHSLMake(14.3f / 360.0f, 0.817f, 0.624f);
	expect(HuesHSLEqualToHSL(hsl, expected)).to.beTruthy();
	
	rgb = HuesRGBMake(0.211f, 0.149f, 0.597f);
	hsl = HuesRGBToHSL(rgb);
	expected = HuesHSLMake(248.3f / 360.0f, 0.601f, 0.373f);
	expect(HuesHSLEqualToHSL(hsl, expected)).to.beTruthy();
	
	rgb = HuesRGBMake(255 / 255.0f, 0.0f, 4 / 255.0f);
	hsl = HuesRGBToHSL(rgb);
	expected = HuesHSLMake(359 / 360.0f, 100 / 100.0f, 50 / 100.0f);
	expect(HuesHSLEqualToHSL(hsl, expected)).to.beTruthy();
		
	rgb = HuesRGBMake(255 / 255.0f, 180 / 255.0f, 255 / 255.0f);
	hsl = HuesRGBToHSL(rgb);
	expected = HuesHSLMake(300 / 360.0f, 100 / 100.0f, 85 / 100.f);
	expect(HuesHSLEqualToHSL(hsl, expected)).to.beTruthy();
}

- (void)testRGBToHSB
{
	// Values take from - https://en.wikipedia.org/wiki/HSL_and_HSV
	HuesRGB rgb = HuesRGBMake(1, 1, 1);
	HuesHSB hsb = HuesRGBToHSB(rgb);
	HuesHSB expected = HuesHSBMake(0, 0, 1);
	
	expect(HuesHSBEqualToHSB(hsb, expected)).to.beTruthy();
	
	rgb = HuesRGBMake(1, 0, 0);
	hsb = HuesRGBToHSB(rgb);
	expected = HuesHSBMake(0, 1, 1);
	expect(HuesHSBEqualToHSB(hsb, expected)).to.beTruthy();
	
	rgb = HuesRGBMake(0, 0.5, 0);
	hsb = HuesRGBToHSB(rgb);
	expected = HuesHSBMake(120.0f / 360.0f, 1.0, 0.5);
	expect(HuesHSBEqualToHSB(hsb, expected)).to.beTruthy();
	
	rgb = HuesRGBMake(0.704f, 0.187f, 0.897f);
	hsb = HuesRGBToHSB(rgb);
	expected = HuesHSBMake(283.7f / 360.0f, 0.792f, 0.897f);
	expect(HuesHSBEqualToHSB(hsb, expected)).to.beTruthy();
	
	rgb = HuesRGBMake(0.931f,	0.463f, 0.316f);
	hsb = HuesRGBToHSB(rgb);
	expected = HuesHSBMake(14.3f / 360.0f, 0.661f, 0.931f);
	expect(HuesHSBEqualToHSB(hsb, expected)).to.beTruthy();
	
	rgb = HuesRGBMake(0.211f, 0.149f, 0.597f);
	hsb = HuesRGBToHSB(rgb);
	expected = HuesHSBMake(248.3f / 360.0f, 0.750f, 0.597f);
	expect(HuesHSBEqualToHSB(hsb, expected)).to.beTruthy();
	
	rgb = HuesRGBMake(255 / 255.0f, 179 / 255.0f, 255 / 255.0f);
	hsb = HuesRGBToHSB(rgb);
	expected = HuesHSBMake(300 / 360.0f, 30 / 100.0f, 100 / 100.f);
	expect(HuesHSBEqualToHSB(hsb, expected)).to.beTruthy();
}

- (void)testHSBToRGB
{
	HuesHSB hsb = HuesHSBMake(0, 0, 1);
	HuesRGB rgb = HuesHSBToRGB(hsb);
	HuesRGB expected = HuesRGBMake(1, 1, 1);
	
	expect(HuesRGBEqualToRGB(rgb, expected)).to.beTruthy();
	
	hsb = HuesHSBMake(0, 1, 1);
	rgb = HuesHSBToRGB(hsb);
	expected = HuesRGBMake(1, 0, 0);
	expect(HuesRGBEqualToRGB(rgb, expected)).to.beTruthy();
	
	hsb = HuesHSBMake(0, 1, 0);
	rgb = HuesHSBToRGB(hsb);
	expected = HuesRGBMake(0, 0, 0);
	expect(HuesRGBEqualToRGB(rgb, expected)).to.beTruthy();
	
	hsb = HuesHSBMake(120.0f / 360.0f, 1.0, 0.5);
	rgb = HuesHSBToRGB(hsb);
	expected = HuesRGBMake(0, 0.5, 0);
	expect(HuesRGBEqualToRGB(rgb, expected)).to.beTruthy();
	
	hsb = HuesHSBMake(283.7f / 360.0f, 0.792f, 0.897f);
	rgb = HuesHSBToRGB(hsb);
	expected = HuesRGBMake(0.704f, 0.187f, 0.897f);
	expect(HuesRGBEqualToRGB(rgb, expected)).to.beTruthy();
	
	hsb = HuesHSBMake(14 / 360.0f, 66 / 100.f, 93 / 100.f);
	rgb = HuesHSBToRGB(hsb);
	expected = HuesRGBMake(237 / 255.0f, 117 / 255.f, 81 / 255.f);
	expect(HuesRGBEqualToRGB(rgb, expected)).to.beTruthy();
	
	hsb = HuesHSBMake(248.3f / 360.0f, 0.750f, 0.597f);
	rgb = HuesHSBToRGB(hsb);
	expected = HuesRGBMake(0.211f, 0.149f, 0.597f);
	expect(HuesRGBEqualToRGB(rgb, expected)).to.beTruthy();
	
	hsb = HuesHSBMake(300 / 360.0f, 30 / 100.0f, 100 / 100.0f);
	rgb = HuesHSBToRGB(hsb);
	expected = HuesRGBMake(255 / 255.0f, 179 / 255.0f, 255 / 255.0f);
	expect(HuesRGBEqualToRGB(rgb, expected)).to.beTruthy();
}

- (void)testHSBToHSL
{
	HuesHSB hsb = HuesHSBMake(0, 1, 0);
	HuesHSL hsl = HuesHSBToHSL(hsb);
	HuesHSL expected = HuesHSLMake(0, 0, 0);
	
	expect(HuesHSLEqualToHSL(hsl, expected)).to.beTruthy();
	
	hsb = HuesHSBMake(0, 0, 0);
	hsl = HuesHSBToHSL(hsb);
	expected = HuesHSLMake(0, 0, 0);
	
	expect(HuesHSLEqualToHSL(hsl, expected)).to.beTruthy();
}

@end
