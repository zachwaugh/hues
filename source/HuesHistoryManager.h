//
//  HuesHistoryManager.h
//  Hues
//
//  Created by Zach Waugh on 12/29/10.
//  Copyright 2010 Giant Comet. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class HuesColor;

@interface HuesHistoryManager : NSObject

@property (strong) NSMutableArray *history;
@property (weak) NSMenu *menu;

+ (HuesHistoryManager *)sharedManager;
- (void)addColor:(HuesColor *)color;

@end
