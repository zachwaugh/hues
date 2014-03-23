//
//  HuesPalettesManager.h
//  Hues
//
//  Created by Zach Waugh on 7/24/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const HuesPalettesUpdatedNotification;

@class HuesPalette;

@interface HuesPalettesManager : NSObject

@property (nonatomic, strong, readonly) NSArray *palettes;
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (HuesPalettesManager *)sharedManager;
- (void)save;
- (HuesPalette *)createPaletteWithName:(NSString *)name;
- (void)removePalette:(HuesPalette *)palette;
- (void)importFiles:(NSArray *)files;

@end
