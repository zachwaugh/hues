//
//  HuesColorParserTest.m
//  Hues
//
//  Created by Zach Waugh on 7/11/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesColorParserTest.h"
#import "HuesColorParser.h"
#import "NSColor+Hues.h"

@implementation HuesColorParserTest

- (void)testParseColorFromHexWithInvalidInput
{
	// Test correct input length
  expect([HuesColorParser colorFromHex:@""]).to.beNil();
  expect([HuesColorParser colorFromHex:@"f"]).to.beNil();
  expect([HuesColorParser colorFromHex:@"ff"]).to.beNil();
  expect([HuesColorParser colorFromHex:@"fff"]).to.beNil();
  expect([HuesColorParser colorFromHex:@"ffff"]).to.beNil();
  expect([HuesColorParser colorFromHex:@"fffff"]).to.beNil();
  expect([HuesColorParser colorFromHex:@"#fffff"]).to.beNil();
	
	// test invalid input returns #000000
  expect([[HuesColorParser colorFromHex:@"ZZZZZZ"] hues_hexWithLowercase:NO]).to.equal(@"#000000");
  expect([[HuesColorParser colorFromHex:@"tyuytutytuytytuyt"] hues_hexWithLowercase:NO]).to.equal(@"#000000");
  expect([[HuesColorParser colorFromHex:@";^&><?**&&'"] hues_hexWithLowercase:NO]).to.equal(@"#000000");
  expect([[HuesColorParser colorFromHex:@"!@#$\"\"\\"] hues_hexWithLowercase:NO]).to.equal(@"#000000");
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

- (void)testParseColorFromHexReturnsSameHex
{
  expect([[HuesColorParser colorFromHex:@"FFFFFF"] hues_hexWithLowercase:NO]).to.equal(@"#FFFFFF");
  expect([[HuesColorParser colorFromHex:@"000000"] hues_hexWithLowercase:NO]).to.equal(@"#000000");
  expect([[HuesColorParser colorFromHex:@"00ff00"] hues_hexWithLowercase:NO]).to.equal(@"#00FF00");
  expect([[HuesColorParser colorFromHex:@"CCCCCC"] hues_hexWithLowercase:NO]).to.equal(@"#CCCCCC");
  expect([[HuesColorParser colorFromHex:@"abc369"] hues_hexWithLowercase:NO]).to.equal(@"#ABC369");
  
  // test same hex with correct formatting
  expect([[HuesColorParser colorFromHex:@"ffffff"] hues_hexWithLowercase:YES]).to.equal(@"#ffffff");
  expect([[HuesColorParser colorFromHex:@"ffffff"] hues_hexWithLowercase:NO]).to.equal(@"#FFFFFF");
  expect([[HuesColorParser colorFromHex:@"FFFFFF"] hues_hexWithLowercase:YES]).to.equal(@"#ffffff");
}

- (void)testParseColorFromHexWithExtraCharacters
{
	// test extra input still works
  expect([[HuesColorParser colorFromHex:@"#FFFFFF"] hues_hexWithLowercase:NO]).to.equal(@"#FFFFFF");
  expect([[HuesColorParser colorFromHex:@"#FFFFFFFFFFFFF"] hues_hexWithLowercase:NO]).to.equal(@"#FFFFFF");
  expect([[HuesColorParser colorFromHex:@"#CCCCCCfjfyefuf"] hues_hexWithLowercase:NO]).to.equal(@"#CCCCCC");
  expect([[HuesColorParser colorFromHex:@"#CCCCCCFFFFFF"] hues_hexWithLowercase:NO]).to.equal(@"#CCCCCC");
  expect([[HuesColorParser colorFromHex:@"#CCCCCFFFFFF"] hues_hexWithLowercase:NO]).to.equal(@"#CCCCCF");
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
	
}

@end
