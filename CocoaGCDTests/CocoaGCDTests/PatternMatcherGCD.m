//
//  PatternMatcherGCD.m
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 6/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import "PatternMatcherGCD.h"


@interface PatternMatcherGCD ()
@property (nonatomic) unsigned long long totalLinesProcessed;
@end

@implementation PatternMatcherGCD


- (void)startScanning
{
	[self startInternalThreads];
	dispatch_group_notify(self.operationGroup, self.concurrentQ, ^{
		[self allTasksDone];
	});
}

- (void)startScanningWithCompletionBlock:(void (^)())completionBlock
{
	[self startInternalThreads];
	dispatch_group_notify(self.operationGroup, self.concurrentQ, ^{
		[self allTasksDone];
		completionBlock();
	});
}

- (void)startInternalThreads
{
//	__block __weak PatternMatcherGCD *weakSelf = self; //avoid circular references
	self.totalLinesProcessed = 0;
	
	
	dispatch_group_async(self.operationGroup, self.concurrentQ, ^{
		CS_MACRO_BEGIN_TIME(@"obtainHorizontallLinesForLattice");
		[self.latticeExtractor obtainHorizontallLinesForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
			[self serialySearchForStringsInLine:line];
		}];
		CS_MACRO_END_DISPLAY;
	});
	
	dispatch_group_async(self.operationGroup, self.concurrentQ, ^{
		CS_MACRO_BEGIN_TIME(@"obtainLinesInIntraLatticeForLattice");
		[self.latticeExtractor obtainLinesInIntraLatticeForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
			[self serialySearchForStringsInLine:line];
		}];
		CS_MACRO_END_DISPLAY;
	});
	
	
	dispatch_group_async(self.operationGroup, self.concurrentQ, ^{
		CS_MACRO_BEGIN_TIME(@"obtainVerticalLinesForLattice");
		[self.latticeExtractor obtainVerticalLinesForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
			[self serialySearchForStringsInLine:line];
		}];
		CS_MACRO_END_DISPLAY;
	});
	
	
	dispatch_group_async(self.operationGroup, self.concurrentQ, ^{
		CS_MACRO_BEGIN_TIME(@"obtainDiagonalLinesTopLeftBottomRightForLattice");
		[self.latticeExtractor obtainDiagonalLinesTopLeftBottomRightForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
			[self serialySearchForStringsInLine:line];
		}];
		CS_MACRO_END_DISPLAY;
	});
	
	dispatch_group_async(self.operationGroup, self.concurrentQ, ^{
		CS_MACRO_BEGIN_TIME(@"obtainDiagonalLinesBottomLeftTopRightForLattice");
		[self.latticeExtractor obtainDiagonalLinesBottomLeftTopRightForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
			[self serialySearchForStringsInLine:line];
		}];
		CS_MACRO_END_DISPLAY;
	});
	
	dispatch_group_async(self.operationGroup, self.concurrentQ, ^{
		CS_MACRO_BEGIN_TIME(@"obtainDiagonalHeightConstantZ2ForLattice");
		[self.latticeExtractor obtainDiagonalHeightConstantZ2ForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
			[self serialySearchForStringsInLine:line];
		}];
		CS_MACRO_END_DISPLAY;
	});
	
	dispatch_group_async(self.operationGroup, self.concurrentQ, ^{
		CS_MACRO_BEGIN_TIME(@"obtainDiagonalHeightConstantZ1ForLattice");
		[self.latticeExtractor obtainDiagonalHeightConstantZ1ForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
			[self serialySearchForStringsInLine:line];
		}];
		CS_MACRO_END_DISPLAY;
	});
}

- (void)addAsynchronousGroupOperation:(void(^)())operation
{
	dispatch_group_async(self.operationGroup, self.concurrentQ, operation);
}

- (void)serialySearchForStringsInLine:(NSString *)line
{
	self.totalLinesProcessed++;
	[self matchStringsForLine:line withFoundBlock:^(NSString *wordFound) {
		[self seriallyAccessResultsDictionaryWithValue:@YES forKey:wordFound];
	}];
}



- (void)allTasksDone
{
	DDLogVerbose(@"all tasks are done");
	DDLogVerbose(@"total lines processed: %llu", self.totalLinesProcessed);
	//	NSDate *endDate = [NSDate date];
	//	NSTimeInterval timeInterval = [endDate timeIntervalSinceDate:self.startDate];
	//	DDLogVerbose(@"time needed: %f", timeInterval);
	
	[self signalComplete];
}





- (void)dealloc
{
	
}

@end
