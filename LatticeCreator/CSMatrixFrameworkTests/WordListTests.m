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
}

- (void)tearDown
{
    [super tearDown];
}


- (void)testCreation
{
	CSWordList *wordList = [[CSWordList alloc] init];
	expect(wordList).to.notTo.beNil();
	expect(wordList.wordLength).to.equal(0);
	expect(wordList.words).to.notTo.beNil();
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

- (void)testLoadingLimited
{
	CSWordList *wordList = [[CSWordList alloc] init];
	NSBundle *mainBundle = [NSBundle bundleForClass:[self class]];
	NSString *filePath = [mainBundle pathForResource:@"wordlist1" ofType:@"wdl"];
	
	[wordList loadWordListFromFile:filePath maximumCountOfWordsToRead:1];
	
	for (int i = 0; i < wordList.words.count; i++) {
		expect(wordList.words[i]).to.equal([NSString stringWithFormat:@"word%i", i+1]);
	}
	expect(wordList.words.count).to.equal(1);
}

- (void)testSavingAndLoading
{
	CSWordList *wordList = [[CSWordList alloc] init];
	NSBundle *mainBundle = [NSBundle bundleForClass:[self class]];
	NSString *filePath = [mainBundle pathForResource:@"wordlist1" ofType:@"wdl"];
	
	[wordList loadWordListFromFile:filePath];
	
	NSString *testFile = [@"~/.testFile" stringByStandardizingPath];
	[wordList extractListToFileAtPath:testFile];
	
	CSWordList *loadedWordList = [[CSWordList alloc] init];
	[loadedWordList loadWordListFromFile:testFile];
	
	for (int i=0; i<loadedWordList.count; i++) {
		expect(loadedWordList[i]).to.equal(wordList[i]);
	}

	if ([[NSFileManager defaultManager] fileExistsAtPath:testFile]) {
		[[NSFileManager defaultManager] removeItemAtPath:testFile error:NULL];
	}
}

- (void)testNewLiteralSyntax
{
	CSWordList *wordList = [[CSWordList alloc] init];
	NSBundle *mainBundle = [NSBundle bundleForClass:[self class]];
	NSString *filePath = [mainBundle pathForResource:@"wordlist1" ofType:@"wdl"];
	
	[wordList loadWordListFromFile:filePath];
	
	for (int i = 0; i < wordList.words.count; i++) {
		expect(wordList[i]).to.equal([NSString stringWithFormat:@"word%i", i+1]);
	}
}

- (void)testCount
{
	CSWordList *wordList = [[CSWordList alloc] init];
	expect(wordList.count).to.equal(0);
	
	NSBundle *mainBundle = [NSBundle bundleForClass:[self class]];
	NSString *filePath = [mainBundle pathForResource:@"wordlist1" ofType:@"wdl"];
	[wordList loadWordListFromFile:filePath];
	
	expect(wordList.count).to.equal(6);
	[wordList addWord:@"word7"];
	expect(wordList.count).to.equal(7);
	
	[wordList loadWordListFromFile:filePath];
	expect(wordList.count).to.equal(6);
}

- (void)testWordLength
{
	CSWordList *wordList = [[CSWordList alloc] init];
	expect(wordList.wordLength).to.equal(0); //empty wordlist returns 0 as the word length
	
	NSBundle *mainBundle = [NSBundle bundleForClass:[self class]];
	NSString *filePath = [mainBundle pathForResource:@"wordlist1" ofType:@"wdl"];
	[wordList loadWordListFromFile:filePath];
	expect(wordList.wordLength).to.equal(5);
}


- (void)testAddWord
{
	CSWordList *wordList = [[CSWordList alloc] init];
	expect(wordList.wordLength).to.equal(0); //empty wordlist returns 0 as the word length
	expect(wordList.count).to.equal(0);
	
	[wordList addWord:@"word1"];
	expect(wordList.count).to.equal(1);
	expect(wordList.words.lastObject).to.equal(@"word1");
	expect(wordList.wordLength).to.equal(5);
}

- (void)testAddManyWords
{
	CSWordList *wordList = [[CSWordList alloc] init];
	expect(wordList.wordLength).to.equal(0); //empty wordlist returns 0 as the word length

	[wordList addWords:@[@"word1", @"word2", @"word3"]];
	expect(wordList.count).to.equal(3);
	expect(wordList.wordLength).to.equal(5);
}


- (void)testAddNewWordsInvalid
{
	CSWordList *wordList = [[CSWordList alloc] init];
	
	NSBundle *mainBundle = [NSBundle bundleForClass:[self class]];
	NSString *filePath = [mainBundle pathForResource:@"wordlist1" ofType:@"wdl"];
	[wordList loadWordListFromFile:filePath];
	
	//should throw an exception if ee try to add a word with different letter counts than the rest
	//of them.
	XCTAssertThrows([wordList addWord:@"a word that doesn't fit"], @"error: no exception thrown when adding a word that has different letter count from the other ones inside the list");
	XCTAssertThrows([wordList addWord:@"word"], @"error: no exception thrown when adding a word that has different letter count from the other ones inside the list");
	XCTAssertThrows([wordList addWord:@"word\n"], @"error: should throw exception when adding a character that is not supported (newline)");
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
