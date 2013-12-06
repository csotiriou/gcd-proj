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
#import "UtilityInitializer.h"

#define SIDE 3

@interface AppDelegate()
@property (nonatomic, strong) MasterViewController *masterViewController;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	
	self.masterViewController = [[MasterViewController alloc] initWithNibName:NSStringFromClass([MasterViewController class]) bundle:nil];
	
	self.window.contentView = self.masterViewController.view;
	[[UtilityInitializer sharedTestSingleton] initializeLNormalLogsIfNotAlreadyInitialized];
#ifndef TEST_LOGGING
	[[UtilityInitializer sharedTestSingleton] initializeLNormalLogsIfNotAlreadyInitialized];
#endif
}




@end
