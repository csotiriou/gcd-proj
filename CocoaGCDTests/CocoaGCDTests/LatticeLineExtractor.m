//
//  LatticeLineExtractor.m
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 8/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import "LatticeLineExtractor.h"


@implementation LatticeLineExtractor


- (void)obtainHorizontallLinesForLattice:(id<LatticeCommon>)lattice withLineCompletionBlock:(void (^)(NSString *line))block
{
	for (int i=0; i<lattice.sideNumber; i++) {		//change lattice
		for (int j=0; j<lattice.sideNumber; j++) {
			@autoreleasepool {
				char text[lattice.sideNumber+1];
				
				for (int k=0; k<lattice.sideNumber; k++) {
					text[k] = [lattice getItemAti:i andJ:j andK:k]; //add the characters
				}
				text[lattice.sideNumber] = '\0'; //make it a valid string
				NSString *line = [NSString stringWithCString:text encoding:NSUTF8StringEncoding];
				block(line);
			}
		}
	}
}


- (void)obtainVerticalLinesForLattice:(id<LatticeCommon>)lattice withLineCompletionBlock:(void (^)(NSString *line))block
{
	
	for (int i=0; i < lattice.sideNumber; i++) {		//change lattice
		for (int k=0; k < lattice.sideNumber; k++) {
			@autoreleasepool {
				char text2[lattice.sideNumber+1];
				for (int j=0; j<lattice.sideNumber; j++) {
					//				NSLog(@"character: %c", [lattice getItemAti:i andJ:j andK:k]);
					text2[j] = [lattice getItemAti:i andJ:j andK:k]; //add the characters
				}
				text2[lattice.sideNumber] = '\0'; //make it a valid string
				NSString *line = [NSString stringWithCString:text2 encoding:NSUTF8StringEncoding];
				block(line);
			}
		}
	}
}

- (void)obtainLinesInIntraLatticeForLattice:(id<LatticeCommon>)lattice withLineCompletionBlock:(void (^)(NSString *line))block
{
	
	for (int i=0; i<lattice.sideNumber; i++) {		//change lattice
		for (int j=0; j<lattice.sideNumber; j++) {
			@autoreleasepool {
				char text[lattice.sideNumber+1];
				for (int k=0; k<lattice.sideNumber; k++) {
					text[k] = [lattice getItemAti:k andJ:j andK:i]; //add the characters
				}
				text[lattice.sideNumber] = '\0'; //make it a valid string
				NSString *line = [NSString stringWithCString:text encoding:NSUTF8StringEncoding];
				block(line);
			}
		}
	}
}



- (void)obtainDiagonalLinesTopLeftBottomRightForLattice:(id<LatticeCommon>)lattice withLineCompletionBlock:(void (^)(NSString *line))block
{
	for (int constantDimension=0; constantDimension < lattice.sideNumber; constantDimension++) {
		int sideCount = lattice.sideNumber;
		int currentHorizontal = 1;
		int currentVertical = 0;
		
		NSMutableString *currentString = [NSMutableString string];
		
		
		while (currentHorizontal < sideCount) {
			[currentString appendFormat:@"%c", [lattice getItemAti:constantDimension andJ:currentHorizontal andK:currentVertical]];
			
//			NSLog(@"examining: %i, %i, %i", constantDimension, currentHorizontal, currentVertical);
			
			currentVertical++;
			currentHorizontal++;
			if (currentHorizontal >= sideCount) {
//				[currentString appendFormat:@"\n"];
				block(currentString);
				[currentString setString:@""];
				currentHorizontal = sideCount - (currentVertical -1 /*undo last step */);//since this is a square matrix
				currentVertical = 0;
			}
		}
		
//		[currentString appendFormat:@"\n"];
//		block(currentString);
//		[currentString setString:@""];
		
		currentHorizontal = 0;
		currentVertical = 0;
		
		while (currentVertical < sideCount) {
			[currentString appendFormat:@"%c", [lattice getItemAti:constantDimension andJ:currentHorizontal andK:currentVertical]];
//			NSLog(@"examining: %i, %i, %i", constantDimension, currentHorizontal, currentVertical);
			currentVertical++;
			currentHorizontal++;
			
			if (currentVertical >= sideCount) {
//				[currentString appendFormat:@"\n"];
				block(currentString);
				[currentString setString:@""];
				currentVertical = sideCount - (currentHorizontal -1);
				currentHorizontal = 0;
			}
		}

//		block(currentString);
	}
	
}


