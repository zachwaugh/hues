//
//  HuesWindowController.h
//  Hues
//
//  Created by Zach Waugh on 11/28/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface HuesWindowController : NSWindowController <NSWindowDelegate>

@property (assign) IBOutlet NSColorWell *colorWell;
@property (assign) IBOutlet NSTextField *primaryFormat;
@property (assign) IBOutlet NSTextField *secondaryFormat;
@property (assign) IBOutlet NSPopUpButton *alternateFormats;
@property (assign) IBOutlet NSTextField *redField;
@property (assign) IBOutlet NSTextField *greenField;
@property (assign) IBOutlet NSTextField *blueField;
@property (assign) IBOutlet NSTextField *alphaField;
@property (assign) IBOutlet NSSlider *redSlider;
@property (assign) IBOutlet NSSlider *greenSlider;
@property (assign) IBOutlet NSSlider *blueSlider;
@property (assign) IBOutlet NSSlider *alphaSlider;

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
