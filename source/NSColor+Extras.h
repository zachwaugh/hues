//
//  NSColor+Extras.h
//  Hues
//
//  Created by Zach Waugh on 12/21/10.
//  Copyright 2010 Giant Comet. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSColor (Extras)

- (NSString *)hues_hexadecimal;
- (NSString *)hues_rgb;
- (NSString *)hues_hsb;
- (NSColor *)hues_convertedColor;

@end
