//
//  PatternMatcherBase.h
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 4/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CSMatrixFramework/CSMatrixFramework.h>
#import "LatticeLineExtractor.h"
#import "CSAdditions.h"


@class PatternMatcherBase;

@protocol PatternMatcherBaseDelegate <NSObject>
- (void)patternMatcher:(PatternMatcherBase *)matcher didFinishWithResults:(NSDictionary *)results;
@end

/**
 Abstract class implementing the basic functionality, helpful functions, and patterns
 for all pattern matchers.
 */
@interface PatternMatcherBase : NSObject
@property (nonatomic, strong) id <LatticeCommon> lattice;
@property (nonatomic, weak) id<PatternMatcherBaseDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *dictionaryToSearch;
@property (nonatomic, strong) LatticeLineExtractor *latticeExtractor;
@property (nonatomic, strong) NSMutableDictionary *wordsProcessedAndResults;
@property (nonatomic) BOOL hasAlreadyRan;


- (NSArray *)obtainHorizontallLinesForProcessing;
- (NSArray *)obtainVerticalLinesForProcessing;
- (NSArray *)obtainLinesInIntraLatticeForProcessing;
- (NSArray *)obtainDiagonalLinesTopLeftBottomRight;
- (NSArray *)obtainDiagonalLinesBottomLeftTopRight;

- (id)initWithLattice:(id<LatticeCommon>)lattice andDictionaryToSearch:(NSArray *)dictionaryOfWords;
- (void)lineWasFound:(NSString *)line;
- (void)startScanning;

- (void)signalComplete;
@end
