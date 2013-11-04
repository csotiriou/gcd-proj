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
- (void)exportToFile:(NSString *)filePath;
@end
