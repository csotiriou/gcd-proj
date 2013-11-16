//
//  PatternMatcherGCD.m
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 6/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import "PatternMatcherGCD.h"


@interface PatternMatcherGCD ()
@property (nonatomic, strong) dispatch_queue_t backgroundProcessQueue;
@property (nonatomic, strong) dispatch_queue_t serialQueue;
@property (nonatomic, strong) dispatch_group_t operationGroup;
@property (nonatomic, strong) NSMutableDictionary *wordsProcessedAndResults;

@property (nonatomic) unsigned long long totalLinesProcessed;
@property (nonatomic, strong) NSDate *startDate;
@end

@implementation PatternMatcherGCD

- (id)initWithLattice:(id<LatticeCommon>)lattice andDictionaryToSearch:(NSArray *)dictionaryOfWords
{
	if (self = [super initWithLattice:lattice andDictionaryToSearch:dictionaryOfWords]) {
		[self initThreads];
		
		self.wordsProcessedAndResults = [NSMutableDictionary dictionaryWithCapacity:self.dictionaryToSearch.count];
		for (NSString *word in self.dictionaryToSearch) {
			[self.wordsProcessedAndResults setValue:@NO forKey:word];
		}
	}
	return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self initThreads];
    }
    return self;
}

- (void)initThreads
{
	self.backgroundProcessQueue = dispatch_queue_create("com.oramind.concurrent", DISPATCH_QUEUE_CONCURRENT);
	self.serialQueue = dispatch_queue_create("com.oramind.serial", DISPATCH_QUEUE_SERIAL);
	self.operationGroup = dispatch_group_create();
}


- (void)startScanning
{
//	__block __weak PatternMatcherGCD *weakSelf = self; //avoid circular references
	self.totalLinesProcessed = 0;
	self.startDate = [NSDate date];
	
	
	
	dispatch_group_async(self.operationGroup, self.backgroundProcessQueue, ^{
		[self.latticeExtractor obtainHorizontallLinesForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
			[self serialySearchForStringsInLine:line];
		}];
		
	});
	
	dispatch_group_async(self.operationGroup, self.backgroundProcessQueue, ^{
		[self.latticeExtractor obtainLinesInIntraLatticeForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
			[self serialySearchForStringsInLine:line];
		}];
	});
	
	
	dispatch_group_async(self.operationGroup, self.backgroundProcessQueue, ^{
		[self.latticeExtractor obtainVerticalLinesForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
			[self serialySearchForStringsInLine:line];
		}];
	});
	
	
	dispatch_group_async(self.operationGroup, self.backgroundProcessQueue, ^{
		[self.latticeExtractor obtainDiagonalLinesTopLeftBottomRightForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
			[self serialySearchForStringsInLine:line];
		}];
	});
	
	dispatch_group_async(self.operationGroup, self.backgroundProcessQueue, ^{
		[self.latticeExtractor obtainDiagonalLinesBottomLeftTopRightForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
			[self serialySearchForStringsInLine:line];
		}];
	});
	
	dispatch_group_async(self.operationGroup, self.backgroundProcessQueue, ^{
		[self.latticeExtractor obtainDiagonalHeightConstantZ2ForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
			[self serialySearchForStringsInLine:line];
		}];
	});
	
	dispatch_group_async(self.operationGroup, self.backgroundProcessQueue, ^{
		[self.latticeExtractor obtainDiagonalHeightConstantZ1ForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
			[self serialySearchForStringsInLine:line];
		}];
	});
		
	dispatch_group_notify(self.operationGroup, self.backgroundProcessQueue, ^{
		[self allTasksDone];
	});

}

- (void)addAsynchronousGroupOperation:(void(^)())operation
{
	dispatch_group_async(self.operationGroup, self.backgroundProcessQueue, operation);
}

- (void)serialySearchForStringsInLine:(NSString *)line
{
	self.totalLinesProcessed++;
	//serialize access to the array that we have to search, and eliminate elements that we have already found to ease the burden
	for (NSString *word in self.dictionaryToSearch) {
		if ([[self.wordsProcessedAndResults valueForKey:word] boolValue] == NO) {
			if ([line rangeOfString:word].location != NSNotFound) {
				//				[self.wordsProcessedAndResults setValue:@YES forKey:word];
				[self seriallyAccessResultsDictionaryWithValue:@YES forKey:word];			}
		}
	}
}

- (void)scanVerticalLines
{
	@autoreleasepool {
		NSArray *lines = [self obtainVerticalLinesForProcessing];
		for (NSString *word in self.dictionaryToSearch) {
			if ([Util array:lines ContainsString:word]) {
				//				[self.wordsProcessedAndResults setValue:@YES forKey:word];
				[self seriallyAccessResultsDictionaryWithValue:@YES forKey:word];			}
		}
	}
}

- (void)scanHorizontalLines
{
	@autoreleasepool {
		NSArray *lines = [self obtainHorizontallLinesForProcessing];
		for (NSString *word in self.dictionaryToSearch) {
			if ([Util array:lines ContainsString:word]) {
				//				[self.wordsProcessedAndResults setValue:@YES forKey:word];
				[self seriallyAccessResultsDictionaryWithValue:@YES forKey:word];			}
		}
	}
}

- (void)scanDiagonal1
{
	@autoreleasepool {
		NSArray *lines = [self obtainDiagonalLinesBottomLeftTopRight];
		for (NSString *word in self.dictionaryToSearch) {
			if ([Util array:lines ContainsString:word]) {
				//				[self.wordsProcessedAndResults setValue:@YES forKey:word];
				[self seriallyAccessResultsDictionaryWithValue:@YES forKey:word];
			}
		}
	}
}

- (void)scanDiagonal2
{
	@autoreleasepool {
		NSArray *lines = [self obtainDiagonalLinesTopLeftBottomRight];
		for (NSString *word in self.dictionaryToSearch) {
			if ([Util array:lines ContainsString:word]) {
				//				[self.wordsProcessedAndResults setValue:@YES forKey:word];
				[self seriallyAccessResultsDictionaryWithValue:@YES forKey:word];
			}
		}
	}
}


/**
 Forces serial access to the dictionary which holds the results, to avoid multithreading issues.
 
 @param value the parameter to associate with the value
 @param key the key to associate the value with.
 */
- (void)seriallyAccessResultsDictionaryWithValue:(id)value forKey:(NSString *)key
{
	dispatch_async(self.serialQueue, ^{
		[self.wordsProcessedAndResults setValue:value forKey:key];
	});
}

- (void)allTasksDone
{
	DDLogVerbose(@"all tasks are done");
	DDLogVerbose(@"total lines processed: %llu", self.totalLinesProcessed);
	NSDate *endDate = [NSDate date];
	NSTimeInterval timeInterval = [endDate timeIntervalSinceDate:self.startDate];
	DDLogVerbose(@"time needed: %f", timeInterval);
	
	[self signalComplete];
}

- (void)testThreads
{
	__block int threadNum = 0;
	
	for (int i = 0; i<100; i++) {
		dispatch_async(_backgroundProcessQueue, ^{
			NSLog(@"beginning... %i", threadNum);
			threadNum++;
		});
	}
}



- (void)dealloc
{
	
}

@end
