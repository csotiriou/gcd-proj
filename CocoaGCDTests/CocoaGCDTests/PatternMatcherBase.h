//
//  PatternMatcherBase.h
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 4/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CSMatrixFramework/CSMatrixFramework.h>


/**
 Abstract class implementing the basic functionality, helpful functions, and patterns
 for all pattern matchers.
 */
@interface PatternMatcherBase : NSObject
@property (nonatomic, strong) id <LatticeCommon> lattice;
@property (nonatomic, strong) NSMutableArray *dictionaryToSearch;

- (NSArray *)obtainHorizontallLinesForProcessing;
- (NSArray *)obtainVerticalLinesForProcessing;
- (NSArray *)obtainLinesInIntraLatticeForProcessing;
- (NSArray *)obtainDiagonalLinesTopLeftBottomRight;
- (NSArray *)obtainDiagonalLinesBottomLeftTopRight;

- (id)initWithLattice:(id<LatticeCommon>)lattice andDictionaryToSearch:(NSArray *)dictionaryOfWords;
- (void)startScanning;
@end