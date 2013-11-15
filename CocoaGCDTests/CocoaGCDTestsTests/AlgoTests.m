//
//  AlgoTests.m
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 31/10/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <CSMatrixFramework/CSMatrixFramework.h>
#import "PatternMatcherSequential.h"

@interface AlgoTests : XCTestCase
@property (nonatomic, strong) DNALattice1d *lattice;
@property (nonatomic, strong) PatternMatcherSequential *patternMatcher;
@end

@implementation AlgoTests

- (void)setUp
{
    [super setUp];
	self.lattice = [[DNALattice1d alloc] initWithSideNumber:3 andChar:'0'];
	self.patternMatcher = [[PatternMatcherSequential alloc] init];
	
	self.patternMatcher.lattice = self.lattice;
	[self.patternMatcher.dictionaryToSearch addObject:@"abba"];
	
	
	
	[self.lattice setItemAti:0 andJ:0 andK:0 value:'a'];
	[self.lattice setItemAti:0 andJ:0 andK:1 value:'b'];
	[self.lattice setItemAti:0 andJ:0 andK:2 value:'c'];
	
	[self.lattice setItemAti:0 andJ:1 andK:0 value:'d'];
	[self.lattice setItemAti:0 andJ:1 andK:1 value:'e'];
	[self.lattice setItemAti:0 andJ:1 andK:2 value:'f'];
	
	[self.lattice setItemAti:0 andJ:2 andK:0 value:'g'];
	[self.lattice setItemAti:0 andJ:2 andK:1 value:'h'];
	[self.lattice setItemAti:0 andJ:2 andK:2 value:'i'];
	
	
	[self.lattice setItemAti:1 andJ:0 andK:0 value:'j'];
	[self.lattice setItemAti:1 andJ:0 andK:1 value:'k'];
	[self.lattice setItemAti:1 andJ:0 andK:2 value:'l'];
	
	[self.lattice setItemAti:1 andJ:1 andK:0 value:'m'];
	[self.lattice setItemAti:1 andJ:1 andK:1 value:'n'];
	[self.lattice setItemAti:1 andJ:1 andK:2 value:'o'];
	
	[self.lattice setItemAti:1 andJ:2 andK:0 value:'p'];
	[self.lattice setItemAti:1 andJ:2 andK:1 value:'q'];
	[self.lattice setItemAti:1 andJ:2 andK:2 value:'r'];
	
	[self.lattice setItemAti:2 andJ:0 andK:0 value:'s'];
	[self.lattice setItemAti:2 andJ:0 andK:1 value:'t'];
	[self.lattice setItemAti:2 andJ:0 andK:2 value:'u'];
	
	[self.lattice setItemAti:2 andJ:1 andK:0 value:'v'];
	[self.lattice setItemAti:2 andJ:1 andK:1 value:'w'];
	[self.lattice setItemAti:2 andJ:1 andK:2 value:'x'];
	
	[self.lattice setItemAti:2 andJ:2 andK:0 value:'y'];
	[self.lattice setItemAti:2 andJ:2 andK:1 value:'z'];
	[self.lattice setItemAti:2 andJ:2 andK:2 value:'0'];
	
}

- (void)tearDown
{
    [super tearDown];
}


- (void)testGethorizontalLines
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
	
	NSArray *expected = @[@"abc",
						  @"def",
						  @"ghi",
						  @"jkl",
						  @"mno",
						  @"pqr",
						  @"stu",
						  @"vwx",
						  @"yz0"];
	XCTAssertTrue([self arrayWithStrings:expected isEqualToArrayWithStrings:arr], @"error - wrong output");
	
}

- (void)testGetVerticalLines
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
	
	NSArray *expected = @[@"adg",
						  @"beh",
						  @"cfi",
						  @"jmp",
						  @"knq",
						  @"lor",
						  @"svy",
						  @"twz",
						  @"ux0"];
	XCTAssertTrue([self arrayWithStrings:expected isEqualToArrayWithStrings:arr2], @"error - wrong output");
}

- (void)testGetlinesInLatticeChange //get strings from intra-lattice processing
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
	
	NSArray *expected = @[@"ajs",
						  @"dmv",
						  @"gpy",
						  @"bkt",
						  @"enw",
						  @"hqz",
						  @"clu",
						  @"fox",
						  @"ir0"];
	XCTAssertTrue([self arrayWithStrings:expected isEqualToArrayWithStrings:arr], @"error - wrong output");
}


- (void)testGetLinesDiagonally //from top left t bottom right
{
	//start from the element that is in the 0,n-1 place and form diagonal strings using that
	NSMutableArray *linesArray = [NSMutableArray array];
	
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
	NSArray *expected = @[@"bf\naei\ndh\n", @"ko\njnr\nmq\n", @"tx\nsw0\nvz\n"];
	XCTAssertTrue([self arrayWithStrings:expected isEqualToArrayWithStrings:linesArray], @"error - wrong output");
}



