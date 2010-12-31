//
//  NSImage+Hues.m
//  Hues
//
//  Created by Zach Waugh on 12/30/10.
//  Copyright 2010 Giant Comet. All rights reserved.
//

#import "NSImage+Hues.h"


@implementation NSImage (Hues)

+ (NSImage *)imageWithColor:(NSColor *)color
{
  NSImage *image = [[[NSImage alloc] initWithSize:NSMakeSize(10, 10)] autorelease];
  [image lockFocus];
  [color set];
  NSRectFill(NSMakeRect(0, 0, 10, 10));
  [[NSColor colorWithCalibratedWhite:0.722 alpha:1.000] set];
  [[NSBezierPath bezierPathWithRect:NSMakeRect(0.5, 0.5, 9, 9)] stroke];
  [image unlockFocus];
  
  return image;
}

@end
