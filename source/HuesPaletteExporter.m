//
//  HuesPaletteExporter.m
//  Hues
//
//  Created by Zach Waugh on 7/24/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesPaletteExporter.h"
#import "HuesPalette.h"
#import "HuesPaletteItem.h"
#import "HuesColorFormatter.h"

@implementation HuesPaletteExporter

+ (NSString *)exportPaletteToJSON:(HuesPalette *)palette
{
	NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
	data[@"name"] = palette.name;
	data[@"id"] = palette.uuid;
	
	NSMutableArray *colors = [NSMutableArray array];
	
	for (HuesPaletteItem *item in palette.colors) {
		[colors addObject:@{@"name": item.name, @"color": [HuesColorFormatter stringForColor:item.color withFormat:HuesHexFormat]}];
	}
	
	data[@"colors"] = colors;
	
	NSError *error = nil;
	NSData *json = [NSJSONSerialization dataWithJSONObject:data options:0 error:&error];
	
	if (!error) {
		return [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
	} else {
		NSLog(@"error creating json: %@", error);
		return nil;
	}
}

+ (void)exportPaletteToWeb:(HuesPalette *)palette completion:(void (^)(NSURL *url, NSError *error))block
{
	NSString *json = [self exportPaletteToJSON:palette];
	
	if (json) {
		NSLog(@"upload JSON...");
	}
}

@end
