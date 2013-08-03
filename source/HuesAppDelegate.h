//
//  HUAppDelegate.h
//  Hues
//
//  Created by Zach Waugh on 2/17/09.
//  Copyright 2009 Giant Comet. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <HockeySDK/HockeySDK.h>

@interface HuesAppDelegate : NSObject <NSApplicationDelegate, NSUserNotificationCenterDelegate, BITCrashReportManagerDelegate>

@property (weak) IBOutlet NSMenuItem *checkForUpdatesMenuItem;
@property (weak) IBOutlet NSMenu *statusMenu;

- (IBAction)showPreferences:(id)sender;
- (IBAction)showLoupe:(id)sender;

#ifndef APP_STORE
- (IBAction)checkForUpdates:(id)sender;
#endif

@end
