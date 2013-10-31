//
//  AppDelegate.m
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 30/10/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import "AppDelegate.h"

#define SIDE 3

@interface AppDelegate()
@property (nonatomic) char * large;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
}

- (void)initWithSize:(int)size
{
	self.large = (char*)malloc(size * size * size);
	memset(self.large, 'a', size * size * size);
}

- (char)getX:(int)x andY:(int)y andZ:(int)z
{
	int index = x * SIDE * SIDE + y * SIDE + z;
	return self.large[index];
}

- (void)setX:(int)x andY:(int)y andZ:(int)z toValue:(char)v
{
	int index = x * SIDE * SIDE + y * SIDE + z;
	NSLog(@"setting index(%i,%i,%i)=%i to: %c",x,y,z, index, v);
	self.large[index] = v;
}


@end
