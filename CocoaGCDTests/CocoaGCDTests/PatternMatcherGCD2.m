//
//  PatternMatcherGCD2.m
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 16/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//
#import "PatternMatcherGCD2.h"



@interface PatternMatcherGCD2 ()
@property (nonatomic) int numberOfCores;

/**
 An array holding arrays of searchable words, intended to be distributed between threads so that each thread
 only searches for this word.
 */
@property (nonatomic, strong) NSMutableArray *arrayOfArraysWithWordDictionaries;
@end

@implementation PatternMatcherGCD2


- (void)initPhase2
{
	[super initPhase2];
	self.numberOfCores = [Util getNumberOfAvailableCoresForCurrentMachine];
	self.arrayOfArraysWithWordDictionaries = [NSMutableArray array];
}

- (void)startScanning
{
	[self startInternalThreads];
	dispatch_group_notify(self.operationGroup, self.concurrentQ, ^{
		[self signalComplete];
	});
}

- (void)startScanningWithCompletionBlock:(void (^)())completionBlock
{
	[self startInternalThreads];
	dispatch_group_notify(self.operationGroup, self.concurrentQ, ^{
		[self signalComplete];
		completionBlock();
	});
}


- (void)startInternalThreads
{
	if ([self.delegate respondsToSelector:@selector(patternMatcherDidStartScanning:)]) {
		[self.delegate patternMatcherDidStartScanning:self];
	}
	
	[self.arrayOfArraysWithWordDictionaries removeAllObjects];
	[self divideDictionariesBy:self.numberOfCores];
	
	/*
	 We are going to have one operation for each silo, and in each 'silo' we will search all directions
	 for a specific portion of the list of search strings we want.
	 */
	for (int i = 0; i<self.arrayOfArraysWithWordDictionaries.count; i++) {
		
		dispatch_group_async(self.operationGroup, self.concurrentQ, ^{
			
			NSString *currentOperation = [NSString stringWithFormat:@" beginning operations for silo: %i", i];
			CS_MACRO_BEGIN_TIME(currentOperation);
			[self.latticeExtractor obtainHorizontallLinesForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
				[self asynchronouslySearchForLine:line forSiloAtIndex:i];
			}];
			
			[self.latticeExtractor obtainLinesInIntraLatticeForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
				[self asynchronouslySearchForLine:line forSiloAtIndex:i];
			}];
			
			[self.latticeExtractor obtainVerticalLinesForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
				[self asynchronouslySearchForLine:line forSiloAtIndex:i];
			}];
			
			[self.latticeExtractor obtainDiagonalLinesTopLeftBottomRightForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
				[self asynchronouslySearchForLine:line forSiloAtIndex:i];
			}];
			
			[self.latticeExtractor obtainDiagonalLinesBottomLeftTopRightForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
				[self asynchronouslySearchForLine:line forSiloAtIndex:i];
			}];
			
			[self.latticeExtractor obtainDiagonalHeightConstantZ2ForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
				[self asynchronouslySearchForLine:line forSiloAtIndex:i];
			}];
			
			[self.latticeExtractor obtainDiagonalHeightConstantZ1ForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
				[self asynchronouslySearchForLine:line forSiloAtIndex:i];
			}];
			CS_MACRO_END_DISPLAY;
		});
	}
}

/**
 Matches the patterns found in the appropriate slot (because each processor will look into specific silos)
 @param line the line to search for
 @param index the index of the pool with the words to search
 */
- (void)asynchronouslySearchForLine:(NSString *)line forSiloAtIndex:(int)index

{
	NSArray *currentArray = self.arrayOfArraysWithWordDictionaries[index];
	for (SearchableWord *word in currentArray) {
		if ([line rangeOfString:word.wordToSearch].location != NSNotFound || [line rangeOfString:word.reverseWord].location != NSNotFound) {
			[self seriallyAccessResultsDictionaryWithValue:@YES forKey:word.wordToSearch];
		}
	}
	
}


/**
 Separates the jobs to be done according to the words that are to be searched and the processors available.
 Creates a mutable array with items equal to the number of processors. Each item is also an array holding the
 words that are to be processed by the processor at this index. Each place in this internal array contains an object
 which contains the word to be found and its reverse.
 */
- (void)divideDictionariesBy:(int)divisionCount
{
	if (divisionCount % 2 != 0) {
		@throw [NSException exceptionWithName:@"INVALID CORES" reason:[NSString stringWithFormat:@"tried to divide jobs by %i. Have you ever heard of a computer with %i cores???", divisionCount, divisionCount] userInfo:nil];
	}
	DDLogVerbose(@"separating jobs in %i processors", divisionCount);
	[self.arrayOfArraysWithWordDictionaries removeAllObjects];
	
	//create the placeholder arrays for the divided works
	for (int i = 0; i<divisionCount; i++) {
		[self.arrayOfArraysWithWordDictionaries addObject:[NSMutableArray array]];
	}
	
	
	//fill the placeholders with words to be processed
	int currentProcessorIndex = 0;
	for (int i =0; i<self.dictionaryToSearch.count; i++) {
		NSString *word = self.dictionaryToSearch[i];
		NSString *reversed = self.reversedDictionaryToSearch[i];
		SearchableWord *newWord = [[SearchableWord alloc] init];
		newWord.wordToSearch = word;
		newWord.reverseWord = reversed;
		DDLogVerbose(@"word: '%@' with its reverse goes into processor %i/%i", newWord.wordToSearch, currentProcessorIndex + 1, divisionCount);
		
		[self.arrayOfArraysWithWordDictionaries[currentProcessorIndex] addObject:newWord]; //add the word to search with its reverse to the queue for this processor
		currentProcessorIndex++;//increase the processor index
		if (currentProcessorIndex >= self.numberOfCores) {
			currentProcessorIndex = 0;
		}
	}
}
@end




#pragma mark - Searchable Word Implementation
@implementation SearchableWord
- (NSString *)description
{
	return [NSString stringWithFormat:@"Word: %@, Reverse Word: %@", self.wordToSearch, self.reverseWord];
}

@end