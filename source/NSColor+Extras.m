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
  return [self hues_hexWithFormat:[HuesPreferences hexFormat] useLowercase:[HuesPreferences useLowercase]];
}


- (NSString *)hues_hexWithLowercase:(BOOL)lowercase
{
  return [self hues_hexWithFormat:@"#{r}{g}{b}" useLowercase:lowercase];
}


- (NSString *)hues_hexWithFormat:(NSString *)format
{
  return [self hues_hexWithFormat:format useLowercase:NO];
}


- (NSString *)hues_hexWithFormat:(NSString *)format useLowercase:(BOOL)lowercase
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
		
    NSString *output = [format stringByReplacingOccurrencesOfString:@"{r}" withString:redHexValue];
    output = [output stringByReplacingOccurrencesOfString:@"{g}" withString:greenHexValue];
    output = [output stringByReplacingOccurrencesOfString:@"{b}" withString:blueHexValue];
        
    return (lowercase) ? [output lowercaseString] : output;
  }
	
  return nil;
}


- (NSString *)hues_rgb
{
  return ([self alphaComponent] < 1) ? [self hues_rgbaWithFormat:[HuesPreferences rgbaFormat]] : [self hues_rgbWithFormat:[HuesPreferences rgbFormat]];
}


- (NSString *)hues_rgbWithDefaultFormat
{
  return ([self alphaComponent] < 1) ? [self hues_rgbaWithFormat:@"rgba({r}, {g}, {b}, {a})"] : [self hues_rgbWithFormat:@"rgb({r}, {g}, {b})"];
}


- (NSString *)hues_rgbWithFormat:(NSString *)format
{
  int red, green, blue;
  
  NSColor *color = [self hues_convertedColor];
  
  if (color)
  {
    red = roundf([color redComponent] * 255.0f);
    green = roundf([color greenComponent] * 255.0f);
    blue = roundf([color blueComponent] * 255.0f);
    
		NSString *output;    
    output = [format stringByReplacingOccurrencesOfString:@"{r}" withString:[NSString stringWithFormat:@"%d", red]];
    output = [output stringByReplacingOccurrencesOfString:@"{g}" withString:[NSString stringWithFormat:@"%d", green]];
    output = [output stringByReplacingOccurrencesOfString:@"{b}" withString:[NSString stringWithFormat:@"%d", blue]];
    
    return output;
  }
	
  return nil;
}


- (NSString *)hues_rgbaWithFormat:(NSString *)format
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
    output = [format stringByReplacingOccurrencesOfString:@"{r}" withString:[NSString stringWithFormat:@"%d", red]];
    output = [output stringByReplacingOccurrencesOfString:@"{g}" withString:[NSString stringWithFormat:@"%d", green]];
    output = [output stringByReplacingOccurrencesOfString:@"{b}" withString:[NSString stringWithFormat:@"%d", blue]];
    output = [output stringByReplacingOccurrencesOfString:@"{a}" withString:[NSString stringWithFormat:@"%.2f", alpha]];

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
  return ([self alphaComponent] < 1) ? [self hues_hslaWithFormat:[HuesPreferences hslaFormat]] : [self hues_hslWithFormat:[HuesPreferences hslFormat]];
}


- (NSString *)hues_hslWithDefaultFormat
{
  return ([self alphaComponent] < 1) ? [self hues_hslaWithFormat:@"hsla({h}, {s}%, {l}%, {a})"] : [self hues_hslWithFormat:@"hsl({h}, {s}%, {l}%)"];
}


- (NSString *)hues_hslWithFormat:(NSString *)format
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
    hue = (hue >= 360) ? 0 : hue;
    
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
    output = [format stringByReplacingOccurrencesOfString:@"{h}" withString:[NSString stringWithFormat:@"%d", hue]];
    output = [output stringByReplacingOccurrencesOfString:@"{s}" withString:[NSString stringWithFormat:@"%d", (int)roundf(saturation * 100.0f)]];
    output = [output stringByReplacingOccurrencesOfString:@"{l}" withString:[NSString stringWithFormat:@"%d", (int)roundf(lightness * 100.0f)]];
    
    return output;
  }
  
  return nil;
}


- (NSString *)hues_hslaWithFormat:(NSString *)format
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
    output = [format stringByReplacingOccurrencesOfString:@"{h}" withString:[NSString stringWithFormat:@"%d", hue]];
    output = [output stringByReplacingOccurrencesOfString:@"{s}" withString:[NSString stringWithFormat:@"%d", (int)roundf(saturation * 100.0f)]];
    output = [output stringByReplacingOccurrencesOfString:@"{l}" withString:[NSString stringWithFormat:@"%d", (int)roundf(lightness * 100.0f)]];
    output = [output stringByReplacingOccurrencesOfString:@"{a}" withString:[NSString stringWithFormat:@"%.2f", alpha]];
    
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


+ (NSColor *)hues_colorFromHex:(NSString *)hex
{
  // remove any # signs
  hex = [hex stringByReplacingOccurrencesOfString:@"#" withString:@""];
  
  if ([hex length] < 6) return nil;
  
  if ([hex length] > 6) hex = [hex substringToIndex:6];
  
	NSColor *result = nil;
	unsigned int colorCode = 0;
	unsigned char redByte, greenByte, blueByte;
	
	if (hex != nil)
	{
		NSScanner *scanner = [NSScanner scannerWithString:hex];
		(void) [scanner scanHexInt:&colorCode];	// ignore error
	}
  
	redByte		= (unsigned char) (colorCode >> 16);
	greenByte	= (unsigned char) (colorCode >> 8);
	blueByte	= (unsigned char) (colorCode);	// masks off high bits
	result = [NSColor
            colorWithCalibratedRed:(float)redByte / 0xff
            green:(float)greenByte / 0xff
            blue:(float)blueByte / 0xff
            alpha:1.0];

	return result;
}

@end
