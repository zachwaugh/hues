//
//  HuesTextField.m
//  Hues
//
//  Created by Zach Waugh on 7/17/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesTextFieldCell.h"

static NSImage *_textFieldLeft = nil, *_textFieldFill = nil, *_textFieldRight = nil;

@implementation HuesTextFieldCell

+ (void)initialize
{
	_textFieldLeft = [NSImage imageNamed:@"text-field-left"];
	_textFieldFill = [NSImage imageNamed:@"text-field-fill"];
	_textFieldRight = [NSImage imageNamed:@"text-field-right"];
}

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{
	NSDrawThreePartImage(cellFrame, _textFieldLeft, _textFieldFill, _textFieldRight, NO, NSCompositeSourceOver, 1.0, YES);
	
	cellFrame.origin.x += 5;
	cellFrame.origin.y += 2;
	[super drawWithFrame:cellFrame inView:controlView];
}

- (void)selectWithFrame:(NSRect)aRect inView:(NSView *)controlView editor:(NSText *)textObj delegate:(id)anObject start:(NSInteger)selStart length:(NSInteger)selLength
{
	aRect.origin.x += 5;
	aRect.origin.y += 2;
	[super selectWithFrame:aRect inView:controlView editor:textObj delegate:anObject start:selStart length:selLength];
}

@end
