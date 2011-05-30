//
//  HuesColorTest.m
//  Hues
//
//  Created by Zach Waugh on 5/30/11.
//  Copyright 2011 Giant Comet. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "NSColor+Extras.h"

@interface HuesColorTest : SenTestCase
{
}

- (void)testHexFromColor;
- (void)testHexFormatParsing;
- (void)testColorFromHex;

- (void)testRGBFromColor;
- (void)testHSLFromColor;

@end

@implementation HuesColorTest

- (void)setUp
{
  [super setUp];
  // Set-up code here.
}


- (void)tearDown
{
  // Tear-down code here.
  [super tearDown];
}


- (void)testHexFromColor
{
  STAssertEqualObjects([[NSColor whiteColor] hues_hexWithLowercase:NO], @"#FFFFFF", @"");
  STAssertEqualObjects([[NSColor whiteColor] hues_hexWithLowercase:YES], @"#ffffff", @"");
  STAssertEqualObjects([[NSColor blackColor] hues_hexWithLowercase:NO], @"#000000", @"");
  
  STAssertEqualObjects([[NSColor colorWithCalibratedWhite:0 alpha:1] hues_hexWithLowercase:NO], @"#000000", @"");
  STAssertEqualObjects([[NSColor colorWithCalibratedWhite:0 alpha:0] hues_hexWithLowercase:NO], @"#000000", @"");
  
  
  STAssertEqualObjects([[NSColor colorWithCalibratedRed:1 green:1 blue:1 alpha:1] hues_hexWithLowercase:NO], @"#FFFFFF", @"");
  STAssertEqualObjects([[NSColor colorWithDeviceRed:1 green:1 blue:1 alpha:1] hues_hexWithLowercase:NO], @"#FFFFFF", @"");
  STAssertEqualObjects([[NSColor colorWithCalibratedRed:0 green:0 blue:0 alpha:1] hues_hexWithLowercase:NO], @"#000000", @"");
  STAssertEqualObjects([[NSColor colorWithDeviceRed:0 green:0 blue:0 alpha:1] hues_hexWithLowercase:NO], @"#000000", @"");
  STAssertEqualObjects([[NSColor colorWithCalibratedRed:0.5 green:0.5 blue:0.5 alpha:1] hues_hexWithLowercase:NO], @"#808080", @"");
  STAssertEqualObjects([[NSColor colorWithDeviceRed:0.5 green:0.5 blue:0.5 alpha:1] hues_hexWithLowercase:NO], @"#808080", @"");
  STAssertEqualObjects([[NSColor colorWithCalibratedRed:0.25 green:0.25 blue:0.25 alpha:1] hues_hexWithLowercase:NO], @"#404040", @"");
  STAssertEqualObjects([[NSColor colorWithDeviceRed:0.25 green:0.25 blue:0.25 alpha:1] hues_hexWithLowercase:NO], @"#404040", @"");
  STAssertEqualObjects([[NSColor colorWithCalibratedRed:0.1 green:0.1 blue:0.25 alpha:1] hues_hexWithLowercase:NO], @"#1A1A40", @"");
  STAssertEqualObjects([[NSColor colorWithDeviceRed:0.1 green:0.1 blue:0.25 alpha:1] hues_hexWithLowercase:NO], @"#1A1A40", @"");
}


