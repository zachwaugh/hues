//
//  HUPreferences.h
//  Hues
//
//  Created by Zach Waugh on 12/21/10.
//  Copyright 2010 Giant Comet. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HuesGlobal.h"

@interface HuesPreferences : NSObject

+ (void)registerDefaults;

+ (BOOL)copyToClipboard;
+ (void)setCopyToClipboard:(BOOL)copy;


+ (HuesColorRepresentation)defaultRepresentation;
+ (NSString *)hexFormat;
+ (NSString *)rgbFormat;
+ (NSString *)rgbaFormat;
+ (NSString *)hsbFormat;
+ (NSString *)hslFormat;
+ (NSString *)hslaFormat;
+ (NSInteger)pickerMask;

+ (BOOL)useLowercase;

//+ (BOOL)useCalibratedColors;
//+ (void)setCalibratedColors:(BOOL)calibrated;

@end
