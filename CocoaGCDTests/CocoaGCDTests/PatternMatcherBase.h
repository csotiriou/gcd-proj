//
//  PatternMatcherBase.h
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 4/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CSMatrixFramework/CSMatrixFramework.h>
#import "LatticeLineExtractor.h"
#import "CSAdditions.h"
#import "LatticeLineExtractorProtocol.h"

@class PatternMatcherBase;

@protocol PatternMatcherBaseDelegate <NSObject>
- (void)patternMatcher:(PatternMatcherBase *)matcher didFinishWithResults:(NSDictionary *)results;
@end

/**
 Abstract class implementing the basic functionality, helpful functions, and patterns
 for all pattern matchers.
 */
@interface PatternMatcherBase : NSObject

/**
 The lattice that is about to be processed. It represents a 3D cube, NxNxN
 */
@property (nonatomic, readonly) id <LatticeCommon> lattice;

/**
 The delegate object will be notified upon completion of processing.
 */
@property (nonatomic, weak) id<PatternMatcherBaseDelegate> delegate;

/**
 The dictionary of words to search. An array of strings.
 */
@property (nonatomic, readonly) NSArray *dictionaryToSearch;

/**
 The reversed words of the dictionary to be searched. An Array of strings.
 */
@property (nonatomic, readonly) NSArray *reversedDictionaryToSearch;

/**
 Helper class that extracts components from lattices in order to be processed. Use it, but don't change it.
 */
@property (nonatomic, readonly) id<LatticeLineExtractorProtocol> latticeExtractor;

/**
 Resulting dictionary for the given words. Each key represents a word given in the 'dictionaryToSearch'. Each value is
 an NSNumber, representing 'YES' or 'NO', indicating if the word is found inside the dictionary or not. After the scanning of the cube has ended, this dictionary will hold the results.
 */
@property (nonatomic, readonly) NSMutableDictionary *wordsProcessedAndResults;


/**
 Flag indicating if the object has already scanned the lattice once. Note that this flag is not being taken into account when starting a new scan, so it's up to the 3rd party developer to decide if he wants to do a new search or not.
 */
@property (nonatomic, readonly) BOOL hasAlreadyRan;



/**
 @brief Inits the pattern matcher with a lattice and a dictionary of words
 @param lattice a lattice
 @param dictionaryOfWords an array of words to search in the lattice.
 */
//- (id)initWithLattice:(id<LatticeCommon>)lattice andDictionaryToSearch:(NSArray *)dictionaryOfWords;


/**
 @brief Inits the pattern matcher with a lattice and a wordlist object.
 @param lattice a lattice
 @param wordList a wordlist object containing unique strings.
 */
- (id)initWithLattice:(id<LatticeCommon>)lattice andWordList:(CSWordList *)wordList;

/**
 Starts scanning the lattice. After scanning ends, the delegate will be called.
 */
- (void)startScanning;


/**
 @brief Starts the scanning process. On completion, it runs the completion block. NOTICE:
 Upon finishing the tasks, the completion block will be called in addition to the delegate
 functions.
 
 @param completionBlock the block to call upon completion.
 */
- (void)startScanningWithCompletionBlock:(void (^)())completionBlock;


/**
 @brief signals the delegate if any, that the whole process is complete. Made public, in order to be called
 by subclasses, and not directly by external classes. If you override 'signalComplete', you MUST call
 [super signalComplete] somewhere inside the same function, in order to notify the delegates and set all flags to their
 appropriate values.
 */
- (void)signalComplete;


/**
 @brief Searches a line for strings that are included in the dictionary to search. performs search in both directions. In case
 where a line indeed contains a word, this word is passed as the argument in the 'found' block. In case where no word is found
 inside the line, the 'foundBlock' is not even called. Avoids searching words that have already been found
 
 @discussion Since subclasses use the same algorihm for searching but do different actions when a word is found, the 'foundBlock'
 will allow them to specify different behaviors when a line is found to contain a word.
 
 @param line the line to search the strings into
 @param foundBlock the block to be called if a word is found inside a line
 */
- (void)matchStringsForLine:(NSString *)line withFoundBlock:(void(^)(NSString *wordFound))foundBlock;


//
///**
// @brief Searches a line for strings that are included in the dictionary to search. performs search in both directions. In case
// where a line indeed contains a word, this word is passed as the argument in the 'found' block. In case where no word is found
// inside the line, the 'foundBlock' is not even called. Avoids searching words that have already been found. This algorithm is supposed
// to be faster than the plain matchStringsForLine:withFoundBlock method
// 
// @discussion Since subclasses use the same algorihm for searching but do different actions when a word is found, the 'foundBlock'
// will allow them to specify different behaviors when a line is found to contain a word.
// 
// @param line the line to search the strings into
// @param foundBlock the block to be called if a word is found inside a line
// */
//
//- (void)matchStringsFastForLine:(NSString *)line withFoundBlock:(void(^)(NSString *wordFound))foundBlock;


/**
 Performs additional initializations. Override this method to perform initializations that happen after the initial ones.
 If you override this method, you MUST call [super initPhase2] before your initialisation, to avoid overriding default behaviors.
 */
- (void)initPhase2;
@end
