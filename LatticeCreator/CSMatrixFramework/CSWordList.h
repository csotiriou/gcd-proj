//
//  CSWordList.h
//  LatticeCreator
//
//  Created by Christos Sotiriou on 20/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSWordList : NSObject <NSFastEnumeration>
@property (nonatomic, readonly) NSOrderedSet *words;

- (void)addWord:(NSString *)word;
- (void)loadWordListFromFile:(NSString *)filePath;
@end
