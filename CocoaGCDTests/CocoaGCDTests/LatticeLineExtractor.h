//
//  LatticeLineExtractor.h
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 8/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CSMatrixFramework/CSMatrixFramework.h>

@class LatticeLineExtractor;

@protocol LatticeLineExtractorDelegate <NSObject>
- (void)lineExtractor:(LatticeLineExtractor *)extractor lineWasFound:(NSString *)line;
@end

@interface LatticeLineExtractor : NSObject
@property (nonatomic, weak) id<LatticeLineExtractorDelegate>delegate;

- (id)initWithDelegate:(id<LatticeLineExtractorDelegate>)delegate;




- (void)obtainHorizontallLinesForLattice:(id<LatticeCommon>)lattice withLineCompletionBlock:(void (^)(NSString *line))block;
- (void)obtainVerticalLinesForLattice:(id<LatticeCommon>)lattice withLineCompletionBlock:(void (^)(NSString *line))block;
- (void)obtainLinesInIntraLatticeForLattice:(id<LatticeCommon>)lattice withLineCompletionBlock:(void (^)(NSString *line))block;
- (void)obtainDiagonalLinesTopLeftBottomRightForLattice:(id<LatticeCommon>)lattice withLineCompletionBlock:(void (^)(NSString *line))block;
- (void)obtainDiagonalLinesBottomLeftTopRightForLattice:(id<LatticeCommon>)lattice withLineCompletionBlock:(void (^)(NSString *line))block;


@end
