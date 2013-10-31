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

- (void)testCreation
{
	const char alpha[8] = {'0','1','2','3','4','5','6','7'};
	DNALattice1d *lattice = [[DNALattice1d alloc] initWithSideNumber:2 andChar:0];
	[lattice copyData:alpha ofSize:8];
	

}

@end
