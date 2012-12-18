//
//  HuesWindowController.h
//  Hues
//
//  Created by Zach Waugh on 11/28/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface HuesWindowController : NSWindowController <NSWindowDelegate>

@property (weak) IBOutlet NSColorWell *colorWell;
@property (weak) IBOutlet NSTextField *primaryFormat;
@property (weak) IBOutlet NSTextField *secondaryFormat;
@property (weak) IBOutlet NSPopUpButton *alternateFormats;
@property (weak) IBOutlet NSView *mixerContainerView;

- (IBAction)copyPrimary:(id)sender;
- (IBAction)copySecondary:(id)sender;
- (IBAction)copyAlternate:(id)sender;
- (IBAction)toggleKeepOnTop:(id)sender;
- (IBAction)changeMixerTab:(id)sender;

//- (void)toggleWindow;
- (void)hideWindow;
- (void)showWindow:(id)sender;
- (IBAction)showLoupe:(id)sender;

@end
