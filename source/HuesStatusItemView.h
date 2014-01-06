//
//  HuesStatusItemView.h
//  Hues
//
//  Created by Zach Waugh on 10/30/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface HuesStatusItemView : NSView

@property (nonatomic, assign) BOOL highlighted;
@property (nonatomic, strong) NSImage *image;
@property (nonatomic, strong) NSImage *alternateImage;
@property (nonatomic, weak) NSStatusItem *statusItem;
@property (nonatomic, assign) SEL action;
@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL altAction;
@property (nonatomic, assign) id altTarget;

@end
