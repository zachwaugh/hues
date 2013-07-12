//
//  HuesPreferencesController.h
//  Hues
//
//  Created by Zach Waugh on 12/27/10.
//  Copyright 2010 Giant Comet. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class MASShortcutView;

@interface HuesPreferencesController : NSWindowController <NSToolbarDelegate>

@property (weak, nonatomic) NSView *currentView;
@property (strong) NSToolbar *toolbar;
@property (strong) NSView *view;
@property (strong) NSView *generalView;
@property (weak) IBOutlet MASShortcutView *loupeShortcutView;

- (void)toolbarItemSelected:(id)sender;

@end
