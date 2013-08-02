//
//  HuesWindow.m
//  Hues
//
//  Created by Zach Waugh on 8/1/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesWindow.h"
#import "HuesWindowController.h"

@implementation HuesWindow

// Custom handling to support tab navigation
- (BOOL)performKeyEquivalent:(NSEvent *)event
{
  NSString *keys = [event charactersIgnoringModifiers];
	if (keys.length == 0) {
		return [super performKeyEquivalent:event];
	}
	
  NSArray *numbers = @[@"1", @"2", @"3", @"4"];
  BOOL commandPressed = (event.modifierFlags & NSCommandKeyMask) == NSCommandKeyMask;
	
  if ([numbers containsObject:keys] && commandPressed) {
    [(HuesWindowController *)self.windowController selectTabAtIndex:[keys integerValue] - 1];
    return YES;
  } else {
    return [super performKeyEquivalent:event];
  }
}

@end