- (void)testRGBFromColor
{
  // test basic black and white
  STAssertEqualObjects([[NSColor whiteColor] hues_rgbWithDefaultFormat], @"rgb(255, 255, 255)", @"");
  STAssertEqualObjects([[NSColor blackColor] hues_rgbWithDefaultFormat], @"rgb(0, 0, 0)", @"");
  
  // test rgba is correctly returned
  STAssertEqualObjects([[NSColor colorWithCalibratedWhite:0 alpha:1] hues_rgbWithDefaultFormat], @"rgb(0, 0, 0)", @"");
  STAssertEqualObjects([[NSColor colorWithCalibratedWhite:0 alpha:0.5] hues_rgbWithDefaultFormat], @"rgba(0, 0, 0, 0.50)", @"");
  STAssertEqualObjects([[NSColor colorWithCalibratedWhite:0 alpha:0.25] hues_rgbWithDefaultFormat], @"rgba(0, 0, 0, 0.25)", @"");
  STAssertEqualObjects([[NSColor colorWithCalibratedWhite:0 alpha:0] hues_rgbWithDefaultFormat], @"rgba(0, 0, 0, 0.00)", @"");
  STAssertEqualObjects([[NSColor colorWithCalibratedWhite:1 alpha:1] hues_rgbWithDefaultFormat], @"rgb(255, 255, 255)", @"");
  STAssertEqualObjects([[NSColor colorWithCalibratedWhite:1 alpha:0.5] hues_rgbWithDefaultFormat], @"rgba(255, 255, 255, 0.50)", @"");
  STAssertEqualObjects([[NSColor colorWithCalibratedWhite:1 alpha:0.25] hues_rgbWithDefaultFormat], @"rgba(255, 255, 255, 0.25)", @"");
  STAssertEqualObjects([[NSColor colorWithCalibratedWhite:1 alpha:0] hues_rgbWithDefaultFormat], @"rgba(255, 255, 255, 0.00)", @"");
  
  // test various values - rgb
  STAssertEqualObjects([[NSColor colorWithCalibratedRed:1 green:1 blue:1 alpha:1] hues_rgbWithDefaultFormat], @"rgb(255, 255, 255)", @"");
  STAssertEqualObjects([[NSColor colorWithDeviceRed:1 green:1 blue:1 alpha:1] hues_rgbWithDefaultFormat], @"rgb(255, 255, 255)", @"");
  STAssertEqualObjects([[NSColor colorWithCalibratedRed:0 green:0 blue:0 alpha:1] hues_rgbWithDefaultFormat], @"rgb(0, 0, 0)", @"");
  STAssertEqualObjects([[NSColor colorWithDeviceRed:0 green:0 blue:0 alpha:1] hues_rgbWithDefaultFormat], @"rgb(0, 0, 0)", @"");
  STAssertEqualObjects([[NSColor colorWithCalibratedRed:0.5 green:0.5 blue:0.5 alpha:1] hues_rgbWithDefaultFormat], @"rgb(128, 128, 128)", @"");
  STAssertEqualObjects([[NSColor colorWithDeviceRed:0.5 green:0.5 blue:0.5 alpha:1] hues_rgbWithDefaultFormat], @"rgb(128, 128, 128)", @"");
  STAssertEqualObjects([[NSColor colorWithCalibratedRed:0.25 green:0.25 blue:0.25 alpha:1] hues_rgbWithDefaultFormat], @"rgb(64, 64, 64)", @"");
  STAssertEqualObjects([[NSColor colorWithDeviceRed:0.25 green:0.25 blue:0.25 alpha:1] hues_rgbWithDefaultFormat], @"rgb(64, 64, 64)", @"");
  STAssertEqualObjects([[NSColor colorWithCalibratedRed:0.1 green:0.1 blue:0.1 alpha:1] hues_rgbWithDefaultFormat], @"rgb(26, 26, 26)", @"");
  STAssertEqualObjects([[NSColor colorWithDeviceRed:0.1 green:0.1 blue:0.1 alpha:1] hues_rgbWithDefaultFormat], @"rgb(26, 26, 26)", @"");
}


