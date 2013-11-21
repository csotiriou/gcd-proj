//
//  WordListTests.m
//  LatticeCreator
//
//  Created by Christos Sotiriou on 21/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CSWordList.h"
#import "Expecta.h"

@interface WordListTests : XCTestCase
@end

@implementation WordListTests

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

- (void)testLoading
{
	CSWordList *wordList = [[CSWordList alloc] init];
	NSBundle *mainBundle = [NSBundle bundleForClass:[self class]];
	NSString *filePath = [mainBundle pathForResource:@"wordlist1" ofType:@"wdl"];
	
	[wordList loadWordListFromFile:filePath];
	
	for (int i = 0; i < wordList.words.count; i++) {
		expect(wordList.words[i]).to.equal([NSString stringWithFormat:@"word%i", i+1]);
	}
}

- (void)testFastEnumeration
{
	CSWordList *wordList = [[CSWordList alloc] init];
	NSBundle *mainBundle = [NSBundle bundleForClass:[self class]];
	NSString *filePath = [mainBundle pathForResource:@"wordlist1" ofType:@"wdl"];
	
	[wordList loadWordListFromFile:filePath];
	
	for (NSString *word in wordList) {
		expect(word).toNot.beNil();
	}
}

@end
