//
//  HuesPreferencesController.h
//  Hues
//
//  Created by Zach Waugh on 12/27/10.
//  Copyright 2010 Giant Comet. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface HuesPreferencesController : NSWindowController <NSToolbarDelegate>

@property (nonatomic, weak) NSView *currentView;
@property (nonatomic, strong) NSToolbar *toolbar;
@property (nonatomic, strong) NSView *view;

- (void)toolbarItemSelected:(id)sender;

@end
