//
//  PatternMatcher.m
//  GCDTests
//
//  Created by Christos Sotiriou on 30/10/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import "PatternMatcherSequential.h"
#import <stdio.h>
#import <time.h>

@interface PatternMatcherSequential ()
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
	CS_MACRO_BEGIN_TIME(@"scanning entire cube");
	
	{
	CS_MACRO_BEGIN_TIME(@"obtainDiagonalLinesBottomLeftTopRightForLattice");
	[self.latticeExtractor obtainDiagonalLinesBottomLeftTopRightForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
		[self serialySearchForStringsInLine:line];
	}];
	CS_MACRO_END_DISPLAY;
	}
	
	{
	CS_MACRO_BEGIN_TIME(@"obtainDiagonalLinesTopLeftBottomRightForLattice");
	[self.latticeExtractor obtainDiagonalLinesTopLeftBottomRightForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
		[self serialySearchForStringsInLine:line];
	}];
	CS_MACRO_END_DISPLAY;
	}
	
	{
	CS_MACRO_BEGIN_TIME(@"obtainDiagonalLinesBottomLeftTopRightForLattice");
	[self.latticeExtractor obtainHorizontallLinesForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
		[self serialySearchForStringsInLine:line];
	}];
	CS_MACRO_END_DISPLAY;
	}
	
	{
	CS_MACRO_BEGIN_TIME(@"obtainLinesInIntraLatticeForLattice");
	[self.latticeExtractor obtainLinesInIntraLatticeForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
		[self serialySearchForStringsInLine:line];
	}];
	CS_MACRO_END_DISPLAY;
	}
	
	{
	CS_MACRO_BEGIN_TIME(@"obtainVerticalLinesForLattice");
	[self.latticeExtractor obtainVerticalLinesForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
		[self serialySearchForStringsInLine:line];
	}];
	CS_MACRO_END_DISPLAY;
	}
	
	{
	CS_MACRO_BEGIN_TIME(@"obtainDiagonalHeightConstantZ1ForLattice");
	[self.latticeExtractor obtainDiagonalHeightConstantZ1ForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
		[self serialySearchForStringsInLine:line];
	}];
	CS_MACRO_END_DISPLAY;
	}
	
	{
	CS_MACRO_BEGIN_TIME(@"obtainDiagonalHeightConstantZ2ForLattice");
	[self.latticeExtractor obtainDiagonalHeightConstantZ2ForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
		[self serialySearchForStringsInLine:line];
	}];
	CS_MACRO_END_DISPLAY;
	}
	
	CS_MACRO_END_DISPLAY;
	
	[self signalComplete];
	
	self.hasAlreadyRan = YES;
}

- (void)startScanningWithCompletionBlock:(void (^)())completionBlock
{
	[self startScanning];
	completionBlock();
}


- (void)serialySearchForStringsInLine:(NSString *)line
{
	[self matchStringsForLine:line withFoundBlock:^(NSString *wordFound) {
		[self.wordsProcessedAndResults setValue:@YES forKey:wordFound];
	}];
}

@end
