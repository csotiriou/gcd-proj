//
//  PatternMatcher.m
//  GCDTests
//
//  Created by Christos Sotiriou on 30/10/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import "PatternMatcherSequential.h"

@interface PatternMatcherSequential ()
@property (nonatomic, strong) NSMutableDictionary *wordsProcessedAndResults;
@property (nonatomic) BOOL hasAlreadyRan;
@end

@implementation PatternMatcherSequential

- (id)initWithLattice:(id<LatticeCommon>)lattice andDictionaryToSearch:(NSArray *)dictionaryOfWords
{
    self = [super initWithLattice:lattice andDictionaryToSearch:dictionaryOfWords];
    if (self) {
		self.wordsProcessedAndResults = [NSMutableDictionary dictionaryWithCapacity:self.dictionaryToSearch.count];
		self.hasAlreadyRan = NO;
		for (NSString *word in self.dictionaryToSearch) {
			[self.wordsProcessedAndResults setValue:@NO forKey:word];
		}
    }
    return self;
}


- (void)startScanning
{
	@autoreleasepool {
		NSArray *lines = [self obtainHorizontallLinesForProcessing];
		for (NSString *word in self.dictionaryToSearch) {
			if ([self array:lines ContainsString:word]) {
				[self.wordsProcessedAndResults setValue:@YES forKey:word];
			}
		}
	}

	@autoreleasepool {
		NSArray *lines = [self obtainVerticalLinesForProcessing];
		for (NSString *word in self.dictionaryToSearch) {
			if ([self array:lines ContainsString:word]) {
				[self.wordsProcessedAndResults setValue:@YES forKey:word];
			}
		}
	}
	@autoreleasepool {
		NSArray *lines = [self obtainDiagonalLinesBottomLeftTopRight];
		for (NSString *word in self.dictionaryToSearch) {
			if ([self array:lines ContainsString:word]) {
				[self.wordsProcessedAndResults setValue:@YES forKey:word];
			}
		}
	}
	@autoreleasepool {
		NSArray *lines = [self obtainDiagonalLinesTopLeftBottomRight];
		for (NSString *word in self.dictionaryToSearch) {
			if ([self array:lines ContainsString:word]) {
				[self.wordsProcessedAndResults setValue:@YES forKey:word];
			}
		}
	}
	self.hasAlreadyRan = YES;
}

- (BOOL)array:(NSArray *)array ContainsString:(NSString *)string
{
	for (NSString *str in array) {
		if ([str rangeOfString:string].location != NSNotFound) {
			return YES;
		}
	}
	return NO;
}


- (NSDictionary *)getResults
{
	if (!self.hasAlreadyRan) {
		[self startScanning];
	}
	return self.wordsProcessedAndResults;
}



@end
