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

@property (nonatomic, assign) NSInteger loupeSize;
@property (nonatomic, assign) NSInteger zoomLevel;

- (HuesColor *)colorAtPoint:(CGPoint)point;
+ (NSInteger)defaultLoupeSize;

@end
