//
//  main.m
//  LatticeCreator
//
//  Created by Christos Sotiriou on 3/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSMatrixFramework.h"

int main(int argc, const char * argv[])
{

	@autoreleasepool {
		DNALattice1d *lattice = [[DNALattice1d alloc] initWithSideNumber:1000 andChar:'a'];
		DNALattice1d *lattice2 = [lattice copy];
		
		CSMatrixExporter *exporter = [[CSMatrixExporter alloc] initWithLattice:lattice];
		[exporter exportToFile:[@"~/Desktop/output.desc" stringByStandardizingPath]];
	    
	}
    return 0;
}

