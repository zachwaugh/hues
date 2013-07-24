//
//  HuesPaletteExporter.h
//  Hues
//
//  Created by Zach Waugh on 7/24/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HuesPalette;

@interface HuesPaletteExporter : NSObject

+ (NSString *)exportPaletteToJSON:(HuesPalette *)palette;
+ (void)exportPaletteToWeb:(HuesPalette *)palette completion:(void (^)(NSURL *url, NSError *error))block;

@end
