//
//  LoupeWindow.m
//  Loupe
//
//  Created by Zach Waugh on 11/4/11.
//  Copyright (c) 2011 Figure 53. All rights reserved.
//

#import "HuesLoupeWindow.h"

@implementation HuesLoupeWindow

- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag 
{	
	HuesLoupeWindow *window = [super initWithContentRect:contentRect styleMask:(NSBorderlessWindowMask | NSNonactivatingPanelMask) backing:NSBackingStoreBuffered defer:NO];
	
	[window setBackgroundColor:[NSColor clearColor]];
	[window setLevel:NSStatusWindowLevel];
	[window setOpaque:NO];
	[window setHasShadow:YES];
	[window setMovableByWindowBackground:NO];
	[window setIgnoresMouseEvents:NO];
	[window setAcceptsMouseMovedEvents:YES];
	
  [self disableCursorRects];
  [NSCursor hide];
  
	return window;
}


- (void)becomeMainWindow
{
  [super becomeMainWindow];
  
  [self disableCursorRects];
  [NSCursor hide];
}


- (void)mouseMoved:(NSEvent *)event
{
  NSPoint point = [event locationInWindow];
  
  //NSLog(@"screen: %@, window: %@, view: %@", NSStringFromPoint([self convertBaseToScreen:point]), NSStringFromPoint(point), NSStringFromPoint([self.contentView convertPoint:point fromView:nil]));
  
  NSPoint origin = [self convertBaseToScreen:NSMakePoint(round(point.x - 100), round(point.y - 100))];
  
  [self setFrameOrigin:origin];
  
  [[self contentView] setNeedsDisplay:YES];
}

@end
