//
//  DNALattice.h
//  GCDTests
//
//  Created by Christos Sotiriou on 30/10/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DNALattice : NSObject<NSCopying>

@property (nonatomic, readonly) int sideNumber;

- (DNALattice *)initWithSideNumber:(int)sideNumber andChar:(char)c;

- (char)getItemAti:(int)i andJ:(int)j andK:(int)k;
- (void)setItemAti:(int)i andJ:(int)j andK:(int)k value:(char)v;
@end
