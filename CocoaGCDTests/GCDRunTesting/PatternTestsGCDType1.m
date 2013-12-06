//
//  PatternTestsGCDType1.m
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 5/12/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TestCaseCommon.h"
#import <CSMatrixFramework/CSMatrixFramework.h>
#import "PatternMatcherGCD.h"
#import "Expecta.h"

@interface PatternTestsGCDType1 : TestCaseCommon

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
