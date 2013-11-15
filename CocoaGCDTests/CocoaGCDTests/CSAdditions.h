//
//  NSArray+CSAdditions.h
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 15/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CSAdditions)
- (NSString *)reversedString;

- (BOOL)containsStringStrict:(NSString *)str;
- (BOOL)containsStringCareless:(NSString *)str;
- (BOOL)containsString:(NSString *)str options:(NSStringCompareOptions)options;
@end

@interface NSArray (CSAdditions)
- (BOOL)containsString:(NSString *)string;
@end
