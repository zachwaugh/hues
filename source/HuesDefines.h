//
//  HuesDefines.h
//  Hues
//
//  Created by Zach Waugh on 12/27/10.
//  Copyright 2010 Giant Comet. All rights reserved.
//

#define BETA 1
#define BETA_EXPIRATION @"2014-06-01 23:59:00" // June 1, 2014
#define HUES_MAS_URL @"https://itunes.apple.com/us/app/hues/id411811718?mt=12"

typedef enum {
	HuesDockAndMenuBarMode,
	HuesDockOnlyMode,
	HuesMenuBarOnlyMode
} HuesApplicationMode;

// Notifications
extern NSString * const HuesUpdateColorNotification;
extern NSString * const HuesColorFormatsUpdatedNotification;

extern NSInteger const HuesLoupeSize;
extern NSInteger const HuesLoupeZoom;