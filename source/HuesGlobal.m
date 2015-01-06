//
//  HuesGlobal.m
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

#import "HuesGlobal.h"

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

NSString * const HuesShowColorWheelPickerKey = @"HuesShowColorWheelPicker";
NSString * const HuesShowColorSlidersGrayPickerKey = @"HuesShowColorSlidersGrayPicker";
NSString * const HuesShowColorSlidersRGBPickerKey = @"HuesShowColorSlidersRGBPicker";
NSString * const HuesShowColorSlidersCMYKPickerKey = @"HuesShowColorSlidersCMYKPicker";
NSString * const HuesShowColorSlidersHSBPickerKey = @"HuesShowColorSlidersHSBPicker";
NSString * const HuesShowColorPalettesPickerKey = @"HuesShowColorPalettesPicker";
NSString * const HuesShowImagePalettesPickerKey = @"HuesShowImagePalettesPicker";
NSString * const HuesShowCrayonsPickerKey = @"HuesShowCrayonsPicker";


// Notifications
NSString * const HuesUpdateColorNotification = @"HuesUpdateColorNotification";