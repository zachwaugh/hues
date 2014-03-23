//
//  HuesColorParserTest.m
//  Hues
//
//  Created by Zach Waugh on 7/11/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesColorParserTest.h"
#import "HuesColorParser.h"
#import "HuesColor.h"

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
	expect([HuesColorParser colorFromHex:@"#FFFFFF"]).to.equal([HuesColor colorWithRed:1 green:1 blue:1]);
	
	expect([HuesColorParser colorFromHex:@"ffffff"]).toNot.beNil();
	expect([HuesColorParser colorFromHex:@"ffffff"]).to.equal([HuesColor colorWithRed:1 green:1 blue:1]);
	
	expect([HuesColorParser colorFromHex:@"FFFFFF"]).toNot.beNil();
	expect([HuesColorParser colorFromHex:@"FFFFFF"]).to.equal([HuesColor colorWithRed:1 green:1 blue:1]);
	
	expect([HuesColorParser colorFromHex:@"000000"]).toNot.beNil();
	expect([HuesColorParser colorFromHex:@"000000"]).to.equal([HuesColor colorWithRed:0 green:0 blue:0]);
	
	expect([HuesColorParser colorFromHex:@"000000"]).toNot.beNil();
	expect([HuesColorParser colorFromHex:@"000000"]).to.equal([HuesColor colorWithRed:0 green:0 blue:0]);
}

- (void)testParseColorFromHexWithExtraCharacters
{
	// test extra input still works
	expect([HuesColorParser colorFromHex:@"#FFFFFF"]).to.equal([HuesColor colorWithRed:1 green:1 blue:1]);
	expect([HuesColorParser colorFromHex:@"#FFFFFFFFFFFFF"]).to.equal([HuesColor colorWithRed:1 green:1 blue:1]);
	expect([HuesColorParser colorFromHex:@"#CCCCCCfjfyefuf"]).to.equal([HuesColor colorWithRed:0.8 green:0.8 blue:0.8]);
	expect([HuesColorParser colorFromHex:@"#CCCCCCFFFFFF"]).to.equal([HuesColor colorWithRed:0.8 green:0.8 blue:0.8]);
	expect([HuesColorParser colorFromHex:@"#CCCCCFFFFFF"]).to.equal([HuesColor colorWithRed:0.8 green:0.8 blue:0.811764706]);
}

- (void)testParseColorFromRGBWithValidInput
{
	expect([HuesColorParser colorFromRGB:@"rgb(255, 255, 255)"]).to.equal([HuesColor colorWithRed:1 green:1 blue:1 alpha:1]);
	expect([HuesColorParser colorFromRGB:@"rgb(0, 0, 0)"]).to.equal([HuesColor colorWithRed:0 green:0 blue:0 alpha:1]);
}

- (void)testParseColorFromRGBWithInvalidInput
{
	expect([HuesColorParser colorFromRGB:@"255, 255, 255"]).to.beNil();
	expect([HuesColorParser colorFromRGB:@"blah"]).to.beNil();
}

- (void)testParseColorFromRGBAWithValidInput
{
	expect([HuesColorParser colorFromRGB:@"rgba(255, 255, 255, 0.5)"]).to.equal([HuesColor colorWithRed:1 green:1 blue:1 alpha:0.5]);
	expect([HuesColorParser colorFromRGB:@"rgba(0, 0, 0, 0.1)"]).to.equal([HuesColor colorWithRed:0 green:0 blue:0 alpha:0.1]);
}

- (void)testParseColorFromHSL
{
	
}

- (void)testColorFromNSColor
{
	expect([HuesColorParser colorFromCocoaColor:@"[NSColor colorWithCalibratedRed:1.0 green:1.0 blue:1.0 alpha:1.0]"]).to.equal([HuesColor colorWithRed:1 green:1 blue:1 alpha:1.0]);
	expect([HuesColorParser colorFromCocoaColor:@"[NSColor colorWithCalibratedRed:0.0 green:0.0 blue:0.0 alpha:1.0]"]).to.equal([HuesColor colorWithRed:0 green:0 blue:0 alpha:1.0]);
	
	expect([HuesColorParser colorFromCocoaColor:@"[NSColor colorWithCalibratedRed:0.5 green:0.5 blue:0.5 alpha:0.75]"]).to.equal([HuesColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.75]);
}

- (void)testColorFromUIColor
{
	expect([HuesColorParser colorFromCocoaColor:@"[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.75]"]).to.equal([HuesColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.75]);
}

@end
