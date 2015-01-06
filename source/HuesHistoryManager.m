//
//  HuesHistoryManager.m
//  Hues
//
//  Created by Zach Waugh on 12/29/10.
//  Copyright 2010 Giant Comet. All rights reserved.
//

#import "HuesHistoryManager.h"
#import "NSColor+Extras.h"
#import "NSImage+Hues.h"
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
  if ((self = [super init]))
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
  // Don't add if same as last color
  if ([self.history count] > 0 && [[color hues_hex] isEqualToString:[[self.history objectAtIndex:0] hues_hex]]) return;
 
  // Ensure doesn't go past max history size
  if ([self.history count] == HUES_MAX_HISTORY_SIZE)
  {
    [self.history removeLastObject];
  }
  
  
  [self.history insertObject:color atIndex:0];
   
  
  if ([self.menu numberOfItems] == HUES_MAX_HISTORY_SIZE)
  {
    [self.menu removeItemAtIndex:HUES_MAX_HISTORY_SIZE - 1];
  }
  
  NSMenuItem *item = [[[NSMenuItem alloc] initWithTitle:[color hues_hex] action:@selector(colorChosen:) keyEquivalent:@""] autorelease];
  [item setImage:[NSImage imageWithColor:color]];
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
