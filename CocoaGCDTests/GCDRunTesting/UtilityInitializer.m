//
//  TestSingleton.m
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 5/12/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import "UtilityInitializer.h"
#import "DDLog.h"
#import "DDFileLogger.h"
#import "DDTTYLogger.h"
#import "Util.h"


@interface UtilityInitializer ()
@property (nonatomic) BOOL hasInitializedNormalLoggers;
@property (nonatomic) BOOL hasInitializedNormalFileLogger;
@property (nonatomic) BOOL hasInitializedTestLoggers;
@end

@implementation UtilityInitializer
@synthesize testsLogDirPath = _testsLogDirPath;

+ (UtilityInitializer *)sharedTestSingleton
{
    static dispatch_once_t onceQueue;
    static UtilityInitializer *testSingleton = nil;
	
    dispatch_once(&onceQueue, ^{ testSingleton = [[self alloc] init]; });
    return testSingleton;
}


- (NSString *)testsLogDirPath
{
	if (!_testsLogDirPath) {
		_testsLogDirPath = [[NSHomeDirectory() stringByAppendingPathComponent:CS_INTERMEDIATE_PATHS_DIRECTORY] stringByAppendingPathComponent:[CS_LOG_DIRECTORY_NAME stringByAppendingString:@"_forTests"]];
	}
	return _testsLogDirPath;
}

- (void)initializeLNormalLogsIfNotAlreadyInitialized
{
	if (!self.hasInitializedNormalLoggers) {
		[DDLog addLogger:[DDTTYLogger sharedInstance]];
		self.hasInitializedNormalLoggers = YES;
	}
}

- (void)initializeNormalFileLoggerIfNotAlreadyInitialized
{
	if (!self.hasInitializedNormalFileLogger) {
		DDLogFileManagerDefault *defaultManager = [[DDLogFileManagerDefault alloc] initWithLogsDirectory:[Util logDirectoryPath]];
		DDFileLogger *fileLogger = [[DDFileLogger alloc] initWithLogFileManager:defaultManager];
		[fileLogger setMaximumFileSize:(10 * 1024 * 1024)]; //1 mbytes
		[fileLogger setRollingFrequency:(3600.0 * 24.0)];
		[[fileLogger logFileManager] setMaximumNumberOfLogFiles:10];
		[DDLog addLogger:fileLogger];
		self.hasInitializedNormalFileLogger = YES;
	}
}

- (void)initializeTestLogsIfNotInitialized
{
	if (!self.hasInitializedTestLoggers) {
		DDLogFileManagerDefault *defaultManager = [[DDLogFileManagerDefault alloc] initWithLogsDirectory:self.testsLogDirPath];
		DDFileLogger *fileLogger = [[DDFileLogger alloc] initWithLogFileManager:defaultManager];
		[fileLogger setMaximumFileSize:(10 * 1024 * 1024)]; //1 mbytes
		[fileLogger setRollingFrequency:(3600.0 * 24.0)];
		[[fileLogger logFileManager] setMaximumNumberOfLogFiles:10];
		[DDLog addLogger:fileLogger];
		self.hasInitializedTestLoggers = YES;
	}
}
@end
