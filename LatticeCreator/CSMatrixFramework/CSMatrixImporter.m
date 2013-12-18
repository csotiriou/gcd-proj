//
//  CSMatrixImporters.m
//  LatticeCreator
//
//  Created by Christos Sotiriou on 6/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import "CSMatrixImporter.h"
#import "CSFileReader.h"

@interface CSMatrixImporter () <CSFileReaderDelegate, CSFileReaderDataSource>
@property (nonatomic, strong) CSFileReader *reader;
@property (nonatomic, strong) DNALattice1d *resultLattice;

@property (nonatomic) int numberOfVertices;
@property (nonatomic) char defaultChar;
@end

@implementation CSMatrixImporter
- (id)init
{
    self = [super init];
    if (self) {
		self.reader = [[CSFileReader alloc] init];
		self.reader.delegate = self;
		self.reader.dataSource = self;
		self.defaultChar = '0';
    }
    return self;
}

- (void)loadLatticeAtLocation:(NSString *)location completionBlock:(void (^)(DNALattice1d *lattice))completionBlock;
{
	[self reset];
	[self.reader startReadingLineByLineFileAtPath:location encoding:NSUTF8StringEncoding];
	completionBlock(_resultLattice);
}

- (DNALattice1d *)dnaLatticeFromFileAtLocation:(NSString *)location
{
	[self reset];
	[self.reader startReadingLineByLineFileAtPath:location encoding:NSUTF8StringEncoding];
	return self.resultLattice;
}


- (void)fileReader:(CSFileReader *)reader didEncounterLine:(NSString *)line
{
	switch ([line characterAtIndex:0]) {
		case '#':
			break;
		case 's':{
			NSScanner *scanner = [NSScanner scannerWithString:line];
			scanner.scanLocation = 2;
			int latticeSize = 0;
			[scanner scanInt:&latticeSize];
			NSLog(@"creating lattice with size: %i", latticeSize);
			self.numberOfVertices = latticeSize;
		}
			break;
		case 'd':{
			if (!self.resultLattice) {
				self.resultLattice = [[DNALattice1d alloc] initWithSideNumber:self.numberOfVertices andChar:self.defaultChar];
				NSLog(@"created lattice with side: %i and default char: %c", self.numberOfVertices, self.defaultChar);
			}
			int i=0, j=0, k=0;
			char scanCharacter = '0';
			
			NSScanner *scanner = [NSScanner scannerWithString:line];
			scanner.scanLocation = 2;
			[scanner scanInt:&i];
			scanner.scanLocation++;
			[scanner scanInt:&j];
			scanner.scanLocation++;
			[scanner scanInt:&k];
			scanner.scanLocation++;
			
			scanCharacter = [line characterAtIndex:[line rangeOfString:@"="].location+1]; //just take the character after the '=' sign. No need to press the scanner to parse an nsstring and then convert to a character.
			[self.resultLattice setItemAti:i andJ:j andK:k value:scanCharacter];
		}
			break;
		case 'f':{
			self.defaultChar = [line characterAtIndex:2];
		}
			break;
		default:
			break;
	}
}

- (void)reset
{
	self.resultLattice = nil;
}

- (void)fileReaderDidEndProcessingFile:(CSFileReader *)reader
{
	
}

- (BOOL)fileReaderShouldContinueProcessing:(CSFileReader *)fileReader
{
	return YES;
}

- (BOOL)string:(NSString *)haystack containsString:(NSString *)needle
{
	return ([haystack rangeOfString:needle].location != NSNotFound);
}
@end
