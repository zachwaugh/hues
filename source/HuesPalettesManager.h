//
//  HuesPalettesManager.h
//  Hues
//
//  Created by Zach Waugh on 7/24/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HuesPalette;

@interface HuesPalettesManager : NSObject

@property (strong, readonly) NSMutableArray *palettes;

+ (HuesPalettesManager *)sharedManager;
- (void)save;
- (void)addPalette:(HuesPalette *)palette;
- (void)removePalette:(HuesPalette *)palette;

@end
