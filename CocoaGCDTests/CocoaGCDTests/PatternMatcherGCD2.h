//
//  PatternMatcherGCD2.h
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 16/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import "PatternMatcherAsynchronous.h"

/**
 Asynchronous pattern matcher. Relies heavily on garnd central dispatch for heavy lifting.
 Separation of jobs is being done by assigning each of the available cores a number of words to search
 and match.
 */
@interface PatternMatcherGCD2 : PatternMatcherAsynchronous

@end


#pragma mark - Searchable word
@interface SearchableWord : NSObject
@property (nonatomic, strong) NSString *wordToSearch;
@property (nonatomic, strong) NSString *reverseWord;
@end

