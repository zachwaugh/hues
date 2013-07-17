//
//  HuesColorFormatter.h
//  Hues
//
//  Created by Zach Waugh on 7/11/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HuesColorFormatter : NSObject

+ (NSString *)hexForColor:(NSColor *)color;
+ (NSString *)stringForColorWithPrimaryFormat:(NSColor *)color;
+ (NSString *)stringForColorWithSecondaryFormat:(NSColor *)color;
+ (NSString *)stringForColor:(NSColor *)color withFormat:(NSString *)format;
+ (NSArray *)tokensForColorFormat:(NSString *)format;

@end
