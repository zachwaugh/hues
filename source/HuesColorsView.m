//
//  HuesColorsView.m
//  Hues
//
//  Created by Zach Waugh on 12/22/10.
//  Copyright 2010 Giant Comet. All rights reserved.
//

#import "HuesColorsView.h"


@implementation HuesColorsView

- (void)drawRect:(NSRect)dirtyRect
{
  NSImage *cap = [NSImage imageNamed:@"background_left.png"];
  NSImage *center = [NSImage imageNamed:@"background_middle.png"];
  
  NSDrawThreePartImage([self bounds], cap, center, cap, NO, NSCompositeSourceOver, 1.0, NO);
  
  //NSImage *background = [NSImage imageNamed:@"background.png"];
  
  //[background drawInRect:[self bounds] fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
  
//  [[NSColor colorWithCalibratedWhite:0.537 alpha:1.000] set];
//  NSRectFill(NSMakeRect(0, 0, [self bounds].size.width, 1));
}


@end
