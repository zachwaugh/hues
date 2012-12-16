//
//  HuesWindowController.h
//  Hues
//
//  Created by Zach Waugh on 11/28/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class HuesColorSlider;

@interface HuesWindowController : NSWindowController <NSWindowDelegate>

@property (assign) IBOutlet NSColorWell *colorWell;
@property (assign) IBOutlet NSTextField *primaryFormat;
@property (assign) IBOutlet NSTextField *secondaryFormat;
@property (assign) IBOutlet NSPopUpButton *alternateFormats;
@property (assign) IBOutlet NSTextField *redField;
@property (assign) IBOutlet NSTextField *greenField;
@property (assign) IBOutlet NSTextField *blueField;
@property (assign) IBOutlet NSTextField *alphaField;
@property (assign) IBOutlet HuesColorSlider *redSlider;
@property (assign) IBOutlet HuesColorSlider *greenSlider;
@property (assign) IBOutlet HuesColorSlider *blueSlider;
@property (assign) IBOutlet HuesColorSlider *alphaSlider;
@property (assign) IBOutlet HuesColorSlider *hueSlider;
@property (assign) IBOutlet HuesColorSlider *saturationSlider;
@property (assign) IBOutlet HuesColorSlider *lightnessSlider;
@property (assign) IBOutlet NSTextField *hueField;
@property (assign) IBOutlet NSTextField *saturationField;
@property (assign) IBOutlet NSTextField *lightnessField;

- (IBAction)copyPrimary:(id)sender;
- (IBAction)copySecondary:(id)sender;
- (IBAction)copyAlternate:(id)sender;
- (IBAction)toggleKeepOnTop:(id)sender;
- (IBAction)sliderChanged:(id)sender;
- (void)toggleWindow;
- (void)hideWindow;
- (void)showWindow:(id)sender;
- (IBAction)showLoupe:(id)sender;

@end
