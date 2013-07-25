//
//  HuesPaletteTest.m
//  Hues
//
//  Created by Zach Waugh on 7/24/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import "HuesPaletteTest.h"
#import "HuesPalette.h"
#import "HuesPaletteItem.h"

@implementation HuesPaletteTest

- (void)testCreation
{
	HuesPalette *palette = [[HuesPalette alloc] init];
	expect(palette).toNot.beNil();
	expect(palette.name).to.equal(@"");
	expect(palette.uuid).toNot.beNil();
	
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

- (void)testCreateWithDictionary
{
	NSDictionary *dict = @{@"name": @"test palette", @"id": @"aaa-bbb-ccc", @"colors": @[ @{@"name": @"a color", @"color": @"#ffffff"}]};
	
	HuesPalette *palette = [HuesPalette paletteWithDictionary:dict];
	expect(palette).toNot.beNil();
	expect(palette.name).to.equal(@"test palette");
	expect(palette.uuid).to.equal(@"aaa-bbb-ccc");
	expect(palette.colors).to.haveCountOf(1);
	
	HuesPaletteItem *item = palette.colors[0];
	expect(item).toNot.beNil();
	expect(item).to.beKindOf([HuesPaletteItem class]);
	expect(item.name).to.equal(@"a color");
	expect(item.color).to.equal([NSColor colorWithCalibratedRed:1 green:1 blue:1 alpha:1]);
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
