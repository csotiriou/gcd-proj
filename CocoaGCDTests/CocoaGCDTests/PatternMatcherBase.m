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

/**
 associates the reversed strings to be searched with their normal ones.
 */
@property (nonatomic, strong) NSMutableDictionary *dictionaryFromReverseToNormal;
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
	self.dictionaryFromReverseToNormal = [NSMutableDictionary dictionary];
	
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
	
	//associate each word with its reverse, so that when we have the reverse word we can easily
	//find the normal one.
	for (int i=0; i<self.dictionaryToSearchNormal.count; i++) {
		self.dictionaryFromReverseToNormal[self.dictionaryToSearchNormal[i]] = self.dictionaryToSearchReverse[i];
	}

}



- (void)matchStringsForLine:(NSString *)line withFoundBlock:(void(^)(NSString *wordFound))foundBlock
{
	for (int i = 0; i < self.dictionaryToSearchNormal.count; i++) {
		NSString *word = [self.dictionaryToSearchNormal objectAtIndex:i];
		if ([[self.wordsProcessedAndResults valueForKey:word] boolValue] == NO) { //only check if we have not found it already.
			NSString *reversedWord = [self.reversedDictionaryToSearch objectAtIndex:i];
			
			if ([line rangeOfString:word options:NSLiteralSearch].location != NSNotFound || [line rangeOfString:reversedWord options:NSLiteralSearch].location != NSNotFound) {
				foundBlock(word);
			}
		}
	}
}

//-----------------THIS WAS ACTUALLY TWICE AS SLOW THAN PLAIN STRING ITERATION!!-------------------------
//- (void)matchStringsFastForLine:(NSString *)line withFoundBlock:(void(^)(NSString *wordFound))foundBlock
//{
//	CS_MACRO_BEGIN_TIME(@"------------------------------");
//	{//searching for strings normally
////		self.regularExpressionStraight = [[NSRegularExpression alloc] initWithPattern:[NSString stringWithFormat:@"\\b%@\\b", [self.dictionaryToSearchNormal componentsJoinedByString:@"|"]] options:0 error:NULL];
//		[self.regularExpressionStraight enumerateMatchesInString:line options:0 range:NSMakeRange(0, line.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
//			NSString *currentMatch = [line substringWithRange:result.range];
//			foundBlock(currentMatch);
//		}];
//	}
//
//	{//searching for reversed strings
////		NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:[NSString stringWithFormat:@"\\b%@\\b", [self.dictionaryToSearchReverse componentsJoinedByString:@"|"]] options:0 error:NULL];
//		[self.regularExpressionReverse enumerateMatchesInString:line options:0 range:NSMakeRange(0, line.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
//			NSString *currentMatch = [line substringWithRange:result.range];
//			foundBlock(self.dictionaryFromReverseToNormal[currentMatch]); //tell johny that we have found the string!
//		}];
//	}
//	CS_MACRO_END_DISPLAY;
//
//}



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
