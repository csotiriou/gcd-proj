//
//  AlgoTests.m
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 31/10/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "DNALattice1d.h"
#import "PatternMatcher.h"

@interface AlgoTests : XCTestCase
@property (nonatomic, strong) DNALattice1d *lattice;
@property (nonatomic, strong) PatternMatcher *patternMatcher;
@end

@implementation AlgoTests

- (void)setUp
{
    [super setUp];
	self.lattice = [[DNALattice1d alloc] initWithSideNumber:3 andChar:'0'];
	self.patternMatcher = [[PatternMatcher alloc] init];
	
	self.patternMatcher.lattice = self.lattice;
	[self.patternMatcher.dictionaryToSearch addObject:@"abba"];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testExample
{
	//find elements horizontally
	NSString *str = @"aa";
	
	char side[self.lattice.sideNumber];
	
	[self.lattice fillArrayWithCharacter:'a'];
	
	//copy vertical just one row
	for (int i=0; i<self.lattice.sideNumber; i++) {
		side[i] = [self.lattice getItemAti:0 andJ:0 andK:i];
	}
	
	NSString *temp = [NSString stringWithCString:side encoding:NSUTF8StringEncoding];
	if ([temp rangeOfString:str].location != NSNotFound) {
		NSLog(@"found item");
	}
	
	
}

@end
