//
//  HuesPalettesManager.m
//  Hues
//
//  Created by Zach Waugh on 7/24/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesPalettesManager.h"
#import "HuesPalette.h"
#import <CoreData/CoreData.h>

NSString * const HuesPalettesUpdatedNotification = @"HuesPalettesUpdatedNotification";

@interface HuesPalettesManager ()

@property (strong, readwrite) NSArray *palettes;
@property (readwrite, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readwrite, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readwrite, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation HuesPalettesManager

+ (HuesPalettesManager *)sharedManager
{
	static HuesPalettesManager *_sharedManager = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
    _sharedManager = [[HuesPalettesManager alloc] init];
	});
	
	return _sharedManager;
}

- (id)init
{
	self = [super init];
	if (!self) return nil;
	
	_palettes = @[];
	[self refreshPalettes];
	
	return self;
}

- (void)refreshPalettes
{
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Palette" inManagedObjectContext:self.managedObjectContext];
	[request setEntity:entity];
	
	//	NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
	//	[request setSortDescriptors:@[sortDescriptor]];
	
	NSError *error = nil;
	NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
	
	if (error) {
		NSLog(@"error retrieving palettes: %@", error);
	}
	
	self.palettes = results;
}

- (HuesPalette *)createPaletteWithName:(NSString *)name
{
	HuesPalette *palette = (HuesPalette *)[NSEntityDescription insertNewObjectForEntityForName:@"Palette" inManagedObjectContext:self.managedObjectContext];
	palette.uuid = [[NSUUID UUID] UUIDString];
	
	if (!name) {
		NSString *untitledName = @"Untitled Palette";
		NSInteger index = 0;
		
		for (HuesPalette *palette in self.palettes) {
			if ([palette.name hasPrefix:untitledName]) {
				index++;
			}
		}
		
		if (index > 0) {
			untitledName = [NSString stringWithFormat:@"%@ %ld", untitledName, index];
		}
		
		palette.name = untitledName;
	} else {
		palette.name = name;
	}
	
	[self refreshPalettes];
	
	return palette;
}

//- (void)addPalette:(HuesPalette *)palette
//{
//	NSLog(@"addPalette: %@", palette);
//	[self.palettes addObject:palette];
//	[[NSNotificationCenter defaultCenter] postNotificationName:HuesPalettesUpdatedNotification object:self];
//	[self save];
//}

- (void)removePalette:(HuesPalette *)palette
{
	NSLog(@"removePalette: %@", palette);
	[self.managedObjectContext deleteObject:palette];
	[self save];
	[self refreshPalettes];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:HuesPalettesUpdatedNotification object:self];
}

#pragma mark - Importing

- (void)importFiles:(NSArray *)files
{
	for (NSString *file in files) {
		if ([file.pathExtension isEqualToString:@"hues"]) {
			NSError *error = nil;
			NSData *data = [NSData dataWithContentsOfFile:file options:0 error:&error];
			
			if (!error) {
				NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
				
				if (!error) {
					HuesPalette *palette = [self createPaletteWithName:dict[@"name"]];
					NSLog(@"imported palette: %@", palette);
					
					[self save];
					
					NSUserNotification *notification = [[NSUserNotification alloc] init];
					notification.title = @"Palette imported";
					notification.informativeText = [NSString stringWithFormat:@"%@ was imported successfully", file.lastPathComponent];
					
					[[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
				} else {
					NSLog(@"error decoding JSON: %@", error);
				}
			} else {
				NSLog(@"error importing palette");
			}
		}
	}
}

#pragma mark - Core Data stack

- (void)save
{
	NSError *error = nil;
	NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
	if (managedObjectContext != nil) {
		if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
			// Replace this implementation with code to handle the error appropriately.
			// abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
	}
}

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
	if (_managedObjectContext != nil) {
		return _managedObjectContext;
	}
	
	NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
	if (coordinator != nil) {
		_managedObjectContext = [[NSManagedObjectContext alloc] init];
		[_managedObjectContext setPersistentStoreCoordinator:coordinator];
	}
	return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
	if (_managedObjectModel != nil) {
		return _managedObjectModel;
	}
	NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Hues" withExtension:@"momd"];
	_managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
	return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
	if (_persistentStoreCoordinator != nil) {
		return _persistentStoreCoordinator;
	}
	
	NSURL *storeURL = [[self.class applicationSupportDirectory] URLByAppendingPathComponent:@"palettes.huesdb"];
	
	NSError *error = nil;
	_persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
	if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
		 
		 Typical reasons for an error here include:
		 * The persistent store is not accessible;
		 * The schema for the persistent store is incompatible with current managed object model.
		 Check the error message to determine what the actual problem was.
		 
		 
		 If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
		 
		 If you encounter schema incompatibility errors during development, you can reduce their frequency by:
		 * Simply deleting the existing store:
		 [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
		 
		 * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
		 @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
		 
		 Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
		 
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
	return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
+ (NSURL *)applicationSupportDirectory
{
	NSURL *directory = [[[[NSFileManager defaultManager] URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:@"Hues"];
	
	if (![[NSFileManager defaultManager] fileExistsAtPath:directory.path]) {
		NSError *error = nil;
		[[NSFileManager defaultManager] createDirectoryAtURL:directory withIntermediateDirectories:YES attributes:nil error:&error];
		
		if (error) {
			NSLog(@"error creating application support directory");
		}
	}
	
	return directory;
}

@end
