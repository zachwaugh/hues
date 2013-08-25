//
//  HuesPaletteNameController.h
//  Hues
//
//  Created by Zach Waugh on 7/25/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef void(^HuesPaletteNameBlock)(NSString *name, BOOL complete);

@interface HuesPaletteNameController : NSWindowController <NSWindowDelegate, NSTextFieldDelegate>

@property (weak) IBOutlet NSTextField *field;
@property (strong, nonatomic) NSString *name;
@property (strong) HuesPaletteNameBlock completionBlock;
@property (assign) BOOL nameValid;

- (IBAction)ok:(id)sender;
- (IBAction)cancel:(id)sender;

@end
