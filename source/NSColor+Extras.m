//
//  NSColor+Extras.m
//  Hues
//
//  Created by Zach Waugh on 12/21/10.
//  Copyright 2010 Giant Comet. All rights reserved.
//

#import "NSColor+Extras.h"
#import "HuesPreferences.h"

@implementation NSColor (Extras)

- (NSString *)hues_hex
{
  int red, green, blue;
  NSString *redHexValue, *greenHexValue, *blueHexValue;
	
  NSColor *color = [self hues_convertedColor];

  if (color)
  {
    red = roundf([color redComponent] * 255.0f);
    green = roundf([color greenComponent] * 255.0f);
    blue = roundf([color blueComponent] * 255.0f);
		
    redHexValue = [[NSString stringWithFormat:@"%02x", red] uppercaseString];
    greenHexValue = [[NSString stringWithFormat:@"%02x", green] uppercaseString];
    blueHexValue = [[NSString stringWithFormat:@"%02x", blue] uppercaseString];
		

    NSString *format = [HuesPreferences hexFormat];
		
    NSString *output = [format stringByReplacingOccurrencesOfString:@"{r}" withString:redHexValue];
    output = [output stringByReplacingOccurrencesOfString:@"{g}" withString:greenHexValue];
    output = [output stringByReplacingOccurrencesOfString:@"{b}" withString:blueHexValue];
    
    return output;
  }
	
  return nil;
}


- (NSString *)hues_rgb
{
	CGFloat alpha;
  int red, green, blue;
  
  NSColor *color = [self hues_convertedColor];
  
  if (color)
  {
    red = roundf([color redComponent] * 255.0f);
    green = roundf([color greenComponent] * 255.0f);
    blue = roundf([color blueComponent] * 255.0f);
		alpha = [color alphaComponent];
    
		NSString *output;
    NSString *format = (alpha < 1) ? [HuesPreferences rgbaFormat] : [HuesPreferences rgbFormat];
    
    output = [format stringByReplacingOccurrencesOfString:@"{r}" withString:[NSString stringWithFormat:@"%d", red]];
    output = [output stringByReplacingOccurrencesOfString:@"{g}" withString:[NSString stringWithFormat:@"%d", green]];
    output = [output stringByReplacingOccurrencesOfString:@"{b}" withString:[NSString stringWithFormat:@"%d", blue]];
    
		if (alpha < 1)
		{
      output = [output stringByReplacingOccurrencesOfString:@"{a}" withString:[NSString stringWithFormat:@"%.2f", alpha]];
		}

    return output;
  }
	
  return nil;
}


- (NSString *)hues_hsb
{
  int hue, saturation, brightness;
  
  NSColor *color = [self hues_convertedColor];
  
  if (color)
  {
    hue = roundf([color hueComponent] * 360.0f);
    brightness = roundf([color brightnessComponent] * 100.0f);
    saturation = roundf([color saturationComponent] * 100.0f);
    
    NSString *output;
    NSString *format = [HuesPreferences hsbFormat];
    
    output = [format stringByReplacingOccurrencesOfString:@"{h}" withString:[NSString stringWithFormat:@"%d", hue]];
    output = [output stringByReplacingOccurrencesOfString:@"{s}" withString:[NSString stringWithFormat:@"%d", saturation]];
    output = [output stringByReplacingOccurrencesOfString:@"{b}" withString:[NSString stringWithFormat:@"%d", brightness]];
    
    
    return output;
  }
  
  return nil;
}


- (NSString *)hues_hsl
{
  int hue;
  float red, green, blue, alpha, saturation, lightness, max, min, delta;
  
  NSColor *color = [self hues_convertedColor];
  
  if (color)
  {
    red = [color redComponent];
    green = [color greenComponent];
    blue = [color blueComponent];
    alpha = [color alphaComponent];
    
    max = MAX(red, MAX(green, blue));
    min = MIN(red, MIN(green, blue));
    
    hue = roundf([color hueComponent] * 360.0f);
    lightness = (max + min) / 2;
    
    if (max == min)
    {
      hue = 0;
      saturation = 0;
    }
    else
    {
      delta = max - min;
      saturation = (lightness > 0.5) ? delta / (2 - max - min) : delta / (max + min);
    }

    
    NSString *output;
    NSString *format = (alpha < 1) ? [HuesPreferences hslaFormat] : [HuesPreferences hslFormat];
    
    output = [format stringByReplacingOccurrencesOfString:@"{h}" withString:[NSString stringWithFormat:@"%d", hue]];
    output = [output stringByReplacingOccurrencesOfString:@"{s}" withString:[NSString stringWithFormat:@"%d", (int)roundf(saturation * 100.0f)]];
    output = [output stringByReplacingOccurrencesOfString:@"{l}" withString:[NSString stringWithFormat:@"%d", (int)roundf(lightness * 100.0f)]];
    
    if (alpha < 1)
		{
      output = [output stringByReplacingOccurrencesOfString:@"{a}" withString:[NSString stringWithFormat:@"%.2f", alpha]];
		}
    
    return output;
  }
  
  return nil;
}



- (NSColor *)hues_convertedColor
{
  NSColor *color;
  
  if ([self colorSpaceName] != NSCalibratedRGBColorSpace && [self colorSpaceName] != NSDeviceRGBColorSpace)
  {
    color = [self colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
  }
  else
  {
    color = self;
  }
  
  return color;
}

@end
