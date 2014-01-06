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

@property (nonatomic, weak) IBOutlet HuesColorSlider *redSlider;
@property (nonatomic, weak) IBOutlet HuesColorSlider *greenSlider;
@property (nonatomic, weak) IBOutlet HuesColorSlider *blueSlider;
@property (nonatomic, weak) IBOutlet HuesColorSlider *alphaSlider;
@property (nonatomic, weak) IBOutlet NSTextField *redField;
@property (nonatomic, weak) IBOutlet NSTextField *greenField;
@property (nonatomic, weak) IBOutlet NSTextField *blueField;
@property (nonatomic, weak) IBOutlet NSTextField *alphaField;

- (IBAction)sliderChanged:(id)sender;
- (IBAction)fieldChanged:(id)sender;

@end
