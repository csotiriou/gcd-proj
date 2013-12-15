//
//  CSWordList.h
//  LatticeCreator
//
//  Created by Christos Sotiriou on 20/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <Foundation/Foundation.h>


#define kWordListAcceptableCharacters @"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~©≥¢±£≤"
//2013-12-15 01:59:04.075 LatticeCreator[12266:303] d:6,6,5=¬

/**
 CSWordList is a wordlist maker. It creates word lists to be used with the pattern matchers. All strings to be inserted into
 CSWordList are of equal length. In this wordlist, there are no duplicates. The wordlist was created to ensure validity of the
 words inserted into a pattern matcher for beginning the process. The maximum words that a CSWordList can hold are 1000 distinct ones
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
 Gets the acceptable characters for this word list. Readonly, since for this project only words containing
 specific characters are accepted
 */
@property (nonatomic, readonly) NSString *acceptableCharacters;


/**
 Initialises the wordlist with some words. Words are being checked and being treated as if they were added one by one.
 */
- (id)initWithWords:(NSArray *)words;

/**
 @brief Adds a word to the list. The word must be of length equal to the rest of the other ones. In case where the
 word already exists, it is discarded.
 
 @param filePath The path of the .wdl file to load the words from.
 */
- (void)addWord:(NSString *)word;

/**
 @brief Adds many words to the list. The words must be of length equal to the rest of the other ones. In case where a
 word already exists, it is discarded.
 
 @param filePath The path of the .wdl file to load the words from.
 */
- (void)addWords:(NSArray *)array;

/**
 @brief Loads a wordlist from a file in the specified path
 
 @param filePath The path of the file to load the words from.
 */
- (void)loadWordListFromFile:(NSString *)filePath;


/**
 @brief Extracts the words loaded to this list to a file at a specified path
 
 @param filePath the file path to write the file.
 */
- (void)extractListToFileAtPath:(NSString *)filePath;

/*
 Add support for the new Obejctive C literals (allowing c array-style access to objects in collections, and other stuff)
 */
- (id)objectAtIndexedSubscript:(NSUInteger)idx;
- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx;

@end
