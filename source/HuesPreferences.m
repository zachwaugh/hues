//
//  HUPreferences.m
//  Hues
//
//  Copyright (c) 2014 Zach Waugh
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "HuesPreferences.h"

NSString * const HuesCopyToClipboardKey = @"HuesCopyToClipboard";
NSString * const HuesUseLowercaseKey = @"HuesUseLowercase";
NSString * const HuesDefaultColorRepresentationKey = @"HuesDefaultColorRepresentation";
NSString * const HuesHexFormatKey = @"HuesHexFormat";
NSString * const HuesRGBFormatKey = @"HuesRGBFormat";
NSString * const HuesRGBAFormatKey = @"HuesRGBAFormat";
NSString * const HuesHSBFormatKey = @"HuesHSBFormat";
NSString * const HuesHSLFormatKey = @"HuesHSLFormat";
NSString * const HuesHSLAFormatKey = @"HuesHSLAFormat";

@implementation HuesPreferences

+ (void)registerDefaults {
    NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
    
    // Auto copy to clipboard on
    [defaults setObject:@YES forKey:HuesCopyToClipboardKey];
    
    // Hex is default
    [defaults setObject:@(HuesHexRepresentation) forKey:HuesDefaultColorRepresentationKey];
    
    // Don't default to lowercase
    [defaults setObject:@NO forKey:HuesUseLowercaseKey];
    
    // Color formats
    [defaults setObject:@"#{r}{g}{b}" forKey:HuesHexFormatKey];
    [defaults setObject:@"rgb({r}, {g}, {b})" forKey:HuesRGBFormatKey];
    [defaults setObject:@"rgba({r}, {g}, {b}, {a})" forKey:HuesRGBAFormatKey];
    [defaults setObject:@"hsb({h}, {s}%, {b}%)" forKey:HuesHSBFormatKey];
    [defaults setObject:@"hsl({h}, {s}%, {l}%)" forKey:HuesHSLFormatKey];
    [defaults setObject:@"hsla({h}, {s}%, {l}%, {a})" forKey:HuesHSLAFormatKey];
    
    // Color Pickers
    [defaults setObject:@YES forKey:HuesShowColorWheelPickerKey];
    [defaults setObject:@YES forKey:HuesShowColorSlidersGrayPickerKey];
    [defaults setObject:@YES forKey:HuesShowColorSlidersRGBPickerKey];
    [defaults setObject:@YES forKey:HuesShowColorSlidersCMYKPickerKey];
    [defaults setObject:@YES forKey:HuesShowColorSlidersHSBPickerKey];
    [defaults setObject:@YES forKey:HuesShowColorPalettesPickerKey];
    [defaults setObject:@YES forKey:HuesShowImagePalettesPickerKey];
    [defaults setObject:@YES forKey:HuesShowCrayonsPickerKey];
    
    [NSUserDefaults.standardUserDefaults registerDefaults:defaults];
}

+ (HuesColorRepresentation)defaultRepresentation {
    return [NSUserDefaults.standardUserDefaults integerForKey:HuesDefaultColorRepresentationKey];
}

+ (BOOL)useLowercase {
    return [NSUserDefaults.standardUserDefaults boolForKey:HuesUseLowercaseKey];
}

+ (void)setUseLowercase:(BOOL)lowercase {
    [NSUserDefaults.standardUserDefaults setBool:lowercase forKey:HuesUseLowercaseKey];
}

+ (NSString *)hexFormat {
    return [NSUserDefaults.standardUserDefaults stringForKey:HuesHexFormatKey];
}

+ (NSString *)rgbFormat {
    return [NSUserDefaults.standardUserDefaults stringForKey:HuesRGBFormatKey];
}

+ (NSString *)rgbaFormat {
    return [NSUserDefaults.standardUserDefaults stringForKey:HuesRGBAFormatKey];
}

+ (NSString *)hsbFormat {
    return [NSUserDefaults.standardUserDefaults stringForKey:HuesHSBFormatKey];
}

+ (NSString *)hslFormat {
    return [NSUserDefaults.standardUserDefaults stringForKey:HuesHSLFormatKey];
}

+ (NSString *)hslaFormat {
    return [NSUserDefaults.standardUserDefaults stringForKey:HuesHSLAFormatKey];
}

+ (BOOL)copyToClipboard {
    return [NSUserDefaults.standardUserDefaults boolForKey:HuesCopyToClipboardKey];
}

+ (void)setCopyToClipboard:(BOOL)copy {
    [NSUserDefaults.standardUserDefaults setBool:copy forKey:HuesCopyToClipboardKey];
    [NSUserDefaults.standardUserDefaults synchronize];
}

+ (NSUInteger)pickerMask {
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

@end
