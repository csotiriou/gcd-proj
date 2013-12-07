//
//  GCDRunTesting.m
//  GCDRunTesting
//
//  Created by Christos Sotiriou on 14/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <CSMatrixFramework/CSMatrixFramework.h>
#import "TestCaseCommon.h"
#import "PatternMatcherGCD2.h"
#import "Expecta.h"
#import "TRVSMonitor.h"

@interface PatternTestsGCDType2 : TestCaseCommon

@end

@implementation PatternTestsGCDType2

- (void)setUp
{
    [super setUp];
	
}

- (void)tearDown
{
    [super tearDown];
}


- (void)testCreationWithWordList
{
	CSWordList *wordList = [[CSWordList alloc] init];
	[wordList loadWordListFromFile:[self.bundle pathForResource:@"testWords" ofType:@"wdl"]];
	
	DNALattice1d *lattice = [[DNALattice1d alloc] initWithSideNumber:50 andChar:'a'];
	PatternMatcherGCD2 *patternMatcher = [[PatternMatcherGCD2 alloc] initWithLattice:lattice andWordList:wordList];
	
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

//- (void)testCreationWithDictionary
//{
//	DNALattice1d *lattice = [[DNALattice1d alloc] initWithSideNumber:50 andChar:'a'];
//	PatternMatcherGCD2 *patternMatcher = [[PatternMatcherGCD2 alloc] initWithLattice:lattice andDictionaryToSearch:@[@"empty"]];
//	
//	expect(patternMatcher).to.notTo.beNil();
//	expect(patternMatcher.hasAlreadyRan).to.beFalsy();
//	expect(patternMatcher.lattice).to.notTo.beNil();
//	expect(patternMatcher.latticeExtractor).to.notTo.beNil();
//	expect(patternMatcher.delegate).to.beNil();
//	expect(patternMatcher.dictionaryToSearch).toNot.beNil();
//	expect(patternMatcher.reversedDictionaryToSearch).toNot.beNil();
//	expect(patternMatcher.reversedDictionaryToSearch.count).to.beGreaterThan(0);
//	expect(patternMatcher.dictionaryToSearch.count).to.beGreaterThan(0);
//	
//	expect(patternMatcher.wordsProcessedAndResults).toNot.beNil();
//	expect(patternMatcher.wordsProcessedAndResults.count).to.equal(patternMatcher.dictionaryToSearch.count);
//	expect(patternMatcher.reversedDictionaryToSearch.count).to.equal(patternMatcher.dictionaryToSearch.count);
//	
//	for (NSString *str in patternMatcher.wordsProcessedAndResults.allKeys) {
//		expect([patternMatcher.dictionaryToSearch containsObject:str]).to.beTruthy();
//		expect([patternMatcher.reversedDictionaryToSearch containsObject:[str reversedString]]);
//		expect([patternMatcher.wordsProcessedAndResults[str] boolValue]).to.beFalsy();
//	}
//	
//}

- (void)testSimpleAsynchronousType2_50
{
	CS_MACRO_BLOCKED_FORTESTS_BEGIN_TIME(@"");
	CSWordList *wordList = [[CSWordList alloc] init];
	DNALattice1d *lattice = [[DNALattice1d alloc] initWithSideNumber:50 andChar:'a'];
	
	[wordList loadWordListFromFile:[self.bundle pathForResource:@"testWords" ofType:@"wdl"]];
	PatternMatcherGCD2 *patternMatcher = [[PatternMatcherGCD2 alloc] initWithLattice:lattice andWordList:wordList];
	
	[patternMatcher startScanningWithCompletionBlock:^{
		[self.monitor signal];
		CS_MACRO_BLOCKED_FORTESTS_END_DISPLAY;
	}];
	
	[self.monitor wait];
	
	expect(patternMatcher.hasAlreadyRan).will.beTruthy();
	expect(patternMatcher.wordsProcessedAndResults[@"aaa"]).to.beTruthy();
	expect(patternMatcher.wordsProcessedAndResults[@"bbb"]).to.beFalsy();
	expect(patternMatcher.wordsProcessedAndResults[@"abc"]).to.beFalsy();
	expect(patternMatcher.wordsProcessedAndResults[@"cba"]).to.beFalsy();
}


- (void)testSimpleAsynchronousType2_100
{
	CS_MACRO_BLOCKED_FORTESTS_BEGIN_TIME(@"");
	CSWordList *wordList = [[CSWordList alloc] init];
	DNALattice1d *lattice = [[DNALattice1d alloc] initWithSideNumber:100 andChar:'a'];
	
	[wordList loadWordListFromFile:[self.bundle pathForResource:@"testWords" ofType:@"wdl"]];
	PatternMatcherGCD2 *patternMatcher = [[PatternMatcherGCD2 alloc] initWithLattice:lattice andWordList:wordList];
	
	[patternMatcher startScanningWithCompletionBlock:^{
		[self.monitor signal];
		CS_MACRO_BLOCKED_FORTESTS_END_DISPLAY;
	}];
	
	[self.monitor wait];
	
	expect(patternMatcher.hasAlreadyRan).will.beTruthy();
	expect(patternMatcher.wordsProcessedAndResults[@"aaa"]).to.beTruthy();
	expect(patternMatcher.wordsProcessedAndResults[@"bbb"]).to.beFalsy();
	expect(patternMatcher.wordsProcessedAndResults[@"abc"]).to.beFalsy();
	expect(patternMatcher.wordsProcessedAndResults[@"cba"]).to.beFalsy();
}

@end
