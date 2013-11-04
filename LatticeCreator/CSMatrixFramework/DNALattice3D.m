//
//  DNALattice3D.m
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 31/10/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import "DNALattice3D.h"

@interface DNALattice3D ()
@property (nonatomic) void *cube3d;
@end

@implementation DNALattice3D

- (id)copyWithZone:(NSZone *)zone
{
	DNALattice3D *result = [[DNALattice3D alloc] init];
	return result;
}

- (id)initWithSideNumber:(int)sideNumber andChar:(char)c
{
	if (self = [super init]) {
		_sideNumber = sideNumber;
		_cube3d = NULL;
		[self allocateCube:sideNumber withChar:c];
	}
	return self;
}


- (void)allocateCube:(int)side withChar:(char)defaultCharacter
{
	char (*p)[side][side] = malloc(side * sizeof(*p));
	self.cube3d = p;
	
	for (int i = 0; i<side; i++) {
		for (int j=0; j<side; j++) {
			for (int k=0; k<side; k++) {
				p[i][j][k] = defaultCharacter;
			}
		}
	}
}

- (char)getItemAti:(int)i andJ:(int)j andK:(int)k
{
	char (*p)[self.sideNumber][self.sideNumber] = _cube3d;
	return p[i][j][k];
}

- (void)setItemAti:(int)i andJ:(int)j andK:(int)k value:(char)v
{
	char (*p)[self.sideNumber][self.sideNumber] = _cube3d;
	p[i][j][k] = v;
}

- (void)copyMemoryFrom:(char ***)origin to:(char***)dest
{
	//incomplete
}


- (void)deleteCubeInternals
{
	free(_cube3d);
}

- (void)dealloc
{
    [self deleteCubeInternals];
}

@end
