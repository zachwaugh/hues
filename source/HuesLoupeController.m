//
//  HuesLoupeController.m
//  Hues
//
//  Created by Zach Waugh on 7/12/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesLoupeController.h"
#import "HuesLoupeWindow.h"
#import "HuesLoupeView.h"

@interface HuesLoupeController ()

@property (strong) HuesLoupeWindow *loupeWindow;
@property (assign) id monitor;

@end

@implementation HuesLoupeController

+ (HuesLoupeController *)sharedController
{
	static HuesLoupeController *_sharedController = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
    _sharedController = [[HuesLoupeController alloc] init];
	});
	
	return _sharedController;
}

- (id)init
{
	self = [super init];
	if (!self) return nil;
	
	[self startEventMonitor];
	
	return self;
}

- (void)showLoupe
{
	NSInteger loupeSize = [HuesLoupeView defaultLoupeSize];
	NSPoint point = [NSEvent mouseLocation];
	NSRect loupeRect = NSMakeRect(round(point.x) - round(loupeSize / 2), round(point.y) - round(loupeSize / 2), loupeSize, loupeSize);
	
	//NSLog(@"showLoupe: %@, active: %d", NSStringFromRect(loupeRect), [NSApp isActive]);
	
	if (!self.loupeWindow) {
		self.loupeWindow = [[HuesLoupeWindow alloc] initWithFrame:loupeRect];
		self.loupeWindow.delegate = self;
	} else {
		[self.loupeWindow adjustLoupeWithOrigin:loupeRect.origin];
	}
	
  [self.loupeWindow show];
}

- (void)startEventMonitor
{
	self.monitor = [NSEvent addGlobalMonitorForEventsMatchingMask:NSMouseMovedMask handler:^(NSEvent *event ){
		if (self.loupeWindow && [self.loupeWindow isVisible]) {
			//NSLog(@"[monitor] sending mouseMoved: %@, app active: %d", NSStringFromPoint(event.locationInWindow), [NSApp isActive]);
			[self.loupeWindow mouseMoved:event];
		}
	}];
}

- (void)stopEventMonitor
{
	[NSEvent removeMonitor:self.monitor];
	self.monitor = nil;
}

@end
