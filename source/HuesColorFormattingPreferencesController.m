//
//  HuesColorFormattingPreferencesController.m
//  Hues
//
//  Created by Zach Waugh on 7/11/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesColorFormattingPreferencesController.h"
#import "HuesPreferences.h"

@interface HuesColorFormattingPreferencesController ()

@property (strong) NSMutableArray *formats;

@end

@implementation HuesColorFormattingPreferencesController

- (id)init
{
	self = [super initWithNibName:@"HuesColorFormattingPreferencesController" bundle:nil];
	if (!self) return nil;
	
	_formats = [[HuesPreferences colorFormats] mutableCopy];
	self.title = @"Color Formats";
	
	return self;
}

- (void)addFormat:(id)sender
{
	[self.formats addObject:@{@"name": @"Name", @"format": @""}];
	[self.tableView reloadData];
	
	NSInteger lastRow = self.formats.count - 1;
	[self.tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:lastRow] byExtendingSelection:NO];
	[self.tableView editColumn:0 row:lastRow withEvent:nil select:YES];
}

- (void)removeFormat:(id)sender
{
	NSInteger selectedRow = self.tableView.selectedRow;
	
	if (selectedRow != -1) {
		[self.formats removeObjectAtIndex:selectedRow];
		[self.tableView reloadData];
	}
}

- (void)showHelp:(id)sender
{
	
}

#pragma mark - NSTableViewDelegate

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
	return self.formats.count;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
	NSDictionary *dict = self.formats[row];
	
	return dict[tableColumn.identifier];
}

- (void)tableView:(NSTableView *)tableView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
	NSMutableDictionary *format = [self.formats[row] mutableCopy];
	format[tableColumn.identifier] = object;
	self.formats[row] = format;
	
	[HuesPreferences setColorFormats:self.formats];
}

@end
