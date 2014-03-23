//
//  HuesColor+FormattingTest.m
//  Hues
//
//  Created by Zach Waugh on 7/20/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HuesColor.h"
#import "HuesColorFormatter.h"

@interface HuesColorFormatterTest : XCTestCase

@property (nonatomic, strong) HuesColor *white;
@property (nonatomic, strong) HuesColor *black;
@property (nonatomic, strong) HuesColor *gray;
@property (nonatomic, strong) HuesColor *green;

- (void)testHexStringFromColor;
- (void)testRGBStringFromColor;
- (void)testHSLStringFromColor;
- (void)testHSBStringFromColor;
//- (void)testTokensFromColorFormat;

@end

@implementation HuesColorFormatterTest

- (void)setUp
{
	self.white = [HuesColor colorWithRed:1 green:1 blue:1 alpha:1];
	self.black = [HuesColor colorWithRed:0 green:0 blue:0 alpha:1];
	self.gray = [HuesColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
	self.green = [HuesColor colorWithRed:0 green:1 blue:0 alpha:1];
}

- (void)testHexStringFromColor
{
	expect([HuesColorFormatter stringWithColor:self.white format:@"#{RR}{GG}{BB}"]).to.equal(@"#FFFFFF");
	expect([HuesColorFormatter stringWithColor:self.black format:@"#{RR}{GG}{BB}"]).to.equal(@"#000000");
	expect([HuesColorFormatter stringWithColor:self.gray format:@"#{RR}{GG}{BB}"]).to.equal(@"#808080");
}

- (void)testRGBStringFromColor
{
	expect([HuesColorFormatter stringWithColor:self.white format:@"{r}-{g}-{b}"]).to.equal(@"1.000-1.000-1.000");
	expect([HuesColorFormatter stringWithColor:self.white format:@"{R}-{G}-{B}"]).to.equal(@"255-255-255");
	
	expect([HuesColorFormatter stringWithColor:self.black format:@"{r}-{g}-{b}"]).to.equal(@"0.000-0.000-0.000");
	expect([HuesColorFormatter stringWithColor:self.black format:@"{R}-{G}-{B}"]).to.equal(@"0-0-0");
	
	expect([HuesColorFormatter stringWithColor:self.gray format:@"{r}-{g}-{b}"]).to.equal(@"0.500-0.500-0.500");
	expect([HuesColorFormatter stringWithColor:self.gray format:@"{R}-{G}-{B}"]).to.equal(@"128-128-128");
}

- (void)testHSBStringFromColor
{
	expect([HuesColorFormatter stringWithColor:self.white format:@"{h}-{s}-{br}"]).to.equal(@"0.000-0.000-1.000");
	expect([HuesColorFormatter stringWithColor:self.white format:@"{H}-{S}-{BR}"]).to.equal(@"0-0-100");
	
	expect([HuesColorFormatter stringWithColor:self.black format:@"{h}-{s}-{br}"]).to.equal(@"0.000-0.000-0.000");
	expect([HuesColorFormatter stringWithColor:self.black format:@"{H}-{S}-{BR}"]).to.equal(@"0-0-0");
	
	expect([HuesColorFormatter stringWithColor:self.gray format:@"{h}-{s}-{br}"]).to.equal(@"0.000-0.000-0.500");
	expect([HuesColorFormatter stringWithColor:self.gray format:@"{H}-{S}-{BR}"]).to.equal(@"0-0-50");
	
	expect([HuesColorFormatter stringWithColor:self.green format:@"{h}-{s}-{br}"]).to.equal(@"0.333-1.000-1.000");
	expect([HuesColorFormatter stringWithColor:self.green format:@"{H}-{S}-{BR}"]).to.equal(@"120-100-100");
}

- (void)testHSLStringFromColor
{
	expect([HuesColorFormatter stringWithColor:self.white format:@"{h}-{s}-{l}"]).to.equal(@"0.000-0.000-1.000");
	expect([HuesColorFormatter stringWithColor:self.white format:@"{H}-{S}-{L}"]).to.equal(@"0-0-100");
	
	expect([HuesColorFormatter stringWithColor:self.black format:@"{h}-{s}-{l}"]).to.equal(@"0.000-0.000-0.000");
	expect([HuesColorFormatter stringWithColor:self.black format:@"{H}-{S}-{L}"]).to.equal(@"0-0-0");
	
	expect([HuesColorFormatter stringWithColor:self.gray format:@"{h}-{s}-{l}"]).to.equal(@"0.000-0.000-0.500");
	expect([HuesColorFormatter stringWithColor:self.gray format:@"{H}-{S}-{L}"]).to.equal(@"0-0-50");
	
	expect([HuesColorFormatter stringWithColor:self.green format:@"{h}-{s}-{l}"]).to.equal(@"0.333-1.000-0.500");
	expect([HuesColorFormatter stringWithColor:self.green format:@"{H}-{S}-{L}"]).to.equal(@"120-100-50");
	
	HuesColor *red = [HuesColor colorWithRed:1.0 green:0.0 blue:0.0];
	expect([HuesColorFormatter stringWithColor:red format:@"{h}-{s}-{l}"]).to.equal(@"0.000-1.000-0.500");
	expect([HuesColorFormatter stringWithColor:red format:@"{H}-{S}-{L}"]).to.equal(@"0-100-50");
	
	red = [HuesColor colorWithHue:359 / 360.f saturation:1 lightness:1.0];
	expect([HuesColorFormatter stringWithColor:red format:@"{h}-{s}-{l}"]).to.equal(@"0.997-1.000-1.000");
	expect([HuesColorFormatter stringWithColor:red format:@"{H}-{S}-{L}"]).to.equal(@"359-100-100");
}

- (void)testNSColorCalibratedRGB
{
	NSString *format = @"[NSColor colorWithCalibratedRed:{r} green:{g} blue:{b} alpha:{a}]";
	
	// Test full white and full black
	expect([HuesColorFormatter stringWithColor:self.white format:format]).to.equal(@"[NSColor colorWithCalibratedRed:1.000 green:1.000 blue:1.000 alpha:1.000]");
	expect([HuesColorFormatter stringWithColor:self.black format:format]).to.equal(@"[NSColor colorWithCalibratedRed:0.000 green:0.000 blue:0.000 alpha:1.000]");
	expect([HuesColorFormatter stringWithColor:self.gray format:format]).to.equal(@"[NSColor colorWithCalibratedRed:0.500 green:0.500 blue:0.500 alpha:1.000]");
	expect([HuesColorFormatter stringWithColor:self.green format:format]).to.equal(@"[NSColor colorWithCalibratedRed:0.000 green:1.000 blue:0.000 alpha:1.000]");
}

- (void)testNSColorDeviceRGB
{
	NSString *format = @"[NSColor colorWithDeviceRed:{r} green:{g} blue:{b} alpha:{a}]";
	
	expect([HuesColorFormatter stringWithColor:self.white format:format]).to.equal(@"[NSColor colorWithDeviceRed:1.000 green:1.000 blue:1.000 alpha:1.000]");
	expect([HuesColorFormatter stringWithColor:self.black format:format]).to.equal(@"[NSColor colorWithDeviceRed:0.000 green:0.000 blue:0.000 alpha:1.000]");
	expect([HuesColorFormatter stringWithColor:self.gray format:format]).to.equal(@"[NSColor colorWithDeviceRed:0.500 green:0.500 blue:0.500 alpha:1.000]");
	expect([HuesColorFormatter stringWithColor:self.green format:format]).to.equal(@"[NSColor colorWithDeviceRed:0.000 green:1.000 blue:0.000 alpha:1.000]");
}

- (void)testUIColorRGB
{
	NSString *format = @"[UIColor colorWithRed:{r} green:{g} blue:{b} alpha:{a}]";
	
	expect([HuesColorFormatter stringWithColor:self.white format:format]).to.equal(@"[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1.000]");
	expect([HuesColorFormatter stringWithColor:self.black format:format]).to.equal(@"[UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:1.000]");
	expect([HuesColorFormatter stringWithColor:self.gray format:format]).to.equal(@"[UIColor colorWithRed:0.500 green:0.500 blue:0.500 alpha:1.000]");
	expect([HuesColorFormatter stringWithColor:self.green format:format]).to.equal(@"[UIColor colorWithRed:0.000 green:1.000 blue:0.000 alpha:1.000]");
}

//- (void)testTokensFromColorFormat
//{
//	expect([HuesColorFormatter tokensForColorFormat:@""]).to.equal(@[]);
//	//expect([HuesColorFormatter tokensForColorFormat:@"{asdfasdf"]).to.equal(@[]);
//	expect([HuesColorFormatter tokensForColorFormat:@"{a}"]).to.equal(@[@"a"]);
//
//	NSArray *tokens = @[@"a", @"b"];
//	expect([HuesColorFormatter tokensForColorFormat:@"{a}-{b}"]).to.equal(tokens);
//
//	tokens = @[@"a", @"b", @"c"];
//	expect([HuesColorFormatter tokensForColorFormat:@"foo bar{a}:{b} and also {c}"]).to.equal(tokens);
//}

@end