- (void)testHSLFromColor
{
  // test basic black and white
  STAssertEqualObjects([[NSColor whiteColor] hues_hslWithDefaultFormat], @"hsl(0, 0%, 100%)", @"");
  STAssertEqualObjects([[NSColor blackColor] hues_hslWithDefaultFormat], @"hsl(0, 0%, 0%)", @"");
  
  // test various colors
  STAssertEqualObjects([[NSColor colorWithCalibratedRed:0 green:1 blue:0 alpha:1] hues_hslWithDefaultFormat], @"hsl(120, 100%, 50%)", @"");
  STAssertEqualObjects([[NSColor colorWithDeviceRed:0 green:1 blue:0 alpha:1] hues_hslWithDefaultFormat], @"hsl(120, 100%, 50%)", @"");
  STAssertEqualObjects([[NSColor colorWithCalibratedRed:1 green:1 blue:0 alpha:1] hues_hslWithDefaultFormat], @"hsl(60, 100%, 50%)", @"");
  STAssertEqualObjects([[NSColor colorWithDeviceRed:1 green:1 blue:0 alpha:1] hues_hslWithDefaultFormat], @"hsl(60, 100%, 50%)", @"");
  STAssertEqualObjects([[NSColor colorWithCalibratedRed:1 green:0 blue:0 alpha:1] hues_hslWithDefaultFormat], @"hsl(0, 100%, 50%)", @"");
  STAssertEqualObjects([[NSColor colorWithCalibratedRed:1 green:0 blue:1 alpha:1] hues_hslWithDefaultFormat], @"hsl(300, 100%, 50%)", @"");
  
  // test hsla is returned
  STAssertEqualObjects([[NSColor colorWithCalibratedWhite:1 alpha:0.5] hues_hslWithDefaultFormat], @"hsla(0, 0%, 100%, 0.50)", @"");
  STAssertEqualObjects([[NSColor colorWithCalibratedWhite:0 alpha:0.5] hues_hslWithDefaultFormat], @"hsla(0, 0%, 0%, 0.50)", @"");
  STAssertEqualObjects([[NSColor colorWithCalibratedRed:0 green:1 blue:0 alpha:0.75] hues_hslWithDefaultFormat], @"hsla(120, 100%, 50%, 0.75)", @"");
  STAssertEqualObjects([[NSColor colorWithDeviceRed:0 green:1 blue:0 alpha:0.5] hues_hslWithDefaultFormat], @"hsla(120, 100%, 50%, 0.50)", @"");
  STAssertEqualObjects([[NSColor colorWithCalibratedRed:1 green:1 blue:0 alpha:0.25] hues_hslWithDefaultFormat], @"hsla(60, 100%, 50%, 0.25)", @"");
  STAssertEqualObjects([[NSColor colorWithDeviceRed:1 green:1 blue:0 alpha:0.1] hues_hslWithDefaultFormat], @"hsla(60, 100%, 50%, 0.10)", @"");
}


- (void)testHexFormatParsing
{
  NSColor *color = [NSColor whiteColor];
  
  STAssertEqualObjects([color hues_hexWithFormat:@"{r}"], @"FF", @"");
  STAssertEqualObjects([color hues_hexWithFormat:@"{r}" useLowercase:YES], @"ff", @"");
  STAssertEqualObjects([color hues_hexWithFormat:@"{g}"], @"FF", @"");
  STAssertEqualObjects([color hues_hexWithFormat:@"{b}"], @"FF", @"");
  STAssertEqualObjects([color hues_hexWithFormat:@"{r}{g}{b}"], @"FFFFFF", @"");
  STAssertEqualObjects([color hues_hexWithFormat:@"{r}{g}{b}" useLowercase:YES], @"ffffff", @"");
  STAssertEqualObjects([color hues_hexWithFormat:@"#{r}{g}{b}"], @"#FFFFFF", @"");
  STAssertEqualObjects([color hues_hexWithFormat:@"{r} {g} {b}"], @"FF FF FF", @"");
  STAssertEqualObjects([color hues_hexWithFormat:@"{r}-{g}-{b}"], @"FF-FF-FF", @"");
  STAssertEqualObjects([color hues_hexWithFormat:@"{r}_{g}_{b}"], @"FF_FF_FF", @"");
  STAssertEqualObjects([color hues_hexWithFormat:@"0x{r}{g}{b}"], @"0xFFFFFF", @"");
  STAssertEqualObjects([color hues_hexWithFormat:@"{{r}}{{g}}{{b}}"], @"{FF}{FF}{FF}", @"");
  
  color = [NSColor colorWithCalibratedRed:1 green:0.5 blue:0.25 alpha:1];
  STAssertEqualObjects([color hues_hexWithFormat:@"{r}"], @"FF", @"");
  STAssertEqualObjects([color hues_hexWithFormat:@"{g}"], @"80", @"");
  STAssertEqualObjects([color hues_hexWithFormat:@"{b}"], @"40", @"");
  STAssertEqualObjects([color hues_hexWithFormat:@"{r}{g}{b}"], @"FF8040", @"");
  STAssertEqualObjects([color hues_hexWithFormat:@"#{r}{g}{b}"], @"#FF8040", @"");
  STAssertEqualObjects([color hues_hexWithFormat:@"{r} {g} {b}"], @"FF 80 40", @"");
  STAssertEqualObjects([color hues_hexWithFormat:@"{r}-{g}-{b}"], @"FF-80-40", @"");
  STAssertEqualObjects([color hues_hexWithFormat:@"{r}_{g}_{b}"], @"FF_80_40", @"");
  STAssertEqualObjects([color hues_hexWithFormat:@"0x{r}{g}{b}"], @"0xFF8040", @"");
  STAssertEqualObjects([color hues_hexWithFormat:@"{{r}}{{g}}{{b}}"], @"{FF}{80}{40}", @"");
}


