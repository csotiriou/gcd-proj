//
//  LatticeExtractorTests.m
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 11/12/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LatticeLineExtractor.h"
#import "Expecta.h"


@interface LatticeExtractorTests : XCTestCase
@property (nonatomic, strong) id<LatticeCommon> lattice;
@property (nonatomic, strong) id<LatticeCommon> lattice4;

@property (nonatomic, strong) id<LatticeLineExtractorProtocol> latticeExtractor;

@end

@implementation LatticeExtractorTests

- (void)setUp
{
    [super setUp];
	self.lattice = [[DNALattice1d alloc] initWithSideNumber:3 andChar:'0'];
	
	
	[self.lattice setItemAti:0 andJ:0 andK:0 value:'a'];
	[self.lattice setItemAti:0 andJ:0 andK:1 value:'b'];
	[self.lattice setItemAti:0 andJ:0 andK:2 value:'c'];
	
	[self.lattice setItemAti:0 andJ:1 andK:0 value:'d'];
	[self.lattice setItemAti:0 andJ:1 andK:1 value:'e'];
	[self.lattice setItemAti:0 andJ:1 andK:2 value:'f'];
	
	[self.lattice setItemAti:0 andJ:2 andK:0 value:'g'];
	[self.lattice setItemAti:0 andJ:2 andK:1 value:'h'];
	[self.lattice setItemAti:0 andJ:2 andK:2 value:'i'];
	
	
	[self.lattice setItemAti:1 andJ:0 andK:0 value:'j'];
	[self.lattice setItemAti:1 andJ:0 andK:1 value:'k'];
	[self.lattice setItemAti:1 andJ:0 andK:2 value:'l'];
	
	[self.lattice setItemAti:1 andJ:1 andK:0 value:'m'];
	[self.lattice setItemAti:1 andJ:1 andK:1 value:'n'];
	[self.lattice setItemAti:1 andJ:1 andK:2 value:'o'];
	
	[self.lattice setItemAti:1 andJ:2 andK:0 value:'p'];
	[self.lattice setItemAti:1 andJ:2 andK:1 value:'q'];
	[self.lattice setItemAti:1 andJ:2 andK:2 value:'r'];
	
	[self.lattice setItemAti:2 andJ:0 andK:0 value:'s'];
	[self.lattice setItemAti:2 andJ:0 andK:1 value:'t'];
	[self.lattice setItemAti:2 andJ:0 andK:2 value:'u'];
	
	[self.lattice setItemAti:2 andJ:1 andK:0 value:'v'];
	[self.lattice setItemAti:2 andJ:1 andK:1 value:'w'];
	[self.lattice setItemAti:2 andJ:1 andK:2 value:'x'];
	
	[self.lattice setItemAti:2 andJ:2 andK:0 value:'y'];
	[self.lattice setItemAti:2 andJ:2 andK:1 value:'z'];
	[self.lattice setItemAti:2 andJ:2 andK:2 value:'0'];
	
	self.latticeExtractor = [[LatticeLineExtractor alloc] init];
	
	self.lattice4 = [[DNALattice1d alloc] initWithSideNumber:4 andChar:'0'];
	
	int offset = 33;
	for (int i=0; i<4; i++) {
		for (int j=0; j<4; j++) {
			for (int k=0; k<4; k++) {
				NSLog(@"inserting: %c", (char)offset);
				[self.lattice4 setItemAti:i andJ:j andK:k value:(char)offset];
				offset++;
				
			}
		}
	}
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCreation
{
	expect(self.latticeExtractor).to.notTo.beNil();
}

- (void)testGetHorizontalLines
{
	__block int linesFound = 0;
	__block NSOrderedSet *resultsArray = [[NSOrderedSet alloc] initWithArray:@[@"abc", @"def", @"ghi", @"jkl", @"mno", @"pqr", @"stu", @"vwx", @"yz0"]];
	[self.latticeExtractor obtainHorizontallLinesForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
		NSLog(@"LINE FOUND: %@", line);
		expect([resultsArray containsObject:line]).to.beTruthy();
		linesFound ++;
	}];
	
	expect(linesFound).to.equal(resultsArray.count);
}

- (void)testGetVerticalLines
{
	__block int linesFound = 0;
	__block NSOrderedSet *resultsArray = [[NSOrderedSet alloc] initWithArray:@[@"adg", @"beh", @"cfi", @"jmp", @"knq", @"lor", @"svy", @"twz", @"ux0"]];

	
	[self.latticeExtractor obtainVerticalLinesForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
		expect([resultsArray containsObject:line]).to.beTruthy();
		linesFound ++;
	}];
	expect(linesFound).to.equal(resultsArray.count);
}

