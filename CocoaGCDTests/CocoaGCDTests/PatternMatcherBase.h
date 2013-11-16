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


@class PatternMatcherBase;

@protocol PatternMatcherBaseDelegate <NSObject>
- (void)patternMatcher:(PatternMatcherBase *)matcher didFinishWithResults:(NSDictionary *)results;
@end

/**
 Abstract class implementing the basic functionality, helpful functions, and patterns
 for all pattern matchers.
 */
@interface PatternMatcherBase : NSObject
@property (nonatomic, strong) id <LatticeCommon> lattice;
@property (nonatomic, weak) id<PatternMatcherBaseDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *dictionaryToSearch;
@property (nonatomic, strong) LatticeLineExtractor *latticeExtractor;
@property (nonatomic, strong) NSMutableDictionary *wordsProcessedAndResults;
@property (nonatomic, readonly) NSArray *reversedDictionaryToSearch;
@property (nonatomic) BOOL hasAlreadyRan;



/**
 @brief Inits the pattern matcher with a lattice and a dictionary of words
 @param lattice a lattice
 @param dictionaryOfWords an array of words to search in the lattice.
 */
- (id)initWithLattice:(id<LatticeCommon>)lattice andDictionaryToSearch:(NSArray *)dictionaryOfWords;


/**
 Starts scanning the lattice. After scanning ends, the delegate will be called.
 */
- (void)startScanning;


/**
 @brief signals the delegate if any, that the whole process is complete. Made public, in order to be called
 by subclasses, and not directly by external classes.
 */
- (void)signalComplete;


/**
 @brief Searches a line for strings that are included in the dictionary to search. performs search in both directions. In case
 where a line indeed contains a word, this word is passed as the argument in the 'found' block. In case where no word is found
 inside the line, the 'foundBlock' is not even called. Avoids searching words that have already been found
 
 @discussion Since subclasses use the same algorihm for searching but do different actions when a word is found, the 'foundBlock'
 will allow them to specify different behaviors.
 
 @param line the line to search the strings into
 @param foundBlock the block to be called if a word is found inside a line
 */
- (void)matchStringsForLine:(NSString *)line withFoundBlock:(void(^)(NSString *wordFound))foundBlock;
@end
