//
//  Lattice1DTests.m
//  LatticeCreator
//
//  Created by Christos Sotiriou on 20/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DNALattice1d.h"
#import "Expecta.h"

@interface Lattice1DTests : XCTestCase
@property (nonatomic, strong) DNALattice1d *dnaLattice;
@end

@implementation Lattice1DTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
	self.dnaLattice = [[DNALattice1d alloc] initWithSideNumber:5 andChar:'a'];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCreation
{
	DNALattice1d *lattice = [[DNALattice1d alloc] initWithSideNumber:5 andChar:'a'];
	expect(lattice).notTo.beNil();
	expect(lattice.sideNumber).to.equal(5);
	expect(lattice.isInitialized).to.beTruthy();
	
	for (int i=0; i<lattice.sideNumber; i++) {
		for (int j=0; j<lattice.sideNumber; j++) {
			for (int k=0; k<lattice.sideNumber; k++) {
				expect([lattice getItemAti:i andJ:j andK:k]).to.equal('a');
			}
		}
	}
}

- (void)testChangeSomething
{
	[self.dnaLattice setItemAti:0 andJ:0 andK:0 value:'l'];
	expect([self.dnaLattice getItemAti:0 andJ:0 andK:0]).to.equal('l');
}


- (void)testCopyLattice
{
	DNALattice1d *lattice = [[DNALattice1d alloc] initWithSideNumber:5 andChar:'a'];
	DNALattice1d *lattice2 = [lattice copy];
	
	expect(lattice2).to.notTo.beNil();
	expect(lattice.sideNumber).to.equal(lattice2.sideNumber);
	expect(lattice2.isInitialized).to.beTruthy();
	
	for (int i=0; i<lattice2.sideNumber; i++) {
		for (int j=0; j<lattice2.sideNumber; j++) {
			for (int k=0; k<lattice2.sideNumber; k++) {
				expect([lattice getItemAti:i andJ:j andK:k]).to.equal([lattice2 getItemAti:i andJ:j andK:k]);
			}
		}
	}
	
}
@end
