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

// Private methods
@interface HuesHistoryManager ()

- (void)colorChosen:(id)sender;

@end

@implementation HuesHistoryManager

+ (HuesHistoryManager *)sharedManager
{
  static HuesHistoryManager *_sharedHistoryManager = nil;
  static dispatch_once_t oncePredicate;
  dispatch_once(&oncePredicate, ^{
    NSLog(@"creating history manager");
    _sharedHistoryManager = [[self alloc] init];
  });
  
  return _sharedHistoryManager;
}

- (id)init
{
  if ((self = [super init])) {
    _history = [[NSMutableArray arrayWithCapacity:HUES_MAX_HISTORY_SIZE] retain];
  }
  
  return self;
}

- (void)dealloc
{
  [_history release];
  _history = nil;
  [super dealloc];
}

- (void)addColor:(NSColor *)color
{
  // Don't add if same as last color
  if (self.history.count > 0 && [[color hues_hex] isEqualToString:[self.history[0] hues_hex]]) return;
 
  // Ensure doesn't go past max history size
  if (self.history.count == HUES_MAX_HISTORY_SIZE) {
    [self.history removeLastObject];
  }
  
  [self.history insertObject:color atIndex:0];
  
  if ([self.menu numberOfItems] == HUES_MAX_HISTORY_SIZE) {
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
  NSColor *color = self.history[index];
  [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:HuesUpdateColorNotification object:color]];
}

@end
