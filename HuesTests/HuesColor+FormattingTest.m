//
//  HuesColor+FormattingTest.m
//  Hues
//
//  Created by Zach Waugh on 7/20/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesColor+FormattingTest.h"
#import "HuesColor+Formatting.h"

@implementation HuesColor_FormattingTest

- (void)setUp
{
	self.white = [HuesColor colorWithRed:1 green:1 blue:1 alpha:1];
	self.black = [HuesColor colorWithRed:0 green:0 blue:0 alpha:1];
	self.gray = [HuesColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
	self.green = [HuesColor colorWithRed:0 green:1 blue:0 alpha:1];
}

- (void)testHexStringFromColor
{
	expect([self.white stringWithFormat:@"#{RR}{GG}{BB}"]).to.equal(@"#FFFFFF");
	expect([self.black stringWithFormat:@"#{RR}{GG}{BB}"]).to.equal(@"#000000");
	expect([self.gray stringWithFormat:@"#{RR}{GG}{BB}"]).to.equal(@"#808080");
}

- (void)testRGBStringFromColor
{
	expect([self.white stringWithFormat:@"{r}-{g}-{b}"]).to.equal(@"1.000-1.000-1.000");
	expect([self.white stringWithFormat:@"{R}-{G}-{B}"]).to.equal(@"255-255-255");
	
	expect([self.black stringWithFormat:@"{r}-{g}-{b}"]).to.equal(@"0.000-0.000-0.000");
	expect([self.black stringWithFormat:@"{R}-{G}-{B}"]).to.equal(@"0-0-0");
	
	expect([self.gray stringWithFormat:@"{r}-{g}-{b}"]).to.equal(@"0.500-0.500-0.500");
	expect([self.gray stringWithFormat:@"{R}-{G}-{B}"]).to.equal(@"128-128-128");
}

- (void)testHSBStringFromColor
{
	expect([self.white stringWithFormat:@"{h}-{s}-{br}"]).to.equal(@"0.000-0.000-1.000");
	expect([self.white stringWithFormat:@"{H}-{S}-{BR}"]).to.equal(@"0-0-100");
	
	expect([self.black stringWithFormat:@"{h}-{s}-{br}"]).to.equal(@"0.000-0.000-0.000");
	expect([self.black stringWithFormat:@"{H}-{S}-{BR}"]).to.equal(@"0-0-0");
	
	expect([self.gray stringWithFormat:@"{h}-{s}-{br}"]).to.equal(@"0.000-0.000-0.500");
	expect([self.gray stringWithFormat:@"{H}-{S}-{BR}"]).to.equal(@"0-0-50");
	
	expect([self.green stringWithFormat:@"{h}-{s}-{br}"]).to.equal(@"0.333-1.000-1.000");
	expect([self.green stringWithFormat:@"{H}-{S}-{BR}"]).to.equal(@"120-100-100");
}

- (void)testHSLStringFromColor
{
	expect([self.white stringWithFormat:@"{h}-{s}-{l}"]).to.equal(@"0.000-0.000-1.000");
	expect([self.white stringWithFormat:@"{H}-{S}-{L}"]).to.equal(@"0-0-100");
	
	expect([self.black stringWithFormat:@"{h}-{s}-{l}"]).to.equal(@"0.000-0.000-0.000");
	expect([self.black stringWithFormat:@"{H}-{S}-{L}"]).to.equal(@"0-0-0");
	
	expect([self.gray stringWithFormat:@"{h}-{s}-{l}"]).to.equal(@"0.000-0.000-0.500");
	expect([self.gray stringWithFormat:@"{H}-{S}-{L}"]).to.equal(@"0-0-50");
	
	expect([self.green stringWithFormat:@"{h}-{s}-{l}"]).to.equal(@"0.333-1.000-0.500");
	expect([self.green stringWithFormat:@"{H}-{S}-{L}"]).to.equal(@"120-100-50");
	
	HuesColor *red = [HuesColor colorWithRed:1.0 green:0.0 blue:0.0];
	expect([red stringWithFormat:@"{h}-{s}-{l}"]).to.equal(@"0.000-1.000-0.500");
	expect([red stringWithFormat:@"{H}-{S}-{L}"]).to.equal(@"0-100-50");
	
	red = [HuesColor colorWithHue:359 / 360.f saturation:1 lightness:1.0];
	expect([red stringWithFormat:@"{h}-{s}-{l}"]).to.equal(@"0.997-1.000-1.000");
	expect([red stringWithFormat:@"{H}-{S}-{L}"]).to.equal(@"359-100-100");
}

- (void)testNSColorCalibratedRGB
{
	NSString *format = @"[NSColor colorWithCalibratedRed:{r} green:{g} blue:{b} alpha:{a}]";
	
	// Test full white and full black
	expect([self.white stringWithFormat:format]).to.equal(@"[NSColor colorWithCalibratedRed:1.000 green:1.000 blue:1.000 alpha:1.000]");
  expect([self.black stringWithFormat:format]).to.equal(@"[NSColor colorWithCalibratedRed:0.000 green:0.000 blue:0.000 alpha:1.000]");
	expect([self.gray stringWithFormat:format]).to.equal(@"[NSColor colorWithCalibratedRed:0.500 green:0.500 blue:0.500 alpha:1.000]");
	expect([self.green stringWithFormat:format]).to.equal(@"[NSColor colorWithCalibratedRed:0.000 green:1.000 blue:0.000 alpha:1.000]");
}

- (void)testNSColorDeviceRGB
{
	NSString *format = @"[NSColor colorWithDeviceRed:{r} green:{g} blue:{b} alpha:{a}]";
	
	expect([self.white stringWithFormat:format]).to.equal(@"[NSColor colorWithDeviceRed:1.000 green:1.000 blue:1.000 alpha:1.000]");
  expect([self.black stringWithFormat:format]).to.equal(@"[NSColor colorWithDeviceRed:0.000 green:0.000 blue:0.000 alpha:1.000]");
	expect([self.gray stringWithFormat:format]).to.equal(@"[NSColor colorWithDeviceRed:0.500 green:0.500 blue:0.500 alpha:1.000]");
	expect([self.green stringWithFormat:format]).to.equal(@"[NSColor colorWithDeviceRed:0.000 green:1.000 blue:0.000 alpha:1.000]");
}

- (void)testUIColorRGB
{
	NSString *format = @"[UIColor colorWithRed:{r} green:{g} blue:{b} alpha:{a}]";
	
	expect([self.white stringWithFormat:format]).to.equal(@"[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1.000]");
  expect([self.black stringWithFormat:format]).to.equal(@"[UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:1.000]");
	expect([self.gray stringWithFormat:format]).to.equal(@"[UIColor colorWithRed:0.500 green:0.500 blue:0.500 alpha:1.000]");
	expect([self.green stringWithFormat:format]).to.equal(@"[UIColor colorWithRed:0.000 green:1.000 blue:0.000 alpha:1.000]");
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
