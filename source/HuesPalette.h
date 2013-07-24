//
//  HuesPalette.h
//  Hues
//
//  Created by Zach Waugh on 6/6/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HuesPaletteItem;

@interface HuesPalette : NSObject <NSCoding>

@property (strong) NSString *name;
@property (strong, readonly) NSMutableArray *colors;

- (id)initWithName:(NSString *)name;
+ (HuesPalette *)paletteWithName:(NSString *)name;
+ (HuesPalette *)paletteWithDictionary:(NSDictionary *)dict;

- (void)addItem:(HuesPaletteItem *)item;
- (void)removeItem:(HuesPaletteItem *)item;

@end
