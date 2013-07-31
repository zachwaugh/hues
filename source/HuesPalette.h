//
//  HuesPalette.h
//  Hues
//
//  Created by Zach Waugh on 7/31/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class HuesPaletteItem;

@interface HuesPalette : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * uuid;
@property (nonatomic, retain) NSOrderedSet *colors;
@end

@interface HuesPalette (CoreDataGeneratedAccessors)

- (void)insertObject:(HuesPaletteItem *)value inColorsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromColorsAtIndex:(NSUInteger)idx;
- (void)insertColors:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeColorsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInColorsAtIndex:(NSUInteger)idx withObject:(HuesPaletteItem *)value;
- (void)replaceColorsAtIndexes:(NSIndexSet *)indexes withColors:(NSArray *)values;
- (void)addColorsObject:(HuesPaletteItem *)value;
- (void)removeColorsObject:(HuesPaletteItem *)value;
- (void)addColors:(NSOrderedSet *)values;
- (void)removeColors:(NSOrderedSet *)values;
@end
