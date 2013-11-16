//
//  PatternMatcherGCD.h
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 6/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import "PatternMatcherAsynchronous.h"

/**
 Pattern Matcher that works asynchronously. Works by dividing the threads according to the direction that we are searching right now.
 On each direction being searched, it creates a thread and adds it to an asynchronous concurrent queue. 7 separate directions (14 if we count
 the reversed ones) are divided into threads and added to the queue.
 */
@interface PatternMatcherGCD : PatternMatcherAsynchronous

@end
