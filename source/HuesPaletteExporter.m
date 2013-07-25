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
#import "AFJSONRequestOperation.h"
#import "AFHTTPClient.h"

static NSString * const HuesShareServerURL = @"http://hues.cc:3000/";
static NSString * const HuesShareServerKey = @"12345";

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
		
		NSLog(@"posting JSON: %@", json);
		
		NSDictionary *params = @{@"key": HuesShareServerKey};
		NSString *string = [HuesShareServerURL stringByAppendingFormat:@"?%@", AFQueryStringFromParametersWithEncoding(params, NSUTF8StringEncoding)];
		
		NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:string]];
		[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
		request.HTTPMethod = @"POST";
		request.HTTPBody = [json dataUsingEncoding:NSUTF8StringEncoding];
		
		AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
			if ([JSON[@"status"] isEqualToString:@"ok"]) {
				NSLog(@"palette shared! %@", JSON);
				
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
