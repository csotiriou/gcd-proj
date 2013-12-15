//
//  CorrectnessTests.m
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 14/12/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TestCaseCommon.h"
#import "PatternMatcherGCD.h"
#import "PatternMatcherGCD2.h"
#import "PatternMatcherSequential.h"
#import "Expecta.h"

@interface CorrectnessTests : TestCaseCommon

@end

@implementation CorrectnessTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCorrectness1
{
	//set up
	NSSet *expectedResults = [NSSet setWithObjects:@"aaa", @"ccc", @"ddd", @"naa", @"mag", @"adg", @"___", @"lgg", nil];
	id<LatticeCommon> l = [self cubeFromFileInThisBundleWithName:@"testcube"];
	CSWordList *wordList = [self wordListFromThisBundleWithName:@"testWordList"];
	
	
	/* Test the sequential matcher */
	PatternMatcherBase *sequential = [[PatternMatcherSequential alloc] initWithLattice:l andWordList:wordList];
	[sequential startScanningIfefficient];
	
	for (NSString *str in expectedResults) {
		expect([sequential.wordsProcessedAndResults[str] boolValue]).to.beTruthy();
	}
	
	
	/* Test the asynchronous matcher 1*/
	PatternMatcherBase *asynchronous1 = [[PatternMatcherGCD alloc] initWithLattice:l andWordList:wordList];
	[asynchronous1 startScanningIfEfficientWithCompletionBlock:^{
		[self.monitor signal];
	}];
	[self.monitor wait];
	
	for (NSString *str in expectedResults) {
		expect([asynchronous1.wordsProcessedAndResults[str] boolValue]).to.beTruthy();
	}
	
	
	/* Test the asynchronous matcher 2*/
	PatternMatcherBase *asynchronous2 = [[PatternMatcherGCD2 alloc] initWithLattice:l andWordList:wordList];
	[asynchronous2 startScanningIfEfficientWithCompletionBlock:^{
		[self.monitor signal];
	}];
	[self.monitor wait];
	
	for (NSString *str in expectedResults) {
		expect([asynchronous2.wordsProcessedAndResults[str] boolValue]).to.beTruthy();
	}
}

- (void)testWithSpecialCharacters
{
	id<LatticeCommon> l = [self cubeFromFileInThisBundleWithName:@"randomCube"];
	CSWordList *list = [[CSWordList alloc] init];
	[list addWord:@"[9±%CLy)-#"];
	[list addWord:@"m_F/©kwUgg"];
	[list addWord:@"84TL'y¢CR%"];
	
	
	PatternMatcherBase *sequential = [[PatternMatcherSequential alloc] initWithLattice:l andWordList:list];
	[sequential startScanningIfefficient];
	
	for (NSString *str in list) {
		expect([sequential.wordsProcessedAndResults[str] boolValue]).to.beTruthy();
	}

}

/**
 Test wether 2 asynchronous matchers can be ran at the same time without the universe exploding!
 */
- (void)testCorrectnessWithMultiplePatternMatchersRunning
{
	//set up
	NSSet *expectedResults = [NSSet setWithObjects:@"aaa", @"ccc", @"ddd", @"naa", @"mag", @"adg", @"___", @"lgg", @"bfe", nil];
	id<LatticeCommon> l = [self cubeFromFileInThisBundleWithName:@"testcube"];
	CSWordList *wordList = [self wordListFromThisBundleWithName:@"testWordList"];
	
	
	/* Test the sequential matcher */
	PatternMatcherBase *sequential = [[PatternMatcherSequential alloc] initWithLattice:l andWordList:wordList];
	[sequential startScanningIfefficient];
	
	for (NSString *str in expectedResults) {
		expect([sequential.wordsProcessedAndResults[str] boolValue]).to.beTruthy();
	}
	
	TRVSMonitor *internalMonitor = [[TRVSMonitor alloc] initWithExpectedSignalCount:2];
	
	/* Test the asynchronous matcher 1*/
	PatternMatcherBase *asynchronous1 = [[PatternMatcherGCD alloc] initWithLattice:l andWordList:wordList];
	[asynchronous1 startScanningIfEfficientWithCompletionBlock:^{
		[internalMonitor signal];
	}];

	
	
	/* Test the asynchronous matcher 2*/
	PatternMatcherBase *asynchronous2 = [[PatternMatcherGCD2 alloc] initWithLattice:l andWordList:wordList];
	[asynchronous2 startScanningIfEfficientWithCompletionBlock:^{
		[internalMonitor signal];
	}];
	
	
	[internalMonitor wait];
	
	for (NSString *str in expectedResults) {
		expect([asynchronous2.wordsProcessedAndResults[str] boolValue]).to.beTruthy();
	}
	for (NSString *str in expectedResults) {
		expect([asynchronous1.wordsProcessedAndResults[str] boolValue]).to.beTruthy();
	}
}
@end
