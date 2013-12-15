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
//  CSFileReader.m
//  SeqReader
//
//  Created by Christos Sotiriou on 18/10/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import "CSFileReader.h"

@interface CSFileReader ()

@end

@implementation CSFileReader

- (void)startReadingLineByLineFileAtPath:(NSString *)filePath encoding:(NSStringEncoding)encoding
{
	FILE *fp;
	char *line = NULL;
	size_t len = 0;
	ssize_t read;
	
	fp = fopen([filePath cStringUsingEncoding:NSUTF8StringEncoding], "r");
	if (fp) {
		while ( (read =  getline(&line, &len, fp)) != -1) {
			@autoreleasepool {
				NSString *currentLine = [[NSString alloc] initWithBytes:line length:read encoding:encoding];
				if (currentLine) {
					if ([self.dataSource fileReaderShouldContinueProcessing:self]) {
						if ([self.delegate respondsToSelector:@selector(fileReader:didEncounterLine:)]) {
							[self.delegate fileReader:self didEncounterLine:currentLine];
						}
					}else{
						break;
					}
				}
			}
		}
	}else{
		@throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"File %@ could not be opened for reading", filePath] userInfo:nil];
	}
	
	if ([self.delegate respondsToSelector:@selector(fileReaderDidEndProcessingFile:)]) {
		[self.delegate fileReaderDidEndProcessingFile:self];
	}
	
	fclose(fp);
	if (line != NULL) {
		free(line);
	}
}

- (void)dealloc
{
    
}
@end
