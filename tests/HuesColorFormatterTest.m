//
//  HuesColorFormatterTest.m
//  Hues
//
//  Created by Zach Waugh on 7/12/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesColorFormatterTest.h"
#import "HuesColorFormatter.h"

@implementation HuesColorFormatterTest

- (void)testStringFromColor
{
	NSColor *white = [NSColor colorWithCalibratedRed:1 green:1 blue:1 alpha:1];
	
	expect([HuesColorFormatter stringForColor:white withFormat:@"#{RR}{GG}{BB}"]).to.equal(@"#FFFFFF");
	expect([HuesColorFormatter stringForColor:white withFormat:@"{r}-{g}-{b}"]).to.equal(@"1.000-1.000-1.000");
	expect([HuesColorFormatter stringForColor:white withFormat:@"{R}-{G}-{B}"]).to.equal(@"255-255-255");
	
	NSColor *black = [NSColor colorWithCalibratedRed:0 green:0 blue:0 alpha:1];
	
	expect([HuesColorFormatter stringForColor:black withFormat:@"#{RR}{GG}{BB}"]).to.equal(@"#000000");
	expect([HuesColorFormatter stringForColor:black withFormat:@"{r}-{g}-{b}"]).to.equal(@"0.000-0.000-0.000");
	expect([HuesColorFormatter stringForColor:black withFormat:@"{R}-{G}-{B}"]).to.equal(@"0-0-0");
	
	NSColor *gray = [NSColor colorWithCalibratedRed:0.5 green:0.5 blue:0.5 alpha:1];
	
	expect([HuesColorFormatter stringForColor:gray withFormat:@"#{RR}{GG}{BB}"]).to.equal(@"#808080");
	expect([HuesColorFormatter stringForColor:gray withFormat:@"{r}-{g}-{b}"]).to.equal(@"0.500-0.500-0.500");
	expect([HuesColorFormatter stringForColor:gray withFormat:@"{R}-{G}-{B}"]).to.equal(@"128-128-128");
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
