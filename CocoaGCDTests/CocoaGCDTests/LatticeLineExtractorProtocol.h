//
//  LatticeLineExtractorProtocol.h
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 6/12/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Protocol that defines the interface for a lattice line extractor, extracting lines from different directions from a cube lattice,
 following the LatticeCommon protocol.
 */
@protocol LatticeLineExtractorProtocol <NSObject>
/**
 @brief Obtains horizontal lines and calls the callback when a line is found
 
 @param lattice the lattice that is found
 @param the block to call when a line is found inside the lattice
 */
- (void)obtainHorizontallLinesForLattice:(id<LatticeCommon>)lattice withLineCompletionBlock:(void (^)(NSString *line))block;

/**
 @brief Obtains vertical lines and calls the callback when a line is found
 
 @param lattice the lattice that is found
 @param the block to call when a line is found inside the lattice
 */
- (void)obtainVerticalLinesForLattice:(id<LatticeCommon>)lattice withLineCompletionBlock:(void (^)(NSString *line))block;

/**
 @brief Obtains lines in the Z axis of the lattice and calls the callback when a line is found
 
 @param lattice the lattice that is found
 @param the block to call when a line is found inside the lattice
 */
- (void)obtainLinesInIntraLatticeForLattice:(id<LatticeCommon>)lattice withLineCompletionBlock:(void (^)(NSString *line))block;


/**
 @brief Obtains diagonal lines from top left to bottom right and calls the callback when a line is found
 
 @param lattice the lattice that is found
 @param the block to call when a line is found inside the lattice
 */
- (void)obtainDiagonalLinesTopLeftBottomRightForLattice:(id<LatticeCommon>)lattice withLineCompletionBlock:(void (^)(NSString *line))block;

/**
 @brief Obtains diagonal lines from bottom left to top right and calls the callback when a line is found
 
 @param lattice the lattice that is found
 @param the block to call when a line is found inside the lattice
 */
- (void)obtainDiagonalLinesBottomLeftTopRightForLattice:(id<LatticeCommon>)lattice withLineCompletionBlock:(void (^)(NSString *line))block;



/**
 @brief Obtains diagonal lines from top left to bottom right and calls the callback when a line is found. It operates on a 'layer' level. For example,
 in an imaginary 3D rubic's cube, a layer is considered each row (also extending in the Z axis). Therefore, this method operates on the same 'Y' level
 
 @param lattice the lattice that is found
 @param the block to call when a line is found inside the lattice
 */
- (void)obtainDiagonalHeightConstantZ1ForLattice:(id<LatticeCommon>)lattice withLineCompletionBlock:(void (^)(NSString *line))block;


/**
 @brief Obtains diagonal lines from bottom left to top right and calls the callback when a line is found. It operates on a 'layer' level. For example,
 in an imaginary 3D rubic's cube, a layer is considered each row (also extending in the Z axis). Therefore, this method operates on the same 'Y' level
 
 @param lattice the lattice that is found
 @param the block to call when a line is found inside the lattice
 */
- (void)obtainDiagonalHeightConstantZ2ForLattice:(id<LatticeCommon>)lattice withLineCompletionBlock:(void (^)(NSString *line))block;
@end
