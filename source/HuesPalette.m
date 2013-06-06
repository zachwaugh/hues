//
//  HuesPalette.m
//  Hues
//
//  Created by Zach Waugh on 6/6/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesPalette.h"
#import "HuesPaletteItem.h"

@interface HuesPalette ()

@property (strong) NSMutableArray *colors;

@end

@implementation HuesPalette

- (id)init
{
	self = [super init];
	if (!self) return nil;
	
	_name = @"";
	_colors = [[NSMutableArray alloc] init];
	
	return self;
}

- (void)addItem:(HuesPaletteItem *)item
{
	[self.colors addObject:item];
}

- (void)removeItem:(HuesPaletteItem *)item
{
	[self.colors removeObject:item];
}


@end
