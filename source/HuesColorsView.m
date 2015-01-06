//
//  HuesColorsView.m
//  Hues
//
//  Copyright (c) 2014 Zach Waugh
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "HuesColorsView.h"

#define BACKGROUND_GRAY_VALUE 220
#define BORDER_GRAY_VALUE 202
#define BORDER_INSET 20
#define TOP_SEPARATOR_OFFSET 130
#define BOTTOM_SEPARATOR_OFFSET 68

@implementation HuesColorsView

- (void)drawRect:(NSRect)dirtyRect {
    NSColor *backgroundColor = [NSColor colorWithWhite:BACKGROUND_GRAY_VALUE / 255.0 alpha:1.0];
    [backgroundColor set];
    NSRectFill(self.bounds);
    
    [[NSColor colorWithWhite:BORDER_GRAY_VALUE / 255.0 alpha:1.0] set];
    // Top border
    NSRectFill(NSMakeRect(0, self.bounds.size.height - 1, self.bounds.size.width, 1));
    
    // Separator lines - this is a crappy way to do this, but currently the view doesn't resize vertically
    NSRectFill(NSMakeRect(BORDER_INSET, TOP_SEPARATOR_OFFSET, self.bounds.size.width - (BORDER_INSET * 2), 1));
    NSRectFill(NSMakeRect(BORDER_INSET, BOTTOM_SEPARATOR_OFFSET, self.bounds.size.width - (BORDER_INSET * 2), 1));
}

@end
