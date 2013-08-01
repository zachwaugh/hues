//
//  HuesMixerViewController.m
//  Hues
//
//  Created by Zach Waugh on 12/17/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import "HuesMixerViewController.h"
#import "HuesColor.h"
#import "HuesDefines.h"

@implementation HuesMixerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (!self) return nil;
	
	_color = [HuesColor colorWithRed:1 green:1 blue:1 alpha:1];
	
	return self;
}

- (void)awakeFromNib
{
	if (self.color) {
		[self updateInterfaceWithColor:self.color];
	}
}

- (void)updateColor:(HuesColor *)color
{
	self.color = color;
	[[NSNotificationCenter defaultCenter] postNotificationName:HuesUpdateColorNotification object:color];
	[self updateInterfaceWithColor:color];
}

- (void)updateInterfaceWithColor:(NSColor *)color
{
	// Default does nothing - override in subclass
}

@end
