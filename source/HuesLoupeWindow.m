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
	HuesLoupeWindow *window = [super initWithContentRect:contentRect styleMask:(NSBorderlessWindowMask | NSUtilityWindowMask | NSNonactivatingPanelMask) backing:NSBackingStoreBuffered defer:NO];
	
	[window setBackgroundColor:[NSColor clearColor]];
	[window setLevel:NSStatusWindowLevel + 1];
	[window setOpaque:NO];
	[window setHasShadow:YES];
	[window setMovableByWindowBackground:NO];
	[window setIgnoresMouseEvents:NO];
	[window setAcceptsMouseMovedEvents:YES];
	
  [self disableCursorRects];
  [NSCursor hide];
  
	return window;
}

- (BOOL)canBecomeKeyWindow
{
	return YES;
}

- (BOOL)canBecomeMainWindow
{
	return YES;
}

- (void)cancel:(id)sender
{
	[self hide];
}

- (void)moveUp:(id)sender
{
	NSPoint origin = self.frame.origin;
	
	origin.y += ([NSEvent modifierFlags] & NSShiftKeyMask) ? 10 : 1;
	[self adjustLoupeWithOrigin:origin];
}

- (void)moveDown:(id)sender
{
	NSPoint origin = self.frame.origin;
	
	origin.y -= ([NSEvent modifierFlags] & NSShiftKeyMask) ? 10 : 1;
	[self adjustLoupeWithOrigin:origin];
}

- (void)moveLeft:(id)sender
{
	NSPoint origin = self.frame.origin;
	
	origin.x -= ([NSEvent modifierFlags] & NSShiftKeyMask) ? 10 : 1;
	[self adjustLoupeWithOrigin:origin];
}

- (void)moveRight:(id)sender
{
	NSPoint origin = self.frame.origin;
	
	origin.x += ([NSEvent modifierFlags] & NSShiftKeyMask) ? 10 : 1;
	[self adjustLoupeWithOrigin:origin];
}

- (void)hide
{
	[self orderOut:nil];
  [NSCursor unhide];
}

- (void)mouseMoved:(NSEvent *)event
{
	// Get current point in screen coordinates
  NSPoint point = [NSEvent mouseLocation]; // [event locationInWindow];
  
  //NSLog(@"screen: %@, window: %@, view: %@", NSStringFromPoint([self convertBaseToScreen:point]), NSStringFromPoint(point), NSStringFromPoint([self.contentView convertPoint:point fromView:nil]));
  
	// Adjust window so it's centered on new point
  NSPoint origin = NSMakePoint(round(point.x - round(self.frame.size.width / 2)), round(point.y - round(self.frame.size.height / 2))); //[self convertBaseToScreen:NSMakePoint(round(point.x - 100), round(point.y - 100))];
  
  [self adjustLoupeWithOrigin:origin];
}

- (void)adjustLoupeWithOrigin:(NSPoint)origin
{
	//NSLog(@"loupe origin: %@", NSStringFromPoint(origin));
	[self setFrameOrigin:origin];
  [[self contentView] setNeedsDisplay:YES];
}

@end
