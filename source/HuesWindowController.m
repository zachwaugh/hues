//
//  HuesMainController.m
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

// NSColorPanelWheelModeMask            - Color Wheel
// NSColorPanelGrayModeMask             - Color Sliders
// NSColorPanelRGBModeMask              - Color Sliders
// NSColorPanelCMYKModeMask             - Color Sliders
// NSColorPanelHSBModeMask              - Color Sliders
// NSColorPanelColorListModeMask        - Color Palettes
// NSColorPanelCustomPaletteModeMask    - Image Palettes
// NSColorPanelCrayonModeMask           - Crayons
// NSColorPanelAllModesMask             - All

#import "HuesWindowController.h"
#import "HuesColorsView.h"
#import "HuesPreferences.h"
#import "HuesHistoryManager.h"
#import "HuesGlobal.h"
#import "NSColor+Extras.h"

@interface HuesWindowController ()

- (void)copyToClipboard:(NSString *)value;
- (void)updateLabelsWithColor:(NSColor *)color;

@end

@implementation HuesWindowController

- (id)init {
    self = [super init];
    if (!self) return nil;
    
    self.colorPanel = [NSColorPanel sharedColorPanel];
    [self.colorPanel setStyleMask:NSTitledWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask | NSResizableWindowMask];
    [self.colorPanel setTitle:@"Hues"];
    [self.colorPanel setDelegate:self];
    [self.colorPanel setShowsAlpha:YES];
    [self.colorPanel setFloatingPanel:NO];
    [self.colorPanel setHidesOnDeactivate:NO];
    [self.colorPanel setShowsAlpha:YES];
    [self.colorPanel setTarget:self];
    [self.colorPanel setAction:@selector(colorChanged:)];
    [self.colorPanel makeKeyAndOrderFront:nil];
    [self.colorPanel setMaxSize:NSMakeSize(FLT_MAX, FLT_MAX)];
    
    [NSBundle.mainBundle loadNibNamed:@"HuesColorsView" owner:self topLevelObjects:nil];
    
    [self updateLabelsWithColor:[self.colorPanel color]];
    
    [self.colorPanel setAccessoryView:self.colorsView];
    //[self.colorsView setFrame:NSMakeRect(0, self.colorsView.frame.origin.y + 6, self.colorPanel.frame.size.width, self.colorsView.bounds.size.height)];
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(updateColor:) name:HuesUpdateColorNotification object:nil];
    
    return self;
}

- (void)dealloc
{
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)colorChanged:(id)sender {
    NSColor *color = [sender color];
    [HuesHistoryManager.sharedManager addColor:color];
    
    if (HuesPreferences.copyToClipboard) {
        if ([HuesPreferences defaultRepresentation] == HuesHexRepresentation) {
            [self copyToClipboard:[color hues_hex]];
        } else if ([HuesPreferences defaultRepresentation] == HuesRGBRepresentation) {
            [self copyToClipboard:[color hues_rgb]];
        } else if ([HuesPreferences defaultRepresentation] == HuesHSLRepresentation) {
            [self copyToClipboard:[color hues_hsb]];
        }
    }
    
    [self updateLabelsWithColor:color];
}

- (void)updateColor:(NSNotification *)notification {
    NSColor *color = [notification object];
    [self.colorPanel setColor:color];
    [self updateLabelsWithColor:color];
}

- (void)updateLabelsWithColor:(NSColor *)color {
    // Setup overlay text attributes
    NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowColor:[NSColor colorWithCalibratedWhite:1.0 alpha:0.5]];
    [shadow setShadowOffset:NSMakeSize(0, -1)];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:shadow, NSShadowAttributeName, [NSFont fontWithName:@"Lucida Grande" size:14.0], NSFontAttributeName, nil];
    
    NSAttributedString *hexString = [[NSAttributedString alloc] initWithString:[color hues_hex] attributes:attributes];
    NSAttributedString *rgbString = [[NSAttributedString alloc] initWithString:[color hues_rgb] attributes:attributes];
    NSAttributedString *hslString = [[NSAttributedString alloc] initWithString:[color hues_hsl] attributes:attributes];
    
    [self.hexField setAttributedStringValue:hexString];
    [self.rgbLabel setAttributedStringValue:rgbString];
    [self.hslLabel setAttributedStringValue:hslString];
}

- (void)copyHex:(id)sender {
    [self copyToClipboard:[[[NSColorPanel sharedColorPanel] color] hues_hex]];
}

- (void)copyRGB:(id)sender {
    [self copyToClipboard:[[[NSColorPanel sharedColorPanel] color] hues_rgb]];
}

- (void)copyHSL:(id)sender {
    [self copyToClipboard:[[[NSColorPanel sharedColorPanel] color] hues_hsl]];
}

- (void)copyToClipboard:(NSString *)value {
    NSPasteboard *pasteboard = NSPasteboard.generalPasteboard;
    [pasteboard declareTypes:[NSArray arrayWithObject:NSStringPboardType] owner:self];
    [pasteboard setString:value forType:NSStringPboardType];
}

#pragma mark - Color input

- (void)controlTextDidChange:(NSNotification *)notification {
    if (notification.object == self.hexField) {
        NSString *value = self.hexField.stringValue;
        NSColor *newColor = [NSColor hues_colorFromHex:value];
        
        if (newColor) {
            [self updateLabelsWithColor:newColor];
            [self.colorPanel setColor:newColor];
        }
    }
}

// Make sure app quits after panel is closed
- (void)windowWillClose:(NSNotification *)notification {
    [[NSApplication sharedApplication] terminate:nil];
}

@end
