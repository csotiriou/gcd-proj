//
//  TestCaseCommon.m
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 26/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TestCaseCommon.h"

@interface TestCaseCommon ()

@end

@implementation TestCaseCommon
- (void)setUp
{
	self.monitor = [[TRVSMonitor alloc] init];
}
- (NSBundle *)bundle
{
	return [NSBundle bundleForClass:[self class]];
}
@end