- (void)testColorFromHex
{
  // Test correct input length
  STAssertNil([NSColor hues_colorFromHex:@""], @"Input less than 6 characters should be nil");
  STAssertNil([NSColor hues_colorFromHex:@"f"], @"Input less than 6 characters should be nil");
  STAssertNil([NSColor hues_colorFromHex:@"ff"], @"Input less than 6 characters should be nil");
  STAssertNil([NSColor hues_colorFromHex:@"fff"], @"Input less than 6 characters should be nil");
  STAssertNil([NSColor hues_colorFromHex:@"ffff"], @"Input less than 6 characters should be nil");
  STAssertNil([NSColor hues_colorFromHex:@"fffff"], @"Input less than 6 characters should be nil");
  STAssertNil([NSColor hues_colorFromHex:@"#fffff"], @"Input less than 6 characters after stripping # should be nil");
  
  // test same hex is returned
  STAssertEqualObjects([[NSColor hues_colorFromHex:@"FFFFFF"] hues_hexWithLowercase:NO], @"#FFFFFF", @"should return same hex");
  STAssertEqualObjects([[NSColor hues_colorFromHex:@"000000"] hues_hexWithLowercase:NO], @"#000000", @"should return same hex");
  STAssertEqualObjects([[NSColor hues_colorFromHex:@"00ff00"] hues_hexWithLowercase:NO], @"#00FF00", @"should return same hex");
  STAssertEqualObjects([[NSColor hues_colorFromHex:@"CCCCCC"] hues_hexWithLowercase:NO], @"#CCCCCC", @"should return same hex");
  STAssertEqualObjects([[NSColor hues_colorFromHex:@"abc369"] hues_hexWithLowercase:NO], @"#ABC369", @"should return same hex");
  
  // test same hex with correct formatting
  STAssertEqualObjects([[NSColor hues_colorFromHex:@"ffffff"] hues_hexWithLowercase:YES], @"#ffffff", @"lowercase and should return same hex, lowercase");
  STAssertEqualObjects([[NSColor hues_colorFromHex:@"ffffff"] hues_hexWithLowercase:NO], @"#FFFFFF", @"lowercase and should return same hex, uppercase");
  STAssertEqualObjects([[NSColor hues_colorFromHex:@"FFFFFF"] hues_hexWithLowercase:YES], @"#ffffff", @"uppercase and should return same hex, lowercase");
  
  
  // test extra input still works
  STAssertEqualObjects([[NSColor hues_colorFromHex:@"#FFFFFF"] hues_hexWithLowercase:NO], @"#FFFFFF", @"hex with # should return same hex");
  STAssertEqualObjects([[NSColor hues_colorFromHex:@"#FFFFFFFFFFFFF"] hues_hexWithLowercase:NO], @"#FFFFFF", @"hex with extra digits and # should return same hex");
  STAssertEqualObjects([[NSColor hues_colorFromHex:@"#CCCCCCfjfyefuf"] hues_hexWithLowercase:NO], @"#CCCCCC", @"hex with extra digits and # should return same hex");
  STAssertEqualObjects([[NSColor hues_colorFromHex:@"#CCCCCCFFFFFF"] hues_hexWithLowercase:NO], @"#CCCCCC", @"hex with extra digits and # should return same hex");
  STAssertEqualObjects([[NSColor hues_colorFromHex:@"#CCCCCFFFFFF"] hues_hexWithLowercase:NO], @"#CCCCCF", @"hex with extra digits and # should return same hex");
  
  
  // test invalid input returns #000000
  STAssertEqualObjects([[NSColor hues_colorFromHex:@"ZZZZZZ"] hues_hexWithLowercase:NO], @"#000000", @"invalid should return #000000");
  STAssertEqualObjects([[NSColor hues_colorFromHex:@"tyuytutytuytytuyt"] hues_hexWithLowercase:NO], @"#000000", @"invalid should return #000000");
  STAssertEqualObjects([[NSColor hues_colorFromHex:@";^&><?**&&'"] hues_hexWithLowercase:NO], @"#000000", @"invalid should return #000000");
  STAssertEqualObjects([[NSColor hues_colorFromHex:@"!@#$\"\"\\"] hues_hexWithLowercase:NO], @"#000000", @"invalid should return #000000");
}

@end