- (void)testGetLinesAlongZAxis
{
	__block int linesFound = 0;
	__block NSOrderedSet *resultsArray = [[NSOrderedSet alloc] initWithArray:@[@"ajs", @"dmv", @"gpy", @"bkt", @"enw", @"hqz", @"clu", @"fox", @"ir0"]];
	
	
	[self.latticeExtractor obtainLinesInIntraLatticeForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
		NSLog(@"LINE FOUND: %@", line);
		expect([resultsArray containsObject:line]).to.beTruthy();
		linesFound ++;
	}];
	expect(linesFound).to.equal(resultsArray.count);
}


- (void)testGetDiagonalLinesTopLeftBottomRight
{
	__block int linesFound = 0;
	__block NSOrderedSet *resultsArray = [[NSOrderedSet alloc] initWithArray:@[@"dh", @"g", @"aei", @"bf", @"c", @"mq", @"p", @"jnr", @"ko", @"l", @"vz", @"y", @"sw0", @"tx", @"u"]];
	
	
	[self.latticeExtractor obtainDiagonalLinesTopLeftBottomRightForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
		NSLog(@"LINE FOUND: %@", line);
		expect([resultsArray containsObject:line]).to.beTruthy();
		linesFound ++;
	}];
	expect(linesFound).to.equal(resultsArray.count);
}


- (void)testGetDiagonalLinesBottomLeftTopRight
{
	__block int linesFound = 0;
	__block NSOrderedSet *resultsArray = [[NSOrderedSet alloc] initWithArray:@[@"bd", @"a", @"i", @"fh", @"ceg", @"km", @"j", @"r", @"oq", @"lnp", @"tv", @"s", @"0", @"xz", @"uwy"]];
	
	
	[self.latticeExtractor obtainDiagonalLinesBottomLeftTopRightForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
		NSLog(@"LINE FOUND: %@", line);
		expect([resultsArray containsObject:line]).to.beTruthy();
		linesFound ++;
	}];
	expect(linesFound).to.equal(resultsArray.count);
}


- (void)testGetDiagonalHeightConstantZ1
{
	__block int linesFound = 0;
	__block NSOrderedSet *resultsArray = [[NSOrderedSet alloc] initWithArray:@[@"jd", @"a", @"y", @"vp", @"smg", @"ke", @"b", @"z", @"wq", @"tnh", @"lf", @"c", @"0", @"xr", @"uoi"]];
	
	
	[self.latticeExtractor obtainDiagonalHeightConstantZ1ForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
		NSLog(@"LINE FOUND: %@", line);
		expect([resultsArray containsObject:line]).to.beTruthy();
		linesFound ++;
	}];
	expect(linesFound).to.equal(resultsArray.count);
}

- (void)testObtainDiagonalHeightConstantZ2ForLattice
{
	__block int linesFound = 0;
	__block NSOrderedSet *resultsArray = [[NSOrderedSet alloc] initWithArray:@[@"dp", @"g", @"amy", @"jv", @"s", @"eq", @"h", @"bnz", @"kw", @"t", @"fr", @"i", @"co0", @"lx", @"u"]];
	
	
	[self.latticeExtractor obtainDiagonalHeightConstantZ2ForLattice:self.lattice withLineCompletionBlock:^(NSString *line) {
		NSLog(@"LINE FOUND: %@", line);
		expect([resultsArray containsObject:line]).to.beTruthy();
		linesFound ++;
	}];
	expect(linesFound).to.equal(resultsArray.count);
}

- (void)testMakeDiagonalTestWithLargerArray
{
	__block int linesFound = 0;
//	__block NSOrderedSet *resultsArray = [[NSOrderedSet alloc] initWithArray:@[@"dp", @"g", @"amy", @"jv", @"s", @"eq", @"h", @"bnz", @"kw", @"t", @"fr", @"i", @"co0", @"lx", @"u"]];
	
	
	[self.latticeExtractor obtainDiagonalLinesTopLeftBottomRightForLattice:self.lattice4 withLineCompletionBlock:^(NSString *line) {
		NSLog(@"LINE FOUND: %@", line);
//		expect([resultsArray containsObject:line]).to.beTruthy();
		linesFound ++;
	}];
//	expect(linesFound).to.equal(resultsArray.count);
}

@end
