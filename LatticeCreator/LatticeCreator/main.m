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

		CSMatrixImporter *importer = [[CSMatrixImporter alloc] init];
		__block DNALattice1d *lat = [[DNALattice1d alloc] initWithSideNumber:10 andChar:'a'];
//		[importer loadLatticeAtLocation:fileDescriptor completionBlock:^(DNALattice1d *lattice) {
//			NSLog(@"completed.");
//			lat = lattice;
//		}];
		
		
		CSMatrixExporter *exporter = [[CSMatrixExporter alloc] init];
		exporter.lattice = lat;
		[exporter exportToFile:fileDescriptor withDefaultCharacter:'k'];
		
		
		CSWordList *list = [[CSWordList alloc] init];
		[list addWord:@"ok1"];
		[list addWord:@"oka"];
		[list addWord:@"ok1"];
		[list addWord:@"ok2"];
		[list addWord:@"ok2"];
		[list addWord:@"ok2"];
		[list addWord:@"ok5"];
		[list addWord:@"ok4"];
		[list addWord:@"ok3"];
		[list addWord:@"ok2"];
		[list addWord:@"ok1"];
		[list addWord:@"okw"];
		[list addWord:@"okq"];
		[list addWord:@"okj"];
		[list addWord:@"ok2"];
		[list addWord:@"oka"];
		[list addWord:@"oks"];
		[list addWord:@"okf"];
		[list addWord:@"ok9"];
		[list addWord:@"ok2"];
		[list addWord:@"098"];
		
		for (int i = 100; i<999; i++) {
			[list addWord:[NSString stringWithFormat:@"%i", i]];
		}
		
		NSMutableString *str = [NSMutableString string];
		for (NSString *str1 in list) {
			[str appendFormat:@"%@", [NSString stringWithFormat:@"%@\n", str1]];
		}
		NSLog(@"%@", str);
		
		[list extractListToFileAtPath:@"/Users/soulstorm/Desktop/words.wdl"];
		
	}
    return 0;
}

