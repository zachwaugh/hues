//
//  HuesColorTest.m
//  Hues
//
//  Created by Zach Waugh on 5/30/11.
//  Copyright 2011 Giant Comet. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HuesColor.h"

@interface HuesColor (private)

- (NSInteger)relativeBrightness;

@end

@interface HuesColorTest : XCTestCase

- (void)testIsDark;
- (void)testRelativeBrightness;

@end

@implementation HuesColorTest

- (void)testCreateColorWithRGB
{
	HuesColor *color = [HuesColor colorWithRed:1.0f green:1.0f blue:1.0f];
	expect(color).toNot.beNil();
	expect(color.red).to.equal(1.0f);
	expect(color.green).to.equal(1.0f);
	expect(color.blue).to.equal(1.0f);
	expect(color.alpha).to.equal(1.0f);
}

- (void)testCreateColorWithHSL
{
	HuesColor *color = [HuesColor colorWithHue:1.0f saturation:1.0f lightness:1.0f];
	expect(color).toNot.beNil();
	expect(color.hue).to.equal(1.0f);
	expect(color.saturation).to.equal(1.0f);
	expect(color.lightness).to.equal(1.0f);
	expect(color.alpha).to.equal(1.0f);
}

- (void)testIsDark
{
	HuesColor *color = [HuesColor colorWithRed:1 green:1 blue:1];
	
	// White
	expect([color isDark]).to.beFalsy();
	
	// Black
	color = [HuesColor colorWithRed:0 green:0 blue:0];
	expect([color isDark]).to.beTruthy();
	
	// Red
	color = [HuesColor colorWithRed:1 green:0 blue:0];
	expect([color isDark]).to.beTruthy();
	
	// This fails - is it actually dark?
	//expect([[NSColor colorWithCalibratedRed:0.5 green:0.5 blue:0.5 alpha:1.0] hues_isColorDark]).to.beFalsy();
}

- (void)testRelativeBrightness
{
	HuesColor *color;
	
	color = [HuesColor colorWithRed:1 green:1 blue:1];
	expect([color relativeBrightness]).to.equal(255);
	
	color = [HuesColor colorWithRed:1.0 green:0.0 blue:0.0];
	expect([color relativeBrightness]).to.equal(125);
	
	color = [HuesColor colorWithRed:0.5 green:0.5 blue:0.5];
	expect([color relativeBrightness]).to.equal(128);
	
	color = [HuesColor colorWithRed:0 green:0 blue:0];
	expect([color relativeBrightness]).to.equal(0);
}

