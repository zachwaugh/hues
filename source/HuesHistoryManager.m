//
//  HuesHistoryManager.m
//  Hues
//
//  Created by Zach Waugh on 12/29/10.
//  Copyright 2010 Giant Comet. All rights reserved.
//

#import "HuesHistoryManager.h"
#import "NSColor+Extras.h"
#import "HuesGlobal.h"

#define HUES_MAX_HISTORY_SIZE 25

static HuesHistoryManager *sharedHistoryManager = nil;

// Private methods
@interface HuesHistoryManager ()

- (void)colorChosen:(id)sender;

@end


@implementation HuesHistoryManager

@synthesize history, menu;

- (id)init
{
  if (self = [super init])
  {
    self.history = [NSMutableArray arrayWithCapacity:HUES_MAX_HISTORY_SIZE];
  }
  
  return self;
}


- (void)dealloc
{
  self.history = nil;
  [super dealloc];
}


- (void)addColor:(NSColor *)color
{
  if ([self.history count] == HUES_MAX_HISTORY_SIZE)
  {
    [self.history removeLastObject];
  }
  
  [self.history insertObject:color atIndex:0];
 
  NSLog(@"history size: %d", [self.history count]);
  
  NSImage *swatch = [[[NSImage alloc] initWithSize:NSMakeSize(10, 10)] autorelease];
  [swatch lockFocus];
  [color set];
  NSRectFill(NSMakeRect(0, 0, 10, 10));
  [[NSColor grayColor] set];
  [[NSBezierPath bezierPathWithRect:NSMakeRect(0, 0, 10, 10)] stroke];
  [swatch unlockFocus];
  
  
  if ([self.menu numberOfItems] == HUES_MAX_HISTORY_SIZE)
  {
    [self.menu removeItemAtIndex:HUES_MAX_HISTORY_SIZE - 1];
  }
  
  NSMenuItem *item = [[[NSMenuItem alloc] initWithTitle:[color hues_hexadecimal] action:@selector(colorChosen:) keyEquivalent:@""] autorelease];
  [item setImage:swatch];
  [item setTarget:self];
  [self.menu insertItem:item atIndex:0];
}


- (void)colorChosen:(id)sender
{
  NSInteger index = [self.menu indexOfItem:sender];
  NSColor *color = [self.history objectAtIndex:index];
  [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:HuesUpdateColorNotification object:color]];
}


#pragma mark -
#pragma mark Singleton methods

+ (HuesHistoryManager *)sharedManager
{
  if (sharedHistoryManager == nil)
  {
    sharedHistoryManager = [[super allocWithZone:NULL] init];
    
  }
  
  return sharedHistoryManager;
}

+ (id)allocWithZone:(NSZone *)zone
{
  return [[self sharedManager] retain];
}

- (id)copyWithZone:(NSZone *)zone
{
  return self;
}

- (id)retain
{
  return self;
}

- (NSUInteger)retainCount
{
  return NSUIntegerMax;  //denotes an object that cannot be released
}

- (void)release
{
  //do nothing
}

- (id)autorelease
{
  return self;
}

@end
