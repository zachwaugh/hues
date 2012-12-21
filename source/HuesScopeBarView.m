//
//  HuesScopeBarView.m
//  Hues
//
//  Created by Zach Waugh on 12/16/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import "HuesScopeBarView.h"

#define PADDING 2

@interface HuesScopeBarView ()

@end

@implementation HuesScopeBarView

- (id)initWithFrame:(NSRect)frameRect
{
	if ((self = [super initWithFrame:frameRect])) {
		_titles = @[];
	}
	
	return self;
}

- (void)setTitles:(NSArray *)titles
{
	_titles = titles;
	[self updateButtons];
}

- (void)updateButtons
{
	for (NSView *view in self.subviews) {
		[view removeFromSuperview];
	}
	
	for (NSString *title in self.titles) {
		NSButton *button = [[NSButton alloc] initWithFrame:NSMakeRect(0, 0, 100, 20)];
		button.bezelStyle = NSRecessedBezelStyle;
		[button setButtonType:NSOnOffButton];
		[button setBordered:YES];
		[button setAllowsMixedState:NO];
		[button setShowsBorderOnlyWhileMouseInside:YES];
		button.title = title;
		button.state = NSOffState;
		
		button.target = self;
		button.action = @selector(buttonClicked:);
		[button sizeToFit];
		[self addSubview:button];
	}
	
	[self layoutButtons];
}

- (void)layoutButtons
{
	CGFloat width = 0;
	
	for (NSView *view in self.subviews) {
		width += NSWidth(view.frame);
	}
	
	width += (PADDING * (self.subviews.count - 1));
	
	float x = round((self.bounds.size.width - width) / 2);
	
	for (NSView *view in self.subviews) {
		NSRect frame = view.frame;
		frame.origin.x = x;
		frame.origin.y = round((NSHeight(self.bounds) - NSHeight(view.frame)) / 2);
		view.frame = frame;
		x += NSWidth(frame) + PADDING;
	}
}

- (void)buttonClicked:(id)sender
{
	NSButton *button = sender;
	
	for (NSView *view in self.subviews) {
		[(NSButton *)view setState:NSOffState];
	}
	
	button.state = NSOnState;
	
	if (self.delegate) {
		[self.delegate scopeBarDidSelectTabWithTitle:button.title];
	}
}

- (void)drawRect:(NSRect)dirtyRect
{
  NSGradient *gradient = [[NSGradient alloc] initWithStartingColor:[NSColor colorWithCalibratedRed:0.925 green:0.925 blue:0.925 alpha:1.000] endingColor:[NSColor colorWithCalibratedRed:0.961 green:0.961 blue:0.961 alpha:1.000]];
	[gradient drawInRect:self.bounds angle:90];
	
	[[NSColor colorWithCalibratedRed:0.776 green:0.776 blue:0.776 alpha:1.000] set];
	NSRectFill((NSRect){0, 0, self.bounds.size.width, 1});
}

- (void)resizeSubviewsWithOldSize:(NSSize)oldSize
{
	[self layoutButtons];
}

@end
