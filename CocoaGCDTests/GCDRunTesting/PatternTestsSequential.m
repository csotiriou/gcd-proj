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

@end
