//
//  CSMatrixImporters.m
//  LatticeCreator
//
//  Created by Christos Sotiriou on 6/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import "CSMatrixImporter.h"
#import "CSFileReader.h"

@interface CSMatrixImporter () <CSFileReaderDelegate>
@property (nonatomic, strong) CSFileReader *reader;

@property (nonatomic, strong) DNALattice1d *resultLattice;
@end

@implementation CSMatrixImporter
- (id)init
{
    self = [super init];
    if (self) {
		self.reader = [[CSFileReader alloc] init];
		self.reader.delegate = self;
    }
    return self;
}

- (void)loadLatticeAtLocation:(NSString *)location completionBlock:(void (^)(DNALattice1d *lattice))completionBlock;
{
	[self.reader startReadingLineByLineFileAtPath:location encoding:NSUTF8StringEncoding];
	completionBlock(_resultLattice);
}

- (DNALattice1d *)dnaLatticeFromFileAtLocation:(NSString *)location
{
	[self.reader startReadingLineByLineFileAtPath:location encoding:NSUTF8StringEncoding];
	return self.resultLattice;
}


- (void)fileReader:(CSFileReader *)reader didEncounterLine:(NSString *)line
{
	if (![self string:line containsString:@"#"]) {
		if ([line characterAtIndex:0] == 's') {//we have a lattice size definition
			NSScanner *scanner = [NSScanner scannerWithString:line];
			scanner.scanLocation = 2;
			int latticeSize = 0;
			[scanner scanInt:&latticeSize];
			NSLog(@"creating lattice if size: %i", latticeSize);
			self.resultLattice = [[DNALattice1d alloc] initWithSideNumber:latticeSize andChar:'0'];
		}else if ([line characterAtIndex:0] == 'd') {//we have a line containing data
			int i=0, j=0, k=0;
			char scanCharacter = '0';
			
			NSScanner *scanner = [NSScanner scannerWithString:line];
			scanner.scanLocation = 2;
			[scanner scanInt:&i];
			scanner.scanLocation++;
			[scanner scanInt:&j];
			scanner.scanLocation++;
			[scanner scanInt:&k];
			
			scanCharacter = [line characterAtIndex:line.length-2]; //just take the character before the last (the last one is the new line). No need to press the scanner to parse an nsstring and then convert to a character.
			[self.resultLattice setItemAti:i andJ:j andK:k value:scanCharacter];
		}
	}
}


- (void)fileReaderDidEndProcessingFile:(CSFileReader *)reader
{
	
}

- (BOOL)string:(NSString *)haystack containsString:(NSString *)needle
{
	return ([haystack rangeOfString:needle].location != NSNotFound);
}
@end
