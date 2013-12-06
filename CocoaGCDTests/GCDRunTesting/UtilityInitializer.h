//
//  TestSingleton.h
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 5/12/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Common functions for running unit tests and returning thingies. Useful for setting up logging, which is bundle-wide. This singleton is not tested ("how many tests would a unit test test if a uni test could test tests?")
 Design decision: This kind of functionality is implemented using a singleton, because we are not sure about when each unit test is going to run. Therefore, we need a mechanism to hold global variables, and not re-initialize loggers and other data more than once.
 */
@interface UtilityInitializer : NSObject


@property (nonatomic, readonly) NSString *testsLogDirPath;

+ (UtilityInitializer *)sharedTestSingleton;

/**
 Initialize the normal loggers, that are being used throughout the normal application. These include the
 TTY logger for displaying information on the terminal, and a file logger, for logging output to the normal
 output file used by the normal application. NOTE: if you call this function more than once, it will have no
 effect.
 */
- (void)initializeLNormalLogsIfNotAlreadyInitialized;

/**
 Initializes the loggers used for testing the application. These include a logger that writes to external files specific to the unit testing procedure. NOTE: if you call this function more than once, it will have no effect.
 */
- (void)initializeTestLogsIfNotInitialized;
@end
