//
//  HuesColorTest.m
//  Hues
//
//  Copyright (c) 2014 Zach Waugh
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import <XCTest/XCTest.h>
#import "NSColor+Extras.h"
#import "HuesPreferences.h"

@interface HuesColorTest : XCTestCase

@end

@implementation HuesColorTest

- (void)setUp
{
    [super setUp];
    [HuesPreferences registerDefaults];
}

- (void)tearDown
{
    // Tear-down code here.
    [super tearDown];
}

- (void)testHexFromColor
{
    XCTAssertEqualObjects([[NSColor whiteColor] hues_hexWithLowercase:NO], @"#FFFFFF", @"");
    XCTAssertEqualObjects([[NSColor whiteColor] hues_hexWithLowercase:YES], @"#ffffff", @"");
    XCTAssertEqualObjects([[NSColor blackColor] hues_hexWithLowercase:NO], @"#000000", @"");
    
    XCTAssertEqualObjects([[NSColor colorWithCalibratedWhite:0 alpha:1] hues_hexWithLowercase:NO], @"#000000", @"");
    XCTAssertEqualObjects([[NSColor colorWithCalibratedWhite:0 alpha:0] hues_hexWithLowercase:NO], @"#000000", @"");
    
    
    XCTAssertEqualObjects([[NSColor colorWithCalibratedRed:1 green:1 blue:1 alpha:1] hues_hexWithLowercase:NO], @"#FFFFFF", @"");
    XCTAssertEqualObjects([[NSColor colorWithDeviceRed:1 green:1 blue:1 alpha:1] hues_hexWithLowercase:NO], @"#FFFFFF", @"");
    XCTAssertEqualObjects([[NSColor colorWithCalibratedRed:0 green:0 blue:0 alpha:1] hues_hexWithLowercase:NO], @"#000000", @"");
    XCTAssertEqualObjects([[NSColor colorWithDeviceRed:0 green:0 blue:0 alpha:1] hues_hexWithLowercase:NO], @"#000000", @"");
    XCTAssertEqualObjects([[NSColor colorWithCalibratedRed:0.5 green:0.5 blue:0.5 alpha:1] hues_hexWithLowercase:NO], @"#808080", @"");
    XCTAssertEqualObjects([[NSColor colorWithDeviceRed:0.5 green:0.5 blue:0.5 alpha:1] hues_hexWithLowercase:NO], @"#808080", @"");
    XCTAssertEqualObjects([[NSColor colorWithCalibratedRed:0.25 green:0.25 blue:0.25 alpha:1] hues_hexWithLowercase:NO], @"#404040", @"");
    XCTAssertEqualObjects([[NSColor colorWithDeviceRed:0.25 green:0.25 blue:0.25 alpha:1] hues_hexWithLowercase:NO], @"#404040", @"");
    XCTAssertEqualObjects([[NSColor colorWithCalibratedRed:0.1 green:0.1 blue:0.25 alpha:1] hues_hexWithLowercase:NO], @"#1A1A40", @"");
    XCTAssertEqualObjects([[NSColor colorWithDeviceRed:0.1 green:0.1 blue:0.25 alpha:1] hues_hexWithLowercase:NO], @"#1A1A40", @"");
}

