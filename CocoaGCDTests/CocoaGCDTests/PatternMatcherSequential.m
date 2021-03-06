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



- (void)startScanning
{
	//notify the delegate that we are starting the proces...
	if ([self.delegate respondsToSelector:@selector(patternMatcherDidStartScanning:)]) {
		[self.delegate patternMatcherDidStartScanning:self];
	}
	
	//Now, for each direction, get the lines sequentially and process them.
	CS_MACRO_BEGIN_TIME(@"scanning entire cube");
	{
	NSDate *date = [NSDate date];
	CS_MACRO_BEGIN_TIME(@"obtainDiagonalLinesBottomLeftTopRightForLattice");
	[self.latticeExtractor obtainDiagonalLinesBottomLeftTopRightForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
		[self serialySearchForStringsInLine:line];
	}];
	NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:date];
	NSLog(@"time interval: %f", interval);
	CS_MACRO_END_DISPLAY
	}
	
	{
	CS_MACRO_BEGIN_TIME(@"obtainDiagonalLinesTopLeftBottomRightForLattice");
	[self.latticeExtractor obtainDiagonalLinesTopLeftBottomRightForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
		[self serialySearchForStringsInLine:line];
	}];
	CS_MACRO_END_DISPLAY
	}
	
	{
	CS_MACRO_BEGIN_TIME(@"obtainDiagonalLinesBottomLeftTopRightForLattice")
	[self.latticeExtractor obtainHorizontallLinesForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
		[self serialySearchForStringsInLine:line];
	}];
	CS_MACRO_END_DISPLAY
	}
	
	{
	CS_MACRO_BEGIN_TIME(@"obtainLinesInIntraLatticeForLattice");
	[self.latticeExtractor obtainLinesInIntraLatticeForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
		[self serialySearchForStringsInLine:line];
	}];
	CS_MACRO_END_DISPLAY
	}
	
	{
	CS_MACRO_BEGIN_TIME(@"obtainVerticalLinesForLattice");
	[self.latticeExtractor obtainVerticalLinesForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
		[self serialySearchForStringsInLine:line];
	}];
	CS_MACRO_END_DISPLAY
	}
	
	{
	CS_MACRO_BEGIN_TIME(@"obtainDiagonalHeightConstantZ1ForLattice")
	[self.latticeExtractor obtainDiagonalHeightConstantZ1ForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
		[self serialySearchForStringsInLine:line];
	}];
	CS_MACRO_END_DISPLAY
	}
	
	{
	CS_MACRO_BEGIN_TIME(@"obtainDiagonalHeightConstantZ2ForLattice");
	[self.latticeExtractor obtainDiagonalHeightConstantZ2ForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
		[self serialySearchForStringsInLine:line];
	}];
	CS_MACRO_END_DISPLAY
	}
	
	CS_MACRO_END_DISPLAY
	
	//notify everyone that the operation is complete.
	[self signalComplete];
	
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
