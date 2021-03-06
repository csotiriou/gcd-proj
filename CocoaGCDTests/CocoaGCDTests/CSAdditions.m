//
//  NSArray+CSAdditions.m
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 15/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import "CSAdditions.h"

@implementation NSString (CSAdditions)
- (NSString *)reversedString
{
	//although the commented string works well for normal strings with ascii characters, (and it is faster), it fails
	//to handle strings with special characters, as we use here. That's why I chose the slower but more reliable approach,
	//letting NSString to handle the special characters.
	
/*	const char *originalChars = [self cStringUsingEncoding:NSUTF8StringEncoding];
	char reverseString[self.length];
	
	int i;
	for (i = 1; i<= self.length; i++) {
		reverseString[i-1] = originalChars[self.length - i];
	}
	reverseString[self.length] = '\0'; //add the terminating character
	
	NSString *finalString = [NSString stringWithCString:reverseString encoding:NSUTF8StringEncoding];
	return finalString;*/
	
	NSMutableString *reversedString = [NSMutableString string];
	NSInteger charIndex = [self length];
	while (charIndex > 0) {
		charIndex--;
		NSRange subStrRange = NSMakeRange(charIndex, 1);
		[reversedString appendString:[self substringWithRange:subStrRange]];
	}
	return [reversedString copy];
}


- (BOOL)containsStringStrict:(NSString *)str
{
	return [self rangeOfString:str].location != NSNotFound;
}

- (BOOL)containsStringCareless:(NSString *)str
{
	return [self containsString:str options:NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch];
}

- (BOOL)containsString:(NSString *)str options:(NSStringCompareOptions)options
{
	return [self rangeOfString:str options:options].location != NSNotFound;
}
@end

@implementation NSArray (CSAdditions)
- (BOOL)containsString:(NSString *)string
{
	for (NSString *str in self) {
		if ([str rangeOfString:string].location != NSNotFound) {
			return YES;
		}
	}
	return NO;
}
@end
