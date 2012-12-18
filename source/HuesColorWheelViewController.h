//
//  HuesColorWheelViewController.h
//  Hues
//
//  Created by Zach Waugh on 12/17/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import "HuesMixerViewController.h"
#import "HuesColorWheelHueView.h"
#import "HuesColorWheelView.h"

@interface HuesColorWheelViewController : HuesMixerViewController <HuesColorWheelViewDelegate, HuesColorWheelHueViewDelegate>

@property (weak) IBOutlet HuesColorWheelView *colorWheelView;
@property (weak) IBOutlet HuesColorWheelHueView	*hueView;

@end
