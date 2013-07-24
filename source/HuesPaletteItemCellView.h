//
//  HuesPaletteItemCellView.h
//  Hues
//
//  Created by Zach Waugh on 7/24/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HuesColorWell.h"

@interface HuesPaletteItemCellView : NSTableCellView

@property (weak) IBOutlet NSTextField *name;
@property (weak) IBOutlet HuesColorWell *colorWell;

@end