- (void)testGetLinesDiagonallyNormalWayAlgorithm
{
	NSMutableArray *linesArray = [NSMutableArray array];
	
	for (int constantDimension=0; constantDimension<self.lattice.sideNumber; constantDimension++) {
		int sideCount = self.lattice.sideNumber;
		int currentHorizontal = 1;
		int currentVertical = 0;
		
		NSMutableString *currentString = [NSMutableString string];
		
		
		while (currentHorizontal < sideCount) {
			[currentString appendFormat:@"%c", [self.lattice getItemAti:constantDimension andJ:currentHorizontal andK:currentVertical]];
			
			NSLog(@"examining: %i, %i, %i", constantDimension, currentHorizontal, currentVertical);
			
			currentVertical++;
			currentHorizontal++;
			if (currentHorizontal >= sideCount) {
				[currentString appendFormat:@"\n"];
				currentHorizontal = sideCount - (currentVertical -1 /*undo last step */);//since this is a square matrix
				currentVertical = 0;
			}
		}
		
		[currentString appendFormat:@"\n"];
		currentHorizontal = 0;
		currentVertical = 0;
		
		while (currentVertical < sideCount) {
			[currentString appendFormat:@"%c", [self.lattice getItemAti:constantDimension andJ:currentHorizontal andK:currentVertical]];
			NSLog(@"examining: %i, %i, %i", constantDimension, currentHorizontal, currentVertical);
			currentVertical++;
			currentHorizontal++;
			
			if (currentVertical >= sideCount) {
				[currentString appendFormat:@"\n"];
				currentVertical = sideCount - (currentHorizontal -1);
				currentHorizontal = 0;
//				currentHorizontal = currentVertical;
//				currentVertical = sideCount-1;
			}
		}
		
		[linesArray addObject:currentString];
	}

}

- (void)testGetLinesDiagonally2 //from bottom left to top right, more understandable but possibly less efficient than the other algorithm
{
	NSMutableArray *linesArray = [NSMutableArray array];
	
	for (int lattice=0; lattice<self.lattice.sideNumber; lattice++) {
		int sideCount = self.lattice.sideNumber;
		int currentHorizontal = 0;
		int currentVertical = sideCount-2;
		
		NSMutableString *currentString = [NSMutableString string];
		
	
		while (currentVertical >= 0) {
			[currentString appendFormat:@"%c", [self.lattice getItemAti:lattice andJ:currentHorizontal andK:currentVertical]];
//			NSLog(@"examining: %i, %i, %i", lattice, currentHorizontal, currentVertical);
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

- (void)testGetDiagonallyZ1 //diagonally, from z = 0 to z = n, from bottom to top
{
	//start from the element that is in the 0,n-1 place and form diagonal strings using that
	NSMutableArray *linesArray = [NSMutableArray array];
	
	for (int constantDimension=0; constantDimension<self.lattice.sideNumber; constantDimension++) {
		int sideCount = self.lattice.sideNumber;
		int currentHorizontal = 0;
		int currentVertical = sideCount-2;
		
		NSMutableString *currentString = [NSMutableString string];
		
		
		while (currentVertical >= 0) {
			[currentString appendFormat:@"%c", [self.lattice getItemAti:currentVertical andJ:currentHorizontal andK:constantDimension]];
			//			NSLog(@"examining: %i, %i, %i", lattice, currentHorizontal, currentVertical);
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
			[currentString appendFormat:@"%c", [self.lattice getItemAti:currentVertical andJ:currentHorizontal andK:constantDimension]];
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

- (void)testGetDiagonallyZ2 //diagonally, from z = 0 to z = n, from top to bottom
{
	NSMutableArray *linesArray = [NSMutableArray array];
	
	for (int constantDimension=0; constantDimension<self.lattice.sideNumber; constantDimension++) {
		int sideCount = self.lattice.sideNumber;
		int currentHorizontal = 1;
		int currentVertical = 0;
		
		NSMutableString *currentString = [NSMutableString string];
		
		
		while (currentHorizontal < sideCount) {
			[currentString appendFormat:@"%c", [self.lattice getItemAti:currentVertical andJ:currentHorizontal andK:constantDimension]];
			
			
			currentVertical++;
			currentHorizontal++;
			if (currentHorizontal >= sideCount) {
				[currentString appendFormat:@"\n"];
				currentHorizontal = sideCount - (currentVertical -1 /*undo last step */);//since this is a square matrix
				currentVertical = 0;
			}
		}
		
		[currentString appendFormat:@"\n"];
		currentHorizontal = 0;
		currentVertical = 0;
		
		while (currentVertical < sideCount) {
			[currentString appendFormat:@"%c", [self.lattice getItemAti:currentVertical andJ:currentHorizontal andK:constantDimension]];
			currentVertical++;
			currentHorizontal++;
			
			if (currentVertical >= sideCount) {
				[currentString appendFormat:@"\n"];
				currentVertical = sideCount - (currentHorizontal -1);
				currentHorizontal = 0;
				//				currentHorizontal = currentVertical;
				//				currentVertical = sideCount-1;
			}
		}
		
		[linesArray addObject:currentString];
	}
}


- (void)testGetReversedString
{
	NSString *original = @"this is a string";
	const char *originalChars = [original cStringUsingEncoding:NSUTF8StringEncoding];
	char reverseString[original.length];
	
	int i;
	for (i = 1; i<= original.length; i++) {
		reverseString[i-1] = originalChars[original.length - i];
	}
	reverseString[original.length] = '\0'; //add the terminating character
	
	NSString *finalString = [NSString stringWithCString:reverseString encoding:NSUTF8StringEncoding];
	XCTAssertEqualObjects(finalString, @"gnirts a si siht", @"strings are not equal");
}





- (BOOL)arrayWithStrings:(NSArray *)arr isEqualToArrayWithStrings:(NSArray *)arr2
{
	for (int i=0; i<arr.count; i++) {
		if (![[arr objectAtIndex:i] isEqualToString:[arr2 objectAtIndex:i]]) {
			return NO;
		}
	}
	return YES;
}
@end
