//
//  HuesPreferencesViewControllerProtocol.h
//  Hues
//
//  Created by Zach Waugh on 7/11/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HuesPreferencesViewControllerProtocol <NSObject>

- (NSString *)identifier;
- (void)setIdentifier:(NSString *)identifier;

@end
