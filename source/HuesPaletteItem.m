//
//  HuesPaletteItem.m
//  Hues
//
//  Created by Zach Waugh on 6/6/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesPaletteItem.h"
#import "HuesColorParser.h"

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

+ (HuesPaletteItem *)itemWithDictionary:(NSDictionary *)dict
{
	NSColor *color = [HuesColorParser colorFromHex:dict[@"color"]];
	HuesPaletteItem *item = [[HuesPaletteItem alloc] initWithName:dict[@"name"] color:color];
	
	return item;
}

- (id)initWithCoder:(NSCoder *)decoder
{
	self = [super init];
	if (!self) return nil;
	
	_name = [decoder decodeObjectForKey:@"name"];
	_color = [decoder decodeObjectForKey:@"color"];
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
	[coder encodeObject:self.name forKey:@"name"];
	[coder encodeObject:self.color forKey:@"color"];
}

@end
