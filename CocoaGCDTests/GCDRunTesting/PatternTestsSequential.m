//
//  PatternTestsSequential.m
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 5/12/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TestCaseCommon.h"
#import <CSMatrixFramework/CSMatrixFramework.h>
#import "PatternMatcherSequential.h"
#import "Expecta.h"

@interface PatternTestsSequential : TestCaseCommon

@end

@implementation PatternTestsSequential

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testSimpleSynchronous50
{
	CS_MACRO_BLOCKED_FORTESTS_BEGIN_TIME(@"");
	
	CSWordList *wordList = [[CSWordList alloc] init];
	DNALattice1d *lattice = [[DNALattice1d alloc] initWithSideNumber:50 andChar:'a'];
	
	[wordList loadWordListFromFile:[self.bundle pathForResource:@"testWords" ofType:@"wdl"]];
	PatternMatcherSequential *patternMatcher = [[PatternMatcherSequential alloc] initWithLattice:lattice andWordList:wordList];
	[patternMatcher startScanning];
	
	expect(patternMatcher.hasAlreadyRan).will.beTruthy();
	expect(patternMatcher.wordsProcessedAndResults[@"aaa"]).to.beTruthy();
	expect(patternMatcher.wordsProcessedAndResults[@"bbb"]).to.beFalsy();
	expect(patternMatcher.wordsProcessedAndResults[@"abc"]).to.beFalsy();
	expect(patternMatcher.wordsProcessedAndResults[@"cba"]).to.beFalsy();
	CS_MACRO_BLOCKED_FORTESTS_END_DISPLAY;
}

- (void)testSimpleSynchronous100
{
	CS_MACRO_BLOCKED_FORTESTS_BEGIN_TIME(@"");
	
	CSWordList *wordList = [[CSWordList alloc] init];
	DNALattice1d *lattice = [[DNALattice1d alloc] initWithSideNumber:100 andChar:'a'];
	[wordList loadWordListFromFile:[self.bundle pathForResource:@"testWords" ofType:@"wdl"]];

	
	PatternMatcherSequential *patternMatcher = [[PatternMatcherSequential alloc] initWithLattice:lattice andWordList:wordList];
	[patternMatcher startScanning];
	
	expect(patternMatcher.hasAlreadyRan).will.beTruthy();
	expect(patternMatcher.wordsProcessedAndResults[@"aaa"]).to.beTruthy();
	expect(patternMatcher.wordsProcessedAndResults[@"bbb"]).to.beFalsy();
	expect(patternMatcher.wordsProcessedAndResults[@"abc"]).to.beFalsy();
	expect(patternMatcher.wordsProcessedAndResults[@"cba"]).to.beFalsy();
	CS_MACRO_BLOCKED_FORTESTS_END_DISPLAY;
}

- (void)testScalabilityCubeSizeIncrement
{
	CSWordList *wordList = [[CSWordList alloc] init];
	[wordList loadWordListFromFile:[self.bundle pathForResource:@"testWords" ofType:@"wdl"]];
	
	for (int i = 0; i<300; i+=50) {
		NSString *currentString = [NSString stringWithFormat:@"cube_side %i", i];
		CS_MACRO_BLOCKED_FORTESTS_BEGIN_TIME(currentString);
		DNALattice1d *lattice = [[DNALattice1d alloc] initWithSideNumber:(i == 0? 5 : i) andChar:'a'];
		PatternMatcherSequential *patternMatcher = [[PatternMatcherSequential alloc] initWithLattice:lattice andWordList:wordList];
		[patternMatcher startScanning];
		CS_MACRO_BLOCKED_FORTESTS_END_DISPLAY;
	}
}

- (void)testScalabilityWordCountIncrement
{
	for (int i = 0; i<300; i+=50) {
		CSWordList *wordList = [self createWordListWithNumberOfLetters:30 andSize:i defaultCharacter:'a'];
		NSString *currentString = [NSString stringWithFormat:@"letter_side %i", i];
		CS_MACRO_BLOCKED_FORTESTS_BEGIN_TIME(currentString);
		
		DNALattice1d *lattice = [[DNALattice1d alloc] initWithSideNumber:100 andChar:'a'];
		PatternMatcherSequential *patternMatcher = [[PatternMatcherSequential alloc] initWithLattice:lattice andWordList:wordList];
		[patternMatcher startScanning];
		CS_MACRO_BLOCKED_FORTESTS_END_DISPLAY;
	}
}

- (void)testScalabilityWordSizeIncrement
{
	for (int i = 0; i<1000; i+= 100) {
		CSWordList *wordList = [self createWordListWithNumberOfLetters:(i == 0? 5 : i) andSize:10 defaultCharacter:'a'];
		DNALattice1d *lattice = [[DNALattice1d alloc] initWithSideNumber:100 andChar:'a'];
		PatternMatcherSequential *patternMatcher = [[PatternMatcherSequential alloc] initWithLattice:lattice andWordList:wordList];
		
		NSString *currentString = [NSString stringWithFormat:@"letter_count %i", i];
		CS_MACRO_BLOCKED_FORTESTS_BEGIN_TIME(currentString);
		[patternMatcher startScanning];
		CS_MACRO_BLOCKED_FORTESTS_END_DISPLAY;
	}
}


@end
