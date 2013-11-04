//
//  PatternMatcher.h
//  GCDTests
//
//  Created by Christos Sotiriou on 30/10/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CSMatrixFramework/CSMatrixFramework.h>

/**
Class that aims at finding patterns into a given lattice. To be implemented
*/
@interface PatternMatcher : NSObject

@property (nonatomic, strong) id <LatticeCommon> lattice;

@property (nonatomic, strong) NSMutableArray *dictionaryToSearch;

- (void)start;
@end
