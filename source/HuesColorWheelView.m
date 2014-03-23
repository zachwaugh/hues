//
//  HuesColorWheelView.m
//  Hues
//
//  Created by Zach Waugh on 12/17/12.
//  Copyright (c) 2012 Giant Comet. All rights reserved.
//

#import "HuesColorWheelView.h"
#import "HuesColorParser.h"
#import "HuesColorConversion.h"
#import "HuesColor.h"

#define CIRCLE_RADIUS 2
#define COMPONENTS_PER_PIXEL 4
#define BITS_PER_COMPONENT 8

@interface HuesColorWheelView ()

@property (strong) NSImage *image;

@end

@implementation HuesColorWheelView

- (id)initWithFrame:(NSRect)frame
{
	self = [super initWithFrame:frame];
	if (!self) return nil;
	
	_color = [HuesColor colorWithHue:1.0 saturation:1.0 brightness:1.0 alpha:1.0];
	
	return self;
}

- (BOOL)acceptsFirstResponder
{
	return YES;
}

- (void)setColor:(HuesColor *)color
{
	_color = color;
	[self cacheBitmap];
	[self setNeedsDisplay:YES];
}

- (void)cacheBitmap
{
	CGFloat width = self.bounds.size.width;
	CGFloat height = self.bounds.size.height;
	CGFloat hue = self.color.hue;
	
	unsigned char *buffer = calloc(height * width * 4, 4);
	
	if (buffer == NULL) {
		NSLog(@"error creating buffer");
	}
	
	NSInteger x, y, pixel = 0, byte = 0;
	
	for (y = 0; y < height; y++) {
		for (x = 0; x < width; x++) {
			HuesHSB hsb = HuesHSBMake(hue, x / width, y / height);
			HuesRGB rgb = HuesHSBToRGB(hsb);
			
			pixel = (width * y) + x;
			byte = pixel * 4;
			
			buffer[byte] = rgb.red * 255;
			buffer[byte + 1] = rgb.green * 255;
			buffer[byte + 2] = rgb.blue * 255;
			buffer[byte + 3] = 255;
			
			pixel += 4;
		}
	}
	
	// Create bitmap context
	CGContextRef context = CGBitmapContextCreate(buffer, width, height, BITS_PER_COMPONENT, width * COMPONENTS_PER_PIXEL, [NSColorSpace genericRGBColorSpace].CGColorSpace, kCGImageAlphaPremultipliedLast);
	
	// Create and cache image
	CGImageRef image = CGBitmapContextCreateImage(context);
	NSBitmapImageRep *imageRep = [[NSBitmapImageRep alloc] initWithCGImage:image];
	self.image = [[NSImage alloc] initWithSize:self.bounds.size];
	[self.image setFlipped:YES];
	[self.image addRepresentation:imageRep];
	
	free(buffer);
	CGImageRelease(image);
	CGContextRelease(context);
}

- (void)drawRect:(NSRect)dirtyRect
{
	NSRect rect = self.bounds;
	[self.image drawInRect:self.bounds fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0 respectFlipped:YES hints:nil];
	
	CGFloat x = self.color.HSBSaturation * self.bounds.size.width;
	CGFloat y = self.color.brightness * self.bounds.size.height;
	
	NSRect circleRect = NSMakeRect(x - CIRCLE_RADIUS, y - CIRCLE_RADIUS, CIRCLE_RADIUS * 2, CIRCLE_RADIUS * 2);
	
	[[NSColor whiteColor] set];
	[[NSBezierPath bezierPathWithOvalInRect:circleRect] stroke];
	
	// Border
	[[NSColor colorWithCalibratedWhite:0.0 alpha:0.25] set];
	[[NSBezierPath bezierPathWithRect:NSInsetRect(rect, 0.5, 0.5)] stroke];
}

- (void)mouseDown:(NSEvent *)event
{
	NSPoint point = [self convertPoint:event.locationInWindow fromView:nil];
	[self updateColorWithPoint:point];
}

- (void)mouseDragged:(NSEvent *)event
{
	NSPoint point = [self convertPoint:event.locationInWindow fromView:nil];
	[self updateColorWithPoint:point];
}

- (BOOL)mouseDownCanMoveWindow
{
	return NO;
}

- (void)updateColorWithPoint:(NSPoint)point
{
	// Make sure point is constrained
	if (point.x < NSMinX(self.bounds)) {
		point.x = NSMinX(self.bounds);
	} else if (point.x > NSMaxX(self.bounds)) {
		point.x = NSMaxX(self.bounds);
	}
	
	if (point.y < NSMinY(self.bounds)) {
		point.y = NSMinY(self.bounds);
	} else if (point.y > NSMaxY(self.bounds)) {
		point.y = NSMaxY(self.bounds);
	}
	
	CGFloat saturation = point.x / self.bounds.size.width;
	CGFloat brightness = point.y / self.bounds.size.height;
	
	self.color = [HuesColor colorWithHue:self.color.hue saturation:saturation brightness:brightness];
	
	if (self.delegate) {
		[self.delegate colorWheelDidChangeSaturation:saturation brightness:brightness];
	}
}

@end
