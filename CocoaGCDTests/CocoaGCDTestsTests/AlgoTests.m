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
	NSString *str = @"aaaa";
	
	char side[self.lattice.sideNumber +1];
	
//	[self.lattice fillArrayWithCharacter:'a'];
	[self.lattice setItemAti:0 andJ:0 andK:0 value:'a'];
	[self.lattice setItemAti:0 andJ:0 andK:1 value:'b'];
	[self.lattice setItemAti:0 andJ:0 andK:2 value:'c'];
	
	[self.lattice setItemAti:0 andJ:1 andK:0 value:'a'];
	[self.lattice setItemAti:0 andJ:1 andK:1 value:'b'];
	[self.lattice setItemAti:0 andJ:1 andK:2 value:'c'];
	
	[self.lattice setItemAti:0 andJ:2 andK:0 value:'a'];
	[self.lattice setItemAti:0 andJ:2 andK:1 value:'a'];
	[self.lattice setItemAti:0 andJ:2 andK:2 value:'a'];
	

	[self.lattice setItemAti:1 andJ:0 andK:0 value:'a'];
	[self.lattice setItemAti:1 andJ:0 andK:1 value:'a'];
	[self.lattice setItemAti:1 andJ:0 andK:2 value:'a'];
	
	[self.lattice setItemAti:1 andJ:1 andK:0 value:'a'];
	[self.lattice setItemAti:1 andJ:1 andK:1 value:'a'];
	[self.lattice setItemAti:1 andJ:1 andK:2 value:'a'];
	
	[self.lattice setItemAti:1 andJ:2 andK:0 value:'a'];
	[self.lattice setItemAti:1 andJ:2 andK:1 value:'a'];
	[self.lattice setItemAti:1 andJ:2 andK:2 value:'a'];
	
	[self.lattice setItemAti:2 andJ:0 andK:0 value:'a'];
	[self.lattice setItemAti:2 andJ:0 andK:1 value:'a'];
	[self.lattice setItemAti:2 andJ:0 andK:2 value:'a'];
	
	[self.lattice setItemAti:2 andJ:1 andK:0 value:'a'];
	[self.lattice setItemAti:2 andJ:1 andK:1 value:'a'];
	[self.lattice setItemAti:2 andJ:1 andK:2 value:'a'];
	
	[self.lattice setItemAti:2 andJ:2 andK:0 value:'a'];
	[self.lattice setItemAti:2 andJ:2 andK:1 value:'a'];
	[self.lattice setItemAti:2 andJ:2 andK:2 value:'a'];
	
	//copy vertical just one row
	for (int i=0; i<self.lattice.sideNumber; i++) {
		side[i] = [self.lattice getItemAti:0 andJ:0 andK:i];
	}
	side[self.lattice.sideNumber] = '\0';
	
	NSString *temp = [NSString stringWithCString:side encoding:NSUTF8StringEncoding];
	if ([temp rangeOfString:str].location != NSNotFound) {
		NSLog(@"found item");
	}
	
	
}

@end
