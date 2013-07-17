//
//  NSMutableArray+Move.m
//  Hues
//
//  Created by Zach Waugh on 7/16/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "NSMutableArray+Move.h"

@implementation NSMutableArray (Move)

- (void)hues_moveObjectAtIndex:(NSInteger)currentIndex toIndex:(NSInteger)index
{
	NSAssert(currentIndex >= 0 && currentIndex < self.count, nil);
	NSAssert(index >= 0 && index < self.count, nil);
	
	id object = self[currentIndex];
	[self removeObjectAtIndex:currentIndex];
	[self insertObject:object atIndex:index];
}

@end
