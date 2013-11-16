//
//  Util.m
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 6/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import "Util.h"
#include <mach/mach_host.h>

@implementation Util

+ (NSString *)userHomeDirectoryPath
{
	return NSHomeDirectory();
}

+ (NSString *)logDirectoryPath
{
	return [[NSHomeDirectory() stringByAppendingPathComponent:CS_INTERMEDIATE_PATHS_DIRECTORY] stringByAppendingPathComponent:CS_LOG_DIRECTORY_NAME];
}

+ (BOOL)array:(NSArray *)array ContainsString:(NSString *)string
{
	for (NSString *str in array) {
		if ([str rangeOfString:string].location != NSNotFound) {
			return YES;
		}
	}
	return NO;
}


/* 
 Code found in:
 http://stackoverflow.com/questions/7241936/how-do-i-detect-a-dual-core-cpu-on-ios
 */
+ (int)getNumberOfAvailableCoresForCurrentMachine
{
	host_basic_info_data_t hostInfo;
	mach_msg_type_number_t infoCount;
	
	infoCount = HOST_BASIC_INFO_COUNT;
	host_info( mach_host_self(), HOST_BASIC_INFO, (host_info_t)&hostInfo, &infoCount ) ;
	
	return hostInfo.max_cpus ;
}
@end
