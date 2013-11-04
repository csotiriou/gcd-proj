//
//  DNALattice1d.h
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 31/10/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LatticeCommon.h"



/**
 This is an implementation of a 3d-dimensional array based on
 a one-dimensional array, to facilitate efficient data copying
 */
@interface DNALattice1d : NSObject <LatticeCommon>

@property (nonatomic, readonly) int sideNumber;
@property (nonatomic, readonly) int numberOfElements;
@property (nonatomic, readonly) BOOL isInitialized;

/**
 Copies the data deom the argument to the object
 @param dataToCopy the data to copy
 @param size the size of the data to copy. Must be equal to the size of this object
 */
- (void)copyData:(const char *)dataToCopy ofSize:(int)size;


/**
 Fills the entire data with a specified character
 @param character the character to fill the internal data
 */
- (void)fillArrayWithCharacter:(char)character;


@end
