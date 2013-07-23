//
//  HuesColor+FormattingTest.h
//  Hues
//
//  Created by Zach Waugh on 7/20/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@class HuesColor;

@interface HuesColor_FormattingTest : SenTestCase

@property (strong) HuesColor *white;
@property (strong) HuesColor *black;
@property (strong) HuesColor *gray;
@property (strong) HuesColor *green;

- (void)testHexStringFromColor;
- (void)testRGBStringFromColor;
- (void)testHSLStringFromColor;
- (void)testHSBStringFromColor;
//- (void)testTokensFromColorFormat;

@end
