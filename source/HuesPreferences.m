//
//  HUPreferences.m
//  Hues
//
//  Created by Zach Waugh on 12/21/10.
//  Copyright 2010 Giant Comet. All rights reserved.
//

#import "HuesPreferences.h"
#import "MASShortcut.h"

// Preferences
NSString * const HuesCopyToClipboardKey = @"HuesCopyToClipboard";
NSString * const HuesUseLowercaseKey = @"HuesUseLowercase";
NSString * const HuesDefaultColorRepresentationKey = @"HuesDefaultColorRepresentation";
NSString * const HuesHexFormatKey = @"HuesHexFormat";
NSString * const HuesRGBFormatKey = @"HuesRGBFormat";
NSString * const HuesRGBAFormatKey = @"HuesRGBAFormat";
NSString * const HuesHSBFormatKey = @"HuesHSBFormat";
NSString * const HuesHSLFormatKey = @"HuesHSLFormat";
NSString * const HuesHSLAFormatKey = @"HuesHSLAFormat";
NSString * const HuesKeepOnTopKey = @"HuesKeepOnTop";
NSString * const HuesApplicationModeKey = @"HuesApplicationMode";
NSString * const HuesLoupeShortcutKey = @"loupeShortcut";

@implementation HuesPreferences

+ (void)registerDefaults
{
  NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
  
	// Default to Menu bar only
	defaults[HuesApplicationModeKey] = @(HuesMenuBarOnlyMode);
	
  // Auto copy to clipboard on
  defaults[HuesCopyToClipboardKey] = @YES;
  
  // Hex is default
	defaults[HuesDefaultColorRepresentationKey] = @(HuesHexRepresentation);
  
  // Don't default to lowercase
	defaults[HuesUseLowercaseKey] = @NO;
	
  // Color formats
	defaults[HuesHexFormatKey] = @"#{r}{g}{b}";
  //[defaults setObject:@"#{r}{g}{b}" forKey:HuesHexFormatKey];
  
	defaults[HuesRGBFormatKey] = @"rgb({r}, {g}, {b})";
	//[defaults setObject:@"rgb({r}, {g}, {b})" forKey:HuesRGBFormatKey];
  
	defaults[HuesRGBAFormatKey] = @"rgba({r}, {g}, {b}, {a})";
	//[defaults setObject:@"rgba({r}, {g}, {b}, {a})" forKey:HuesRGBAFormatKey];
  
	defaults[HuesHSBFormatKey] = @"hsb({h}, {s}%, {b}%)";
	//[defaults setObject:@"hsb({h}, {s}%, {b}%)" forKey:HuesHSBFormatKey];
  
	defaults[HuesHSLFormatKey] = @"hsl({h}, {s}%, {l}%)";
	//[defaults setObject:@"hsl({h}, {s}%, {l}%)" forKey:HuesHSLFormatKey];
  
	defaults[HuesHSLAFormatKey] = @"hsla({h}, {s}%, {l}%, {a})";
	//[defaults setObject:@"hsla({h}, {s}%, {l}%, {a})" forKey:HuesHSLAFormatKey];
	
	// Window
	defaults[HuesKeepOnTopKey] = @NO;
	
	// Shortcut
	defaults[HuesLoupeShortcutKey] = [[MASShortcut shortcutWithKeyCode:kVK_ANSI_C modifierFlags:(NSAlternateKeyMask | NSCommandKeyMask)] data];
  
  [[NSUserDefaults standardUserDefaults] registerDefaults:defaults];
}

+ (HuesColorRepresentation)defaultRepresentation
{
  return (HuesColorRepresentation)[[NSUserDefaults standardUserDefaults] integerForKey:HuesDefaultColorRepresentationKey];
}

+ (BOOL)useLowercase
{
  return [[NSUserDefaults standardUserDefaults] boolForKey:HuesUseLowercaseKey];
}

+ (void)setUseLowercase:(BOOL)lowercase
{
  [[NSUserDefaults standardUserDefaults] setBool:lowercase forKey:HuesUseLowercaseKey];
}

+ (NSString *)hexFormat
{
  return [[NSUserDefaults standardUserDefaults] stringForKey:HuesHexFormatKey];
}

+ (NSString *)rgbFormat
{
  return [[NSUserDefaults standardUserDefaults] stringForKey:HuesRGBFormatKey];
}

+ (NSString *)rgbaFormat
{
  return [[NSUserDefaults standardUserDefaults] stringForKey:HuesRGBAFormatKey];
}

+ (NSString *)hsbFormat
{
  return [[NSUserDefaults standardUserDefaults] stringForKey:HuesHSBFormatKey];
}

+ (NSString *)hslFormat
{
  return [[NSUserDefaults standardUserDefaults] stringForKey:HuesHSLFormatKey];
}

+ (NSString *)hslaFormat
{
  return [[NSUserDefaults standardUserDefaults] stringForKey:HuesHSLAFormatKey];
}

+ (BOOL)copyToClipboard
{
  return [[NSUserDefaults standardUserDefaults] boolForKey:HuesCopyToClipboardKey];  
}

+ (void)setCopyToClipboard:(BOOL)copy
{
  [[NSUserDefaults standardUserDefaults] setBool:copy forKey:HuesCopyToClipboardKey];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

//+ (BOOL)useCalibratedColors
//{
//  return [[NSUserDefaults standardUserDefaults] boolForKey:HuesUseCalibratedColorsKey]; 
//}
//
//
//+ (void)setCalibratedColors:(BOOL)calibrated
//{
//  [[NSUserDefaults standardUserDefaults] setBool:calibrated forKey:HuesUseCalibratedColorsKey];
//  [[NSUserDefaults standardUserDefaults] synchronize];
//}

+ (HuesApplicationMode)applicationMode
{
	return (HuesApplicationMode)[[NSUserDefaults standardUserDefaults] integerForKey:HuesApplicationModeKey];
}

+ (void)setApplicationMode:(HuesApplicationMode)mode
{
	[[NSUserDefaults standardUserDefaults] setInteger:mode forKey:HuesApplicationModeKey];
}

+ (BOOL)keepOnTop
{
	return [[NSUserDefaults standardUserDefaults] boolForKey:HuesKeepOnTopKey];
}

+ (void)setKeepOnTop:(BOOL)keepOnTop
{
	[[NSUserDefaults standardUserDefaults] setBool:keepOnTop forKey:HuesKeepOnTopKey];
}

@end
