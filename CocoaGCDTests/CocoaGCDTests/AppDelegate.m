//
//  AppDelegate.m
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 30/10/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import "AppDelegate.h"

#import "DDTTYLogger.h"
#import "DDFileLogger.h"
#import "MasterViewController.h"


#define SIDE 3

@interface AppDelegate()
@property (nonatomic, strong) MasterViewController *masterViewController;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	
	self.masterViewController = [[MasterViewController alloc] initWithNibName:NSStringFromClass([MasterViewController class]) bundle:nil];
	
	self.window.contentView = self.masterViewController.view;
	
	//setup logging
	[DDLog addLogger:[DDTTYLogger sharedInstance]];
	DDLogFileManagerDefault *defaultManager = [[DDLogFileManagerDefault alloc] initWithLogsDirectory:[Util logDirectoryPath]];
	DDFileLogger *fileLogger = [[DDFileLogger alloc] initWithLogFileManager:defaultManager];
	[fileLogger setMaximumFileSize:(10 * 1024 * 1024)]; //1 mbytes
	[fileLogger setRollingFrequency:(3600.0 * 24.0)];
	[[fileLogger logFileManager] setMaximumNumberOfLogFiles:10];
	[DDLog addLogger:fileLogger];
}




@end
