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
#import "AFJSONRequestOperation.h"
#import "AFHTTPClient.h"

#define LOCAL 0

#if LOCAL && defined(DEBUG)
static NSString * const HuesShareServerURL = @"http://localhost:3000/";
#else
static NSString * const HuesShareServerURL = @"http://hues.cc/";
#endif

static NSString * const HuesShareServerKey = @"12345";

@implementation HuesPaletteExporter

+ (NSString *)exportPaletteToJSON:(HuesPalette *)palette
{
	NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
	data[@"name"] = palette.name ?: @"Untitled Palette";
	data[@"id"] = palette.uuid;
	
	NSMutableArray *colors = [NSMutableArray array];
	
	for (HuesPaletteItem *item in palette.colors) {
		[colors addObject:@{@"name": item.name, @"color": item.color}];
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
		NSDictionary *params = @{@"key": HuesShareServerKey};
		NSString *string = [HuesShareServerURL stringByAppendingFormat:@"?%@", AFQueryStringFromParametersWithEncoding(params, NSUTF8StringEncoding)];
		
		NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:string]];
		[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
		request.HTTPMethod = @"POST";
		request.HTTPBody = [json dataUsingEncoding:NSUTF8StringEncoding];
		
		AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
			if ([JSON[@"status"] isEqualToString:@"ok"]) {				
				if (block) block([NSURL URLWithString:JSON[@"url"]], nil);
			} else {
				if (block) block(nil, nil);
			}
		} failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
			if (block) block(nil, error);
		}];
		
		[operation start];		
	}
}

@end
