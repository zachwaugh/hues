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
	[[NSColor redColor] set];
	NSRectFill([self bounds]);
}

@end
