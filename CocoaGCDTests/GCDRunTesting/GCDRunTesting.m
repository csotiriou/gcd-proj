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
#import "Expecta.h"
#import "TRVSMonitor.h"

@interface GCDRunTesting : TestCaseCommon

@end

@implementation GCDRunTesting

- (void)setUp
{
    [super setUp];
	
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSimpleAsynchronous
{
	CSWordList *wordList = [[CSWordList alloc] init];
	DNALattice1d *lattice = [[DNALattice1d alloc] initWithSideNumber:100 andChar:'a'];
	
	[wordList loadWordListFromFile:[self.bundle pathForResource:@"testWords" ofType:@"wdl"]];
	PatternMatcherGCD *patternMatcher = [[PatternMatcherGCD alloc] initWithLattice:lattice andWordList:wordList];
	
	[patternMatcher startScanningWithCompletionBlock:^{
		[self.monitor signal];
	}];
	
	[self.monitor wait];
	
	expect(patternMatcher.hasAlreadyRan).will.beTruthy();
	expect(patternMatcher.wordsProcessedAndResults[@"aaa"]).to.beTruthy();
	expect(patternMatcher.wordsProcessedAndResults[@"bbb"]).to.beFalsy();
	expect(patternMatcher.wordsProcessedAndResults[@"abc"]).to.beFalsy();
	expect(patternMatcher.wordsProcessedAndResults[@"cba"]).to.beFalsy();
}

@end
