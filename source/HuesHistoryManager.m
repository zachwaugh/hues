//
//  HuesHistoryManager.m
//  Hues
//
//  Created by Zach Waugh on 12/29/10.
//  Copyright 2010 Giant Comet. All rights reserved.
//

#import "HuesHistoryManager.h"
#import "NSImage+Hues.h"
#import "HuesColorFormatter.h"
#import "HuesDefines.h"

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
    _sharedHistoryManager = [[self alloc] init];
  });
  
  return _sharedHistoryManager;
}

- (id)init
{
  self = [super init];
	if (!self) return nil;
	
	_history = [NSMutableArray arrayWithCapacity:HUES_MAX_HISTORY_SIZE];
  
  return self;
}

- (void)addColor:(NSColor *)color
{
  // Don't add if same as last color
  if (self.history.count > 0 && [color isEqualTo:self.history[0]]) return;
 
  // Ensure doesn't go past max history size
  if (self.history.count == HUES_MAX_HISTORY_SIZE) {
    [self.history removeLastObject];
  }
  
  [self.history insertObject:color atIndex:0];
  
  if ([self.menu numberOfItems] == HUES_MAX_HISTORY_SIZE) {
    [self.menu removeItemAtIndex:HUES_MAX_HISTORY_SIZE - 1];
  }
  
	NSString *value = [HuesColorFormatter stringForColorWithDefaultFormat:color];
  NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:value action:@selector(colorChosen:) keyEquivalent:@""];
  [item setImage:[NSImage imageWithColor:color]];
  [item setTarget:self];
  [self.menu insertItem:item atIndex:0];
}

- (void)colorChosen:(id)sender
{
  NSInteger index = [self.menu indexOfItem:sender];
  NSColor *color = self.history[index];
  [[NSNotificationCenter defaultCenter] postNotificationName:HuesUpdateColorNotification object:color];
}

@end
