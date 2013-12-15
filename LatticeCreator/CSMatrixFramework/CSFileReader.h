/*
 The MIT License (MIT)
 
 Copyright (c) 2013 Christos Sotiriou
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 the Software, and to permit persons to whom the Software is furnished to do so,
 subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
//	https://github.com/csotiriou/seqreader
//  CSFileReader.h
//  SeqReader
//
//  Created by Christos Sotiriou on 18/10/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CSFileReader;

@protocol CSFileReaderDelegate <NSObject>
@optional
- (void)fileReader:(CSFileReader *)reader didEncounterLine:(NSString *)line;
- (void)fileReaderDidEndProcessingFile:(CSFileReader *)reader;
@end

@protocol CSFileReaderDataSource <NSObject>

/**
 @brief Should be implemented by datasources. Indicates wether the file reader should stop processing in this step
 or not. Called before processing of each line starts.
 
 @param fileReader the file reader in question
 @return YES if you want to continue processing, otherwise NO
 */
- (BOOL)fileReaderShouldContinueProcessing:(CSFileReader *)fileReader;

@end


@interface CSFileReader : NSObject
@property (nonatomic, weak) id<CSFileReaderDelegate> delegate;
@property (nonatomic, weak) id<CSFileReaderDataSource> dataSource;


/**
 Start reading the file line bby line. Each time a new line is found, the delegate is
 notified
 @param filePath the path of the file to read
 @param encoding the encoding of the file to open for read
 */
- (void)startReadingLineByLineFileAtPath:(NSString *)filePath encoding:(NSStringEncoding)encoding;

@end
