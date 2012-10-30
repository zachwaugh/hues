//
//  HuesPreferencesController.h
//  Hues
//
//  Created by Zach Waugh on 12/27/10.
//  Copyright 2010 Giant Comet. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface HuesPreferencesController : NSWindowController <NSToolbarDelegate>

@property (retain) NSString *currentToolbarIdentifier;
@property (nonatomic, assign) NSView *currentView;
@property (retain) NSToolbar *toolbar;
@property (retain) NSView *view;
@property (retain) NSView *generalView;
@property (retain) NSView *colorPickersView;
@property (retain) NSView *advancedView;

- (void)toolbarItemSelected:(id)sender;

@end
