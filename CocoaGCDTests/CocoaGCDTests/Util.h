//
//  Util.h
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 6/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject
+ (NSString *)userHomeDirectoryPath;
+ (NSString *)logDirectoryPath;
+ (BOOL)array:(NSArray *)array ContainsString:(NSString *)string;
@end
