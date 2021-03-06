//
//  PatternMatcherAsynchronous.m
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 16/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import "PatternMatcherAsynchronous.h"

@interface PatternMatcherAsynchronous ()
/**
 Concurrent Grand Central Dispatch queue for performing multiple tasks in the background.
 */
@property (nonatomic, strong) dispatch_queue_t backgroundProcessQueue;

/**
 Serial queue, for serializing access to sensitive matrerial (like the resulting array).
 */
@property (nonatomic, strong) dispatch_queue_t serialQueue;

/**
 Operation group used for notifications of when all threads have finished processing.
 */
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


-(void)initPhase2
{
	[super initPhase2];
	[self initThreads];
}

- (void)initThreads
{
	self.backgroundProcessQueue = dispatch_queue_create("com.oramind.concurrent", DISPATCH_QUEUE_CONCURRENT);
	dispatch_queue_t sampleQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
	dispatch_set_target_queue(self.backgroundProcessQueue, sampleQueue); //method for setting the priority of our queue to that of the second argument.
	
	self.serialQueue = dispatch_queue_create("com.oramind.serial", DISPATCH_QUEUE_SERIAL);
	self.operationGrp = dispatch_group_create();
}




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
