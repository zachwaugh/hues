//
//  HuesPalette.h
//  Hues
//
//  Created by Zach Waugh on 6/6/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HuesPaletteItem;

@interface HuesPalette : NSObject

@property (strong) NSString *name;

- (void)addItem:(HuesPaletteItem *)item;
- (void)removeItem:(HuesPaletteItem *)item;

@end
