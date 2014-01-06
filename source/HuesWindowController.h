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

@property (nonatomic, weak) IBOutlet NSColorWell *colorWell;
@property (nonatomic, weak) IBOutlet NSTextField *primaryFormatLabel;
@property (nonatomic, weak) IBOutlet NSTextField *primaryFormat;
@property (nonatomic, weak) IBOutlet NSTextField *secondaryFormatLabel;
@property (nonatomic, weak) IBOutlet NSTextField *secondaryFormat;
@property (nonatomic, weak) IBOutlet NSPopUpButton *alternateFormats;
@property (nonatomic, weak) IBOutlet NSView *mixerContainerView;
@property (nonatomic, weak) IBOutlet HuesScopeBarView *scopeBar;

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
