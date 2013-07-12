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
NSString * const HuesColorFormatsKey = @"HuesColorFormats";
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
	defaults[HuesColorFormatsKey] = @[
									@{@"name": @"Hex", @"format": @"#{r}{g}{b}"},
									@{@"name": @"RGB", @"format": @"rgb({r}, {g}, {b})"},
									@{@"name": @"RGBA", @"format": @"rgba({r}, {g}, {b}, {a})"},
									@{@"name": @"HSB", @"format": @"hsb({h}, {s}%, {b}%)"},
									@{@"name": @"HSL", @"format": @"hsl({h}, {s}%, {l}%)"},
									@{@"name": @"HSLA", @"format": @"hsla({h}, {s}%, {l}%, {a})"},
									@{@"name": @"NSColor", @"format": @"[NSColor colorWithCalibratedRed:{r} green:{g} blue:{b} alpha:{a}]"}
	];
	
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

+ (NSArray *)colorFormats
{
  return [[NSUserDefaults standardUserDefaults] arrayForKey:HuesColorFormatsKey];
}

+ (void)setColorFormats:(NSArray *)formats
{
	[[NSUserDefaults standardUserDefaults] setObject:formats forKey:HuesColorFormatsKey];
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
