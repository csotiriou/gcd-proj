//
//  Util.m
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 6/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import "Util.h"

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
@end
