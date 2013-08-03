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
#import "HuesColor.h"
#import "HuesColor+Formatting.h"

@interface HuesLoupeView ()
{
	CGImageRef _image;
}

@property (assign, nonatomic) BOOL showGridLines;

@end

@implementation HuesLoupeView

- (void)dealloc
{
  if (_image) {
		CGImageRelease(_image);
	}
}

- (id)initWithFrame:(NSRect)frameRect
{
	self = [super initWithFrame:frameRect];
	if (!self) return nil;
	
	_image = NULL;
	_loupeSize = [self.class defaultLoupeSize];
	_zoomLevel = [self.class defaultZoomLevel];
	_showGridLines = YES;
	
	return self;
}

- (void)setShowGridLines:(BOOL)showGridLines
{
	_showGridLines = showGridLines;
	[self setNeedsDisplay:YES];
}

- (void)setZoomLevel:(NSInteger)zoomLevel
{
	if (zoomLevel < 2) zoomLevel = 2;
	
	_zoomLevel = zoomLevel;
	[self setNeedsDisplay:YES];
}

- (void)zoomIn
{
	self.zoomLevel += 1;
}

- (void)zoomOut
{
	self.zoomLevel -= 1;
}

- (void)resetZoom
{
	self.zoomLevel = [self.class defaultZoomLevel];
}

#pragma mark - Drawing

- (void)drawRect:(NSRect)dirtyRect
{
	[self grabScreenshot];
	
  NSRect b = self.bounds;
	CGContextRef ctx = [NSGraphicsContext currentContext].graphicsPort;
	
	CGFloat scaleFactor = self.window.backingScaleFactor;
	NSInteger zoomLevel = self.zoomLevel;
	NSInteger loupeSize = self.loupeSize;

	// Main loupe path
  NSBezierPath *loupePath = [NSBezierPath bezierPathWithOvalInRect:b];
	
  CGFloat offset = (((zoomLevel * loupeSize) - loupeSize) / 2);
  
	// Draw scaled screenshot clipped to loupe path
  CGContextSaveGState(ctx);
  
	// Clip to circle
	[loupePath addClip];

	// Set interpolation to none so pixels are crisp when scaled up
  CGContextSetInterpolationQuality(ctx, kCGInterpolationNone);
	
	// Translate and scale context so image is drawn correctly
  CGContextTranslateCTM(ctx, -offset, -offset);
  CGContextScaleCTM(ctx, zoomLevel, zoomLevel);
	
	// Draw screenshot into context
  CGContextDrawImage(ctx, b, _image);
  CGContextRestoreGState(ctx);
  
	CGFloat gridSize = zoomLevel / scaleFactor;

	//NSLog(@"zoom level: %ld, size: %@, grid size: %f,", self.zoomLevel, NSStringFromSize(b.size), gridSize);
	
	// Draw grid on top of screenshot
	if (self.showGridLines) {
		[[NSColor colorWithDeviceWhite:0.0 alpha:0.1] set];
		
		// Clip to loupe path and disable anti-aliasing for lines
		CGContextSaveGState(ctx);
		
		[loupePath addClip];
		CGContextSetAllowsAntialiasing(ctx, NO);
		
		int y = 0;
		int x = 0;
				
		// Draw vertical lines
		for (x = 0; x <= NSWidth(b); x += gridSize) {
			NSRect rect = NSIntegralRect(NSMakeRect(x, y, 1.0, NSHeight(b)));
			NSRectFillUsingOperation(rect, NSCompositeSourceOver);
		}
		
		x = 0;
		
		// Draw horizontal lines
		for (y = 0; y <= NSHeight(b); y += gridSize) {
			NSRect rect = NSMakeRect(x, y, NSWidth(b), 1.0);
			NSRectFillUsingOperation(rect, NSCompositeSourceOver);
		}
		
		CGContextRestoreGState(ctx);
	}
		
	// Turn off anti-aliasing so lines are crisp
	CGContextSetAllowsAntialiasing(ctx, NO);
	
	HuesColor *color = [self colorAtCenter];

	// Figure out whether primary pixel is dark or light and change outline
	if ([color isDark]) {
		[[NSColor whiteColor] set];
	} else {
		[[NSColor blackColor] set];
	}
	
	// Square around center pixel that will be used for picking
	NSRect centerRect = NSMakeRect(NSMidX(b) - (gridSize / 2), NSMidY(b)  - (gridSize / 2), gridSize, gridSize);
	[[NSBezierPath bezierPathWithRect:centerRect] stroke];

	// Need to turn this back on
	CGContextSetAllowsAntialiasing(ctx, YES);
	
	static NSDictionary *attrs = nil;
	if (!attrs) {
		NSShadow *shadow = [[NSShadow alloc] init];
		shadow.shadowColor = [NSColor blackColor];
		shadow.shadowOffset = NSMakeSize(0, -1);
		attrs = @{ NSFontAttributeName: [NSFont fontWithName:@"HelveticaNeue-Bold" size:12.0], NSForegroundColorAttributeName: [NSColor whiteColor], NSShadowAttributeName: shadow };
	}

	NSAttributedString *hex = [[NSAttributedString alloc] initWithString:[color hex] attributes:attrs];
	NSSize textSize = hex.size;
	CGFloat width = textSize.width + 10;
	NSRect hexRect = NSMakeRect(round((self.bounds.size.width - width) / 2), 10, width, textSize.height);
	[[NSColor colorWithCalibratedWhite:0.0 alpha:0.8] set];
	[[NSBezierPath bezierPathWithRoundedRect:hexRect xRadius:4 yRadius:4] fill];
	NSRect hexTextRect = NSInsetRect(hexRect, 5, 0);
	hexTextRect.origin.y += 3;
	[hex drawInRect:hexTextRect];
}

