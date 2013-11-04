//
//  AlgoTests.m
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 31/10/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <CSMatrixFramework/CSMatrixFramework.h>
#import "PatternMatcher.h"

@interface AlgoTests : XCTestCase
@property (nonatomic, strong) DNALattice1d *lattice;
@property (nonatomic, strong) PatternMatcher *patternMatcher;
@end

@implementation AlgoTests

- (void)setUp
{
    [super setUp];
	self.lattice = [[DNALattice1d alloc] initWithSideNumber:3 andChar:'0'];
	self.patternMatcher = [[PatternMatcher alloc] init];
	
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

- (void)testExample
{
	//	NSMutableArray *arr = [NSMutableArray array];
	//	for (int i=0; i<self.lattice.sideNumber; i++) {		//change lattice
	//		for (int j=0; j<self.lattice.sideNumber; j++) {
	//
	//			char text[self.lattice.sideNumber+1];
	//
	//			for (int k=0; k<self.lattice.sideNumber; k++) {
	//				text[k] = [self.lattice getItemAti:i andJ:j andK:k]; //add the characters
	//			}
	//			text[self.lattice.sideNumber] = '\0'; //make it a valid string
	//			NSString *line = [NSString stringWithCString:text encoding:NSUTF8StringEncoding];
	//			[arr addObject:line];
	//		}
	//	}
	//
	//	NSMutableArray *arr2 = [NSMutableArray array];
	//
	//
	//	for (int i=0; i<self.lattice.sideNumber; i++) {		//change lattice
	//		for (int k=0; k<self.lattice.sideNumber; k++) {
	//			char text2[self.lattice.sideNumber+1];
	//			for (int j=0; j<self.lattice.sideNumber; j++) {
	//				NSLog(@"character: %c", [self.lattice getItemAti:i andJ:j andK:k]);
	//				text2[j] = [self.lattice getItemAti:i andJ:j andK:k]; //add the characters
	//			}
	//			text2[self.lattice.sideNumber] = '\0'; //make it a valid string
	//			NSString *line = [NSString stringWithCString:text2 encoding:NSUTF8StringEncoding];
	//			[arr2 addObject:line];
	//		}
	//	}
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
				NSLog(@"character: %c", [self.lattice getItemAti:i andJ:j andK:k]);
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


- (void)testGetLinesDiagonally //
{
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
//			currentPoint = CGPointMake(currentHorizontal, currentVertical);
//			NSLog(@"current point: %@", NSStringFromPoint(currentPoint));
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