- (void)testRGBFromColor
{
    // test basic black and white
    XCTAssertEqualObjects([[NSColor whiteColor] hues_rgbWithDefaultFormat], @"rgb(255, 255, 255)", @"");
    XCTAssertEqualObjects([[NSColor blackColor] hues_rgbWithDefaultFormat], @"rgb(0, 0, 0)", @"");
    
    // test rgba is correctly returned
    XCTAssertEqualObjects([[NSColor colorWithCalibratedWhite:0 alpha:1] hues_rgbWithDefaultFormat], @"rgb(0, 0, 0)", @"");
    XCTAssertEqualObjects([[NSColor colorWithCalibratedWhite:0 alpha:0.5] hues_rgbWithDefaultFormat], @"rgba(0, 0, 0, 0.50)", @"");
    XCTAssertEqualObjects([[NSColor colorWithCalibratedWhite:0 alpha:0.25] hues_rgbWithDefaultFormat], @"rgba(0, 0, 0, 0.25)", @"");
    XCTAssertEqualObjects([[NSColor colorWithCalibratedWhite:0 alpha:0] hues_rgbWithDefaultFormat], @"rgba(0, 0, 0, 0.00)", @"");
    XCTAssertEqualObjects([[NSColor colorWithCalibratedWhite:1 alpha:1] hues_rgbWithDefaultFormat], @"rgb(255, 255, 255)", @"");
    XCTAssertEqualObjects([[NSColor colorWithCalibratedWhite:1 alpha:0.5] hues_rgbWithDefaultFormat], @"rgba(255, 255, 255, 0.50)", @"");
    XCTAssertEqualObjects([[NSColor colorWithCalibratedWhite:1 alpha:0.25] hues_rgbWithDefaultFormat], @"rgba(255, 255, 255, 0.25)", @"");
    XCTAssertEqualObjects([[NSColor colorWithCalibratedWhite:1 alpha:0] hues_rgbWithDefaultFormat], @"rgba(255, 255, 255, 0.00)", @"");
    
    // test various values - rgb
    XCTAssertEqualObjects([[NSColor colorWithCalibratedRed:1 green:1 blue:1 alpha:1] hues_rgbWithDefaultFormat], @"rgb(255, 255, 255)", @"");
    XCTAssertEqualObjects([[NSColor colorWithDeviceRed:1 green:1 blue:1 alpha:1] hues_rgbWithDefaultFormat], @"rgb(255, 255, 255)", @"");
    XCTAssertEqualObjects([[NSColor colorWithCalibratedRed:0 green:0 blue:0 alpha:1] hues_rgbWithDefaultFormat], @"rgb(0, 0, 0)", @"");
    XCTAssertEqualObjects([[NSColor colorWithDeviceRed:0 green:0 blue:0 alpha:1] hues_rgbWithDefaultFormat], @"rgb(0, 0, 0)", @"");
    XCTAssertEqualObjects([[NSColor colorWithCalibratedRed:0.5 green:0.5 blue:0.5 alpha:1] hues_rgbWithDefaultFormat], @"rgb(128, 128, 128)", @"");
    XCTAssertEqualObjects([[NSColor colorWithDeviceRed:0.5 green:0.5 blue:0.5 alpha:1] hues_rgbWithDefaultFormat], @"rgb(128, 128, 128)", @"");
    XCTAssertEqualObjects([[NSColor colorWithCalibratedRed:0.25 green:0.25 blue:0.25 alpha:1] hues_rgbWithDefaultFormat], @"rgb(64, 64, 64)", @"");
    XCTAssertEqualObjects([[NSColor colorWithDeviceRed:0.25 green:0.25 blue:0.25 alpha:1] hues_rgbWithDefaultFormat], @"rgb(64, 64, 64)", @"");
    XCTAssertEqualObjects([[NSColor colorWithCalibratedRed:0.1 green:0.1 blue:0.1 alpha:1] hues_rgbWithDefaultFormat], @"rgb(26, 26, 26)", @"");
    XCTAssertEqualObjects([[NSColor colorWithDeviceRed:0.1 green:0.1 blue:0.1 alpha:1] hues_rgbWithDefaultFormat], @"rgb(26, 26, 26)", @"");
}


- (void)testHSLFromColor
{
    // test basic black and white
    XCTAssertEqualObjects([[NSColor whiteColor] hues_hslWithDefaultFormat], @"hsl(0, 0%, 100%)", @"");
    XCTAssertEqualObjects([[NSColor blackColor] hues_hslWithDefaultFormat], @"hsl(0, 0%, 0%)", @"");
    
    // test various colors
    XCTAssertEqualObjects([[NSColor colorWithCalibratedRed:0 green:1 blue:0 alpha:1] hues_hslWithDefaultFormat], @"hsl(120, 100%, 50%)", @"");
    XCTAssertEqualObjects([[NSColor colorWithDeviceRed:0 green:1 blue:0 alpha:1] hues_hslWithDefaultFormat], @"hsl(120, 100%, 50%)", @"");
    XCTAssertEqualObjects([[NSColor colorWithCalibratedRed:1 green:1 blue:0 alpha:1] hues_hslWithDefaultFormat], @"hsl(60, 100%, 50%)", @"");
    XCTAssertEqualObjects([[NSColor colorWithDeviceRed:1 green:1 blue:0 alpha:1] hues_hslWithDefaultFormat], @"hsl(60, 100%, 50%)", @"");
    XCTAssertEqualObjects([[NSColor colorWithCalibratedRed:1 green:0 blue:0 alpha:1] hues_hslWithDefaultFormat], @"hsl(0, 100%, 50%)", @"");
    XCTAssertEqualObjects([[NSColor colorWithCalibratedRed:1 green:0 blue:1 alpha:1] hues_hslWithDefaultFormat], @"hsl(300, 100%, 50%)", @"");
    
    // test hsla is returned
    XCTAssertEqualObjects([[NSColor colorWithCalibratedWhite:1 alpha:0.5] hues_hslWithDefaultFormat], @"hsla(0, 0%, 100%, 0.50)", @"");
    XCTAssertEqualObjects([[NSColor colorWithCalibratedWhite:0 alpha:0.5] hues_hslWithDefaultFormat], @"hsla(0, 0%, 0%, 0.50)", @"");
    XCTAssertEqualObjects([[NSColor colorWithCalibratedRed:0 green:1 blue:0 alpha:0.75] hues_hslWithDefaultFormat], @"hsla(120, 100%, 50%, 0.75)", @"");
    XCTAssertEqualObjects([[NSColor colorWithDeviceRed:0 green:1 blue:0 alpha:0.5] hues_hslWithDefaultFormat], @"hsla(120, 100%, 50%, 0.50)", @"");
    XCTAssertEqualObjects([[NSColor colorWithCalibratedRed:1 green:1 blue:0 alpha:0.25] hues_hslWithDefaultFormat], @"hsla(60, 100%, 50%, 0.25)", @"");
    XCTAssertEqualObjects([[NSColor colorWithDeviceRed:1 green:1 blue:0 alpha:0.1] hues_hslWithDefaultFormat], @"hsla(60, 100%, 50%, 0.10)", @"");
}


