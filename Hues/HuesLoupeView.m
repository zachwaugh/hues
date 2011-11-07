//
//  LoupeView.m
//  Loupe
//
//  Created by Zach Waugh on 11/4/11.
//  Copyright (c) 2011 Figure 53. All rights reserved.
//

#import "HuesLoupeView.h"
#import "HuesGlobal.h"
#import "NSColor+Extras.h"

#define ZOOM_LEVEL 12.0
#define LOUPE_SIZE 201

@implementation HuesLoupeView

- (void)dealloc
{
  if (_image) CGImageRelease(_image);
  
  [super dealloc];
}


- (void)drawRect:(NSRect)dirtyRect
{
  NSRect b = [self bounds];  
  NSWindow *window = [self window];
  
  // Convert rect to screen coordinates
  NSRect rect = [window frame];
  rect.origin.y = NSMaxY([[[NSScreen screens] objectAtIndex:0] frame]) - NSMaxY(rect);
  
  //NSLog(@"rect: %@", NSStringFromRect(rect));
  
  NSBezierPath *loupe = [NSBezierPath bezierPathWithRoundedRect:NSInsetRect([self bounds], 2, 2) xRadius:(LOUPE_SIZE / 2) yRadius:(LOUPE_SIZE / 2)];

  CGImageRelease(_image);
  _image = CGWindowListCreateImage(rect, kCGWindowListOptionOnScreenBelowWindow, (unsigned int)[window windowNumber], kCGWindowImageDefault);
	CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
  
  float offset = ((ZOOM_LEVEL * LOUPE_SIZE) - LOUPE_SIZE) / 2;
  
  CGContextSaveGState(ctx);
  [loupe addClip];
  CGContextSetInterpolationQuality(ctx, kCGInterpolationNone);
  CGContextSetRGBFillColor(ctx, 255, 0, 0, 1);
  CGContextFillRect(ctx, [self bounds]);
  CGContextTranslateCTM(ctx, -offset, -offset);
  CGContextScaleCTM(ctx, ZOOM_LEVEL, ZOOM_LEVEL);
  //CGContextSetAlpha(ctx, 0.75);
  //CGContextDrawImage(ctx, CGRectMake(0, 0, LOUPE_SIZE * ZOOM_LEVEL, LOUPE_SIZE * ZOOM_LEVEL), screenShot);
  CGContextDrawImage(ctx, [self bounds], _image);
  CGContextRestoreGState(ctx);
  
  [[NSColor blackColor] set];
  
  float radius = LOUPE_SIZE / 2.0;
  
  // horizontal - beginning to middle
  NSRectFill(NSMakeRect(0, NSMidY(b) - 0.5, round(radius - (ZOOM_LEVEL / 2)), 1.0));
  
  // horizontal - middle to end
  NSRectFill(NSMakeRect(round(radius + (ZOOM_LEVEL / 2)), NSMidY(b) - 0.5, round(radius - (ZOOM_LEVEL / 2)), 1.0));
  
  // Vertical - bottom to middle
  NSRectFill(NSMakeRect(NSMidX(b) - 0.5, 0, 1.0, floor(radius - (ZOOM_LEVEL / 2))));
  
  // Vertical - middle to end
  NSRectFill(NSMakeRect(NSMidX(b) - 0.5, radius + (ZOOM_LEVEL / 2), 1.0, ceil(radius - (ZOOM_LEVEL / 2))));
  
  //[NSBezierPath setDefaultLineWidth:1.0];
  //[[NSBezierPath bezierPathWithRect:NSMakeRect(NSMidX(b) - (ZOOM_LEVEL / 2), NSMidY(b) - (ZOOM_LEVEL / 2), ZOOM_LEVEL, ZOOM_LEVEL)] stroke];
  
  [loupe setLineWidth:4];
  [loupe stroke];
}


- (void)mouseDown:(NSEvent *)theEvent
{
  NSColor *color = [self colorAtPoint:NSMakePoint(LOUPE_SIZE / 2, LOUPE_SIZE / 2)];
  
  [[NSNotificationCenter defaultCenter] postNotificationName:HuesUpdateColorNotification object:color];
  NSLog(@"color: %@", [color hues_hex]);
  
  [[self window] orderOut:nil];
  [NSCursor unhide];
}


- (NSColor *)colorAtPoint:(CGPoint)point
{  
  // Create a 1x1 pixel byte array and bitmap context to draw the pixel into.
  // Reference: http://stackoverflow.com/questions/1042830/retrieving-a-pixel-alpha-value-for-a-uiimage
  NSInteger pointX = trunc(point.x);
  NSInteger pointY = trunc(point.y);
  NSUInteger width = CGImageGetWidth(_image);
  NSUInteger height = CGImageGetHeight(_image);
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  int bytesPerPixel = 4;
  int bytesPerRow = bytesPerPixel * 1;
  NSUInteger bitsPerComponent = 8;
  unsigned char pixelData[4] = { 0, 0, 0, 0 };
  CGContextRef context = CGBitmapContextCreate(pixelData, 1, 1, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
  CGColorSpaceRelease(colorSpace);
  CGContextSetBlendMode(context, kCGBlendModeCopy);
  
  // Draw the pixel we are interested in onto the bitmap context
  CGContextTranslateCTM(context, -pointX, -pointY);
  CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), _image);
  CGContextRelease(context);
  
  // Convert color values [0..255] to floats [0.0..1.0]
  CGFloat red   = (CGFloat)pixelData[0] / 255.0f;
  CGFloat green = (CGFloat)pixelData[1] / 255.0f;
  CGFloat blue  = (CGFloat)pixelData[2] / 255.0f;
  CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
  return [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
}


@end
