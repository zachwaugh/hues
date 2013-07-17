//
//  HuesHSLMixerController.h
//  Hues
//
//  Created by Zach Waugh on 7/17/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesMixerViewController.h"

@class HuesColorSlider, HuesHueColorSlider;

@interface HuesHSLMixerController : HuesMixerViewController <NSTextFieldDelegate>

@property (weak) IBOutlet NSTextField *hueField;
@property (weak) IBOutlet NSTextField *saturationField;
@property (weak) IBOutlet NSTextField *lightnessField;
@property (weak) IBOutlet NSTextField *alphaField;
@property (weak) IBOutlet HuesHueColorSlider *hueSlider;
@property (weak) IBOutlet HuesColorSlider *saturationSlider;
@property (weak) IBOutlet HuesColorSlider *lightnessSlider;
@property (weak) IBOutlet HuesColorSlider *alphaSlider;

- (IBAction)sliderChanged:(id)sender;
- (IBAction)fieldChanged:(id)sender;

@end