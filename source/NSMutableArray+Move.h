//
//  NSMutableArray+Move.h
//  Hues
//
//  Created by Zach Waugh on 7/16/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Move)

- (void)hues_moveObjectAtIndex:(NSInteger)currentIndex toIndex:(NSInteger)index;

@end