- (void)obtainDiagonalLinesBottomLeftTopRightForLattice:(id<LatticeCommon>)lattice withLineCompletionBlock:(void (^)(NSString *line))block
{
	@autoreleasepool {
		for (int lat=0; lat<lattice.sideNumber; lat++) {
			@autoreleasepool {
				int sideCount = lattice.sideNumber;
				int currentHorizontal = 0;
				int currentVertical = sideCount-2;
				
				NSMutableString *currentString = [NSMutableString string];
				
				
				while (currentVertical >= 0) {
					[currentString appendFormat:@"%c", [lattice getItemAti:lat andJ:currentHorizontal andK:currentVertical]];
					//				NSLog(@"examining: %i, %i, %i", lattice, currentHorizontal, currentVertical);
					currentVertical--;
					currentHorizontal++;
					if (currentVertical<0) {
						block(currentString);
						[currentString setString:@""];
						currentVertical = currentHorizontal-2;//since this is a square matrix
						currentHorizontal = 0;
					}
				}
//				[currentString appendFormat:@"\n"];
//				block(currentString);
				[currentString setString:@""];
				
				currentHorizontal = sideCount-1;
				currentVertical = sideCount-1;
				
				while (currentHorizontal >= 0) {
					[currentString appendFormat:@"%c", [lattice getItemAti:lat andJ:currentHorizontal andK:currentVertical]];
					currentVertical--;
					currentHorizontal++;
					
					if (currentHorizontal>=sideCount) {
//						[currentString appendFormat:@"\n"];
						block(currentString);
						[currentString setString:@""];
						currentHorizontal = currentVertical;
						currentVertical = sideCount-1;
					}
				}
				
//				block(currentString);
			}
		}
	}
}



- (void)obtainDiagonalHeightConstantZ1ForLattice:(id<LatticeCommon>)lattice withLineCompletionBlock:(void (^)(NSString *line))block
{
	for (int constantDimension=0; constantDimension < lattice.sideNumber; constantDimension++) {
		int sideCount = lattice.sideNumber;
		int currentHorizontal = 0;
		int currentVertical = sideCount-2;
		
		NSMutableString *currentString = [NSMutableString string];
		
		
		while (currentVertical >= 0) {
			[currentString appendFormat:@"%c", [lattice getItemAti:currentVertical andJ:currentHorizontal andK:constantDimension]];
			//			NSLog(@"examining: %i, %i, %i", lattice, currentHorizontal, currentVertical);
			currentVertical--;
			currentHorizontal++;
			if (currentVertical<0) {
//				[currentString appendFormat:@"\n"];
				block(currentString);
				[currentString setString:@""];
				currentVertical = currentHorizontal-2;//since this is a square matrix
				currentHorizontal = 0;
			}
		}
//		[currentString appendFormat:@"\n"];
//		block(currentString);
//		[currentString setString:@""];
		currentHorizontal = sideCount-1;
		currentVertical = sideCount-1;
		
		while (currentHorizontal >= 0) {
			[currentString appendFormat:@"%c", [lattice getItemAti:currentVertical andJ:currentHorizontal andK:constantDimension]];
			currentVertical--;
			currentHorizontal++;
			
			if (currentHorizontal>=sideCount) {
//				[currentString appendFormat:@"\n"];
				block(currentString);
				[currentString setString:@""];
				currentHorizontal = currentVertical;
				currentVertical = sideCount-1;
			}
		}
//		block(currentString);
	}
}


- (void)obtainDiagonalHeightConstantZ2ForLattice:(id<LatticeCommon>)lattice withLineCompletionBlock:(void (^)(NSString *line))block
{
	for (int constantDimension=0; constantDimension < lattice.sideNumber; constantDimension++) {
		int sideCount = lattice.sideNumber;
		int currentHorizontal = 1;
		int currentVertical = 0;
		
		NSMutableString *currentString = [NSMutableString string];
		
		
		while (currentHorizontal < sideCount) {
			[currentString appendFormat:@"%c", [lattice getItemAti:currentVertical andJ:currentHorizontal andK:constantDimension]];
			
			currentVertical++;
			currentHorizontal++;
			if (currentHorizontal >= sideCount) {
//				[currentString appendFormat:@"\n"];
				block(currentString);
				[currentString setString:@""];
				currentHorizontal = sideCount - (currentVertical -1 /*undo last step */);//since this is a square matrix
				currentVertical = 0;
			}
		}
		
//		[currentString appendFormat:@"\n"];
//		block(currentString);
//		[currentString setString:@""];
		currentHorizontal = 0;
		currentVertical = 0;
		
		while (currentVertical < sideCount) {
			[currentString appendFormat:@"%c", [lattice getItemAti:currentVertical andJ:currentHorizontal andK:constantDimension]];
			currentVertical++;
			currentHorizontal++;
			
			if (currentVertical >= sideCount) {
//				[currentString appendFormat:@"\n"];
				block(currentString);
				[currentString setString:@""];
				currentVertical = sideCount - (currentHorizontal -1);
				currentHorizontal = 0;
			}
		}
//		block(currentString);
	}
}

@end
