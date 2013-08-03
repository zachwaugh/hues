//
//  HuesStatusItemView.m
//  Hues
//
//  Created by Zach Waugh on 10/30/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import "HuesStatusItemView.h"

@implementation HuesStatusItemView

- (id)initWithFrame:(NSRect)frameRect
{
	self = [super initWithFrame:frameRect];
	if (!self) return nil;
	
	_image = [NSImage imageNamed:@"hues_menubar_normal"];
	_alternateImage = [NSImage imageNamed:@"hues_menubar_highlight"];
	
	return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
  [self.statusItem drawStatusBarBackgroundInRect:self.bounds withHighlight:self.highlighted];
  
  NSImage *image = (self.highlighted) ? self.alternateImage : self.image;
  NSRect imageRect = NSMakeRect(ceil((self.bounds.size.width - image.size.width) / 2.0f), ceil((self.bounds.size.height - image.size.height) / 2.0f), image.size.width, image.size.height);
	  
  [image drawInRect:imageRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
}

- (void)setImage:(NSImage *)image
{
  _image = image;
  [self setNeedsDisplay:YES];
}

- (void)setHighlighted:(BOOL)highlighted
{
  _highlighted = highlighted;
  [self setNeedsDisplay:YES];
}

- (NSMenu *)menuForEvent:(NSEvent *)event
{
	return nil;
}

- (void)mouseDown:(NSEvent *)event
{
	BOOL control = (event.modifierFlags & NSControlKeyMask) == NSControlKeyMask;
	BOOL option = (event.modifierFlags & NSAlternateKeyMask) == NSAlternateKeyMask;
	
	if (control || option) {
		self.highlighted = YES;
		[self.statusItem popUpStatusItemMenu:self.menu];
		self.highlighted = NO;
		return;
	}
	
  self.highlighted = YES;
	
	if (self.target && [self.target respondsToSelector:self.action]) {
    [self.target performSelector:self.action withObject:self];
  }
}

- (void)mouseUp:(NSEvent *)theEvent
{
  self.highlighted = NO;
}

- (void)rightMouseDown:(NSEvent *)theEvent
{
  self.highlighted = YES;
	[self.statusItem popUpStatusItemMenu:self.menu];
	self.highlighted = NO;
}

@end
