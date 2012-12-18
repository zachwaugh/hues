//
//  HuesRGBViewController.h
//  Hues
//
//  Created by Zach Waugh on 12/17/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HuesMixerViewController.h"

@class HuesColorSlider;

@interface HuesRGBViewController : HuesMixerViewController <NSTextFieldDelegate>

@property (weak) IBOutlet HuesColorSlider *redSlider;
@property (weak) IBOutlet HuesColorSlider *greenSlider;
@property (weak) IBOutlet HuesColorSlider *blueSlider;
@property (weak) IBOutlet HuesColorSlider *alphaSlider;
@property (weak) IBOutlet NSTextField *redField;
@property (weak) IBOutlet NSTextField *greenField;
@property (weak) IBOutlet NSTextField *blueField;
@property (weak) IBOutlet NSTextField *alphaField;

- (IBAction)sliderChanged:(id)sender;
- (IBAction)fieldChanged:(id)sender;

@end
