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
@property (weak) NSStatusItem *statusItem;
@property (assign) SEL action;
@property (assign) id target;
@property (assign) SEL altAction;
@property (assign) id altTarget;

@end
