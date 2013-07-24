//
//  HuesPalettesController.m
//  Hues
//
//  Created by Zach Waugh on 7/24/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesPalettesController.h"
#import "HuesPaletteItemCellView.h"
#import "HuesPalette.h"
#import "HuesPaletteItem.h"
#import "HuesPalettesManager.h"

@interface HuesPalettesController ()

@property (strong) HuesPalette *currentPalette;
@property (assign) BOOL awake;

@end

@implementation HuesPalettesController

- (id)init
{
	self = [super initWithNibName:@"HuesPalettesController" bundle:nil];
	if (!self) return nil;
	
	_awake = NO;
	
	return self;
}

- (void)awakeFromNib
{
	if (self.awake) return;
	self.awake = YES;
	
	[self refreshPalettes];
}

- (void)refreshPalettes
{
	[self.paletteSelection removeAllItems];
	
	NSArray *palettes = [[HuesPalettesManager sharedManager] palettes];
	
	for (HuesPalette *palette in palettes) {
		[self.paletteSelection addItemWithTitle:palette.name];
	}
	
	if (palettes.count > 0) {
		self.currentPalette = palettes[0];
		[self.tableView reloadData];
	}
}

- (void)paletteDidChange:(id)sender
{
	self.currentPalette = [HuesPalettesManager sharedManager].palettes[self.paletteSelection.indexOfSelectedItem];
	[self.tableView reloadData];
}

- (IBAction)addPalette:(id)sender
{
	HuesPalette *palette = [HuesPalette paletteWithName:@"Untitled Palette"];
	self.currentPalette = palette;
	[[HuesPalettesManager sharedManager] addPalette:palette];
	[self refreshPalettes];
}

- (IBAction)removePalette:(id)sender
{
	
}

#pragma mark - Items

- (IBAction)addItem:(id)sender
{
	HuesPaletteItem *item = [[HuesPaletteItem alloc] initWithName:@"Color" color:self.color];
	
	[self.currentPalette addItem:item];
	[self.tableView reloadData];
	
	[self.tableView editColumn:0 row:self.currentPalette.colors.count - 1 withEvent:nil select:YES];
}

- (IBAction)removeItem:(id)sender
{
	NSIndexSet *indexes = [self.tableView selectedRowIndexes];
	
	[indexes enumerateIndexesWithOptions:NSEnumerationReverse usingBlock:^(NSUInteger idx, BOOL *stop) {
		[self.currentPalette.colors removeObjectAtIndex:idx];
	}];
	
	[self.tableView reloadData];
}

- (IBAction)updateItemName:(id)sender
{
	NSInteger row = [self.tableView rowForView:sender];
	HuesPaletteItem *item = self.currentPalette.colors[row];
	item.name = [sender stringValue];
	[self.tableView reloadData];
}

- (IBAction)updateItemColor:(id)sender
{
	NSLog(@"updateItemColor: %@", sender);
	NSInteger row = [self.tableView rowForView:sender];
	HuesPaletteItem *item = self.currentPalette.colors[row];
	item.color = [sender color];
	[self.tableView reloadData];
}

#pragma mark - NSTableViewDelegate

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
	return (self.currentPalette != nil) ? self.currentPalette.colors.count : 0;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
	static NSString *paletteCellIdentifier = @"PaletteItemCell";
	HuesPaletteItemCellView *view = [tableView makeViewWithIdentifier:paletteCellIdentifier owner:self];
	
	HuesPaletteItem *item = self.currentPalette.colors[row];
	view.name.stringValue = item.name;
	view.colorWell.color = item.color;
	
	return view;
}


@end
