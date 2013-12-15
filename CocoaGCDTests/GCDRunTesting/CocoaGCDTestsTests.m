//
//  CocoaGCDTestsTests.m
//  CocoaGCDTestsTests
//
//  Created by Christos Sotiriou on 30/10/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <CSMatrixFramework/CSMatrixFramework.h>
#import "TestCaseCommon.h"



@interface DNALattice1d (ext)
@property (nonatomic, readonly) char *cube3d;
@end

@interface CocoaGCDTestsTests : TestCaseCommon

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

}

@end
