//
//  LatticeCommon.h
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 31/10/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LatticeCommon <NSObject>
@required
@property (nonatomic, readonly) int sideNumber;

- (id)initWithSideNumber:(int)sideNumber andChar:(char)c;
- (char)getItemAti:(int)i andJ:(int)j andK:(int)k;
- (void)setItemAti:(int)i andJ:(int)j andK:(int)k value:(char)v;
@end
