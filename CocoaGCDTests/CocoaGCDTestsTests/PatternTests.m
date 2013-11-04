//
//  PatternTests.m
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 4/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PatternMatcherSequential.h"
#import <CSMatrixFramework/CSMatrixFramework.h>


@interface PatternTests : XCTestCase
@property (nonatomic, strong) PatternMatcherSequential *patternMatcher;
@property (nonatomic, strong) DNALattice1d *lattice;
@end

@implementation PatternTests

- (void)setUp
{
    [super setUp];
	self.lattice = [[DNALattice1d alloc] initWithSideNumber:10 andChar:'a'];
	self.patternMatcher = [[PatternMatcherSequential alloc] initWithLattice:self.lattice andDictionaryToSearch:@[@"aa",@"bb", @"cc"]];
}

- (void)tearDown
{
	self.patternMatcher = nil;
    [super tearDown];
}

- (void)testExample
{
	[self.patternMatcher startScanning];
	NSDictionary *dict = [self.patternMatcher getResults];
	
	XCTAssertTrue([[dict valueForKey:@"aa"] boolValue], @"");
	XCTAssertFalse([[dict valueForKey:@"bb"] boolValue], @"");
}

@end
