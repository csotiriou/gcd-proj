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
		NSString *fileDescriptor = [@"~/Desktop/output.desc" stringByStandardizingPath];
		
//		DNALattice1d *lattice = [[DNALattice1d alloc] initWithSideNumber:100 andChar:'a'];
//		DNALattice1d *lattice2 = [lattice copy];
		
//		CSMatrixExporter *exporter = [[CSMatrixExporter alloc] initWithLattice:lattice];
//		[exporter exportToFile:[@"~/Desktop/output.desc" stringByStandardizingPath]];
		
//		NSString *line = @"d:123,321,10=a";
//		NSScanner *scanner = [NSScanner scannerWithString:line];
//		scanner.scanLocation = 2;
//		int test = 0;
//		int test2 = 0;
//		int test3 = 0;
//		
//		char character = [line characterAtIndex:line.length-1];
//		
//		[scanner scanInt:&test];
//		scanner.scanLocation ++;
//		[scanner scanInt:&test2];
//		scanner.scanLocation ++;
//		[scanner scanInt:&test3];
//		scanner.scanLocation++;
////		[scanner scanInt:&character];
//		
//	    
//		NSLog(@"test: %i", test);
//		NSLog(@"test: %i", test2);
//		NSLog(@"test: %i", test3);
//		NSLog(@"char: %c", character);
		
		CSMatrixImporter *importer = [[CSMatrixImporter alloc] init];
		[importer loadLatticeAtLocation:fileDescriptor completionBlock:^(DNALattice1d *lattice) {
			NSLog(@"completed.");
		}];
		
	}
    return 0;
}

