//
//  CSWordList.m
//  LatticeCreator
//
//  Created by Christos Sotiriou on 20/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import "CSWordList.h"
#import "CSFileReader.h"

@interface CSWordList () <CSFileReaderDelegate>
@property (nonatomic, strong) NSMutableOrderedSet *wordList;
@property (nonatomic, strong) CSFileReader *reader;
@end


@implementation CSWordList
- (id)init
{
    self = [super init];
    if (self) {
        self.wordList = [NSMutableOrderedSet orderedSet];
    }
    return self;
}



- (void)addWord:(NSString *)word
{
	NSString *actualWord = [word stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
	if (self.wordList.count > 0) {
		NSString *randomWord = [self.wordList lastObject];
		if (randomWord.length != actualWord.length) {
			@throw [NSException exceptionWithName:@"Invalid Word" reason:@"Tried to add a word to the list with different length than the other words" userInfo:nil];
		}else{
			[self.wordList addObject:actualWord];
		}
	}else if (self.wordList.count == 0){
		if (actualWord.length < 2) {
			@throw [NSException exceptionWithName:@"Invalid Word" reason:@"Tried to add a word to the list size less than 2" userInfo:nil];
		}else{
			[self.wordList addObject:actualWord];
		}
	}
}

- (void)loadWordListFromFile:(NSString *)filePath
{
	self.reader = [[CSFileReader alloc] init];
	self.reader.delegate = self;
	[self.reader startReadingLineByLineFileAtPath:filePath encoding:NSUTF8StringEncoding];
}


- (void)fileReader:(CSFileReader *)reader didEncounterLine:(NSString *)line
{
	[self addWord:line];
}

- (void)fileReaderDidEndProcessingFile:(CSFileReader *)reader
{
	
}



- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(__unsafe_unretained id [])buffer count:(NSUInteger)len
{
	return [self.wordList countByEnumeratingWithState:state objects:buffer count:len];
}

- (NSOrderedSet *)words
{
	return _wordList;
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
