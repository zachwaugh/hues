//
//  HuesHistoryManager.m
//  Hues
//
//  Copyright (c) 2014 Zach Waugh
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

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

@synthesize history, menu;

- (id)init {
    if ((self = [super init])) {
        self.history = [NSMutableArray arrayWithCapacity:HUES_MAX_HISTORY_SIZE];
    }
    
    return self;
}

- (void)dealloc {
    self.history = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark Singleton methods

+ (HuesHistoryManager *)sharedManager {
    static HuesHistoryManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[HuesHistoryManager alloc] init];
    });
    
    return _sharedManager;
}

- (void)addColor:(NSColor *)color {
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

- (void)colorChosen:(id)sender {
    NSInteger index = [self.menu indexOfItem:sender];
    NSColor *color = [self.history objectAtIndex:index];
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:HuesUpdateColorNotification object:color]];
}

@end