- (void)grabScreenshot
{
	// Grab screenshot from underneath the window
  NSWindow *window = self.window;
	NSScreen *screen = [NSScreen screens][0];
  
  // Convert rect to screen coordinates
  NSRect rect = window.frame;
  rect.origin.y = NSMaxY(screen.frame) - NSMaxY(rect);
  
	// Release old image
	if (_image) {
		CGImageRelease(_image);
	}
  
	// TODO: limit to minimum area we need
	// Actual image of screen
  _image = CGWindowListCreateImage(rect, kCGWindowListOptionOnScreenBelowWindow, (unsigned int)window.windowNumber, kCGWindowImageDefault);
}

- (void)pickColor
{
	// Always pick color from center of loupe
	HuesColor *color = [self colorAtCenter];
  
	[[NSNotificationCenter defaultCenter] postNotificationName:HuesUpdateColorNotification object:color];
	[(HuesLoupeWindow *)self.window hide];
}

- (HuesColor *)colorAtCenter
{
	NSInteger loupeSize = self.loupeSize;
	return [self colorAtPoint:NSMakePoint(loupeSize / 2, loupeSize / 2)];
}

- (HuesColor *)colorAtPoint:(CGPoint)point
{
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
  CGContextRef context = CGBitmapContextCreate(pixelData, 1, 1, bitsPerComponent, bytesPerRow, CGImageGetColorSpace(_image), kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
  CGContextSetBlendMode(context, kCGBlendModeCopy);
  
  // Draw the pixel we are interested in onto the bitmap context
  CGContextTranslateCTM(context, -pointX, -pointY);
  CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), _image);
  CGContextRelease(context);
  
  // Convert color values [0..255] to floats [0.0..1.0]
	CGFloat red = pixelData[0] / 255.0f;
	CGFloat green = pixelData[1] / 255.0f;
	CGFloat blue = pixelData[2] / 255.0f;
	CGFloat alpha = pixelData[3] / 255.0f;

	return [HuesColor colorWithRed:red green:green blue:blue alpha:alpha];
}

#pragma mark - Key events

- (void)keyDown:(NSEvent *)event
{
	unichar character = [event.characters characterAtIndex:0];
	
	if (character == NSCarriageReturnCharacter || character == NSEnterCharacter || [event.characters isEqualToString:@" "]) {
		[self pickColor];
	} else if ([event.characters isEqualToString:@"g"]) {
		self.showGridLines = !self.showGridLines;
	} else if ([event.characters isEqualToString:@"+"] || [event.characters isEqualToString:@"="]) {
		[self zoomIn];
	} else if ([event.characters isEqualToString:@"-"] || [event.characters isEqualToString:@"_"]) {
		[self zoomOut];
	} else if ([event.characters isEqualToString:@"0"]) {
		[self resetZoom];
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

#pragma mark - Constants

+ (NSInteger)defaultZoomLevel
{
	return 13;
}

+ (NSInteger)defaultLoupeSize
{
	return 247;
}

@end
