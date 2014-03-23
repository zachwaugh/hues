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

@property (nonatomic, weak) IBOutlet NSTableView *tableView;
@property (nonatomic, weak) IBOutlet NSPopUpButton *paletteSelection;
@property (nonatomic, weak) IBOutlet NSMenu *paletteMenu;

- (IBAction)paletteDidChange:(id)sender;
- (IBAction)addPalette:(id)sender;
- (IBAction)removePalette:(id)sender;
- (IBAction)exportPalette:(id)sender;
- (IBAction)sharePalette:(id)sender;
- (IBAction)paletteSettings:(id)sender;
- (IBAction)addItem:(id)sender;
- (IBAction)removeItem:(id)sender;
- (IBAction)updateItemName:(id)sender;
- (IBAction)updateItemColor:(id)sender;

@end
