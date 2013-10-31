//
//  CocoaGCDTestsTests.m
//  CocoaGCDTestsTests
//
//  Created by Christos Sotiriou on 30/10/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DNALattice1d.h"

@interface DNALattice1d (ext)
@property (nonatomic, readonly) char *cube3d;
@end

@interface CocoaGCDTestsTests : XCTestCase

@end

@implementation CocoaGCDTestsTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
	
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCreationSimple
{
	const char alpha[8] = {'0','1','2','3','4','5','6','7'};
	DNALattice1d *lattice = [[DNALattice1d alloc] initWithSideNumber:2 andChar:0];
	[lattice copyData:alpha ofSize:8];
	
	XCTAssertEqual([lattice getItemAti:0 andJ:0 andK:0], (char)'0', @"fault. Data was not copied correctly");
	XCTAssertEqual([lattice getItemAti:0 andJ:0 andK:1], (char)'1', @"fault. Data was not copied correctly");
	
	XCTAssertEqual([lattice getItemAti:0 andJ:1 andK:0], (char)'2', @"fault. Data was not copied correctly");
	XCTAssertEqual([lattice getItemAti:0 andJ:1 andK:1], (char)'3', @"fault. Data was not copied correctly");
	
	XCTAssertEqual([lattice getItemAti:1 andJ:0 andK:0], (char)'4', @"fault. Data was not copied correctly");
	XCTAssertEqual([lattice getItemAti:1 andJ:0 andK:1], (char)'5', @"fault. Data was not copied correctly");
	
	XCTAssertEqual([lattice getItemAti:1 andJ:1 andK:0], (char)'6', @"fault. Data was not copied correctly");
	XCTAssertEqual([lattice getItemAti:1 andJ:1 andK:1], (char)'7', @"fault. Data was not copied correctly");
}

- (void)testCopy
{
	const char alpha[8] = {'0','1','2','3','4','5','6','7'};
	DNALattice1d *lattice = [[DNALattice1d alloc] initWithSideNumber:2 andChar:0];
	[lattice copyData:alpha ofSize:8];
	
	DNALattice1d *lattice2 = [lattice copy];
	
	XCTAssertEqual([lattice2 getItemAti:0 andJ:0 andK:0], (char)'0', @"fault. Data was not copied correctly");
	XCTAssertEqual([lattice2 getItemAti:0 andJ:0 andK:1], (char)'1', @"fault. Data was not copied correctly");
	
	XCTAssertEqual([lattice2 getItemAti:0 andJ:1 andK:0], (char)'2', @"fault. Data was not copied correctly");
	XCTAssertEqual([lattice2 getItemAti:0 andJ:1 andK:1], (char)'3', @"fault. Data was not copied correctly");
	
	XCTAssertEqual([lattice2 getItemAti:1 andJ:0 andK:0], (char)'4', @"fault. Data was not copied correctly");
	XCTAssertEqual([lattice2 getItemAti:1 andJ:0 andK:1], (char)'5', @"fault. Data was not copied correctly");
	
	XCTAssertEqual([lattice2 getItemAti:1 andJ:1 andK:0], (char)'6', @"fault. Data was not copied correctly");
	XCTAssertEqual([lattice2 getItemAti:1 andJ:1 andK:1], (char)'7', @"fault. Data was not copied correctly");
}

@end
