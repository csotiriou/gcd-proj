//
//  LatticeCommon.h
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 31/10/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 Class descriptor for Lattice objects
 */
@protocol LatticeCommon <NSObject>

@required

/**
 The number of the elements at each size of the lattice. in an NxNxN lattice,
 this will be 'N'
 */
@property (nonatomic, readonly) int sideNumber;

/**
 Initialises a NxNxN lattice with sideNumber as N, and a default character to fill the lattice.
 
 @param sideNumber the number of tiles in each side
 @param c the characher to pre-fill the array
 */
- (id)initWithSideNumber:(int)sideNumber andChar:(char)c;

/**
 Gets a characher at the position defined by i, j, k
 
 @param i The lattice part, regarding the Z position in the cartesian coordinate system with X,Y,Z as axies
 @param j The lattice part, regarding the X position in the cartesian coordinate system with X,Y,Z as axies
 @param k The lattice part, regarding the Y position in the cartesian coordinate system with X,Y,Z as axies
 @return a character at the specified coordinates
 */
- (char)getItemAti:(int)i andJ:(int)j andK:(int)k;


/**
 Gets a characher at the position defined by i, j, k
 
 @param i The lattice part, regarding the Z position in the cartesian coordinate system with X,Y,Z as axies
 @param j The lattice part, regarding the X position in the cartesian coordinate system with X,Y,Z as axies
 @param k The lattice part, regarding the Y position in the cartesian coordinate system with X,Y,Z as axies
 @param v the character to put in the specified position
 */
- (void)setItemAti:(int)i andJ:(int)j andK:(int)k value:(char)v;
@end
