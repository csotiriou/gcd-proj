//
//  PatternMatcherBase.m
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 4/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import "PatternMatcherBase.h"

@implementation PatternMatcherBase

- (id)initWithLattice:(id<LatticeCommon>)lattice andDictionaryToSearch:(NSArray *)dictionaryOfWords
{
	if (self = [super init]) {
		self.lattice = lattice;
		self.dictionaryToSearch = [dictionaryOfWords mutableCopy];
	}
	return self;
}


#pragma mark - extracting lines for processing
- (NSArray *)obtainHorizontallLinesForProcessing
{
	NSMutableArray *arr = [NSMutableArray array];
	for (int i=0; i<self.lattice.sideNumber; i++) {		//change lattice
		for (int j=0; j<self.lattice.sideNumber; j++) {
			
			char text[self.lattice.sideNumber+1];
			
			for (int k=0; k<self.lattice.sideNumber; k++) {
				text[k] = [self.lattice getItemAti:i andJ:j andK:k]; //add the characters
			}
			text[self.lattice.sideNumber] = '\0'; //make it a valid string
			NSString *line = [NSString stringWithCString:text encoding:NSUTF8StringEncoding];
			[arr addObject:line];
		}
	}
	return arr;
}

- (NSArray *)obtainVerticalLinesForProcessing
{
	NSMutableArray *arr2 = [NSMutableArray array];
	
	
	for (int i=0; i<self.lattice.sideNumber; i++) {		//change lattice
		for (int k=0; k<self.lattice.sideNumber; k++) {
			char text2[self.lattice.sideNumber+1];
			for (int j=0; j<self.lattice.sideNumber; j++) {
//				NSLog(@"character: %c", [self.lattice getItemAti:i andJ:j andK:k]);
				text2[j] = [self.lattice getItemAti:i andJ:j andK:k]; //add the characters
			}
			text2[self.lattice.sideNumber] = '\0'; //make it a valid string
			NSString *line = [NSString stringWithCString:text2 encoding:NSUTF8StringEncoding];
			[arr2 addObject:line];
		}
	}
	return arr2;
}

- (NSArray *)obtainLinesInIntraLatticeForProcessing
{
	NSMutableArray *arr = [NSMutableArray array];
	for (int i=0; i<self.lattice.sideNumber; i++) {		//change lattice
		for (int j=0; j<self.lattice.sideNumber; j++) {
			
			char text[self.lattice.sideNumber+1];
			
			for (int k=0; k<self.lattice.sideNumber; k++) {
				text[k] = [self.lattice getItemAti:k andJ:j andK:i]; //add the characters
			}
			text[self.lattice.sideNumber] = '\0'; //make it a valid string
			NSString *line = [NSString stringWithCString:text encoding:NSUTF8StringEncoding];
			[arr addObject:line];
		}
	}
	return arr;
}

- (NSArray *)obtainDiagonalLinesTopLeftBottomRight
{
	//start from the element that is in the 0,n-1 place and form diagonal strings using that
	NSMutableArray *linesArray = [NSMutableArray array];
	@autoreleasepool {
		for (int i=0; i<self.lattice.sideNumber; i++){
			int sideCount = self.lattice.sideNumber;
			int startVertical = sideCount - 2; //the element before the last one in the Y axis
			
			int currentHorizontal = 0;
			int currentVertical = startVertical;
			
			BOOL hasCompletedVericalStarts = NO;
			
			BOOL end = NO;
			
			NSMutableString *currentString = [NSMutableString string];
			while ( !end) {
				[currentString appendFormat:@"%c", [self.lattice getItemAti:i andJ:currentHorizontal andK:currentVertical]];
				currentHorizontal++;
				currentVertical++;
				
				if (currentVertical >= sideCount) { //if we have reached the bottom end
					if (!hasCompletedVericalStarts) {
						currentVertical = (currentVertical == 0? 0 : (sideCount - 1) - currentHorizontal); // we know that it is a square, so it's easy to calculate the next starting point.
						[currentString appendFormat:@"\n"];
						currentHorizontal = 0;
						if (currentHorizontal == 0 && currentVertical == 0){
							hasCompletedVericalStarts = YES;
						}
					}else{ //case happens when we have the change from vertical to horizontal starts
						currentHorizontal = 1;
						currentVertical = 0;
						[currentString appendFormat:@"\n"];
					}
				}
				if (currentHorizontal >= sideCount) {
					currentVertical --; //what was the value before the increment that happened only because we thought we had space
					currentHorizontal = (sideCount -1) - (currentVertical-1);
					
					[currentString appendFormat:@"\n"];
					currentVertical = 0;
				}
				if (currentHorizontal == sideCount-1 && currentVertical == 0) {
					end = YES;
					[linesArray addObject:currentString];
				}
			}
		}
	}
//	NSArray *expected = @[@"bf\naei\ndh\n", @"ko\njnr\nmq\n", @"tx\nsw0\nvz\n"];
	return linesArray;
}

- (NSArray *)obtainDiagonalLinesBottomLeftTopRight
{
	NSMutableArray *linesArray = [NSMutableArray array];
	@autoreleasepool {
		for (int lattice=0; lattice<self.lattice.sideNumber; lattice++) {
			int sideCount = self.lattice.sideNumber;
			int currentHorizontal = 0;
			int currentVertical = sideCount-2;
			
			NSMutableString *currentString = [NSMutableString string];
			
			
			while (currentVertical >= 0) {
				[currentString appendFormat:@"%c", [self.lattice getItemAti:lattice andJ:currentHorizontal andK:currentVertical]];
//				NSLog(@"examining: %i, %i, %i", lattice, currentHorizontal, currentVertical);
				currentVertical--;
				currentHorizontal++;
				if (currentVertical<0) {
					[currentString appendFormat:@"\n"];
					currentVertical = currentHorizontal-2;//since this is a square matrix
					currentHorizontal = 0;
				}
			}
			[currentString appendFormat:@"\n"];
			currentHorizontal = sideCount-2;
			currentVertical = sideCount-1;
			
			while (currentHorizontal >= 0) {
				[currentString appendFormat:@"%c", [self.lattice getItemAti:lattice andJ:currentHorizontal andK:currentVertical]];
				currentVertical--;
				currentHorizontal++;
				
				if (currentHorizontal>=sideCount) {
					[currentString appendFormat:@"\n"];
					currentHorizontal = currentVertical;
					currentVertical = sideCount-1;
				}
			}
			
			[linesArray addObject:currentString];
		}
	}
	return linesArray;
}

- (void)startScanning
{
	@throw [NSException exceptionWithName:@"You must implement this function to subclasses" reason:@"" userInfo:nil];
}

@end
