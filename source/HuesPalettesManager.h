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

@property (strong, readonly) NSArray *palettes;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (HuesPalettesManager *)sharedManager;
- (void)save;
- (HuesPalette *)newPalette;
- (void)addPalette:(HuesPalette *)palette;
- (void)removePalette:(HuesPalette *)palette;
- (void)importFiles:(NSArray *)files;

@end
