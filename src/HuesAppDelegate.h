//
//  HUAppDelegate.h
//  Hues
//
//  Created by Zach Waugh on 2/17/09.
//  Copyright 2009 Giant Comet. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class HuesColorsView;

@interface HuesAppDelegate : NSObject <NSWindowDelegate>
{
	IBOutlet HuesColorsView *colorsView;
	IBOutlet NSTextField *hexLabel;
}

@property (retain) NSView *colorsView;
@property (retain) NSTextField *hexLabel;

- (void)copyHex:(id)sender;
- (void)copyRGB:(id)sender;

@end
