//
//  HUPreferences.h
//  Hues
//
//  Created by Zach Waugh on 12/21/10.
//  Copyright 2010 Giant Comet. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HuesDefines.h"

// Preferences keys
extern NSString * const HuesCopyToClipboardKey;
extern NSString * const HuesUseLowercaseKey;
extern NSString * const HuesDefaultColorRepresentationKey;
extern NSString * const HuesHexFormatKey;
extern NSString * const HuesRGBFormatKey;
extern NSString * const HuesRGBAFormatKey;
extern NSString * const HuesHSBFormatKey;
extern NSString * const HuesHSLFormatKey;
extern NSString * const HuesHSLAFormatKey;
extern NSString * const HuesKeepOnTopKey;
extern NSString * const HuesApplicationModeKey;
extern NSString * const HuesLoupeShortcutKey;

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

+ (BOOL)useLowercase;
+ (void)setUseLowercase:(BOOL)lowercase;
//+ (BOOL)useCalibratedColors;
//+ (void)setCalibratedColors:(BOOL)calibrated;

+ (HuesApplicationMode)applicationMode;
+ (void)setApplicationMode:(HuesApplicationMode)mode;
+ (BOOL)keepOnTop;
+ (void)setKeepOnTop:(BOOL)keepOnTop;

@end
