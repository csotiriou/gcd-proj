//
//  AlgoTests.m
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 31/10/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TestCaseCommon.h"
#import <CSMatrixFramework/CSMatrixFramework.h>
#import "PatternMatcherSequential.h"


@interface AlgoTests : TestCaseCommon
@end

@implementation AlgoTests

- (void)setUp
{
    [super setUp];
	
}

- (void)tearDown
{
    [super tearDown];
}



- (void)testGetReversedString
{
	NSString *original = @"this is a string";
	const char *originalChars = [original cStringUsingEncoding:NSUTF8StringEncoding];
	char reverseString[original.length];
	
	int i;
	for (i = 1; i<= original.length; i++) {
		reverseString[i-1] = originalChars[original.length - i];
	}
	reverseString[original.length] = '\0'; //add the terminating character
	
	NSString *finalString = [NSString stringWithCString:reverseString encoding:NSUTF8StringEncoding];
	XCTAssertEqualObjects(finalString, @"gnirts a si siht", @"strings are not equal");
}



- (BOOL)arrayWithStrings:(NSArray *)arr isEqualToArrayWithStrings:(NSArray *)arr2
{
	for (int i=0; i<arr.count; i++) {
		if (![[arr objectAtIndex:i] isEqualToString:[arr2 objectAtIndex:i]]) {
			return NO;
		}
	}
	return YES;
}
@end
