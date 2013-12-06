//
//  LatticeLineExtractor.h
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 8/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CSMatrixFramework/CSMatrixFramework.h>
#import "LatticeLineExtractorProtocol.h"
@class LatticeLineExtractor;



/**
 Class used to extract the lines from a 3D lattice cube. The method of extracting and returning lines is still not completely documented.
 The lines returned by the methods are meant to be processed by string matchers. This is the plain-dumb version of finding lines to be processed
 by a pattern matcher. No checks are made, no optimizations, apart from taking care of some memory optimizations.
 */
@interface LatticeLineExtractor : NSObject <LatticeLineExtractorProtocol>

@end
