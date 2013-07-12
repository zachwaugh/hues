//
//  HuesColorFormatterTest.m
//  Hues
//
//  Created by Zach Waugh on 7/12/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesColorFormatterTest.h"
#import "HuesColorFormatter.h"

@interface HuesColorFormatter ()

@end

@implementation HuesColorFormatterTest

- (void)setUp
{
	self.white = [NSColor colorWithCalibratedRed:1 green:1 blue:1 alpha:1];
	self.black = [NSColor colorWithCalibratedRed:0 green:0 blue:0 alpha:1];
	self.gray = [NSColor colorWithCalibratedRed:0.5 green:0.5 blue:0.5 alpha:1];
	self.green = [NSColor colorWithCalibratedRed:0 green:1 blue:0 alpha:1];
}

- (void)testHexStringFromColor
{
	expect([HuesColorFormatter stringForColor:self.white withFormat:@"#{RR}{GG}{BB}"]).to.equal(@"#FFFFFF");
	expect([HuesColorFormatter stringForColor:self.black withFormat:@"#{RR}{GG}{BB}"]).to.equal(@"#000000");
	expect([HuesColorFormatter stringForColor:self.gray withFormat:@"#{RR}{GG}{BB}"]).to.equal(@"#808080");
}

- (void)testRGBStringFromColor
{
	expect([HuesColorFormatter stringForColor:self.white withFormat:@"{r}-{g}-{b}"]).to.equal(@"1.000-1.000-1.000");
	expect([HuesColorFormatter stringForColor:self.white withFormat:@"{R}-{G}-{B}"]).to.equal(@"255-255-255");
	
	expect([HuesColorFormatter stringForColor:self.black withFormat:@"{r}-{g}-{b}"]).to.equal(@"0.000-0.000-0.000");
	expect([HuesColorFormatter stringForColor:self.black withFormat:@"{R}-{G}-{B}"]).to.equal(@"0-0-0");
	
	expect([HuesColorFormatter stringForColor:self.gray withFormat:@"{r}-{g}-{b}"]).to.equal(@"0.500-0.500-0.500");
	expect([HuesColorFormatter stringForColor:self.gray withFormat:@"{R}-{G}-{B}"]).to.equal(@"128-128-128");
}

- (void)testHSBStringFromColor
{
	expect([HuesColorFormatter stringForColor:self.white withFormat:@"{h}-{s}-{br}"]).to.equal(@"0.000-0.000-1.000");
	expect([HuesColorFormatter stringForColor:self.white withFormat:@"{H}-{S}-{BR}"]).to.equal(@"0-0-100");
	
	expect([HuesColorFormatter stringForColor:self.black withFormat:@"{h}-{s}-{br}"]).to.equal(@"0.000-0.000-0.000");
	expect([HuesColorFormatter stringForColor:self.black withFormat:@"{H}-{S}-{BR}"]).to.equal(@"0-0-0");
	
	expect([HuesColorFormatter stringForColor:self.gray withFormat:@"{h}-{s}-{br}"]).to.equal(@"0.000-0.000-0.500");
	expect([HuesColorFormatter stringForColor:self.gray withFormat:@"{H}-{S}-{BR}"]).to.equal(@"0-0-50");
	
	expect([HuesColorFormatter stringForColor:self.green withFormat:@"{h}-{s}-{br}"]).to.equal(@"0.333-1.000-1.000");
	expect([HuesColorFormatter stringForColor:self.green withFormat:@"{H}-{S}-{BR}"]).to.equal(@"120-100-100");
}

- (void)testHSLStringFromColor
{
	expect([HuesColorFormatter stringForColor:self.white withFormat:@"{h}-{s}-{l}"]).to.equal(@"0.000-0.000-1.000");
	expect([HuesColorFormatter stringForColor:self.white withFormat:@"{H}-{S}-{L}"]).to.equal(@"0-0-100");
	
	expect([HuesColorFormatter stringForColor:self.black withFormat:@"{h}-{s}-{l}"]).to.equal(@"0.000-0.000-0.000");
	expect([HuesColorFormatter stringForColor:self.black withFormat:@"{H}-{S}-{L}"]).to.equal(@"0-0-0");
	
	expect([HuesColorFormatter stringForColor:self.gray withFormat:@"{h}-{s}-{l}"]).to.equal(@"0.000-0.000-0.500");
	expect([HuesColorFormatter stringForColor:self.gray withFormat:@"{H}-{S}-{L}"]).to.equal(@"0-0-50");
	
	expect([HuesColorFormatter stringForColor:self.green withFormat:@"{h}-{s}-{l}"]).to.equal(@"0.333-1.000-0.500");
	expect([HuesColorFormatter stringForColor:self.green withFormat:@"{H}-{S}-{L}"]).to.equal(@"120-100-50");
}

- (void)testTokensFromColorFormat
{
	expect([HuesColorFormatter tokensForColorFormat:@""]).to.equal(@[]);
	expect([HuesColorFormatter tokensForColorFormat:@"{asdfasdf"]).to.equal(@[]);
	expect([HuesColorFormatter tokensForColorFormat:@"{a}"]).to.equal(@[@"a"]);
	
	NSArray *tokens = @[@"a", @"b"];
	expect([HuesColorFormatter tokensForColorFormat:@"{a}-{b}"]).to.equal(tokens);
	
	tokens = @[@"a", @"b", @"c"];
	expect([HuesColorFormatter tokensForColorFormat:@"foo bar{a}:{b} and also {c}"]).to.equal(tokens);
}

@end
