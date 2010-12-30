//
//  HuesColorImage.h
//  Hues
//
//  Created by Zach Waugh on 12/29/10.
//  Copyright 2010 Giant Comet. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface HuesColorImage : NSImage
{

}

+ (HuesColorImage *)imageWithColor:(NSColor *)color;

@end
