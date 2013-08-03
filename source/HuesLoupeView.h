//
//  LoupeView.h
//  Loupe
//
//  Created by Zach Waugh on 11/4/11.
//  Copyright (c) 2011 Figure 53. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class HuesColor;

@interface HuesLoupeView : NSView

@property (assign, nonatomic) NSInteger loupeSize;
@property (assign, nonatomic) NSInteger zoomLevel;

- (HuesColor *)colorAtPoint:(CGPoint)point;
+ (NSInteger)defaultLoupeSize;

@end
