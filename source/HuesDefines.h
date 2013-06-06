//
//  HuesDefines.h
//  Hues
//
//  Created by Zach Waugh on 12/27/10.
//  Copyright 2010 Giant Comet. All rights reserved.
//

#define BETA 1
#define BETA_EXPIRATION @"2013-09-01 23:59:00" // September 1, 2013
#define HUES_MAS_URL @"https://itunes.apple.com/us/app/hues/id411811718?mt=12"

typedef enum {
  HuesHexRepresentation,
  HuesRGBRepresentation,
  HuesHSLRepresentation
} HuesColorRepresentation;

typedef enum {
	HuesDockAndMenuBarMode,
	HuesDockOnlyMode,
	HuesMenuBarOnlyMode
} HuesApplicationMode;

//typedef NSInteger HuesColorRepresentation;

// Notifications
extern NSString * const HuesUpdateColorNotification;

extern NSInteger const HuesLoupeSize;
extern NSInteger const HuesLoupeZoom;