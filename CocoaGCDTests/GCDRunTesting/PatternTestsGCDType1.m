//
//  PatternTestsGCDType1.m
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 5/12/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TestCaseMatcherCommon.h"
#import <CSMatrixFramework/CSMatrixFramework.h>
#import "PatternMatcherGCD.h"
#import "Expecta.h"

@interface PatternTestsGCDType1 : TestCaseMatcherCommon

@end

@implementation PatternTestsGCDType1

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
	PatternMatcherGCD *patternMatcher = [[PatternMatcherGCD alloc] initWithLattice:lattice andWordList:wordList];
	
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


- (void)testSimpleAsynchronousType1
{
	CS_MACRO_BLOCKED_FORTESTS_BEGIN_TIME(@"");
	CSWordList *wordList = [[CSWordList alloc] init];
	DNALattice1d *lattice = [[DNALattice1d alloc] initWithSideNumber:100 andChar:'a'];
	
	[wordList loadWordListFromFile:[self.bundle pathForResource:@"testWords" ofType:@"wdl"]];
	PatternMatcherGCD *patternMatcher = [[PatternMatcherGCD alloc] initWithLattice:lattice andWordList:wordList];
	
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
