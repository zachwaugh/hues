//
//  HuesColorFormattingPreferencesController.h
//  Hues
//
//  Created by Zach Waugh on 7/11/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HuesPreferencesViewControllerProtocol.h"

@interface HuesColorFormattingPreferencesController : NSViewController <HuesPreferencesViewControllerProtocol, NSTableViewDataSource, NSTableViewDelegate>

@property (strong) NSString *identifier;
@property (weak) IBOutlet NSTableView *tableView;

- (IBAction)addFormat:(id)sender;
- (IBAction)removeFormat:(id)sender;
- (IBAction)showHelp:(id)sender;

@end
