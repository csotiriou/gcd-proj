//
//  TestCaseCommon.m
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 26/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TRVSMonitor.h"

@interface TestCaseCommon : XCTestCase
@property (nonatomic, readonly) NSBundle *bundle;
@property (nonatomic, strong) TRVSMonitor *monitor;

- (NSString *)pathForWDLResourceOfName:(NSString *)name;
- (NSString *)pathForSpecFileResource:(NSString *)name;
@end

