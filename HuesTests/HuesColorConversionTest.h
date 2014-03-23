//
//  HuesColorConversionTest.h
//  Hues
//
//  Created by Zach Waugh on 7/20/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface HuesColorConversionTest : XCTestCase

// Conversion
- (void)testHSLToRGB;
- (void)testRGBToHSL;
- (void)testHSBToRGB;
- (void)testRGBToHSB;
- (void)testHSBToHSL;

@end
