//
//  LoupeView.h
//  Loupe
//
//  Created by Zach Waugh on 11/4/11.
//  Copyright (c) 2011 Figure 53. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define LOUPE_SIZE 260

@interface HuesLoupeView : NSView
{
  CGImageRef _image;
}

- (NSColor *)colorAtPoint:(CGPoint)point;

@end
