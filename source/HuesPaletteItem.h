//
//  HuesPaletteItem.h
//  Hues
//
//  Created by Zach Waugh on 6/6/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HuesPaletteItem : NSObject <NSCoding>

@property (strong) NSString *name;
@property (strong) NSColor *color;

- (id)initWithName:(NSString *)name color:(NSColor *)color;

@end
