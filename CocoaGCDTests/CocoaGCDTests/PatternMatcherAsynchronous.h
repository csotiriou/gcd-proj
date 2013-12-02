//
//  PatternMatcherAsynchronous.h
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 16/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import "PatternMatcherBase.h"

/**
 PatternMatcherAsynchronous is the basis for creating an asynchronous pattern matcher. It contains a concurrent queue, a serial queue for access to sensitive data, and an operation group, which will notify any delegate for the completion of the operations. This class is meant to be used as an abstract class, never directly.
 
 Tips for subclassing:
 -- override -initPhase2 to perform additional setups. You MUST call [super initPhase2] to properly initialise it.
 -- override the -startRunning and / or the startRunning:withCompletionBlock and provide your own solution, and customise the behavior. Use concurrentQ to allow multiple threads to run at once, and use operationGroup to perform actions when all threads have finished their work.
 -- although that may be not necessary, you can use seriallyAccessResultsDictionaryWithValue:forKey to set a value for the result dictionary. The dictionary will be accessed using a serial manner (using the serialQ), so it is the most thread-safe way to make changes to the array of results.
 */
@interface PatternMatcherAsynchronous : PatternMatcherBase

/**
 The concurrent queue to load with concurrent threads.
 */
@property (nonatomic, readonly) dispatch_queue_t concurrentQ;

/**
 The serial queue to use when trying to access sensitive data. Make sure that this queue is not overloaded with
 any heavy stuff, or you could have serious problems in performance.
 */
@property (nonatomic, readonly) dispatch_queue_t serialQ;

/**
 The operation group necessary for notifiying the delegates that everything is finished. The one that subclasses the
 PatternMatcherAsynchronous is responsible for using that.
 */
@property (nonatomic, readonly) dispatch_group_t operationGroup;



/**
 Access 'wordsProcessedAndResults' in a safe way.
 
 @param value the new value to set for this key
 @param key the key to search for
 */
- (void)seriallyAccessResultsDictionaryWithValue:(id)value forKey:(NSString *)key;



@end
