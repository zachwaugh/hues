//
//  NSColor+Extras.m
//  Hues
//
//  Created by Zach Waugh on 12/21/10.
//  Copyright 2010 Giant Comet. All rights reserved.
//

#import "NSColor+Extras.h"


@implementation NSColor (Extras)

- (NSString *)hues_hexadecimal
{
  int redIntValue, greenIntValue, blueIntValue;
  NSString *redHexValue, *greenHexValue, *blueHexValue;
	
  //Convert the NSColor to the RGB color space before we can access its components
  NSColor *convertedColor = [self colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
	
  if (convertedColor)
  {
    // Convert the components to numbers (unsigned decimal integer) between 0 and 255
    redIntValue = [convertedColor redComponent] * 255.99999f;
    greenIntValue = [convertedColor greenComponent] * 255.99999f;
    blueIntValue = [convertedColor blueComponent] * 255.99999f;
		
    // Convert the numbers to hex strings
    redHexValue = [NSString stringWithFormat:@"%02x", redIntValue];
    greenHexValue = [NSString stringWithFormat:@"%02x", greenIntValue];
    blueHexValue = [NSString stringWithFormat:@"%02x", blueIntValue];
		
    // Concatenate the red, green, and blue components' hex strings together with a "#"
    return [NSString stringWithFormat:@"#%@%@%@", redHexValue, greenHexValue, blueHexValue];
  }
	
  return nil;
}


- (NSString *)hues_rgb
{
	CGFloat alpha; //red, green, blue, alpha;
  int red, green, blue;
	
  //Convert the NSColor to the RGB color space before we can access its components
  NSColor *convertedColor = [self colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
	
  if (convertedColor)
  {
    // Get the red, green, and blue components of the color
    //[convertedColor getRed:&redFloatValue green:&greenFloatValue blue:&blueFloatValue alpha:NULL];
		
    // Convert the components to numbers (unsigned decimal integer) between 0 and 255
    red = [convertedColor redComponent] * 255.99999f;
    green = [convertedColor greenComponent] * 255.99999f;
    blue = [convertedColor blueComponent] * 255.99999f;
		alpha = [convertedColor alphaComponent];
		
		
		NSString *value;
		
		if (alpha >= 1)
		{
			value = [NSString stringWithFormat:@"rgb(%d, %d, %d)", red, green, blue];
		}
		else
		{
			value = [NSString stringWithFormat:@"rgba(%d, %d, %d, %0.2f)", red, green, blue, alpha];
		}

		
    // Concatenate the red, green, and blue components' hex strings together with a "#"
    return value;
  }
	
  return nil;
}


@end
