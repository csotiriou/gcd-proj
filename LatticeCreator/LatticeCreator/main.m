//
//  main.m
//  LatticeCreator
//
//  Created by Christos Sotiriou on 3/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSMatrixFramework.h"
#import "RRPermutation.h"



void produceWords()
{
	NSString *fileDescriptor = [@"~/Desktop/output.desc" stringByStandardizingPath];
	
	CSMatrixImporter *importer = [[CSMatrixImporter alloc] init];
	__block DNALattice1d *lat = [[DNALattice1d alloc] initWithSideNumber:10 andChar:'a'];
	
	
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


void produceRandomCube(int side, char defaultChar){
	DNALattice1d *lattice = [[DNALattice1d alloc] initWithSideNumber:side andChar:defaultChar];
	int acceptableCharacterCount = (int)kWordListAcceptableCharacters.length;
	
	for (int i=0; i<lattice.sideNumber; i++) {
		for (int j=0; j<lattice.sideNumber; j++) {
			for (int k=0; k<lattice.sideNumber; k++) {
				int characterIndex = arc4random() % (acceptableCharacterCount-1);
//				NSLog(@"character at d:%i,%i,%i char index %i is: %c",i,j,j, characterIndex, [kWordListAcceptableCharacters characterAtIndex:characterIndex]);
				[lattice setItemAti:i andJ:j andK:k value:[kWordListAcceptableCharacters characterAtIndex:characterIndex]];
			}
		}
	}
	
	CSMatrixExporter *exporter = [[CSMatrixExporter alloc] initWithLattice:lattice];
	[exporter exportToFile:@"/Users/soulstorm/Desktop/randomCube.spec"];
}



void createPermutations(int targetWordCount, int letterCount){
	CSWordList *wordList = [[CSWordList alloc] init];
	
	RRPermutation *permutation = [[RRPermutation alloc] initWithSize:letterCount];
	int currentCount = 0;
	for (id indices in permutation) {
		currentCount++;
		if (currentCount > targetWordCount) {
			NSLog(@"reached limit. exiting...");
			break;
		}
		NSMutableString *str = [[NSMutableString alloc] init];
		for (id i in indices){
			[str appendString:[@"abcdefghijklmnopqrstuvwxyz" substringWithRange:NSMakeRange([i unsignedIntegerValue], 1)]];
		}
		NSLog(@"%@", str);
		[wordList addWord:str];
	}
	
	[wordList extractListToFileAtPath:@"/Users/soulstorm/Desktop/result.wdl"];
}


int main(int argc, const char * argv[])
{

	@autoreleasepool {
		createPermutations(1000, 10);
		
	}
    return 0;
}

