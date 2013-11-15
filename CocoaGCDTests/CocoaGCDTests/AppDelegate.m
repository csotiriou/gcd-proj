//
//  AppDelegate.m
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 30/10/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import "AppDelegate.h"
#import <CSMatrixFramework/CSMatrixFramework.h>
#import "DDTTYLogger.h"
#import "DDFileLogger.h"
#import "PatternMatcherGCD.h"

#define SIDE 3

@interface AppDelegate()
@property (nonatomic, strong) PatternMatcherGCD *patternMatcher;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	//setup logging
	[DDLog addLogger:[DDTTYLogger sharedInstance]];
	DDLogFileManagerDefault *defaultManager = [[DDLogFileManagerDefault alloc] initWithLogsDirectory:[Util logDirectoryPath]];
	DDFileLogger *fileLogger = [[DDFileLogger alloc] initWithLogFileManager:defaultManager];
	[fileLogger setMaximumFileSize:(10 * 1024 * 1024)]; //1 mbytes
	[fileLogger setRollingFrequency:(3600.0 * 24.0)];
	[[fileLogger logFileManager] setMaximumNumberOfLogFiles:10];
	[DDLog addLogger:fileLogger];
	

//	DNALattice1d *lattice = [importer dnaLatticeFromFileAtLocation:[[Util userHomeDirectoryPath] stringByAppendingPathComponent:@"Desktop/output.desc"]];
	DNALattice1d *lattice = [[DNALattice1d alloc] initWithSideNumber:10 andChar:'a'];
	
	
	self.patternMatcher = [[PatternMatcherGCD alloc] initWithLattice:lattice andDictionaryToSearch:@[@"aaa", @"bb", @"aaa", @"bb", @"aaa", @"bb", @"aaa", @"bb", @"aaa", @"bb", @"aaa", @"bb", @"aaa", @"bb", @"aaa", @"bb"]];
	[self.patternMatcher startScanning];
//	[self.patternMatcher testThreads];;
//	[self.patternMatcher testThreadsOperationQueue];
}




@end
