//
//  CSMatrixImporters.h
//  LatticeCreator
//
//  Created by Christos Sotiriou on 6/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DNALattice1d.h"

@interface CSMatrixImporter : NSObject
- (void)loadLatticeAtLocation:(NSString *)location completionBlock:(void (^)(DNALattice1d *lattice))completionBlock;
- (DNALattice1d *)dnaLatticeFromFileAtLocation:(NSString *)location;
@end
