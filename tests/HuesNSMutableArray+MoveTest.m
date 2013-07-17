//
//  HuesNSMutableArray+MoveTest.m
//  Hues
//
//  Created by Zach Waugh on 7/16/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesNSMutableArray+MoveTest.h"
#import "NSMutableArray+Move.h"

@implementation HuesNSMutableArray_MoveTest

- (void)testMove
{
	NSArray *array = @[@"a", @"b", @"c"];
	
	expect(array[0]).to.equal(@"a");
	expect(array[1]).to.equal(@"b");
	expect(array[2]).to.equal(@"c");
	
	// a -> end
	NSMutableArray *test = [array mutableCopy];
	[test hues_moveObjectAtIndex:0 toIndex:2];
	expect(test[0]).to.equal(@"b");
	expect(test[1]).to.equal(@"c");
	expect(test[2]).to.equal(@"a");
	
	// c -> beginning
	test = [array mutableCopy];
	[test hues_moveObjectAtIndex:2 toIndex:0];
	expect(test[0]).to.equal(@"c");
	expect(test[1]).to.equal(@"a");
	expect(test[2]).to.equal(@"b");
	
	// b -> end
	test = [array mutableCopy];
	[test hues_moveObjectAtIndex:1 toIndex:2];
	expect(test[0]).to.equal(@"a");
	expect(test[1]).to.equal(@"c");
	expect(test[2]).to.equal(@"b");
}

@end
