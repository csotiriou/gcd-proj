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
@end

@implementation PatternMatcherBase

- (id)initWithLattice:(id<LatticeCommon>)lattice andDictionaryToSearch:(NSArray *)dictionaryOfWords
{
	if (self = [super init]) {
		self.lattice = lattice;
		self.dictionaryToSearch = [NSMutableArray array];
		self.dictionaryToSearchReverse = [NSMutableArray array];
		self.latticeExtractor = [[LatticeLineExtractor alloc] init];
		
		
		//now trying to eliminate duplicate values to avoid multiple useless operations
		NSSet *uniques = [NSSet setWithArray:dictionaryOfWords];
		[self.dictionaryToSearch addObjectsFromArray:uniques.allObjects];
		
		//add the reversed words to the array to search. instead of reversing
		//each of the found strings in order to search for a direction, we can just pre-calculate
		//the reversed search strings from the start, and search for them instead.
		for (NSString *word in self.dictionaryToSearch) {
			[self.dictionaryToSearchReverse addObject:[word reversedString]];
		}
		
		
		self.wordsProcessedAndResults = [NSMutableDictionary dictionaryWithCapacity:self.dictionaryToSearch.count];
		for (NSString *word in self.dictionaryToSearch) {
			[self.wordsProcessedAndResults setValue:@NO forKey:word];
		}
	}
	return self;
}


- (void)matchStringsForLine:(NSString *)line withFoundBlock:(void(^)(NSString *wordFound))foundBlock
{
	for (int i = 0; i < self.dictionaryToSearch.count; i++) {
		NSString *word = [self.dictionaryToSearch objectAtIndex:i];
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
	self.hasAlreadyRan = YES;
	if ([self.delegate respondsToSelector:@selector(patternMatcher:didFinishWithResults:)]) {
		[self.delegate patternMatcher:self didFinishWithResults:self.wordsProcessedAndResults];
	}
}

- (NSArray *)reversedDictionaryToSearch
{
	return _dictionaryToSearchReverse;
}


- (void)startScanning
{
	@throw [NSException exceptionWithName:@"You must implement this function to subclasses" reason:@"" userInfo:nil];
}

@end
