//
//  LoupeWindow.m
//  Loupe
//
//  Created by Zach Waugh on 11/4/11.
//  Copyright (c) 2011 Figure 53. All rights reserved.
//

#import "HuesLoupeWindow.h"
#import "HuesLoupeView.h"
#import "HuesDefines.h"
#import <ApplicationServices/ApplicationServices.h>

NSString * const HuesLoupeWindowDidCloseNotification = @"HuesLoupeWindowDidCloseNotification";

#define USE_UNDOCUMENTED_HIDE 1

@interface HuesLoupeWindow ()

@property (strong) HuesLoupeView *loupeView;

@end

@implementation HuesLoupeWindow

- (id)initWithFrame:(NSRect)frame
{
	return [self initWithContentRect:frame styleMask:(NSBorderlessWindowMask | NSUtilityWindowMask | NSNonactivatingPanelMask) backing:NSBackingStoreBuffered defer:NO];
}

- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)styleMask backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag
{
	self = [super initWithContentRect:contentRect styleMask:styleMask backing:bufferingType defer:flag];
	if (!self) return nil;
	
	[self setBackgroundColor:[NSColor clearColor]];
	[self setLevel:NSStatusWindowLevel + 1];
	[self setOpaque:NO];
	[self setHasShadow:YES];
	[self setMovableByWindowBackground:NO];
	[self setIgnoresMouseEvents:NO];
	[self setAcceptsMouseMovedEvents:YES];
	[self setCollectionBehavior:NSWindowCollectionBehaviorCanJoinAllSpaces];
	[self disableCursorRects];
	self.loupeView = [[HuesLoupeView alloc] initWithFrame:NSMakeRect(0, 0, HuesLoupeSize, HuesLoupeSize)];
	self.contentView = self.loupeView;

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
	[super becomeMainWindow];
	[self makeFirstResponder:self.loupeView];
}

- (void)becomeKeyWindow
{
	[super becomeKeyWindow];
	[self makeFirstResponder:self.loupeView];
}

- (void)show
{
	[self hideCursor];
	[self makeKeyAndOrderFront:nil];
}

- (void)hide
{
	[[NSNotificationCenter defaultCenter] postNotificationName:HuesLoupeWindowDidCloseNotification object:self];
	[self orderOut:nil];
	[self showCursor];
}

// Escape key
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

- (void)mouseMoved:(NSEvent *)event
{
	// Get current point in screen coordinates
  NSPoint point = [NSEvent mouseLocation]; // [event locationInWindow];
  
	// Adjust window so it's centered on new point
  NSPoint origin = NSMakePoint(round(point.x - round(self.frame.size.width / 2)), round(point.y - round(self.frame.size.height / 2)));
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
#if USE_UNDOCUMENTED_HIDE
	// Hack to make background cursor setting work
	// Private API from - http://stackoverflow.com/questions/3885896/globally-hiding-cursor-from-background-app
	void CGSSetConnectionProperty(int, int, CFStringRef, CFBooleanRef);
	int _CGSDefaultConnection();
	
	CFStringRef propertyString = CFStringCreateWithCString(NULL, "SetsCursorInBackground", kCFStringEncodingUTF8);
	CGSSetConnectionProperty(_CGSDefaultConnection(), _CGSDefaultConnection(), propertyString, kCFBooleanTrue);
	CFRelease(propertyString);
	
	CGDisplayHideCursor(kCGDirectMainDisplay);
#else 
	// Standard way - doesn't work if app isn't active
	[NSCursor hide];
#endif
}

- (void)showCursor
{
#if USE_UNDOCUMENTED_HIDE
	CGDisplayShowCursor(kCGDirectMainDisplay);
#else
	[NSCursor unhide];
#endif
}

@end
