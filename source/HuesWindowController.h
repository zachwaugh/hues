//
//  HuesWindowController.h
//  Hues
//
//  Created by Zach Waugh on 11/28/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class HuesColorSlider;

@interface HuesWindowController : NSWindowController <NSWindowDelegate, NSTextFieldDelegate>

@property (weak) IBOutlet NSColorWell *colorWell;
@property (weak) IBOutlet NSTextField *primaryFormat;
@property (weak) IBOutlet NSTextField *secondaryFormat;
@property (weak) IBOutlet NSPopUpButton *alternateFormats;
@property (weak) IBOutlet NSTextField *redField;
@property (weak) IBOutlet NSTextField *greenField;
@property (weak) IBOutlet NSTextField *blueField;
@property (weak) IBOutlet NSTextField *alphaField;
@property (weak) IBOutlet NSTextField *hueField;
@property (weak) IBOutlet NSTextField *saturationField;
@property (weak) IBOutlet NSTextField *lightnessField;
@property (weak) IBOutlet HuesColorSlider *redSlider;
@property (weak) IBOutlet HuesColorSlider *greenSlider;
@property (weak) IBOutlet HuesColorSlider *blueSlider;
@property (weak) IBOutlet HuesColorSlider *alphaSlider;
@property (weak) IBOutlet HuesColorSlider *hueSlider;
@property (weak) IBOutlet HuesColorSlider *saturationSlider;
@property (weak) IBOutlet HuesColorSlider *lightnessSlider;

- (IBAction)copyPrimary:(id)sender;
- (IBAction)copySecondary:(id)sender;
- (IBAction)copyAlternate:(id)sender;
- (IBAction)toggleKeepOnTop:(id)sender;
- (IBAction)sliderChanged:(id)sender;
- (IBAction)fieldChanged:(id)sender;
//- (void)toggleWindow;
- (void)hideWindow;
- (void)showWindow:(id)sender;
- (IBAction)showLoupe:(id)sender;

@end
