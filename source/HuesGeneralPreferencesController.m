//
//  HuesGeneralPreferencesController.m
//  Hues
//
//  Created by Zach Waugh on 7/16/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesGeneralPreferencesController.h"
#import "HuesPreferences.h"
#import "MASShortcutView.h"
#import "MASShortcutView+UserDefaults.h"

@interface HuesGeneralPreferencesController ()

@end

@implementation HuesGeneralPreferencesController

- (id)init
{
	self = [super initWithNibName:@"HuesGeneralPreferencesController" bundle:nil];
	if (!self) return nil;
	
	self.title = @"General";
  
	return self;
}

- (void)awakeFromNib
{
	NSArray *formats = [HuesPreferences colorFormats];
	NSString *defaultFormat = [HuesPreferences defaultColorFormat];

	int index = 0;
	int selected = 0;
	for (NSDictionary *dict in formats) {
		NSString *name = dict[@"name"];
		
		if ([name isEqualToString:defaultFormat]) {
			selected = index;
		}
		
		[self.defaultFormat addItemWithTitle:dict[@"name"]];
		index++;
	}
	
	[self.defaultFormat selectItemAtIndex:selected];
	
	self.shortcutView.associatedUserDefaultsKey = HuesLoupeShortcutKey;
}

- (IBAction)updateDefaultFormat:(id)sender
{
	[HuesPreferences setDefaultColorFormat:[sender title]];
}

@end
