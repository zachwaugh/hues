//
//  HuesSyncManager.m
//  Hues
//
//  Created by Zach Waugh on 7/25/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesSyncManager.h"
#import "HuesPreferences.h"

@implementation HuesSyncManager

+ (HuesSyncManager *)sharedManager
{
	static HuesSyncManager *_sharedManager = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
    _sharedManager = [[HuesSyncManager alloc] init];
	});
	
	return _sharedManager;
}

- (id)init
{
	self = [super init];
	if (!self) return nil;
	
	if ([HuesPreferences useiCloud]) {
		[self initiCloud];
	}
	
	return self;
}

#pragma mark - iCloud

- (void)initiCloud
{
	// iCloud
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(iCloudStoreDidChange:) name:NSUbiquitousKeyValueStoreDidChangeExternallyNotification object:[NSUbiquitousKeyValueStore defaultStore]];
	
	[[NSUbiquitousKeyValueStore defaultStore] synchronize];
}

#pragma mark - iCloud

- (void)iCloudStoreDidChange:(NSNotification *)notification
{
	NSLog(@"iCloudStoreDidChange: %@", notification);
}

@end
