//
//  HuesWindowController.h
//  Hues
//
//  Created by Zach Waugh on 11/28/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HuesScopeBarView.h"

@interface HuesWindowController : NSWindowController <NSWindowDelegate, HuesScopeBarViewDelegate>

@property (weak) IBOutlet NSColorWell *colorWell;
@property (weak) IBOutlet NSTextField *primaryFormatLabel;
@property (weak) IBOutlet NSTextField *primaryFormat;
@property (weak) IBOutlet NSTextField *secondaryFormatLabel;
@property (weak) IBOutlet NSTextField *secondaryFormat;
@property (weak) IBOutlet NSPopUpButton *alternateFormats;
@property (weak) IBOutlet NSView *mixerContainerView;
@property (weak) IBOutlet HuesScopeBarView *scopeBar;

- (IBAction)copyPrimary:(id)sender;
- (IBAction)copySecondary:(id)sender;
- (IBAction)copyAlternate:(id)sender;
- (IBAction)toggleKeepOnTop:(id)sender;

//- (void)toggleWindow;
- (void)hideWindow;
//- (void)showWindow:(id)sender;
- (IBAction)showLoupe:(id)sender;
- (IBAction)didUpdateColorText:(id)sender;
- (void)selectTabAtIndex:(NSInteger)index;

@end
