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


#pragma mark PatternMatcherBaseDelegate
/**
 Delegate protocol, that serves as an interface for notifying classes about important situations, like the
 start and finish of a pattern matching process.
 */
@protocol PatternMatcherBaseDelegate <NSObject>
/**
 @brief Notifies the delegate that the pattern matcher finished processing. A dictionary with results in the
 form NSDictionary<WordToFind, BOOL> indicating found words is returned.
 
 @param matcher the pattern matcher that sent this message
 @param the results if the process in a dictionary
 */
- (void)patternMatcher:(PatternMatcherBase *)matcher didFinishWithResults:(NSDictionary *)results;
@optional

/**
 @brief Notifies the delegate that the pattern matcher started scanning. Optional, and some pattern matchers may ignore it
 (although it's best practice to implement it).
 
 @param matcher the pattern matcher that sent this message
 */
- (void)patternMatcherDidStartScanning:(PatternMatcherBase *)matcher;
@end

#pragma mark PatternMatcherBase

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
 The reversed words of the dictionary to be searched. An Array of strings. The words contained in this array
 are matched in 1-1 in terms of index with the words in 'dictionaryToSearch' Example: The word at index 1
 of the dictionaryToSearch has as a reverse the word at index 1 in 'reversedDictionaryToSearch'.
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
 @brief Inits the pattern matcher with a lattice and a wordlist object. If you subclass this method, be sure to call
 the method implemented in 'super'
 
 @param lattice a lattice
 @param wordList a wordlist object containing unique strings.
 */
- (id)initWithLattice:(id<LatticeCommon>)lattice andWordList:(CSWordList *)wordList;



/**
 Starts scanning the lattice. After scanning ends, the delegate will be called. 
 NOTE: By definition this function will start the pattern matching process even if
 there is no way of actually finding any word. Use the 'startScanningIfEfficientXXXX' family
 of functions to avoid unnecessary work.
 */
- (void)startScanning;


/**
 @brief Starts the scanning process. On completion, it runs the completion block. NOTICE:
 Upon finishing the tasks, the completion block will be called in addition to the delegate
 functions. NOTE: By definition this function will start the pattern matching process even if
 there is no way of actually finding any word. Use the 'startScanningIfEfficientXXXX' family
 of functions to avoid unnecessary work.
 
 @param completionBlock the block to call upon completion.
 */
- (void)startScanningWithCompletionBlock:(void (^)())completionBlock;



/**
 @brief Starts the scan procedure, if it would be efficient to do so. Consults the 'isWorthStartingScanning'
 function to determine if it makes sense to start scanning. If not, then the process will exit immediately.
 */
- (void)startScanningIfefficient;



/**
 @brief Starts the scan procedure, if it would be efficient to do so. Consults the 'isWorthStartingScanning'
 function to determine if it makes sense to start scanning. If not, then the process will immediately call the
 completion block. If not, the completionBlock is called after the results have been collected.
 
 @param completionBlock the block to call upon completion.
 */
- (void)startScanningIfEfficientWithCompletionBlock:(void (^)())completionBlock;


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


/**
 @brief Performs additional initializations. Override this method to perform initializations that happen after the initial ones.
 If you override this method, you MUST call [super initPhase2] before your initialisation, to avoid overriding default behaviors.
 */
- (void)initPhase2;



/**
 @brief Indicates wether a scan process would actually be possible to return results. A scan process would make sense if there are more than 0
 words to search, and if the length of the words to search is less than the size of the cube's side.
 @return a BOOL indicating wether a scan would make sense in this case.
 */
- (BOOL)isWorthStartingScanning;
@end



