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
@end

@implementation PatternMatcherGCD

- (id)initWithLattice:(id<LatticeCommon>)lattice andDictionaryToSearch:(NSArray *)dictionaryOfWords
{
	if (self = [super initWithLattice:lattice andDictionaryToSearch:dictionaryOfWords]) {
		
	}
	return self;
}


- (void)dealloc
{
	
}

@end
