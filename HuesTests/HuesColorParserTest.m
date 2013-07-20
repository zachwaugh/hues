//
//  HuesColorParserTest.m
//  Hues
//
//  Created by Zach Waugh on 7/11/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesColorParserTest.h"
#import "HuesColorParser.h"

@implementation HuesColorParserTest

- (void)testColorFromHexWithShortInput
{
	expect([HuesColorParser colorFromHex:@""]).to.beNil();
  expect([HuesColorParser colorFromHex:@"f"]).to.beNil();
  expect([HuesColorParser colorFromHex:@"ff"]).to.beNil();
  expect([HuesColorParser colorFromHex:@"fff"]).to.beNil();
  expect([HuesColorParser colorFromHex:@"ffff"]).to.beNil();
  expect([HuesColorParser colorFromHex:@"fffff"]).to.beNil();
  expect([HuesColorParser colorFromHex:@"#fffff"]).to.beNil();
}

- (void)testParseColorFromHexWithInvalidInput
{
	// Invalid input should return nil
	expect([HuesColorParser colorFromHex:@"ZZZZZZ"]).to.beNil();
  expect([HuesColorParser colorFromHex:@"tyuytutytuytytuyt"]).to.beNil();
  expect([HuesColorParser colorFromHex:@";^&><?**&&'"]).to.beNil();
  expect([HuesColorParser colorFromHex:@"!@#$\"\"\\"]).to.beNil();
}

- (void)testParseColorFromHexWithValidInput
{
	expect([HuesColorParser colorFromHex:@"#FFFFFF"]).toNot.beNil();
	expect([HuesColorParser colorFromHex:@"#FFFFFF"]).to.equal([NSColor colorWithCalibratedRed:1 green:1 blue:1 alpha:1]);
	
	expect([HuesColorParser colorFromHex:@"ffffff"]).toNot.beNil();
	expect([HuesColorParser colorFromHex:@"ffffff"]).to.equal([NSColor colorWithCalibratedRed:1 green:1 blue:1 alpha:1]);
	
	expect([HuesColorParser colorFromHex:@"FFFFFF"]).toNot.beNil();
	expect([HuesColorParser colorFromHex:@"FFFFFF"]).to.equal([NSColor colorWithCalibratedRed:1 green:1 blue:1 alpha:1]);
	
	expect([HuesColorParser colorFromHex:@"000000"]).toNot.beNil();
	expect([HuesColorParser colorFromHex:@"000000"]).to.equal([NSColor colorWithCalibratedRed:0 green:0 blue:0 alpha:1]);
	
	expect([HuesColorParser colorFromHex:@"000000"]).toNot.beNil();
	expect([HuesColorParser colorFromHex:@"000000"]).to.equal([NSColor colorWithCalibratedRed:0 green:0 blue:0 alpha:1]);
}

- (void)testParseColorFromHexWithExtraCharacters
{
	// test extra input still works
  expect([HuesColorParser colorFromHex:@"#FFFFFF"]).to.equal([NSColor colorWithCalibratedRed:1 green:1 blue:1 alpha:1]);
  expect([HuesColorParser colorFromHex:@"#FFFFFFFFFFFFF"]).to.equal([NSColor colorWithCalibratedRed:1 green:1 blue:1 alpha:1]);
  expect([HuesColorParser colorFromHex:@"#CCCCCCfjfyefuf"]).to.equal([NSColor colorWithCalibratedRed:0.8 green:0.8 blue:0.8 alpha:1]);
  expect([HuesColorParser colorFromHex:@"#CCCCCCFFFFFF"]).to.equal([NSColor colorWithCalibratedRed:0.8 green:0.8 blue:0.8 alpha:1]);
  expect([HuesColorParser colorFromHex:@"#CCCCCFFFFFF"]).to.equal([NSColor colorWithCalibratedRed:0.8 green:0.8 blue:0.811764706 alpha:1]);
}

