//
//  HuesPalettesController.h
//  Hues
//
//  Created by Zach Waugh on 7/24/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HuesMixerViewController.h"

@interface HuesPalettesController : HuesMixerViewController <NSTableViewDataSource, NSTableViewDelegate>

@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSPopUpButton *paletteSelection;

- (IBAction)paletteDidChange:(id)sender;
- (IBAction)addPalette:(id)sender;
- (IBAction)removePalette:(id)sender;
- (IBAction)addItem:(id)sender;
- (IBAction)removeItem:(id)sender;
- (IBAction)updateItemName:(id)sender;
- (IBAction)updateItemColor:(id)sender;

@end
