//
//  HuesColorFormattingPreferencesController.m
//  Hues
//
//  Created by Zach Waugh on 7/11/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesColorFormattingPreferencesController.h"
#import "HuesPreferences.h"
#import "NSMutableArray+Move.h"

static NSString * const HuesColorFormatsReorderType = @"HuesColorFormatsReorderType";

@interface HuesColorFormattingPreferencesController ()

@property (strong) NSMutableArray *formats;
@property (strong) NSColor *testColor;

@end

@implementation HuesColorFormattingPreferencesController

- (id)init
{
	self = [super initWithNibName:@"HuesColorFormattingPreferencesController" bundle:nil];
	if (!self) return nil;
	
	_formats = [[HuesPreferences colorFormats] mutableCopy];
	_testColor = [NSColor colorWithCalibratedRed:1 green:1 blue:1 alpha:1];
	self.title = @"Color Formats";
	
	return self;
}

- (void)awakeFromNib
{
	[self.tableView registerForDraggedTypes:@[HuesColorFormatsReorderType]];
}

- (void)addFormat:(id)sender
{
	[self.formats addObject:@{@"name": @"Name", @"format": @""}];
	[self.tableView reloadData];
	
	NSInteger lastRow = self.formats.count - 1;
	[self.tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:lastRow] byExtendingSelection:NO];
	[self.tableView editColumn:0 row:lastRow withEvent:nil select:YES];
	[HuesPreferences setColorFormats:self.formats];
}

- (void)removeFormat:(id)sender
{
	NSInteger selectedRow = self.tableView.selectedRow;
	
	if (selectedRow != -1) {
		[self.formats removeObjectAtIndex:selectedRow];
		[HuesPreferences setColorFormats:self.formats];
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
	NSString *identifier = tableColumn.identifier;
	
	return dict[identifier];
}

- (void)tableView:(NSTableView *)tableView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{	
	NSMutableDictionary *format = [self.formats[row] mutableCopy];
	format[tableColumn.identifier] = object;
	self.formats[row] = format;
	
	[HuesPreferences setColorFormats:self.formats];
}

- (BOOL)tableView:(NSTableView *)aTableView writeRowsWithIndexes:(NSIndexSet *)rowIndexes toPasteboard:(NSPasteboard *)pboard
{
  // Copy the row numbers to the pasteboard.
  NSData *rowData = [NSKeyedArchiver archivedDataWithRootObject:rowIndexes];
  [pboard clearContents];
  [pboard setData:rowData forType:HuesColorFormatsReorderType];
  
  return YES;
}

- (NSDragOperation)tableView:(NSTableView *)tableView validateDrop:(id)info proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)op
{
  return NSDragOperationEvery;
}

- (BOOL)tableView:(NSTableView *)aTableView acceptDrop:(id)info row:(NSInteger)row dropOperation:(NSTableViewDropOperation)operation
{
  NSPasteboard *pboard = [info draggingPasteboard];
  NSData *rowData = [pboard dataForType:HuesColorFormatsReorderType];
  NSIndexSet *rowIndexes = [NSKeyedUnarchiver unarchiveObjectWithData:rowData];
  NSInteger dragRow = [rowIndexes firstIndex];
	
	if (row >= self.formats.count) {
		row = self.formats.count - 1;
	}
	
	[self.formats hues_moveObjectAtIndex:dragRow toIndex:row];
	[HuesPreferences setColorFormats:self.formats];
  
  [self.tableView reloadData];
  
  return YES;
}

@end
