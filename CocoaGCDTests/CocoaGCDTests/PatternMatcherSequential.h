//
//  PatternMatcher.h
//  GCDTests
//
//  Created by Christos Sotiriou on 30/10/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CSMatrixFramework/CSMatrixFramework.h>
#import "PatternMatcherBase.h"

/**
Class that aims at finding patterns into a given lattice. It sequentially constructs lines from the cube
 according to the direction processed, and then finds patterns to these lines, one by one. Uses only one thread.
*/
@interface PatternMatcherSequential : PatternMatcherBase
@end
