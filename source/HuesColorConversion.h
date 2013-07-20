//
//  HuesColorConversion.h
//  Hues
//
//  Created by Zach Waugh on 7/20/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesColor.h"

HuesHSB HuesRGBToHSB(HuesRGB rgb);
HuesRGB HuesHSBToRGB(HuesHSB hsb);

HuesHSL HuesRGBToHSL(HuesRGB rgb);
HuesRGB HuesHSLToRGB(HuesHSL hsl);

HuesHSB HuesHSLToHSB(HuesHSL hsl);
HuesHSL HuesHSBToHSL(HuesHSB hsb);

CGFloat HuesHueToRGB(CGFloat p, CGFloat q, CGFloat t);