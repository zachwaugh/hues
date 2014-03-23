//
//  HuesTextField.m
//  Hues
//
//  Created by Zach Waugh on 7/17/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesTextFieldCell.h"

@implementation HuesTextFieldCell

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{
	NSImage *textFieldLeft = [NSImage imageNamed:@"text-field-left"];
	NSImage *textFieldFill = [NSImage imageNamed:@"text-field-fill"];
	NSImage *textFieldRight = [NSImage imageNamed:@"text-field-right"];
	NSDrawThreePartImage(cellFrame, textFieldLeft, textFieldFill, textFieldRight, NO, NSCompositeSourceOver, 1.0, YES);
	
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
