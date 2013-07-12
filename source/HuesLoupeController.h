//
//  HuesLoupeController.h
//  Hues
//
//  Created by Zach Waugh on 7/12/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HuesLoupeController : NSObject <NSWindowDelegate>

+ (HuesLoupeController *)sharedController;
- (void)showLoupe;

@end
