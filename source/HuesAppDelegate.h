//
//  HUAppDelegate.h
//  Hues
//
//  Created by Zach Waugh on 2/17/09.
//  Copyright 2009 Giant Comet. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface HuesAppDelegate : NSObject <NSWindowDelegate>

- (void)showPreferences:(id)sender;
- (IBAction)showLoupe:(id)sender;

@end
