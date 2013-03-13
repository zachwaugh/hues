//
//  HuesScopeBarView.h
//  Hues
//
//  Created by Zach Waugh on 12/16/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol HuesScopeBarViewDelegate <NSObject>

- (void)scopeBarDidSelectTabWithTitle:(NSString *)title;

@end

@interface HuesScopeBarView : NSView

@property (strong, nonatomic) NSArray *titles;
@property (unsafe_unretained) id<HuesScopeBarViewDelegate> delegate;

- (void)selectTabAtIndex:(NSInteger)index;

@end
