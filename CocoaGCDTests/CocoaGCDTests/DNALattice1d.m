//
//  DNALattice1d.m
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 31/10/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import "DNALattice1d.h"
#define CS_SKIP_BOUNDARY_CHECKS


@interface DNALattice1d ()
@property (nonatomic) char *cube3D;
@end

@implementation DNALattice1d

- (id)init
{
    self = [super init];
    if (self) {
        _isInitialized = NO;
		_cube3D = NULL;
		_sideNumber = 0;
		_numberOfElements = 0;
    }
    return self;
}

- (id)initWithSideNumber:(int)sideNumber andChar:(char)c
{
	if (self = [super init]) {
		[self initWithSize:sideNumber andChar:c];
	}
	return self;
}

- (void)initWithSize:(int)sideNumber andChar:(char)c
{
	if (sideNumber > 1000 || sideNumber < 3) {
		@throw [NSException exceptionWithName:@"Invalid Argument" reason:@"DNA Lattices must be constructed with a side number between 5 and 1000" userInfo:nil];

	}else{
		_sideNumber = sideNumber;
		_numberOfElements = sideNumber * sideNumber * sideNumber;
		_cube3D = (char*)malloc(sideNumber * sideNumber * sideNumber);
		[self fillArrayWithCharacter:c];
	}
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
	[result copyData:_cube3D ofSize:_sideNumber * _sideNumber * _sideNumber];
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

- (void)fillArrayWithCharacter:(char)character
{
	memset(_cube3D, character, self.sideNumber * self.sideNumber * self.sideNumber);
}
@end
