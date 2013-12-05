//
//  TestCaseCommon.m
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 26/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TestCaseCommon.h"
#import "UtilityInitializer.h"
@interface TestCaseCommon ()

@end

@implementation TestCaseCommon
- (void)setUp
{
	self.monitor = [[TRVSMonitor alloc] init];
	[[UtilityInitializer sharedTestSingleton] initializeTestLogsIfNotInitialized];
}
- (NSBundle *)bundle
{
	return [NSBundle bundleForClass:[self class]];
}

- (NSString *)pathForSpecFileResource:(NSString *)name
{
	return [self.bundle pathForResource:name ofType:@"spec"];
}

- (NSString *)pathForWDLResourceOfName:(NSString *)name
{
	return [self.bundle pathForResource:name ofType:@"wdl"];
}


@end
