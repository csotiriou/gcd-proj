//
//  DNALattice1d.m
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 31/10/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import "DNALattice1d.h"

@interface DNALattice1d ()
@property (nonatomic) char *cube3D;
@end

@implementation DNALattice1d

- (id)initWithSideNumber:(int)sideNumber andChar:(char)c
{
	if (self = [super init]) {
		_sideNumber = sideNumber;
		_numberOfElements = sideNumber * sideNumber * sideNumber;
		[self initWithSize:sideNumber andChar:c];
	}
	return self;
}

- (void)initWithSize:(int)size andChar:(char)c
{
	_cube3D = (char*)malloc(size * size * size);
	memset(_cube3D, c, size * size * size);
}

- (void)copyData:(const char *)dataToCopy ofSize:(int)size
{
	memcpy(_cube3D, dataToCopy, size);
}

- (void)destroy
{
	if (_cube3D != NULL) {
		free(_cube3D);
		_cube3D = NULL;
	}
}

- (id)copyWithZone:(NSZone *)zone
{
	DNALattice1d *result = [[DNALattice1d alloc] initWithSideNumber:_sideNumber andChar:'0'];
	[result copyData:_cube3D ofSize:_sideNumber];
	return result;
}


- (char)getItemAti:(int)i andJ:(int)j andK:(int)k
{
	int index = i * _sideNumber * _sideNumber + j * _sideNumber + k;
	return _cube3D[index];
}

- (void)setItemAti:(int)i andJ:(int)j andK:(int)k value:(char)v
{
	int index = i * _sideNumber * _sideNumber + j * _sideNumber + k;
	_cube3D[index] = v;
}

@end