- (void)testHexFormatParsing
{
    NSColor *color = [NSColor whiteColor];
    
    XCTAssertEqualObjects([color hues_hexWithFormat:@"{r}"], @"FF", @"");
    XCTAssertEqualObjects([color hues_hexWithFormat:@"{r}" useLowercase:YES], @"ff", @"");
    XCTAssertEqualObjects([color hues_hexWithFormat:@"{g}"], @"FF", @"");
    XCTAssertEqualObjects([color hues_hexWithFormat:@"{b}"], @"FF", @"");
    XCTAssertEqualObjects([color hues_hexWithFormat:@"{r}{g}{b}"], @"FFFFFF", @"");
    XCTAssertEqualObjects([color hues_hexWithFormat:@"{r}{g}{b}" useLowercase:YES], @"ffffff", @"");
    XCTAssertEqualObjects([color hues_hexWithFormat:@"#{r}{g}{b}"], @"#FFFFFF", @"");
    XCTAssertEqualObjects([color hues_hexWithFormat:@"{r} {g} {b}"], @"FF FF FF", @"");
    XCTAssertEqualObjects([color hues_hexWithFormat:@"{r}-{g}-{b}"], @"FF-FF-FF", @"");
    XCTAssertEqualObjects([color hues_hexWithFormat:@"{r}_{g}_{b}"], @"FF_FF_FF", @"");
    XCTAssertEqualObjects([color hues_hexWithFormat:@"0x{r}{g}{b}"], @"0xFFFFFF", @"");
    XCTAssertEqualObjects([color hues_hexWithFormat:@"{{r}}{{g}}{{b}}"], @"{FF}{FF}{FF}", @"");
    
    color = [NSColor colorWithCalibratedRed:1 green:0.5 blue:0.25 alpha:1];
    XCTAssertEqualObjects([color hues_hexWithFormat:@"{r}"], @"FF", @"");
    XCTAssertEqualObjects([color hues_hexWithFormat:@"{g}"], @"80", @"");
    XCTAssertEqualObjects([color hues_hexWithFormat:@"{b}"], @"40", @"");
    XCTAssertEqualObjects([color hues_hexWithFormat:@"{r}{g}{b}"], @"FF8040", @"");
    XCTAssertEqualObjects([color hues_hexWithFormat:@"#{r}{g}{b}"], @"#FF8040", @"");
    XCTAssertEqualObjects([color hues_hexWithFormat:@"{r} {g} {b}"], @"FF 80 40", @"");
    XCTAssertEqualObjects([color hues_hexWithFormat:@"{r}-{g}-{b}"], @"FF-80-40", @"");
    XCTAssertEqualObjects([color hues_hexWithFormat:@"{r}_{g}_{b}"], @"FF_80_40", @"");
    XCTAssertEqualObjects([color hues_hexWithFormat:@"0x{r}{g}{b}"], @"0xFF8040", @"");
    XCTAssertEqualObjects([color hues_hexWithFormat:@"{{r}}{{g}}{{b}}"], @"{FF}{80}{40}", @"");
}


