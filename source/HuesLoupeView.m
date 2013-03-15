//
//  LoupeView.m
//  Loupe
//
//  Created by Zach Waugh on 11/4/11.
//  Copyright (c) 2011 Figure 53. All rights reserved.
//

#import "HuesLoupeView.h"
#import "HuesLoupeWindow.h"
#import "HuesDefines.h"
#import "NSColor+Hues.h"

// Zoom level is multiplier of pixel size
#define GRID_LINES YES

@interface HuesLoupeView ()
{
	CGImageRef _image;
}

@end

@implementation HuesLoupeView

- (void)dealloc
{
  if (_image) {
		CGImageRelease(_image);
	}
}

- (void)drawRect:(NSRect)dirtyRect
{
  NSRect b = self.bounds;
	CGContextRef ctx = [NSGraphicsContext currentContext].graphicsPort;
	
	// Grab screenshot from underneath the window
  NSWindow *window = self.window;
  
  // Convert rect to screen coordinates
  NSRect rect = [window frame];
  rect.origin.y = NSMaxY([[NSScreen screens][0] frame]) - NSMaxY(rect);
  
  CGImageRelease(_image);
	
	// TODO: limit to minimum area we need
	// Actual image of screen
  _image = CGWindowListCreateImage(rect, kCGWindowListOptionOnScreenBelowWindow, (unsigned int)[window windowNumber], kCGWindowImageDefault);

	// Main loupe path
  NSBezierPath *loupePath = [NSBezierPath bezierPathWithOvalInRect:b];
	
  float offset = ((HuesLoupeZoom * HuesLoupeSize) - HuesLoupeSize) / 2;
  
	// Draw scaled screenshot clipped to loupe path
  CGContextSaveGState(ctx);
  [loupePath addClip];

	// Set interpolation to none so pixels are crisp when scaled up
  CGContextSetInterpolationQuality(ctx, kCGInterpolationNone);
	
	// Translate and scale context so image is drawn correctly
  CGContextTranslateCTM(ctx, -offset, -offset);
  CGContextScaleCTM(ctx, HuesLoupeZoom, HuesLoupeZoom);
	
	// Draw screenshot into context
  CGContextDrawImage(ctx, b, _image);
  CGContextRestoreGState(ctx);
  
	// Draw grid on top of screenshot
	if (GRID_LINES) {
		[[NSColor colorWithDeviceWhite:0.0 alpha:0.15] set];
		
		// Clip to loupe path and disable anti-aliasing for lines
		CGContextSaveGState(ctx);
		
		[loupePath addClip];
		CGContextSetAllowsAntialiasing(ctx, NO);
		
		int y = 0;
		int x = 0;
		
		// Draw vertical lines
		for (x = 0; x <= NSWidth(b); x += HuesLoupeZoom) {
			NSRect rect = NSMakeRect(x, y, 1.0, NSHeight(b));
			NSRectFillUsingOperation(rect, NSCompositeSourceOver);
		}
		
		x = 0;
		
		// Draw horizontal lines
		for (y = 0; y <= NSHeight(b); y += HuesLoupeZoom) {
			NSRect rect = NSMakeRect(x, y, NSWidth(b), 1.0);
			NSRectFillUsingOperation(rect, NSCompositeSourceOver);
		}
		
		CGContextRestoreGState(ctx);
	}
		
	// Turn off anti-aliasing so lines are crisp
	CGContextSetAllowsAntialiasing(ctx, NO);
	
	// TODO: adjust color based
	NSColor *color = [self colorAtCenter];

	if ([color hues_isColorDark]) {
		NSLog(@"color is dark: %@", color);
		[[NSColor whiteColor] set];
	} else {
		NSLog(@"color is light: %@", color);
		[[NSColor blackColor] set];
	}
	
	// Square around center pixel that will be used for picking
	//[[NSColor whiteColor] set];
	NSRect centerRect = NSMakeRect(NSMidX(b) - (HuesLoupeZoom / 2), NSMidY(b)  - (HuesLoupeZoom / 2), HuesLoupeZoom, HuesLoupeZoom);
	[[NSBezierPath bezierPathWithRect:centerRect] stroke];

	// Need to turn this back on
	CGContextSetAllowsAntialiasing(ctx, YES);
	
	// Border of loupe
	//[[NSColor darkGrayColor] set];
	//[[NSBezierPath bezierPathWithOvalInRect:NSInsetRect(b, 0.5, 0.5)] stroke];
}

- (void)pickColor
{
	// Always pick color from center of loupe
	NSColor *color = [self colorAtCenter];
  
	[[NSNotificationCenter defaultCenter] postNotificationName:HuesUpdateColorNotification object:color];
	[(HuesLoupeWindow *)self.window hide];
}

- (NSColor *)colorAtCenter
{
	return [self colorAtPoint:NSMakePoint(HuesLoupeSize / 2, HuesLoupeSize / 2)];
}

- (NSColor *)colorAtPoint:(CGPoint)point
{
	NSColorSpace *colorSpace = [[NSColorSpace alloc] initWithCGColorSpace:CGImageGetColorSpace(_image)];
	
  // Create a 1x1 pixel byte array and bitmap context to draw the pixel into.
  // Reference: http://stackoverflow.com/questions/1042830/retrieving-a-pixel-alpha-value-for-a-uiimage
  NSInteger pointX = trunc(point.x);
  NSInteger pointY = trunc(point.y);
  NSUInteger width = CGImageGetWidth(_image);
  NSUInteger height = CGImageGetHeight(_image);
	
  int bytesPerPixel = 4;
  int bytesPerRow = bytesPerPixel * 1;
  NSUInteger bitsPerComponent = 8;
  unsigned char pixelData[4] = { 0, 0, 0, 0 };
  CGContextRef context = CGBitmapContextCreate(pixelData, 1, 1, bitsPerComponent, bytesPerRow, colorSpace.CGColorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
  //CGColorSpaceRelease(colorSpace);
  CGContextSetBlendMode(context, kCGBlendModeCopy);
  
  // Draw the pixel we are interested in onto the bitmap context
  CGContextTranslateCTM(context, -pointX, -pointY);
  CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), _image);
  CGContextRelease(context);
  
  // Convert color values [0..255] to floats [0.0..1.0]
	CGFloat rawRed = pixelData[0];
	CGFloat rawGreen = pixelData[1];
	CGFloat rawBlue = pixelData[2];
	CGFloat rawAlpha = pixelData[3];
	
  CGFloat red = rawRed / 255.0f;
  CGFloat green = rawGreen / 255.0f;
  CGFloat blue = rawBlue / 255.0f;
  CGFloat alpha = rawAlpha / 255.0f;

	NSColor *calibrated = [NSColor colorWithCalibratedRed:red green:green blue:blue alpha:alpha];
	
  return calibrated;
}

#pragma mark - Key events

- (void)keyDown:(NSEvent *)event
{
	unichar character = [event.characters characterAtIndex:0];
	
	if (character == NSCarriageReturnCharacter || character == NSEnterCharacter || [[event characters] isEqualToString:@" "]) {
		[self pickColor];
	} else {
		[super keyDown:event];
	}
}

#pragma mark - Mouse Events

- (BOOL)acceptsFirstMouse:(NSEvent *)theEvent
{
	//NSLog(@"[loupe view] acceptsFirstMouse");
	return YES;
}

- (void)mouseDown:(NSEvent *)theEvent
{
	//NSLog(@"[loupe view] mouseDown");
  [self pickColor];
}

@end
