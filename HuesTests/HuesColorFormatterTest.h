//
//  HuesColorFormatterTest.h
//  Hues
//
//  Created by Zach Waugh on 7/12/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@interface HuesColorFormatterTest : SenTestCase

@property (strong) NSColor *white;
@property (strong) NSColor *black;
@property (strong) NSColor *gray;
@property (strong) NSColor *green;

- (void)testHexStringFromColor;
- (void)testRGBStringFromColor;
- (void)testHSLStringFromColor;
- (void)testHSBStringFromColor;
- (void)testTokensFromColorFormat;

@end
