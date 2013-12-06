//
//  PatternMatcherBase.m
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 4/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import "PatternMatcherBase.h"

@interface PatternMatcherBase ()
@property (nonatomic, strong) NSMutableArray *dictionaryToSearchReverse;
@property (nonatomic, strong) NSMutableArray *dictionaryToSearchNormal;

//@property (nonatomic, strong) NSMutableArray *actualDictionaryToSearch;
@end

@implementation PatternMatcherBase

- (id)initWithLattice:(id<LatticeCommon>)lattice andDictionaryToSearch:(NSArray *)dictionaryOfWords
{
	if (self = [super init]) {
		_lattice = lattice;
		[self initDefaults];
		
		//now trying to eliminate duplicate values to avoid multiple useless operations
		NSSet *uniques = [NSSet setWithArray:dictionaryOfWords];
		[self preProcessWordDictionary:uniques.allObjects];
		[self initPhase2];
	}
	return self;
}

- (void)initDefaults
{
	self.dictionaryToSearchNormal = [NSMutableArray array];
	self.dictionaryToSearchReverse = [NSMutableArray array];
	_latticeExtractor = [[LatticeLineExtractor alloc] init];
}

- (void)initPhase2{/* awaiting to be subclassed */}

- (id)initWithLattice:(id<LatticeCommon>)lattice andWordList:(CSWordList *)wordList
{
	if (self = [super init]) {
		_lattice = lattice;
		[self initDefaults];
		[self preProcessWordDictionary:wordList.words.array];
		[self initPhase2];
	}
	return self;
}


- (void)preProcessWordDictionary:(NSArray *)wordDictionary
{

	[self.dictionaryToSearchNormal addObjectsFromArray:wordDictionary];
	
	
	//add the reversed words to the array to search. instead of reversing
	//each of the found strings in order to search for a direction, we can just pre-calculate
	//the reversed search strings from the start, and search for them instead.
	for (NSString *word in self.dictionaryToSearchNormal) {
		[self.dictionaryToSearchReverse addObject:[word reversedString]];
	}
	
	//associate the words with a flag indicating if we have found them
	_wordsProcessedAndResults = [NSMutableDictionary dictionaryWithCapacity:self.dictionaryToSearchNormal.count];
	for (NSString *word in self.dictionaryToSearchNormal) {
		[self.wordsProcessedAndResults setValue:@NO forKey:word];
	}

}



- (void)matchStringsForLine:(NSString *)line withFoundBlock:(void(^)(NSString *wordFound))foundBlock
{
	for (int i = 0; i < self.dictionaryToSearchNormal.count; i++) {
		NSString *word = [self.dictionaryToSearchNormal objectAtIndex:i];
		if ([[self.wordsProcessedAndResults valueForKey:word] boolValue] == NO) { //only check if we have not found it already.
			NSString *reversedWord = [self.reversedDictionaryToSearch objectAtIndex:i];
			
			if ([line rangeOfString:word].location != NSNotFound || [line rangeOfString:reversedWord].location != NSNotFound) {
				foundBlock(word);
			}
		}
	}

}



- (void)signalComplete
{
	_hasAlreadyRan = YES;
	dispatch_async(dispatch_get_main_queue(), ^{
		if ([self.delegate respondsToSelector:@selector(patternMatcher:didFinishWithResults:)]) {
			[self.delegate patternMatcher:self didFinishWithResults:self.wordsProcessedAndResults];
		}
	});
}

- (NSArray *)reversedDictionaryToSearch
{
	return _dictionaryToSearchReverse;
}

- (NSArray *)dictionaryToSearch
{
	return _dictionaryToSearchNormal;
}

- (void)startScanningWithCompletionBlock:(void (^)())completionBlock
{
	@throw [NSException exceptionWithName:@"You must implement this function to subclasses" reason:@"Method Not implemented" userInfo:nil];

}

- (void)startScanning
{
	@throw [NSException exceptionWithName:@"You must implement this function to subclasses" reason:@"Method Not implemented" userInfo:nil];
}

@end