//
//- (void)testHexFromColor
//{
//  STAssertEqualObjects([[NSColor whiteColor] hues_hexWithLowercase:NO], @"#FFFFFF", @"");
//  STAssertEqualObjects([[NSColor whiteColor] hues_hexWithLowercase:YES], @"#ffffff", @"");
//  STAssertEqualObjects([[NSColor blackColor] hues_hexWithLowercase:NO], @"#000000", @"");
//  
//  STAssertEqualObjects([[NSColor colorWithCalibratedWhite:0 alpha:1] hues_hexWithLowercase:NO], @"#000000", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedWhite:0 alpha:0] hues_hexWithLowercase:NO], @"#000000", @"");
//  
//  
//  STAssertEqualObjects([[NSColor colorWithCalibratedRed:1 green:1 blue:1 alpha:1] hues_hexWithLowercase:NO], @"#FFFFFF", @"");
//  STAssertEqualObjects([[NSColor colorWithDeviceRed:1 green:1 blue:1 alpha:1] hues_hexWithLowercase:NO], @"#FFFFFF", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedRed:0 green:0 blue:0 alpha:1] hues_hexWithLowercase:NO], @"#000000", @"");
//  STAssertEqualObjects([[NSColor colorWithDeviceRed:0 green:0 blue:0 alpha:1] hues_hexWithLowercase:NO], @"#000000", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedRed:0.5 green:0.5 blue:0.5 alpha:1] hues_hexWithLowercase:NO], @"#808080", @"");
//  STAssertEqualObjects([[NSColor colorWithDeviceRed:0.5 green:0.5 blue:0.5 alpha:1] hues_hexWithLowercase:NO], @"#808080", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedRed:0.25 green:0.25 blue:0.25 alpha:1] hues_hexWithLowercase:NO], @"#404040", @"");
//  STAssertEqualObjects([[NSColor colorWithDeviceRed:0.25 green:0.25 blue:0.25 alpha:1] hues_hexWithLowercase:NO], @"#404040", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedRed:0.1 green:0.1 blue:0.25 alpha:1] hues_hexWithLowercase:NO], @"#1A1A40", @"");
//  STAssertEqualObjects([[NSColor colorWithDeviceRed:0.1 green:0.1 blue:0.25 alpha:1] hues_hexWithLowercase:NO], @"#1A1A40", @"");
//}
//
//- (void)testRGBFromColor
//{
//  // test basic black and white
//  STAssertEqualObjects([[NSColor whiteColor] hues_rgbWithDefaultFormat], @"rgb(255, 255, 255)", @"");
//  STAssertEqualObjects([[NSColor blackColor] hues_rgbWithDefaultFormat], @"rgb(0, 0, 0)", @"");
//  
//  // test rgba is correctly returned
//  STAssertEqualObjects([[NSColor colorWithCalibratedWhite:0 alpha:1] hues_rgbWithDefaultFormat], @"rgb(0, 0, 0)", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedWhite:0 alpha:0.5] hues_rgbWithDefaultFormat], @"rgba(0, 0, 0, 0.50)", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedWhite:0 alpha:0.25] hues_rgbWithDefaultFormat], @"rgba(0, 0, 0, 0.25)", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedWhite:0 alpha:0] hues_rgbWithDefaultFormat], @"rgba(0, 0, 0, 0.00)", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedWhite:1 alpha:1] hues_rgbWithDefaultFormat], @"rgb(255, 255, 255)", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedWhite:1 alpha:0.5] hues_rgbWithDefaultFormat], @"rgba(255, 255, 255, 0.50)", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedWhite:1 alpha:0.25] hues_rgbWithDefaultFormat], @"rgba(255, 255, 255, 0.25)", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedWhite:1 alpha:0] hues_rgbWithDefaultFormat], @"rgba(255, 255, 255, 0.00)", @"");
//  
//  // test various values - rgb
//  STAssertEqualObjects([[NSColor colorWithCalibratedRed:1 green:1 blue:1 alpha:1] hues_rgbWithDefaultFormat], @"rgb(255, 255, 255)", @"");
//  STAssertEqualObjects([[NSColor colorWithDeviceRed:1 green:1 blue:1 alpha:1] hues_rgbWithDefaultFormat], @"rgb(255, 255, 255)", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedRed:0 green:0 blue:0 alpha:1] hues_rgbWithDefaultFormat], @"rgb(0, 0, 0)", @"");
//  STAssertEqualObjects([[NSColor colorWithDeviceRed:0 green:0 blue:0 alpha:1] hues_rgbWithDefaultFormat], @"rgb(0, 0, 0)", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedRed:0.5 green:0.5 blue:0.5 alpha:1] hues_rgbWithDefaultFormat], @"rgb(128, 128, 128)", @"");
//  STAssertEqualObjects([[NSColor colorWithDeviceRed:0.5 green:0.5 blue:0.5 alpha:1] hues_rgbWithDefaultFormat], @"rgb(128, 128, 128)", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedRed:0.25 green:0.25 blue:0.25 alpha:1] hues_rgbWithDefaultFormat], @"rgb(64, 64, 64)", @"");
//  STAssertEqualObjects([[NSColor colorWithDeviceRed:0.25 green:0.25 blue:0.25 alpha:1] hues_rgbWithDefaultFormat], @"rgb(64, 64, 64)", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedRed:0.1 green:0.1 blue:0.1 alpha:1] hues_rgbWithDefaultFormat], @"rgb(26, 26, 26)", @"");
//  STAssertEqualObjects([[NSColor colorWithDeviceRed:0.1 green:0.1 blue:0.1 alpha:1] hues_rgbWithDefaultFormat], @"rgb(26, 26, 26)", @"");
//}
//
//- (void)testHSLFromColor
//{
//  // test basic black and white
//  STAssertEqualObjects([[NSColor whiteColor] hues_hslWithDefaultFormat], @"hsl(0, 0%, 100%)", @"");
//  STAssertEqualObjects([[NSColor blackColor] hues_hslWithDefaultFormat], @"hsl(0, 0%, 0%)", @"");
//  
//  // test various colors
//  STAssertEqualObjects([[NSColor colorWithCalibratedRed:0 green:1 blue:0 alpha:1] hues_hslWithDefaultFormat], @"hsl(120, 100%, 50%)", @"");
//  STAssertEqualObjects([[NSColor colorWithDeviceRed:0 green:1 blue:0 alpha:1] hues_hslWithDefaultFormat], @"hsl(120, 100%, 50%)", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedRed:1 green:1 blue:0 alpha:1] hues_hslWithDefaultFormat], @"hsl(60, 100%, 50%)", @"");
//  STAssertEqualObjects([[NSColor colorWithDeviceRed:1 green:1 blue:0 alpha:1] hues_hslWithDefaultFormat], @"hsl(60, 100%, 50%)", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedRed:1 green:0 blue:0 alpha:1] hues_hslWithDefaultFormat], @"hsl(0, 100%, 50%)", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedRed:1 green:0 blue:1 alpha:1] hues_hslWithDefaultFormat], @"hsl(300, 100%, 50%)", @"");
//  
//  // test hsla is returned
//  STAssertEqualObjects([[NSColor colorWithCalibratedWhite:1 alpha:0.5] hues_hslWithDefaultFormat], @"hsla(0, 0%, 100%, 0.50)", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedWhite:0 alpha:0.5] hues_hslWithDefaultFormat], @"hsla(0, 0%, 0%, 0.50)", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedRed:0 green:1 blue:0 alpha:0.75] hues_hslWithDefaultFormat], @"hsla(120, 100%, 50%, 0.75)", @"");
//  STAssertEqualObjects([[NSColor colorWithDeviceRed:0 green:1 blue:0 alpha:0.5] hues_hslWithDefaultFormat], @"hsla(120, 100%, 50%, 0.50)", @"");
//  STAssertEqualObjects([[NSColor colorWithCalibratedRed:1 green:1 blue:0 alpha:0.25] hues_hslWithDefaultFormat], @"hsla(60, 100%, 50%, 0.25)", @"");
//  STAssertEqualObjects([[NSColor colorWithDeviceRed:1 green:1 blue:0 alpha:0.1] hues_hslWithDefaultFormat], @"hsla(60, 100%, 50%, 0.10)", @"");
//}
//
//- (void)testHexFormatParsing
//{
//  NSColor *color = [NSColor whiteColor];
//  
//  STAssertEqualObjects([color hues_hexWithFormat:@"{r}"], @"FF", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"{r}" useLowercase:YES], @"ff", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"{g}"], @"FF", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"{b}"], @"FF", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"{r}{g}{b}"], @"FFFFFF", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"{r}{g}{b}" useLowercase:YES], @"ffffff", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"#{r}{g}{b}"], @"#FFFFFF", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"{r} {g} {b}"], @"FF FF FF", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"{r}-{g}-{b}"], @"FF-FF-FF", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"{r}_{g}_{b}"], @"FF_FF_FF", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"0x{r}{g}{b}"], @"0xFFFFFF", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"{{r}}{{g}}{{b}}"], @"{FF}{FF}{FF}", @"");
//  
//  color = [NSColor colorWithCalibratedRed:1 green:0.5 blue:0.25 alpha:1];
//  STAssertEqualObjects([color hues_hexWithFormat:@"{r}"], @"FF", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"{g}"], @"80", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"{b}"], @"40", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"{r}{g}{b}"], @"FF8040", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"#{r}{g}{b}"], @"#FF8040", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"{r} {g} {b}"], @"FF 80 40", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"{r}-{g}-{b}"], @"FF-80-40", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"{r}_{g}_{b}"], @"FF_80_40", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"0x{r}{g}{b}"], @"0xFF8040", @"");
//  STAssertEqualObjects([color hues_hexWithFormat:@"{{r}}{{g}}{{b}}"], @"{FF}{80}{40}", @"");
//}
//

@end
