//
//  HuesMainController.h
//  Hues
//
//  Created by Zach Waugh on 12/27/10.
//  Copyright 2010 Giant Comet. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class HuesColorsView;

@interface HuesMainController : NSObject <NSWindowDelegate>

@property (retain) NSColorPanel *colorPanel;
@property (retain) NSView *colorsView;
@property (retain) NSTextField *hexField;
@property (retain) NSTextField *rgbLabel;
@property (retain) NSTextField *hslLabel;

- (IBAction)copyHex:(id)sender;
- (IBAction)copyRGB:(id)sender;
- (IBAction)copyHSL:(id)sender;
- (IBAction)toggleKeepOnTop:(id)sender;
- (void)updateColor:(NSNotification *)notification;

- (IBAction)showPicker:(id)sender;

@end
