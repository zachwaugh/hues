//
//  HuesGlobal.h
//  Hues
//
//  Created by Zach Waugh on 12/27/10.
//  Copyright 2010 Giant Comet. All rights reserved.
//


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