//
//  CSWordList.h
//  LatticeCreator
//
//  Created by Christos Sotiriou on 20/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 CSWordList is a wordlist maker. It creates word lists to be used with the pattern matchers. All strings to be inserted into
 CSWordList are of equal length. In this wordlist, there are no duplicates.
 */
@interface CSWordList : NSObject <NSFastEnumeration>

/**
 The unique words that are contained into the wordlist
 */
@property (nonatomic, readonly) NSOrderedSet *words;

/**
 The number of objects added into the wordlist
 */
@property (nonatomic, readonly) NSInteger count;

/**
 Gets the length of the words inside the word list. All words have the same length
 */
@property (nonatomic, readonly) NSInteger wordLength;


/**
 @brief Adds a word to the list. The word must be of length equal to the rest of the other ones. In case where the
 word already exists, it is discarded.
 
 @param filePath The path of the .wdl file to load the words from.
 */
- (void)addWord:(NSString *)word;

/**
 @brief Loads a wordlist from a file in the specified path
 
 @param filePath The path of the file to load the words from.
 */
- (void)loadWordListFromFile:(NSString *)filePath;

/*
 Add support for the new Obejctive C literals (allowing c array-style access to objects in collections, and other stuff)
 */
- (id)objectAtIndexedSubscript:(NSUInteger)idx;
- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx;

@end
