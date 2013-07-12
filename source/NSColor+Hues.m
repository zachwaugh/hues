//
//  NSColor+Extras.m
//  Hues
//
//  Created by Zach Waugh on 12/21/10.
//  Copyright 2010 Giant Comet. All rights reserved.
//

#import "NSColor+Hues.h"
#import "HuesPreferences.h"

struct HuesColorHSL {
  CGFloat hue;
	CGFloat saturation;
	CGFloat lightness;
};

static NSString * const HuesNSColorCalibratedRGBFormat = @"[NSColor colorWithCalibratedRed:%0.3f green:%0.3f blue:%0.3f alpha:%0.3f]";
static NSString * const HuesNSColorCalibratedHSBFormat = @"[NSColor colorWithCalibratedHue:%0.3f saturation:%0.3f brightness:%0.3f alpha:%0.3f]";
static NSString * const HuesNSColorDeviceRGBFormat = @"[NSColor colorWithDeviceRed:%0.3f green:%0.3f blue:%0.3f alpha:%0.3f]";
static NSString * const HuesNSColorDeviceHSBFormat = @"[NSColor colorWithDeviceHue:%0.3f saturation:%0.3f brightness:%0.3f alpha:%0.3f]";
static NSString * const HuesUIColorRGBFormat = @"[UIColor colorWithRed:%0.3f green:%0.3f blue:%0.3f alpha:%0.3f]";
static NSString * const HuesUIColorHSBFormat = @"[UIColor colorWithHue:%0.3f saturation:%0.3f brightness:%0.3f alpha:%0.3f]";

@implementation NSColor (Hues)

#pragma mark - Components

- (int)hues_red
{
	return roundf(self.hues_convertedColor.redComponent * 255.0f);
}

- (int)hues_green
{
	return roundf(self.hues_convertedColor.greenComponent * 255.0f);
}

- (int)hues_blue
{
	return roundf(self.hues_convertedColor.blueComponent * 255.0f);
}

- (int)hues_hue
{
	return roundf(self.hues_convertedColor.hueComponent * 360.0f);
}

- (int)hues_saturation
{
	return roundf(self.hues_convertedColor.saturationComponent * 100.0f);
}

- (int)hues_brightness
{
	return roundf(self.hues_convertedColor.brightnessComponent * 100.0f);
}

- (CGFloat)hues_lightnessComponent
{
	NSColor *color = self.hues_convertedColor;
	int hue;
	CGFloat red, green, blue, alpha, saturation, lightness, max, min, delta;

	red = color.redComponent;
	green = color.greenComponent;
	blue = color.blueComponent;
	alpha = color.alphaComponent;
	
	max = MAX(red, MAX(green, blue));
	min = MIN(red, MIN(green, blue));
	hue = roundf(color.hueComponent * 360.0f);
	hue = (hue >= 360) ? 0 : hue;
	
	lightness = (max + min) / 2;
	
	if (max == min) {
		hue = 0;
		saturation = 0;
	} else {
		delta = max - min;
		saturation = (lightness > 0.5) ? delta / (2 - max - min) : delta / (max + min);
	}
	
	return lightness;
}

- (int)hues_lightness
{
	return (int)roundf(self.hues_lightnessComponent * 100.0f);
}

- (NSString *)hues_hslWithFormat:(NSString *)format
{
  int hue;
  CGFloat red, green, blue, alpha, saturation, lightness, max, min, delta;
  
  NSColor *color = [self hues_convertedColor];
  
  if (color) {
		red = color.redComponent;
    green = color.greenComponent;
    blue = color.blueComponent;
    alpha = color.alphaComponent;
		
    max = MAX(red, MAX(green, blue));
    min = MIN(red, MIN(green, blue));
    
    hue = roundf(color.hueComponent * 360.0f);
    hue = (hue >= 360) ? 0 : hue;
    
    lightness = (max + min) / 2;
    
    if (max == min) {
      hue = 0;
      saturation = 0;
    } else {
      delta = max - min;
      saturation = (lightness > 0.5) ? delta / (2 - max - min) : delta / (max + min);
    }
    
    NSString *output;
    output = [format stringByReplacingOccurrencesOfString:@"{h}" withString:[NSString stringWithFormat:@"%d", hue]];
    output = [output stringByReplacingOccurrencesOfString:@"{s}" withString:[NSString stringWithFormat:@"%d", (int)roundf(saturation * 100.0f)]];
    output = [output stringByReplacingOccurrencesOfString:@"{l}" withString:[NSString stringWithFormat:@"%d", (int)roundf(lightness * 100.0f)]];
    
    return output;
  }
  
  return nil;
}

- (NSColor *)hues_convertedColor
{
  NSColor *color;
  
	// If not in calibrated or device color space, make calibrated
  if (self.colorSpaceName != NSCalibratedRGBColorSpace && self.colorSpaceName != NSDeviceRGBColorSpace) {
    color = [self colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
  } else {
    color = self;
  }
  
  return color;
}

- (BOOL)hues_isColorDark
{
	return [self hues_relativeBrightness] < 130;
}

// From: http://www.nbdtech.com/Blog/archive/2008/04/27/Calculating-the-Perceived-Brightness-of-a-Color.aspx
- (NSInteger)hues_relativeBrightness
{
	NSColor *color = [self hues_convertedColor];
	
	return sqrt((.241 * pow(color.hues_red, 2)) + (.691 * pow(color.hues_green, 2)) + (.068 * pow(color.hues_blue, 2)));
}

@end
