//
//  NSColor+Extras.h
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

#import <Cocoa/Cocoa.h>

@interface NSColor (Extras)

- (NSString *)hues_hex;
- (NSString *)hues_hexWithLowercase:(BOOL)lowercase;
- (NSString *)hues_hexWithFormat:(NSString *)format;
- (NSString *)hues_hexWithFormat:(NSString *)format useLowercase:(BOOL)lowercase;
- (NSString *)hues_rgb;
- (NSString *)hues_rgbWithDefaultFormat;
- (NSString *)hues_rgbWithFormat:(NSString *)format;
- (NSString *)hues_rgbaWithFormat:(NSString *)format;
- (NSString *)hues_hsb;
- (NSString *)hues_hsl;
- (NSString *)hues_hslWithDefaultFormat;
- (NSString *)hues_hslWithFormat:(NSString *)format;
- (NSString *)hues_hslaWithFormat:(NSString *)format;
- (NSColor *)hues_convertedColor;
+ (NSColor *)hues_colorFromHex:(NSString *)hex;

@end
