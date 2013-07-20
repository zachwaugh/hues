//
//  HuesColorConversion.m
//  Hues
//
//  Created by Zach Waugh on 7/20/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesColorConversion.h"

// Much of this info came from: https://en.wikipedia.org/wiki/HSL_and_HSV

HuesHSB HuesRGBToHSB(HuesRGB rgb)
{
	CGFloat r = rgb.red, g = rgb.green, b = rgb.blue;
	CGFloat max = MAX(MAX(r, g), b);
	CGFloat min = MIN(MIN(r, g), b);
	CGFloat chroma = max - min;
	
	CGFloat hue;
	
	if (chroma == 0.0f) {
		hue = 0.f;
	} else if (max == r) {
		hue = fmodf(((g - b) / chroma), 6.f);
	} else if (max == g) {
		hue = ((b - r) / chroma) + 2.0f;
	} else if (max == b) {
		hue = ((r - g) / chroma) + 4.f;
	} else {
		hue = 0.f;
	}
	
	hue = (hue * 60.0f) / 360.0f;
	
	CGFloat brightness = max;
	CGFloat saturation = (chroma == 0.0f) ? 0 : chroma / brightness;
	
	return HuesHSBMake(hue, saturation, brightness);
}

HuesRGB HuesHSBToRGB(HuesHSB hsb)
{
	CGFloat chroma = hsb.brightness * hsb.saturation;
	CGFloat h = ((hsb.hue * 360.0f) / 60.0f);
	
	CGFloat x = chroma * (1 - fabsf(fmodf(h, 2) - 1));
	CGFloat r = 0.0f, g = 0.0f, b = 0.0f;
	
	if (h >= 5) {
		r = chroma;
		b = x;
	} else if (h >= 4) {
		r = x;
		b = chroma;
	} else if (h >= 3) {
		g = x;
		b = chroma;
	} else if (h >= 2) {
		g = chroma;
		b = x;
	} else if (h >= 1) {
		r = x;
		g = chroma;
	} else if (h >= 0) {
		r = chroma;
		g = x;
	}
	
	CGFloat m = hsb.brightness - chroma;
	CGFloat red = r + m;
	CGFloat green = g + m;
	CGFloat blue = b + m;
	
	return HuesRGBMake(red, green, blue);
}

HuesHSL HuesRGBToHSL(HuesRGB rgb)
{
	CGFloat r = rgb.red, g = rgb.green, b = rgb.blue;
	CGFloat max = MAX(MAX(r, g), b);
	CGFloat min = MIN(MIN(r, g), b);
	CGFloat chroma = max - min;
	
	CGFloat hue = 0.0f;
	CGFloat saturation = 0.0f;
	CGFloat lightness = (max + min) * 0.5f;
	
	if (chroma != 0) {
		// hue
		if (max == r) {
			hue = fmodf(((g - b) / chroma), 6.0f);
		} else if (max == g) {
			hue = ((b - r) / chroma) + 2.0f;
		} else if (max == b) {
			hue = ((r - g) / chroma) + 4.0f;
		}
		
		saturation = chroma / (1 - fabsf(2 * lightness - 1));
	}
	
	hue = (hue * 60.0f) / 360.0f;

	return HuesHSLMake(hue, saturation, lightness);
}

HuesRGB HuesHSLToRGB(HuesHSL hsl)
{
	CGFloat h = hsl.hue, s = hsl.saturation, l = hsl.lightness;
	CGFloat r, g, b;
	
	CGFloat v1, v2;
	
	if (s == 0) {
		// If saturation is 0, color is the same as lightness
		r = g = b = l;
	} else {
		if (l < 0.5) {
			v2 = l * (1 + s);
		} else {
			v2 = (l + s) - (s * l);
		}
		
		v1 = 2 * l - v2;
		r = HuesHueToRGB(v1, v2, h + (1 / 3.0));
		g = HuesHueToRGB(v1, v2, h);
		b = HuesHueToRGB(v1, v2, h - (1 / 3.0));
	}
	
	return HuesRGBMake(r, g, b);
}

HuesHSB HuesHSLToHSB(HuesHSL hsl)
{
	CGFloat hue = hsl.hue;
	CGFloat ll = hsl.lightness * 2;
	CGFloat ss = hsl.saturation * ((ll <= 1) ? ll : 2 - ll);
	
	CGFloat brightness = (ll + ss) / 2;
	CGFloat saturation = (2 * ss) / (ll + ss);
	
	return HuesHSBMake(hue, saturation, brightness);
}

HuesHSL HuesHSBToHSL(HuesHSB hsb)
{
	CGFloat hue = hsb.hue;
	CGFloat lightness = (2 - hsb.saturation) * hsb.brightness;
	CGFloat saturation = hsb.saturation * hsb.brightness;
	saturation /= (lightness <= 1) ? lightness : 2 - lightness;
	lightness /= 2;
	
	return HuesHSLMake(hue, saturation, lightness);
}

CGFloat HuesHueToRGB(CGFloat v1, CGFloat v2, CGFloat vh)
{
	if (vh < 0) {
		vh += 1;
	}
	
	if (vh > 1) {
		vh -= 1;
	}
	
	if ((6 * vh) < 1) {
		return (v1 + (v2 - v1) * 6 * vh);
	}
	
	if ((2 * vh) < 1) {
		return (v2);
	}
	
	if ((3 * vh) < 2) {
		return (v1 + (v2 - v1) * ((2 / 3.0 - vh) * 6));
	}
	
	return v1;
}
