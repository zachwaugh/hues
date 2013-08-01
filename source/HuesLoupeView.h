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

- (HuesColor *)colorAtPoint:(CGPoint)point;

@end
