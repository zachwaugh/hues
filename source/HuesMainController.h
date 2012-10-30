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
@property (retain) IBOutlet NSView *colorsView;
@property (retain) IBOutlet NSTextField *primaryFormat;
@property (retain) IBOutlet NSTextField *secondaryFormat;
@property (retain) IBOutlet NSPopUpButton *alternateFormats;

- (IBAction)copyPrimary:(id)sender;
- (IBAction)copySecondary:(id)sender;
- (IBAction)copyAlternate:(id)sender;
- (IBAction)toggleKeepOnTop:(id)sender;
- (void)toggleWindow;
- (void)updateColor:(NSNotification *)notification;

- (void)showWindow:(id)sender;
- (IBAction)showLoupe:(id)sender;

@end
