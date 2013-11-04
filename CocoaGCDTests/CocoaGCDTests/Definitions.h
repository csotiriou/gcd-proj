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
