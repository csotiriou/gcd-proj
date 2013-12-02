//
//  Definitions.h
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 4/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import "DDLog.h"
static const int ddLogLevel = LOG_LEVEL_VERBOSE;


#define LOG_INIT_DEFAULT [DDLog addLogger:[DDTTYLogger sharedInstance]];

#define CS_LOG_DIRECTORY_NAME @"CocoaLogs"
#define CS_INTERMEDIATE_PATHS_DIRECTORY @"Desktop"



#ifdef DEBUG_LOGGING
#define CS_MACRO_BEGIN_TIME(X)			clock_t t1, t2; \
										t1 = clock();\
										NSString *functionName = X; \
										DDLogVerbose(@" %@ : started.", functionName);

#define CS_MACRO_END_DISPLAY			t2 = clock(); \
										float diff = (((float)t2 - (float)t1) / CLOCKS_PER_SEC ) * 1000; \
										DDLogVerbose(@" %@ : ended. time taken: %f miliseconds (%f seconds)", functionName, diff, diff / 1000.0f);
#else
#define CS_MACRO_BEGIN_TIME(X)
#define CS_MACRO_END_DISPLAY
#endif