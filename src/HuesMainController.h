//
//  HuesMainController.h
//  Hues
//
//  Created by Zach Waugh on 12/27/10.
//  Copyright 2010 Giant Comet. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class HuesColorsView;

@interface HuesMainController : NSObject
{
  IBOutlet HuesColorsView *colorsView;
	IBOutlet NSTextField *hexLabel;
  IBOutlet NSTextField *rgbLabel;
  
  NSColorPanel *colorPanel;
}


@property (retain) NSColorPanel *colorPanel;
@property (retain) NSView *colorsView;
@property (retain) NSTextField *hexLabel;
@property (retain) NSTextField *rgbLabel;

- (void)copyHex:(id)sender;
- (void)copyRGB:(id)sender;

@end
