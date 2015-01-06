//
//  HuesHistoryManager.h
//  Hues
//
//  Created by Zach Waugh on 12/29/10.
//  Copyright 2010 Giant Comet. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface HuesHistoryManager : NSObject
{
  NSMutableArray *history;
  NSMenu *menu;
}

@property (retain) NSMutableArray *history;
@property (assign) NSMenu *menu;

+ (HuesHistoryManager *)sharedManager;
- (void)addColor:(NSColor *)color;

@end
