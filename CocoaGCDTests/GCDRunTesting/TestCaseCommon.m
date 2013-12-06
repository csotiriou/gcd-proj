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
#import <CSMatrixFramework/CSMatrixFramework.h>
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


- (CSWordList *)createWordListWithNumberOfLetters:(int)numberOfLetters andSize:(int)size defaultCharacter:(char)c
{
	CSWordList *result = [[CSWordList alloc] init];
	for (int i = 0; i<size; i++) {
		NSMutableString *string = [self createStringWithNumberOfLetters:numberOfLetters defaultCharacter:c prefix:[NSString stringWithFormat:@"%i", i]];
		[result addWord:string];
	}
	return result;
}

- (NSMutableString *)createStringWithNumberOfLetters:(int)letternNum defaultCharacter:(char)c prefix:(NSString *)prefix
{
	NSMutableString *str = [NSMutableString string];
	[str appendString:prefix];
	while (str.length < letternNum) {
		[str appendFormat:@"%c", c];
	}
	return str;
}


@end
