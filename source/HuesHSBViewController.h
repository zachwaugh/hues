//
//  HuesHSBViewController.h
//  Hues
//
//  Created by Zach Waugh on 12/17/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HuesMixerViewController.h"

@class HuesColorSlider, HuesHueColorSlider;

@interface HuesHSBViewController : HuesMixerViewController <NSTextFieldDelegate>

@property (weak) IBOutlet NSTextField *hueField;
@property (weak) IBOutlet NSTextField *saturationField;
@property (weak) IBOutlet NSTextField *brightnessField;
@property (weak) IBOutlet NSTextField *alphaField;
@property (weak) IBOutlet HuesHueColorSlider *hueSlider;
@property (weak) IBOutlet HuesColorSlider *saturationSlider;
@property (weak) IBOutlet HuesColorSlider *brightnessSlider;
@property (weak) IBOutlet HuesColorSlider *alphaSlider;

- (IBAction)sliderChanged:(id)sender;
- (IBAction)fieldChanged:(id)sender;

@end
