//
//  HuesPaletteItem.h
//  Hues
//
//  Created by Zach Waugh on 7/31/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class HuesPalette;

@interface HuesPaletteItem : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * color;
@property (nonatomic, retain) HuesPalette *palette;

@end
