//
//  HuesColorParserTest.h
//  Hues
//
//  Created by Zach Waugh on 7/11/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@interface HuesColorParserTest : SenTestCase

// Hex
- (void)testParseColorFromHexWithValidInput;
- (void)testParseColorFromHexWithInvalidInput;
- (void)testParseColorFromHexReturnsSameHex;

// RGB
- (void)testParseColorFromRGBWithValidInput;
- (void)testParseColorFromRGBWithInvalidInput;
- (void)testParseColorFromRGBAWithValidInput;

// HSL
- (void)testParseColorFromHSL;

// NSColor
- (void)testColorFromNSColor;
- (void)testColorFromUIColor;

@end
