//
//  CSMatrixImporters.h
//  LatticeCreator
//
//  Created by Christos Sotiriou on 6/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DNALattice1d.h"

/**
 CSMatrixImporter is a helper class facilitating creation of DNA lattices, by importing from .desc files.
 
 #—- ’s’ indicates the size of each side
 #   of the lattice. Do not change this value unless
 #   you really know what you are doing.
 #— ‘f’ indicates the default character. positions in
 #   the lattice that are not explicitly mentioned in
 #   this file will get this value
 #— ’d’ indicates a position in the lattice. always comes
 #   in the form ’d:<lattice>,<column>,<row>=<character>’
 #   change manually the values you need. Be careful, you
 #   must preserve proper format.
 */
@interface CSMatrixImporter : NSObject

/**
 @brief loads a .desc file containing the description of a DNA lattice. Upon completion, the completion block
 is called, along with the newly formed DNA lattice.
 
 @param location the location of the .desc file
 @param completionBlock the completion block to be called when parsing and importing ends
 */
- (void)loadLatticeAtLocation:(NSString *)location completionBlock:(void (^)(DNALattice1d *lattice))completionBlock;


/**
 @brief loads a .desc file containing the description of a DNA lattice. Upon completion, it returns a new DNA Lattice.
 
 @param location the location of the .desc file
 @return a DNALattic1D containing the data of the file loaded.
 */
- (DNALattice1d *)dnaLatticeFromFileAtLocation:(NSString *)location;
@end
