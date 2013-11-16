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
	//	__block __weak PatternMatcherGCD *weakSelf = self; //avoid circular references
	self.totalLinesProcessed = 0;
	
	
	dispatch_group_async(self.operationGroup, self.concurrentQ, ^{
		[self.latticeExtractor obtainHorizontallLinesForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
			[self serialySearchForStringsInLine:line];
		}];
	});
	
	dispatch_group_async(self.operationGroup, self.concurrentQ, ^{
		[self.latticeExtractor obtainLinesInIntraLatticeForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
			[self serialySearchForStringsInLine:line];
		}];
	});
	
	
	dispatch_group_async(self.operationGroup, self.concurrentQ, ^{
		[self.latticeExtractor obtainVerticalLinesForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
			[self serialySearchForStringsInLine:line];
		}];
	});
	
	
	dispatch_group_async(self.operationGroup, self.concurrentQ, ^{
		[self.latticeExtractor obtainDiagonalLinesTopLeftBottomRightForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
			[self serialySearchForStringsInLine:line];
		}];
	});
	
	dispatch_group_async(self.operationGroup, self.concurrentQ, ^{
		[self.latticeExtractor obtainDiagonalLinesBottomLeftTopRightForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
			[self serialySearchForStringsInLine:line];
		}];
	});
	
	dispatch_group_async(self.operationGroup, self.concurrentQ, ^{
		[self.latticeExtractor obtainDiagonalHeightConstantZ2ForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
			[self serialySearchForStringsInLine:line];
		}];
	});
	
	dispatch_group_async(self.operationGroup, self.concurrentQ, ^{
		[self.latticeExtractor obtainDiagonalHeightConstantZ1ForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
			[self serialySearchForStringsInLine:line];
		}];
	});
	
	dispatch_group_notify(self.operationGroup, self.concurrentQ, ^{
		[self allTasksDone];
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
