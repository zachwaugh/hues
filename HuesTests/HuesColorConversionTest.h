//
//  HuesColorConversionTest.h
//  Hues
//
//  Created by Zach Waugh on 7/20/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@interface HuesColorConversionTest : SenTestCase

// Conversion
- (void)testHSLToRGB;
- (void)testRGBToHSL;
- (void)testHSBToRGB;
- (void)testRGBToHSB;

@end
