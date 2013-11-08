//
//  LatticeLineExtractor.m
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 8/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import "LatticeLineExtractor.h"


@implementation LatticeLineExtractor
- (id)initWithDelegate:(id<LatticeLineExtractorDelegate>)delegate
{
	if (self = [super init]) {
		self.delegate = delegate;
	}
	return self;
}

- (NSArray *)obtainHorizontallLinesForProcessingforLattice:(id<LatticeCommon>)lattice
{
	NSMutableArray *arr = [NSMutableArray array];
	for (int i=0; i<lattice.sideNumber; i++) {		//change lattice
		for (int j=0; j<lattice.sideNumber; j++) {
			
			char text[lattice.sideNumber+1];
			
			for (int k=0; k<lattice.sideNumber; k++) {
				text[k] = [lattice getItemAti:i andJ:j andK:k]; //add the characters
			}
			text[lattice.sideNumber] = '\0'; //make it a valid string
			NSString *line = [NSString stringWithCString:text encoding:NSUTF8StringEncoding];
			[arr addObject:line];
		}
	}
	return arr;
}

- (NSArray *)obtainVerticalLinesForProcessingforLattice:(id<LatticeCommon>)lattice
{
	NSMutableArray *arr2 = [NSMutableArray array];
	
	
	for (int i=0; i < lattice.sideNumber; i++) {		//change lattice
		for (int k=0; k < lattice.sideNumber; k++) {
			char text2[lattice.sideNumber+1];
			for (int j=0; j<lattice.sideNumber; j++) {
				//				NSLog(@"character: %c", [lattice getItemAti:i andJ:j andK:k]);
				text2[j] = [lattice getItemAti:i andJ:j andK:k]; //add the characters
			}
			text2[lattice.sideNumber] = '\0'; //make it a valid string
			NSString *line = [NSString stringWithCString:text2 encoding:NSUTF8StringEncoding];
			[arr2 addObject:line];
		}
	}
	return arr2;
}

- (NSArray *)obtainLinesInIntraLatticeForProcessingforLattice:(id<LatticeCommon>)lattice
{
	NSMutableArray *arr = [NSMutableArray array];
	for (int i=0; i<lattice.sideNumber; i++) {		//change lattice
		for (int j=0; j<lattice.sideNumber; j++) {
			
			char text[lattice.sideNumber+1];
			
			for (int k=0; k<lattice.sideNumber; k++) {
				text[k] = [lattice getItemAti:k andJ:j andK:i]; //add the characters
			}
			text[lattice.sideNumber] = '\0'; //make it a valid string
			NSString *line = [NSString stringWithCString:text encoding:NSUTF8StringEncoding];
			[arr addObject:line];
		}
	}
	return arr;
}

- (NSArray *)obtainDiagonalLinesTopLeftBottomRightforLattice:(id<LatticeCommon>)lattice
{
	//start from the element that is in the 0,n-1 place and form diagonal strings using that
	NSMutableArray *linesArray = [NSMutableArray array];
	@autoreleasepool {
		for (int i=0; i<lattice.sideNumber; i++){
			int sideCount = lattice.sideNumber;
			int startVertical = sideCount - 2; //the element before the last one in the Y axis
			
			int currentHorizontal = 0;
			int currentVertical = startVertical;
			
			BOOL hasCompletedVericalStarts = NO;
			
			BOOL end = NO;
			
			NSMutableString *currentString = [NSMutableString string];
			while ( !end) {
				[currentString appendFormat:@"%c", [lattice getItemAti:i andJ:currentHorizontal andK:currentVertical]];
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

- (NSArray *)obtainDiagonalLinesBottomLeftTopRightforLattice:(id<LatticeCommon>)lattice
{
	NSMutableArray *linesArray = [NSMutableArray array];
	@autoreleasepool {
		for (int lat=0; lat<lattice.sideNumber; lat++) {
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
					[currentString appendFormat:@"\n"];
					currentVertical = currentHorizontal-2;//since this is a square matrix
					currentHorizontal = 0;
				}
			}
			[currentString appendFormat:@"\n"];
			currentHorizontal = sideCount-2;
			currentVertical = sideCount-1;
			
			while (currentHorizontal >= 0) {
				[currentString appendFormat:@"%c", [lattice getItemAti:lat andJ:currentHorizontal andK:currentVertical]];
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
	for (int i=0; i<lattice.sideNumber; i++){
		@autoreleasepool {
			int sideCount = lattice.sideNumber;
			int startVertical = sideCount - 2; //the element before the last one in the Y axis
			
			int currentHorizontal = 0;
			int currentVertical = startVertical;
			
			BOOL hasCompletedVericalStarts = NO;
			
			BOOL end = NO;
			
			NSMutableString *currentString = [NSMutableString string];
			while ( !end) {
				[currentString appendFormat:@"%c", [lattice getItemAti:i andJ:currentHorizontal andK:currentVertical]];
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
					//				[linesArray addObject:currentString];
					block(currentString);
				}
			}
		}
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
						[currentString appendFormat:@"\n"];
						currentVertical = currentHorizontal-2;//since this is a square matrix
						currentHorizontal = 0;
					}
				}
				[currentString appendFormat:@"\n"];
				currentHorizontal = sideCount-2;
				currentVertical = sideCount-1;
				
				while (currentHorizontal >= 0) {
					[currentString appendFormat:@"%c", [lattice getItemAti:lat andJ:currentHorizontal andK:currentVertical]];
					currentVertical--;
					currentHorizontal++;
					
					if (currentHorizontal>=sideCount) {
						[currentString appendFormat:@"\n"];
						currentHorizontal = currentVertical;
						currentVertical = sideCount-1;
					}
				}
				
				//			[linesArray addObject:currentString];
				block(currentString);
			}
		}
	}
}

@end
