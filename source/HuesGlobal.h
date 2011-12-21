//
//  HuesGlobal.h
//  Hues
//
//  Created by Zach Waugh on 12/27/10.
//  Copyright 2010 Giant Comet. All rights reserved.
//


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

// NSColorPanelWheelModeMask            - Color Wheel
// NSColorPanelGrayModeMask             - Color Sliders
// NSColorPanelRGBModeMask              - Color Sliders
// NSColorPanelCMYKModeMask             - Color Sliders
// NSColorPanelHSBModeMask              - Color Sliders
// NSColorPanelColorListModeMask        - Color Palettes
// NSColorPanelCustomPaletteModeMask    - Image Palettes
// NSColorPanelCrayonModeMask           - Crayons
// NSColorPanelAllModesMask             - All
extern NSString * const HuesShowColorWheelPickerKey;
extern NSString * const HuesShowColorSlidersGrayPickerKey;
extern NSString * const HuesShowColorSlidersRGBPickerKey;
extern NSString * const HuesShowColorSlidersCMYKPickerKey;
extern NSString * const HuesShowColorSlidersHSBPickerKey;
extern NSString * const HuesShowColorPalettesPickerKey;
extern NSString * const HuesShowImagePalettesPickerKey;
extern NSString * const HuesShowCrayonsPickerKey;


enum
{
  HuesHexRepresentation,
  HuesRGBRepresentation,
  HuesHSLRepresentation
};

typedef NSInteger HuesColorRepresentation;

// Notifications
extern NSString * const HuesUpdateColorNotification;