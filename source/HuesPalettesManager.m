//
//  HuesPalettesManager.m
//  Hues
//
//  Created by Zach Waugh on 7/24/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesPalettesManager.h"
#import "HuesPalette.h"

@interface HuesPalettesManager ()

@property (strong, readwrite) NSMutableArray *palettes;

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
	
	_palettes = [[NSMutableArray alloc] init];
	[self load];
	
	return self;
}

- (void)addPalette:(HuesPalette *)palette
{
	NSLog(@"addPalette: %@", palette);
	[self.palettes addObject:palette];
}

- (void)removePalette:(HuesPalette *)palette
{
	NSLog(@"removePalette: %@", palette);
	[self.palettes removeObject:palette];
}

#pragma mark - Archiving/Unarchiving

- (void)load
{
	NSString *palettesPath = [self.class pathForPalettes];
	if ([[NSFileManager defaultManager] fileExistsAtPath:palettesPath]) {
		@try {
			NSArray *palettes = [NSKeyedUnarchiver unarchiveObjectWithFile:palettesPath];
			
			if (palettes) {
				self.palettes = [palettes mutableCopy];
			}
		} @catch (NSException *exception) {
			NSLog(@"***Exception: caught unarchiving palettes: %@", exception);
		}
	} else {
		NSLog(@"couldn't load palettes, file doesn't exist");
	}
}

- (void)save
{
	if ([NSKeyedArchiver archiveRootObject:self.palettes toFile:[self.class pathForPalettes]]) {
		NSLog(@"palettes saved!");
	} else {
		NSLog(@"error saving palettes!");
	}
}

+ (NSString *)pathForPalettes
{
	NSFileManager *fm = [NSFileManager defaultManager];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
	
	NSString *dir = [paths[0] stringByAppendingPathComponent:@"Hues"];
	
	if (![fm fileExistsAtPath:dir]) {
		NSError *error = nil;
		[fm createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:&error];
		
		if (error) {
			NSLog(@"error creating application support directory: %@", error);
		}
	}
	
	return [dir stringByAppendingPathComponent:@"palettes.huesdb"];
}

@end
