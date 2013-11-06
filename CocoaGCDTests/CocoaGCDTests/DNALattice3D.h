//
//  DNALattice3D.h
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 31/10/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LatticeCommon.h"

/**
DNALatice represented into a 3D array. Not yet complete
*/
@interface DNALattice3D : NSObject <LatticeCommon>

@property (nonatomic, readonly) int sideNumber;
@end
