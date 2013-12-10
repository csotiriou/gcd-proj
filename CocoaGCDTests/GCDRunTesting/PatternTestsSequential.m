//
//  PatternTestsSequential.m
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 5/12/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TestCaseMatcherCommon.h"
#import <CSMatrixFramework/CSMatrixFramework.h>
#import "PatternMatcherSequential.h"
#import "Expecta.h"

@interface PatternTestsSequential : TestCaseMatcherCommon

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

- (void)testCreationWithWordList
{
	CSWordList *wordList = [[CSWordList alloc] init];
	[wordList loadWordListFromFile:[self.bundle pathForResource:@"testWords" ofType:@"wdl"]];

	DNALattice1d *lattice = [[DNALattice1d alloc] initWithSideNumber:50 andChar:'a'];
	PatternMatcherSequential *patternMatcher = [[PatternMatcherSequential alloc] initWithLattice:lattice andWordList:wordList];
	
	expect(patternMatcher).to.notTo.beNil();
	expect(patternMatcher.hasAlreadyRan).to.beFalsy();
	expect(patternMatcher.lattice).to.notTo.beNil();
	expect(patternMatcher.latticeExtractor).to.notTo.beNil();
	expect(patternMatcher.delegate).to.beNil();
	expect(patternMatcher.dictionaryToSearch).toNot.beNil();
	expect(patternMatcher.reversedDictionaryToSearch).toNot.beNil();
	expect(patternMatcher.reversedDictionaryToSearch.count).to.beGreaterThan(0);
	expect(patternMatcher.dictionaryToSearch.count).to.beGreaterThan(0);
	
	expect(patternMatcher.wordsProcessedAndResults).toNot.beNil();
	expect(patternMatcher.wordsProcessedAndResults.count).to.equal(patternMatcher.dictionaryToSearch.count);
	expect(patternMatcher.reversedDictionaryToSearch.count).to.equal(patternMatcher.dictionaryToSearch.count);
	
	for (NSString *str in patternMatcher.wordsProcessedAndResults.allKeys) {
		expect([patternMatcher.dictionaryToSearch containsObject:str]).to.beTruthy();
		expect([patternMatcher.reversedDictionaryToSearch containsObject:[str reversedString]]);
		expect([patternMatcher.wordsProcessedAndResults[str] boolValue]).to.beFalsy();
	}
}


- (void)testSimpleSynchronous50
{
	CS_MACRO_BLOCKED_FORTESTS_BEGIN_TIME(@"");
	
	CSWordList *wordList = [[CSWordList alloc] init];
	[wordList loadWordListFromFile:[self.bundle pathForResource:@"testWords" ofType:@"wdl"]];
	
	DNALattice1d *lattice = [[DNALattice1d alloc] initWithSideNumber:50 andChar:'a'];
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
		CSWordList *wordList = [self createWordListWithNumberOfLetters:30 andSize:(i==0? 10:i) defaultCharacter:'a'];
		NSString *currentString = [NSString stringWithFormat:@"word_count %i", i];
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
