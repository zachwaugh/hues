//
//  HuesScopeBarButton.m
//  Hues
//
//  Created by Zach Waugh on 7/22/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesScopeBarButton.h"

#define TEXT_PADDING 10

static NSImage *_scopeBackgroundLeft = nil, *_scopeBackgroundFill = nil, *_scopeBackgroundRight = nil;
static NSDictionary *_attributes = nil;

@interface HuesScopeBarButton ()

@property (strong) NSAttributedString *attributedTitle;

@end

@implementation HuesScopeBarButton

+ (void)initialize
{
	_scopeBackgroundLeft = [NSImage imageNamed:@"scope-bar-button-left"];
	_scopeBackgroundFill = [NSImage imageNamed:@"scope-bar-button-fill"];
	_scopeBackgroundRight = [NSImage imageNamed:@"scope-bar-button-right"];
	
	NSFont *font = [NSFont fontWithName:@"HelveticaNeue-Bold" size:12.0f];
	NSColor *textColor = [NSColor colorWithDeviceRed:0.290 green:0.290 blue:0.290 alpha:1.000];
	NSShadow *shadow = [[NSShadow alloc] init];
	shadow.shadowColor = [NSColor whiteColor];
	shadow.shadowOffset = NSMakeSize(0, -1);
	
	_attributes = @{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor, NSShadowAttributeName: shadow};
}

- (id)initWithFrame:(NSRect)frame
{
	self = [super initWithFrame:frame];
	if (!self) return nil;
	
	return self;
}

- (void)setTitle:(NSString *)title
{
	_title = title;
	
	self.attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:_attributes];
	[self setNeedsDisplay:YES];
}

- (void)setSelected:(BOOL)selected
{
	_selected = selected;
	[self setNeedsDisplay:YES];
}

- (void)sizeToFit
{
	NSRect frame = self.frame;
	frame.size.width = self.attributedTitle.size.width + (TEXT_PADDING * 2);
	self.frame = frame;
}

- (void)drawRect:(NSRect)dirtyRect
{
	if (self.selected) {
		NSDrawThreePartImage(self.bounds, _scopeBackgroundLeft, _scopeBackgroundFill, _scopeBackgroundRight, NO, NSCompositeSourceOver, 1.0f, NO);
	}

	NSRect textBounds = NSInsetRect(self.bounds, TEXT_PADDING, 0);
	textBounds.origin.y += 1; // offset origin for HelveticaNeue issue
	[self.attributedTitle drawInRect:textBounds];
}

@end