- (void)testParseColorFromRGBWithValidInput
{
	expect([HuesColorParser colorFromRGB:@"rgb(255, 255, 255)"]).to.equal([NSColor colorWithCalibratedRed:1 green:1 blue:1 alpha:1]);
	expect([HuesColorParser colorFromRGB:@"rgb(0, 0, 0)"]).to.equal([NSColor colorWithCalibratedRed:0 green:0 blue:0 alpha:1]);
}

- (void)testParseColorFromRGBWithInvalidInput
{
	expect([HuesColorParser colorFromRGB:@"255, 255, 255"]).to.beNil();
	expect([HuesColorParser colorFromRGB:@"blah"]).to.beNil();
}

- (void)testParseColorFromRGBAWithValidInput
{
	expect([HuesColorParser colorFromRGB:@"rgba(255, 255, 255, 0.5)"]).to.equal([NSColor colorWithCalibratedRed:1 green:1 blue:1 alpha:0.5]);
	expect([HuesColorParser colorFromRGB:@"rgba(0, 0, 0, 0.1)"]).to.equal([NSColor colorWithCalibratedRed:0 green:0 blue:0 alpha:0.1]);
}

- (void)testParseColorFromHSL
{
	
}

- (void)testColorFromNSColor
{
	expect([HuesColorParser colorFromCocoaColor:@"[NSColor colorWithCalibratedRed:1.0 green:1.0 blue:1.0 alpha:1.0]"]).to.equal([NSColor colorWithCalibratedRed:1 green:1 blue:1 alpha:1.0]);
	expect([HuesColorParser colorFromCocoaColor:@"[NSColor colorWithCalibratedRed:0.0 green:0.0 blue:0.0 alpha:1.0]"]).to.equal([NSColor colorWithCalibratedRed:0 green:0 blue:0 alpha:1.0]);
	
	expect([HuesColorParser colorFromCocoaColor:@"[NSColor colorWithCalibratedRed:0.5 green:0.5 blue:0.5 alpha:0.75]"]).to.equal([NSColor colorWithCalibratedRed:0.5 green:0.5 blue:0.5 alpha:0.75]);
}

- (void)testColorFromUIColor
{
	expect([HuesColorParser colorFromCocoaColor:@"[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.75]"]).to.equal([NSColor colorWithCalibratedRed:0.5 green:0.5 blue:0.5 alpha:0.75]);
}

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

- (void)testRGBFromHSL
{
	HuesHSL hsl = HuesHSLMake(0, 1, 0.5);
	HuesRGB rgb = HuesHSLToRGB(hsl);
	HuesRGB expected = HuesRGBMake(1, 0, 0);
	
	expect(HuesRGBEqualToRGB(rgb, expected)).to.beTruthy();
	
	hsl = HuesHSLMake(.5833333, 0.5, 0.4);
	rgb = HuesHSLToRGB(hsl);
	expected = HuesRGBMake(0.2, 0.4, 0.6);
	
	NSLog(@"hsl: %@ -> rgb: %@ (expected: %@)", NSStringFromHSL(hsl), NSStringFromRGB(rgb), NSStringFromRGB(expected));
	
	expect(HuesRGBEqualToRGB(rgb, expected)).to.beTruthy();
}

- (void)testHSBFromRGB
{
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
	expected = HuesHSBMake(120 / 360.0f, 1.0, 0.5);
	
	//NSLog(@"rgb: %@ -> hsb: %@ (expected: %@)", NSStringFromRGB(rgb), NSStringFromHSB(hsb), NSStringFromHSB(expected));
	
	expect(HuesHSBEqualToHSB(hsb, expected)).to.beTruthy();
	
	rgb = HuesRGBMake(0.704f, 0.187f, 0.897f);
	hsb = HuesRGBToHSB(rgb);
	expected = HuesHSBMake(283.7 / 360.0f, 0.792f, 0.897f);
	
	NSLog(@"rgb: %@ -> hsb: %@ (expected: %@)", NSStringFromRGB(rgb), NSStringFromHSB(hsb), NSStringFromHSB(expected));
	
	expect(HuesHSBEqualToHSB(hsb, expected)).to.beTruthy();
}


- (void)testHSLFromRGB
{
	
}

@end
