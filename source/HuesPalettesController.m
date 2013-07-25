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
#import "HuesPaletteExporter.h"
#import "HuesPaletteNameController.h"

@interface HuesPalettesController ()

@property (strong) HuesPalette *currentPalette;
@property (assign) BOOL awake;
@property (strong) HuesPaletteNameController *nameController;

@end

@implementation HuesPalettesController

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)init
{
	self = [super initWithNibName:@"HuesPalettesController" bundle:nil];
	if (!self) return nil;
	
	_awake = NO;
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(palettesUpdated:) name:HuesPalettesUpdatedNotification object:nil];
	
	return self;
}

- (void)awakeFromNib
{
	if (self.awake) return;
	self.awake = YES;
	
	self.tableView.doubleAction = @selector(addItem:);
	self.tableView.target = self;
	[self refreshPalettes];
}

#pragma mark - Palettes

- (void)refreshPalettes
{
	NSInteger selectedIndex = self.paletteSelection.indexOfSelectedItem;
	[self.paletteSelection removeAllItems];
	
	NSArray *palettes = [[HuesPalettesManager sharedManager] palettes];
	
	for (HuesPalette *palette in palettes) {
		NSMenuItem *item = [[NSMenuItem alloc] init];
		item.title = palette.name;
		
		[self.paletteSelection.menu addItem:item];
	}
	
	if (palettes.count > 0) {
		// Make sure selection is still valid
		if (selectedIndex >= palettes.count) {
			selectedIndex = palettes.count - 1;
		}
		
		self.currentPalette = palettes[selectedIndex];
		[self.paletteSelection selectItemAtIndex:selectedIndex];
		[self.tableView reloadData];
	}
}

- (void)palettesUpdated:(NSNotification *)notification
{
	NSLog(@"palettesUpdated");
	[self refreshPalettes];
}

- (void)paletteDidChange:(id)sender
{
	NSLog(@"paletteDidChange: %@", self.paletteSelection.titleOfSelectedItem);
	self.currentPalette = [HuesPalettesManager sharedManager].palettes[self.paletteSelection.indexOfSelectedItem];
	[self.tableView reloadData];
}

- (IBAction)addPalette:(id)sender
{
	if (!self.nameController) {
		self.nameController = [[HuesPaletteNameController alloc] init];
	}
	
	HuesPalettesController __weak *weakSelf = self;
	self.nameController.name = @"Untitled Palette";
	
	self.nameController.completionBlock = ^(NSString *name, BOOL complete) {
		HuesPalettesController *strongSelf = weakSelf;

		if (complete) {
			HuesPalette *palette = [HuesPalette paletteWithName:name];
			strongSelf.currentPalette = palette;
			[strongSelf.tableView reloadData];
			
			[strongSelf refreshPalettes];
			[strongSelf.paletteSelection selectItemWithTitle:palette.name];
			
			[[HuesPalettesManager sharedManager] addPalette:palette];
		}
		
		[strongSelf.nameController.window orderOut:nil];
	};
	
	// Show sheet
	[NSApp beginSheet:self.nameController.window modalForWindow:self.view.window modalDelegate:nil didEndSelector:NULL contextInfo:nil];
}

- (IBAction)renamePalette:(id)sender
{
	if (!self.nameController) {
		self.nameController = [[HuesPaletteNameController alloc] init];
	}
	
	self.nameController.name = self.currentPalette.name;
	HuesPalettesController __weak *weakSelf = self;
	
	self.nameController.completionBlock = ^(NSString *name, BOOL complete){
		HuesPalettesController *strongSelf = weakSelf;
		if (complete) {
			strongSelf.currentPalette.name = name;
		}
		
		[strongSelf.nameController.window orderOut:nil];
		[strongSelf refreshPalettes];
	};
	
	[NSApp beginSheet:self.nameController.window modalForWindow:self.view.window modalDelegate:nil didEndSelector:NULL contextInfo:nil];
}

- (IBAction)removePalette:(id)sender
{
	[[HuesPalettesManager sharedManager] removePalette:self.currentPalette];
	self.currentPalette = nil;
	
	[self refreshPalettes];
	[self.tableView reloadData];
}

- (IBAction)paletteSettings:(id)sender
{
	NSRect frame = [sender frame];
	[self.paletteMenu popUpMenuPositioningItem:nil atLocation:NSMakePoint(frame.size.width - 5, frame.size.height - 5) inView:sender];
}

- (IBAction)sharePalette:(id)sender
{
	[HuesPaletteExporter exportPaletteToWeb:self.currentPalette completion:^(NSURL *url, NSError *error) {
		if (url) {
			[[NSPasteboard generalPasteboard] clearContents];
			[[NSPasteboard generalPasteboard] writeObjects:@[url]];
			
			NSUserNotification *notification = [[NSUserNotification alloc] init];
			notification.title = @"Palette shared";
			notification.informativeText = [NSString stringWithFormat:@"Palette shared at: %@", url.absoluteString];
			[[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
		}
		
	}];
}

- (IBAction)exportPalette:(id)sender
{
	NSString *json = [HuesPaletteExporter exportPaletteToJSON:self.currentPalette];
	NSString *filename = [NSString stringWithFormat:@"%@.json", self.currentPalette.name];
		
	NSSavePanel *savePanel = [NSSavePanel savePanel];
	savePanel.nameFieldStringValue = filename;
	
	[savePanel beginSheetModalForWindow:self.view.window completionHandler:^(NSInteger result) {
		if (result == NSFileHandlingPanelOKButton) {
			NSError *error = nil;
			[json writeToURL:savePanel.URL atomically:YES encoding:NSUTF8StringEncoding error:&error];
			
			if (error) {
				NSLog(@"error saving palette as json: %@", error);
			}
		}
	}];
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

- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
	if (self.tableView.selectedRowIndexes.count == 1) {
		HuesPaletteItem *item = self.currentPalette.colors[self.tableView.selectedRow];
		
		[self updateColor:item.color];
	}
}

@end
