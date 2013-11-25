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
#import "Expecta.h"
#import "TestCaseCommon.h"


@interface PatternTests : TestCaseCommon
@property (nonatomic, strong) PatternMatcherSequential *patternMatcher;
@property (nonatomic, strong) DNALattice1d *lattice;
@end

@implementation PatternTests

- (void)setUp
{
    [super setUp];
	self.lattice = [[DNALattice1d alloc] initWithSideNumber:100 andChar:'a'];
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
	expect(self.patternMatcher.hasAlreadyRan).to.beTruthy();
}

@end
