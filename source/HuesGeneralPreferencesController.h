//
//  HuesGeneralPreferencesController.h
//  Hues
//
//  Created by Zach Waugh on 7/16/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HuesPreferencesViewControllerProtocol.h"

@class MASShortcutView;

@interface HuesGeneralPreferencesController : NSViewController <HuesPreferencesViewControllerProtocol>

@property (weak) IBOutlet MASShortcutView *shortcutView;
@property (weak) IBOutlet NSPopUpButton *defaultFormat;
@property (strong) NSString *identifier;

- (IBAction)updateDefaultFormat:(id)sender;

@end
