//
//  PatternMatcherAsynchronous.h
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 16/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import "PatternMatcherBase.h"

@interface PatternMatcherAsynchronous : PatternMatcherBase

@property (nonatomic, readonly) dispatch_queue_t concurrentQ;
@property (nonatomic, readonly) dispatch_queue_t serialQ;
@property (nonatomic, readonly) dispatch_group_t operationGroup;



- (void)initThreads;



- (void)seriallyAccessResultsDictionaryWithValue:(id)value forKey:(NSString *)key;
@end
