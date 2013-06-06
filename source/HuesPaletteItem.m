//
//  HuesPaletteItem.m
//  Hues
//
//  Created by Zach Waugh on 6/6/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesPaletteItem.h"

@implementation HuesPaletteItem

- (id)initWithName:(NSString *)name color:(NSColor *)color
{
	NSParameterAssert(name);
	NSParameterAssert(color);
	
	self = [super init];
	if (!self) return nil;
	
	_name = name;
	_color = color;
	
	return self;
}

@end
