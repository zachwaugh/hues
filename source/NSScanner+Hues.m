//
//  NSScanner+Hues.m
//  Hues
//
//  Created by Zach Waugh on 7/11/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "NSScanner+Hues.h"

@implementation NSScanner (Hues)

- (void)hues_skipToString:(NSString *)string
{
	[self scanUpToString:string intoString:NULL];
	[self scanString:string intoString:NULL];
}

@end
