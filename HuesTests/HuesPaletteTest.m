//
//  HuesPaletteTest.m
//  Hues
//
//  Created by Zach Waugh on 7/24/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesPaletteTest.h"
#import "HuesPalette.h"

@implementation HuesPaletteTest

- (void)testCreation
{
	HuesPalette *palette = [[HuesPalette alloc] init];
	expect(palette).toNot.beNil();
	expect(palette.name).to.equal(@"");
	expect(palette.colors).to.haveCountOf(0);
	
	palette = [[HuesPalette alloc] initWithName:@"Foo"];
	expect(palette).toNot.beNil();
	expect(palette.name).to.equal(@"Foo");
	expect(palette.colors).to.haveCountOf(0);

	palette = [HuesPalette paletteWithName:@"Bar"];
	expect(palette).toNot.beNil();
	expect(palette.name).to.equal(@"Bar");
	expect(palette.colors).to.haveCountOf(0);
}

- (void)testAddPaletteItem
{
	HuesPalette *palette = [HuesPalette paletteWithName:@"test"];
	expect(palette.colors).to.haveCountOf(0);
	
	[palette addItem:(HuesPaletteItem *)@""];
	expect(palette.colors).to.haveCountOf(1);
	expect(palette.colors[0]).to.equal(@"");
}

- (void)testRemovePaletteItem
{
	
}

- (void)testUpdateName
{
	
}

@end
