//
//  HuesPaletteNameController.m
//  Hues
//
//  Created by Zach Waugh on 7/25/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesPaletteNameController.h"

@interface HuesPaletteNameController ()

@end

@implementation HuesPaletteNameController

- (id)init
{
	self = [super initWithWindowNibName:@"HuesPaletteNameController"];
	if (!self) return nil;
  
	return self;
}

- (void)windowDidLoad
{
	if (self.name) {
		self.field.stringValue = self.name;
		[self validateName];
	}
}

- (void)setName:(NSString *)name
{
	_name = name;
	self.field.stringValue = name;
}

- (IBAction)ok:(id)sender
{	
	if (self.completionBlock) {
		self.completionBlock(self.field.stringValue, YES);
	}
	
	[self.window.sheetParent endSheet:self.window];
}

- (IBAction)cancel:(id)sender
{
	if (self.completionBlock) {
		self.completionBlock(nil, NO);
	}
	
	[self.window.sheetParent endSheet:self.window];
}

- (void)validateName
{
	self.nameValid = (self.field.stringValue.length > 0);
}

- (void)controlTextDidChange:(NSNotification *)obj
{
	[self validateName];
}

@end