- (void)testColorFromHex
{
    // Test correct input length
    XCTAssertNil([NSColor hues_colorFromHex:@""], @"Input less than 6 characters should be nil");
    XCTAssertNil([NSColor hues_colorFromHex:@"f"], @"Input less than 6 characters should be nil");
    XCTAssertNil([NSColor hues_colorFromHex:@"ff"], @"Input less than 6 characters should be nil");
    XCTAssertNil([NSColor hues_colorFromHex:@"fff"], @"Input less than 6 characters should be nil");
    XCTAssertNil([NSColor hues_colorFromHex:@"ffff"], @"Input less than 6 characters should be nil");
    XCTAssertNil([NSColor hues_colorFromHex:@"fffff"], @"Input less than 6 characters should be nil");
    XCTAssertNil([NSColor hues_colorFromHex:@"#fffff"], @"Input less than 6 characters after stripping # should be nil");
    
    // test same hex is returned
    XCTAssertEqualObjects([[NSColor hues_colorFromHex:@"FFFFFF"] hues_hexWithLowercase:NO], @"#FFFFFF", @"should return same hex");
    XCTAssertEqualObjects([[NSColor hues_colorFromHex:@"000000"] hues_hexWithLowercase:NO], @"#000000", @"should return same hex");
    XCTAssertEqualObjects([[NSColor hues_colorFromHex:@"00ff00"] hues_hexWithLowercase:NO], @"#00FF00", @"should return same hex");
    XCTAssertEqualObjects([[NSColor hues_colorFromHex:@"CCCCCC"] hues_hexWithLowercase:NO], @"#CCCCCC", @"should return same hex");
    XCTAssertEqualObjects([[NSColor hues_colorFromHex:@"abc369"] hues_hexWithLowercase:NO], @"#ABC369", @"should return same hex");
    
    // test same hex with correct formatting
    XCTAssertEqualObjects([[NSColor hues_colorFromHex:@"ffffff"] hues_hexWithLowercase:YES], @"#ffffff", @"lowercase and should return same hex, lowercase");
    XCTAssertEqualObjects([[NSColor hues_colorFromHex:@"ffffff"] hues_hexWithLowercase:NO], @"#FFFFFF", @"lowercase and should return same hex, uppercase");
    XCTAssertEqualObjects([[NSColor hues_colorFromHex:@"FFFFFF"] hues_hexWithLowercase:YES], @"#ffffff", @"uppercase and should return same hex, lowercase");
    
    
    // test extra input still works
    XCTAssertEqualObjects([[NSColor hues_colorFromHex:@"#FFFFFF"] hues_hexWithLowercase:NO], @"#FFFFFF", @"hex with # should return same hex");
    XCTAssertEqualObjects([[NSColor hues_colorFromHex:@"#FFFFFFFFFFFFF"] hues_hexWithLowercase:NO], @"#FFFFFF", @"hex with extra digits and # should return same hex");
    XCTAssertEqualObjects([[NSColor hues_colorFromHex:@"#CCCCCCfjfyefuf"] hues_hexWithLowercase:NO], @"#CCCCCC", @"hex with extra digits and # should return same hex");
    XCTAssertEqualObjects([[NSColor hues_colorFromHex:@"#CCCCCCFFFFFF"] hues_hexWithLowercase:NO], @"#CCCCCC", @"hex with extra digits and # should return same hex");
    XCTAssertEqualObjects([[NSColor hues_colorFromHex:@"#CCCCCFFFFFF"] hues_hexWithLowercase:NO], @"#CCCCCF", @"hex with extra digits and # should return same hex");
    
    
    // test invalid input returns #000000
    XCTAssertEqualObjects([[NSColor hues_colorFromHex:@"ZZZZZZ"] hues_hexWithLowercase:NO], @"#000000", @"invalid should return #000000");
    XCTAssertEqualObjects([[NSColor hues_colorFromHex:@"tyuytutytuytytuyt"] hues_hexWithLowercase:NO], @"#000000", @"invalid should return #000000");
    XCTAssertEqualObjects([[NSColor hues_colorFromHex:@";^&><?**&&'"] hues_hexWithLowercase:NO], @"#000000", @"invalid should return #000000");
    XCTAssertEqualObjects([[NSColor hues_colorFromHex:@"!@#$\"\"\\"] hues_hexWithLowercase:NO], @"#000000", @"invalid should return #000000");
}

@end
