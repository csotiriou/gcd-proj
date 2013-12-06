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
#import "PatternMatcherGCD.h"
#import "PatternMatcherSequential.h"
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
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}



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