//
//  PatternMatcherAsynchronous.m
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 16/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import "PatternMatcherAsynchronous.h"

@interface PatternMatcherAsynchronous ()
@property (nonatomic, strong) dispatch_queue_t backgroundProcessQueue;
@property (nonatomic, strong) dispatch_queue_t serialQueue;
@property (nonatomic, strong) dispatch_group_t operationGrp;
@end

@implementation PatternMatcherAsynchronous


- (id)init
{
    self = [super init];
    if (self) {
        [self initThreads];
    }
    return self;
}

- (id)initWithLattice:(id<LatticeCommon>)lattice andDictionaryToSearch:(NSArray *)dictionaryOfWords
{
	if (self = [super initWithLattice:lattice andDictionaryToSearch:dictionaryOfWords]) {
		[self initThreads];
	}
	return self;
}

- (void)initThreads
{
	self.backgroundProcessQueue = dispatch_queue_create("com.oramind.concurrent", DISPATCH_QUEUE_CONCURRENT);
	self.serialQueue = dispatch_queue_create("com.oramind.serial", DISPATCH_QUEUE_SERIAL);
	self.operationGrp = dispatch_group_create();
}


//- (void)serialySearchForStringsInLine:(NSString *)line
//{
//	//serialize access to the array that we have to search, and eliminate elements that we have already found to ease the burden
//	for (int i = 0; i < self.dictionaryToSearch.count; i++) {
//		NSString *word = [self.dictionaryToSearch objectAtIndex:i];
//		if ([[self.wordsProcessedAndResults valueForKey:word] boolValue] == NO) { //only check if we have not found it already.
//			NSString *reversedWord = [self.reversedDictionaryToSearch objectAtIndex:i];
//			
//			if ([line rangeOfString:word].location != NSNotFound || [line rangeOfString:reversedWord].location != NSNotFound) {
//				[self seriallyAccessResultsDictionaryWithValue:@YES forKey:word]; //set the flag for this element to true
//			}
//		}
//	}
//}


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

- (dispatch_queue_t)concurrentQ
{
	return _backgroundProcessQueue;
}

- (dispatch_queue_t)serialQ
{
	return _serialQueue;
}


- (dispatch_group_t)operationGroup
{
	return _operationGrp;
}
@end
