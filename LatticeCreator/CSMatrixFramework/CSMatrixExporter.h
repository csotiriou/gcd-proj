//
//  CSMatrixExporter.h
//  LatticeCreator
//
//  Created by Christos Sotiriou on 3/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LatticeCommon.h"


/**
 Class for exporting a lattice into a format that is easily readable. This format is of the type
 "x,y,z=<char>", and it is meant to be read line by line
 */
@interface CSMatrixExporter : NSObject

@property (nonatomic, strong) id<LatticeCommon> lattice;

- (id)initWithLattice:(id<LatticeCommon>)lat;

/**
 Exports the current lattice to a file indicated by the filepath. Also, set the default character to be
 that of the argument. This does not change anything when the file is loaded, unless the user decides to delete
 some lines from the file. The lines that are missing will be replaced by the 'defaultCharacter' instead
 @param filePath the path to the output file
 @param defaultCharacter a character to fill the empty lattice spaces, if the user decides to delete some data from the resulting file before loading it again.
 */
- (void)exportToFile:(NSString *)filePath withDefaultCharacter:(char)defaultCharacter;


/**
 Exports the current lattice to a file indicated by the filepath. Also, set the default character to be
 '0'. This does not change anything when the file is loaded, unless the user decides to delete
 some lines from the file. The lines that are missing will be replaced by the 'defaultCharacter' instead.
 @param filePath the path to the output file
 @param defaultCharacter a character to fill the empty lattice spaces, if the user decides to delete some data from the resulting file before loading it again.
 */
- (void)exportToFile:(NSString *)filePath;
@end
