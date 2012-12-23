//
//  LoupeWindow.h
//  Loupe
//
//  Created by Zach Waugh on 11/4/11.
//  Copyright (c) 2011 Figure 53. All rights reserved.
//

#import <AppKit/AppKit.h>

extern NSInteger const HuesLoupeSize;
extern NSString * const HuesLoupeWindowDidCloseNotification;

@interface HuesLoupeWindow : NSPanel

- (id)initWithFrame:(NSRect)frame;
- (void)adjustLoupeWithOrigin:(NSPoint)origin;
- (void)hide;

@end
