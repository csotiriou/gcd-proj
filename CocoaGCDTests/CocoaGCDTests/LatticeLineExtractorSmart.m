//
//  LatticeLineExtractorSmart.m
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 6/12/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import "LatticeLineExtractorSmart.h"
#import <CSMatrixFramework/CSMatrixFramework.h>

@implementation LatticeLineExtractorSmart
- (void)obtainHorizontallLinesForLattice:(id<LatticeCommon>)lattice withLineCompletionBlock:(void (^)(NSString *line))block
{
	@throw [NSException exceptionWithName:@"FUNCTION_NOT_IMPLEMENTED" reason:@"function is not implemented for this LatticeLineCreatorSmart" userInfo:nil];
}


- (void)obtainVerticalLinesForLattice:(id<LatticeCommon>)lattice withLineCompletionBlock:(void (^)(NSString *line))block
{
	@throw [NSException exceptionWithName:@"FUNCTION_NOT_IMPLEMENTED" reason:@"function is not implemented for this LatticeLineCreatorSmart" userInfo:nil];
}

- (void)obtainLinesInIntraLatticeForLattice:(id<LatticeCommon>)lattice withLineCompletionBlock:(void (^)(NSString *line))block
{
	@throw [NSException exceptionWithName:@"FUNCTION_NOT_IMPLEMENTED" reason:@"function is not implemented for this LatticeLineCreatorSmart" userInfo:nil];
}



- (void)obtainDiagonalLinesTopLeftBottomRightForLattice:(id<LatticeCommon>)lattice withLineCompletionBlock:(void (^)(NSString *line))block
{
	@throw [NSException exceptionWithName:@"FUNCTION_NOT_IMPLEMENTED" reason:@"function is not implemented for this LatticeLineCreatorSmart" userInfo:nil];
}


- (void)obtainDiagonalLinesBottomLeftTopRightForLattice:(id<LatticeCommon>)lattice withLineCompletionBlock:(void (^)(NSString *line))block
{
	@throw [NSException exceptionWithName:@"FUNCTION_NOT_IMPLEMENTED" reason:@"function is not implemented for this LatticeLineCreatorSmart" userInfo:nil];
}



- (void)obtainDiagonalHeightConstantZ1ForLattice:(id<LatticeCommon>)lattice withLineCompletionBlock:(void (^)(NSString *line))block
{
	@throw [NSException exceptionWithName:@"FUNCTION_NOT_IMPLEMENTED" reason:@"function is not implemented for this LatticeLineCreatorSmart" userInfo:nil];
}


- (void)obtainDiagonalHeightConstantZ2ForLattice:(id<LatticeCommon>)lattice withLineCompletionBlock:(void (^)(NSString *line))block
{
	@throw [NSException exceptionWithName:@"FUNCTION_NOT_IMPLEMENTED" reason:@"function is not implemented for this LatticeLineCreatorSmart" userInfo:nil];
}
@end
