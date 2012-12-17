//
//  LoupeWindow.m
//  Loupe
//
//  Created by Zach Waugh on 11/4/11.
//  Copyright (c) 2011 Figure 53. All rights reserved.
//

#import "HuesLoupeWindow.h"
#import "HuesLoupeView.h"

NSInteger const HuesLoupeSize = 315;

@interface HuesLoupeWindow ()

@property (strong) HuesLoupeView *loupeView;

@end

@implementation HuesLoupeWindow

- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag 
{	
	self = [super initWithContentRect:contentRect styleMask:(NSBorderlessWindowMask | NSUtilityWindowMask | NSNonactivatingPanelMask) backing:NSBackingStoreBuffered defer:NO];
	
	if (self) {
		[self setBackgroundColor:[NSColor clearColor]];
		[self setLevel:NSStatusWindowLevel + 1];
		[self setOpaque:NO];
		[self setHasShadow:YES];
		[self setMovableByWindowBackground:NO];
		[self setIgnoresMouseEvents:NO];
		[self setAcceptsMouseMovedEvents:YES];
		
		[self disableCursorRects];
		[NSCursor hide];
		
		self.loupeView = [[HuesLoupeView alloc] initWithFrame:NSMakeRect(0, 0, HuesLoupeSize, HuesLoupeSize)];
		self.contentView = self.loupeView;
	}
	
	return self;
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
	NSLog(@"loupe origin: %@", NSStringFromPoint(origin));
	[self setFrameOrigin:origin];
  [self.loupeView setNeedsDisplay:YES];
}

@end
