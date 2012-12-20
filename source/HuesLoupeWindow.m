//
//  LoupeWindow.m
//  Loupe
//
//  Created by Zach Waugh on 11/4/11.
//  Copyright (c) 2011 Figure 53. All rights reserved.
//

#import "HuesLoupeWindow.h"
#import "HuesLoupeView.h"
#import <ApplicationServices/ApplicationServices.h>

NSInteger const HuesLoupeSize = 315;
#define USE_UNDOCUMENTED_HIDE 1

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
		[self hideCursor];
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

- (void)becomeMainWindow
{
	[self makeFirstResponder:self.loupeView];
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
	[self showCursor];
	[self orderOut:nil];
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
	[self setFrameOrigin:origin];
  [self.loupeView setNeedsDisplay:YES];
}

#pragma mark - Cursor

- (void)hideCursor
{
	// Standard way - doesn't work if app isn't active
	[self disableCursorRects];
	[NSCursor hide];
	
#if USE_UNDOCUMENTED_HIDE
	
	// Private API from - http://stackoverflow.com/questions/3885896/globally-hiding-cursor-from-background-app
	void CGSSetConnectionProperty(int, int, CFStringRef, CFBooleanRef);
	int _CGSDefaultConnection();
	CFStringRef propertyString;
	
	// Hack to make background cursor setting work
	propertyString = CFStringCreateWithCString(NULL, "SetsCursorInBackground", kCFStringEncodingUTF8);
	CGSSetConnectionProperty(_CGSDefaultConnection(), _CGSDefaultConnection(), propertyString, kCFBooleanTrue);
	CFRelease(propertyString);
	
	// Hide the cursor and wait
	CGDisplayHideCursor(kCGDirectMainDisplay);
	
#endif
}

- (void)showCursor
{
	[NSCursor unhide];
	
#if USE_UNDOCUMENTED_HIDE
	CGDisplayShowCursor(kCGDirectMainDisplay);
#endif
}

@end
