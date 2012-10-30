//
//  HUPreferences.m
//  Hues
//
//  Created by Zach Waugh on 12/21/10.
//  Copyright 2010 Giant Comet. All rights reserved.
//

#import "HuesPreferences.h"

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

NSString * const HuesShowColorWheelPickerKey = @"HuesShowColorWheelPicker";
NSString * const HuesShowColorSlidersGrayPickerKey = @"HuesShowColorSlidersGrayPicker";
NSString * const HuesShowColorSlidersRGBPickerKey = @"HuesShowColorSlidersRGBPicker";
NSString * const HuesShowColorSlidersCMYKPickerKey = @"HuesShowColorSlidersCMYKPicker";
NSString * const HuesShowColorSlidersHSBPickerKey = @"HuesShowColorSlidersHSBPicker";
NSString * const HuesShowColorPalettesPickerKey = @"HuesShowColorPalettesPicker";
NSString * const HuesShowImagePalettesPickerKey = @"HuesShowImagePalettesPicker";
NSString * const HuesShowCrayonsPickerKey = @"HuesShowCrayonsPicker";

@implementation HuesPreferences

+ (void)registerDefaults
{
  NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
  
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
  
  // Color Pickers
	defaults[HuesShowColorWheelPickerKey] = @YES;
	defaults[HuesShowColorSlidersGrayPickerKey] = @YES;
	defaults[HuesShowColorSlidersRGBPickerKey] = @YES;
	defaults[HuesShowColorSlidersCMYKPickerKey] = @YES;
	defaults[HuesShowColorSlidersHSBPickerKey] = @YES;
	defaults[HuesShowColorPalettesPickerKey] = @YES;
	defaults[HuesShowImagePalettesPickerKey] = @YES;
	defaults[HuesShowCrayonsPickerKey] = @YES;
	
	// Window
	defaults[HuesKeepOnTopKey] = @NO;
  
  [[NSUserDefaults standardUserDefaults] registerDefaults:defaults];
}

+ (HuesColorRepresentation)defaultRepresentation
{
  return [[NSUserDefaults standardUserDefaults] integerForKey:HuesDefaultColorRepresentationKey];
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

+ (NSUInteger)pickerMask
{
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  
  NSUInteger colorWheel = ([defaults boolForKey:HuesShowColorWheelPickerKey]) ? NSColorPanelWheelModeMask : 0;
  NSUInteger colorSliderGrayscale = ([defaults boolForKey:HuesShowColorSlidersGrayPickerKey]) ? NSColorPanelGrayModeMask : 0;
  NSUInteger colorSliderRGB = ([defaults boolForKey:HuesShowColorSlidersRGBPickerKey]) ? NSColorPanelRGBModeMask : 0;
  NSUInteger colorSliderCMYK = ([defaults boolForKey:HuesShowColorSlidersCMYKPickerKey]) ? NSColorPanelCMYKModeMask : 0;
  NSUInteger colorSliderHSB = ([defaults boolForKey:HuesShowColorSlidersHSBPickerKey]) ? NSColorPanelHSBModeMask : 0;
  NSUInteger colorPalettes = ([defaults boolForKey:HuesShowColorPalettesPickerKey]) ? NSColorPanelColorListModeMask : 0;
  NSUInteger imagePalettes = ([defaults boolForKey:HuesShowImagePalettesPickerKey]) ? NSColorPanelCustomPaletteModeMask : 0;
  NSUInteger crayons = ([defaults boolForKey:HuesShowCrayonsPickerKey]) ? NSColorPanelCrayonModeMask : 0;
  
  return (colorWheel | colorSliderGrayscale | colorSliderRGB | colorSliderCMYK | colorSliderHSB | colorPalettes | imagePalettes | crayons);
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

+ (BOOL)keepOnTop
{
	return [[NSUserDefaults standardUserDefaults] boolForKey:HuesKeepOnTopKey];
}

+ (void)setKeepOnTop:(BOOL)keepOnTop
{
	[[NSUserDefaults standardUserDefaults] setBool:keepOnTop forKey:HuesKeepOnTopKey];
}

@end
