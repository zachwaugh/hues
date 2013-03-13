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

@property (strong) NSMutableArray *tabs;

- (void)selectTab:(NSButton *)button;

@end

@implementation HuesScopeBarView

- (id)initWithFrame:(NSRect)frameRect
{
	if ((self = [super initWithFrame:frameRect])) {
		_titles = @[];
		_tabs = [[NSMutableArray alloc] init];
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
	for (NSButton *button in self.tabs) {
		[button removeFromSuperview];
	}
	
	[self.tabs removeAllObjects];
	
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
		[self.tabs addObject:button];
		[self addSubview:button];
	}
	
	[self selectTabAtIndex:0];
	[self layoutButtons];
}

- (void)layoutButtons
{
	CGFloat width = 0;
	
	for (NSButton *button in self.tabs) {
		width += NSWidth(button.frame);
	}
	
	width += (PADDING * (self.tabs.count - 1));
	
	float x = round((self.bounds.size.width - width) / 2);
	
	for (NSButton *button in self.tabs) {
		NSRect frame = button.frame;
		frame.origin.x = x;
		frame.origin.y = round((NSHeight(self.bounds) - NSHeight(button.frame)) / 2);
		button.frame = frame;
		x += NSWidth(frame) + PADDING;
	}
}

- (void)selectTabAtIndex:(NSInteger)index
{
	for (int i = 0; i < self.tabs.count; i++) {
		if (i == index) {
			[self.tabs[i] setState:NSOnState];
		} else {
			[self.tabs[i] setState:NSOffState];
		}
	}
}

- (void)selectTab:(NSButton *)button
{
	for (NSButton *tab in self.tabs) {
		if (tab == button) {
			[tab setState:NSOnState];
		} else {
			[tab setState:NSOffState];
		}
	}
}

- (void)buttonClicked:(id)sender
{
	NSButton *button = sender;
	[self selectTab:button];
	
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
