//
//  Palette.h
//  Hues
//
//  Created by Zach Waugh on 7/31/13.
//  Copyright (c) 2013 Giant Comet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Palette : NSManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *uuid;
@property (nonatomic, retain) NSManagedObject *items;

@end
