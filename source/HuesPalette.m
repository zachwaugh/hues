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

@property (strong, readwrite) NSMutableArray *colors;

@end

@implementation HuesPalette

- (id)init
{
	return [self initWithName:@""];
}

- (id)initWithName:(NSString *)name
{
	self = [super init];
	if (!self) return nil;
	
	_name = name;
	_colors = [[NSMutableArray alloc] init];
	
	return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
	self = [super init];
	if (!self) return nil;
	
	_name = [decoder decodeObjectForKey:@"name"];
	_colors = [decoder decodeObjectForKey:@"colors"];
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
	[coder encodeObject:self.name forKey:@"name"];
	[coder encodeObject:self.colors forKey:@"colors"];
}

+ (HuesPalette *)paletteWithName:(NSString *)name
{
	return [[HuesPalette alloc] initWithName:name];
}

+ (HuesPalette *)paletteWithDictionary:(NSDictionary *)dict
{
	HuesPalette *palette = [[HuesPalette alloc] initWithName:dict[@"name"]];
	palette.colors = [dict[@"colors"] mutableCopy];
	
	return palette;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"Palette: %@ - %d colors", self.name, self.colors.count];
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
