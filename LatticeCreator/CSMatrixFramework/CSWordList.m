//
//  CSWordList.m
//  LatticeCreator
//
//  Created by Christos Sotiriou on 20/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import "CSWordList.h"
#import "CSFileReader.h"

@interface CSWordList () <CSFileReaderDelegate, CSFileReaderDataSource>
@property (nonatomic, strong) NSMutableOrderedSet *wordList;
@property (nonatomic, strong) CSFileReader *reader;

@property (nonatomic, strong) NSCharacterSet *acceptableCharacterSet;

@property (nonatomic) BOOL readingWithLimits;
@property (nonatomic) int targetFileLinesToProcess;
@property (nonatomic) int fileLinesProcessed;
@end


@implementation CSWordList
- (id)init
{
    self = [super init];
    if (self) {
		[self initdefaults];
    }
    return self;
}

- (id)initWithWords:(NSArray *)words
{
    self = [super init];
    if (self) {
        [self initdefaults];
		[self addWords:words];
    }
    return self;
}

- (void)initdefaults
{
	self.wordList = [NSMutableOrderedSet orderedSet];
	self.acceptableCharacterSet = [NSCharacterSet characterSetWithCharactersInString:kWordListAcceptableCharacters];
	self.fileLinesProcessed = 0;
	self.targetFileLinesToProcess = 0;
	self.readingWithLimits = NO;
}

#pragma mark - Functions

- (void)addWord:(NSString *)word
{
	NSString *actualWord = [word stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
	if (![self.acceptableCharacterSet isSupersetOfSet:[NSCharacterSet characterSetWithCharactersInString:actualWord]]) {
		@throw [NSException exceptionWithName:@"Invalid Word" reason:@"Tried to add a word to the list with characters other than the acceptable ones" userInfo:nil];
		return;
	}
	
	if (self.wordList.count > 0) {
		if (self.wordList.count == 1000) {
			@throw [NSException exceptionWithName:@"Could not add word" reason:@"Tried to add a word to the list which will make the list exceed the maximum (1000)" userInfo:nil];
		}else{
			NSString *randomWord = [self.wordList lastObject];
			if (randomWord.length != actualWord.length) {
				@throw [NSException exceptionWithName:@"Invalid Word" reason:@"Tried to add a word to the list with different length than the other words" userInfo:nil];
			}
		}
	}else if (self.wordList.count == 0){
		if (actualWord.length < 2) {
			@throw [NSException exceptionWithName:@"Invalid Word" reason:@"Tried to add a word to the list size less than 2" userInfo:nil];
		}
	}
	
	[self.wordList addObject:actualWord];
	self.fileLinesProcessed++;
}

- (void)addWords:(NSArray *)array
{
	for (NSString *word in array) {
		[self addWord:word];
	}
}

- (void)loadWordListFromFile:(NSString *)filePath
{
	self.readingWithLimits = NO;
	[self startReadingAtPath:filePath];
}

- (void)startReadingAtPath:(NSString *)path
{
	[self.wordList removeAllObjects];
	self.reader = [[CSFileReader alloc] init];
	self.fileLinesProcessed = 0;
	self.reader.delegate = self;
	self.reader.dataSource = self;
	[self.reader startReadingLineByLineFileAtPath:path encoding:NSUTF8StringEncoding];
}

- (void)loadWordListFromFile:(NSString *)filePath maximumCountOfWordsToRead:(int)maxWords
{
	self.targetFileLinesToProcess = maxWords;
	self.readingWithLimits = YES;
	[self startReadingAtPath:filePath];
}

- (void)extractListToFileAtPath:(NSString *)filePath
{
	NSFileManager *fm = [NSFileManager defaultManager];
	if (![fm fileExistsAtPath:filePath]) {
		[fm createFileAtPath:filePath contents:nil attributes:nil];
	}
	NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
	if (fileHandle) {
		for (NSString *str  in self.wordList) {
			[fileHandle writeData:[[NSString stringWithFormat:@"%@\n", str] dataUsingEncoding:NSUTF8StringEncoding]];
		}
	}
	[fileHandle closeFile];
}


#pragma mark - File reader delegate / datasource
- (void)fileReader:(CSFileReader *)reader didEncounterLine:(NSString *)line
{
	[self addWord:line];
}

- (void)fileReaderDidEndProcessingFile:(CSFileReader *)reader
{
	
}

- (BOOL)fileReaderShouldContinueProcessing:(CSFileReader *)fileReader
{
	if (self.fileLinesProcessed >= self.targetFileLinesToProcess && self.readingWithLimits) {
		return NO;
	}
	return YES;
}

#pragma mark - Getters / Setters, conforming to common protocols
- (NSString *)acceptableCharacters
{
	return kWordListAcceptableCharacters;
}


- (NSInteger)count
{
	return self.wordList.count;
}

- (NSInteger)wordLength
{
	return (self.wordList.count == 0? 0 : [self.wordList.lastObject length]);
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(__unsafe_unretained id [])buffer count:(NSUInteger)len
{
	return [self.wordList countByEnumeratingWithState:state objects:buffer count:len];
}

- (NSOrderedSet *)words
{
	return _wordList;
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx
{
	return [self.wordList objectAtIndexedSubscript:idx];
}

- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx
{
	@throw [NSException exceptionWithName:@"CSWordList does not allow setting obejcts directly to indexes, either with literals or without" reason:@"" userInfo:nil];
}

- (NSString *)description
{
	NSMutableString *str = [NSMutableString string];
	for (NSString *current in self.wordList) {
		[str appendFormat:@"%@\n", current];
	}
	return str;
}
@end
