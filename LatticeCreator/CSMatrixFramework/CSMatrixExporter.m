//
//  CSMatrixExporter.m
//  LatticeCreator
//
//  Created by Christos Sotiriou on 3/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import "CSMatrixExporter.h"

@interface CSMatrixExporter ()
@property (nonatomic, strong) NSFileHandle *fileHandle;
@end

@implementation CSMatrixExporter

- (id)initWithLattice:(id<LatticeCommon>)lat
{
	if (self = [super init]) {
		self.lattice = lat;
	}
	return self;
}

- (void)exportToFile:(NSString *)filePath withDefaultCharacter:(char)defaultCharacter
{
	if ([[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:NO]) {
		[[NSFileManager defaultManager] removeItemAtPath:filePath error:NULL];
	}
	[[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
	
	self.fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
	
	if (self.fileHandle != nil) { //file is open
		NSLog(@"starting export...");
		[self.fileHandle writeData:[@"#File Descriptions\n#Legend:\n#—- ’s’ indicates the size of each side\n#   of the lattice. Do not change this value unless\n#   you really know what you are doing.\n#— ‘f’ indicates the default character. positions in\n#   the lattice that are not explicitly mentioned in\n#   this file will get this value\n#— ’d’ indicates a position in the lattice. always comes\n#   in the form ’d:<lattice>,<column>,<row>=<character>’\n#   change manually the values you need. Be careful, you\n#   must preserve proper format.\n#LATTICE--BEGINS\n" dataUsingEncoding:NSUTF8StringEncoding]];
		[self.fileHandle writeData:[[NSString stringWithFormat:@"s:%i\n", self.lattice.sideNumber] dataUsingEncoding:NSUTF8StringEncoding]];
		[self.fileHandle writeData:[[NSString stringWithFormat:@"f:%c\n", defaultCharacter] dataUsingEncoding:NSUTF8StringEncoding]];
		
		[self.fileHandle writeData:[@"#Data begins below this line\n" dataUsingEncoding:NSUTF8StringEncoding]];
		for (int i = 0; i< self.lattice.sideNumber; i++) {
			@autoreleasepool { // release the interme
				NSMutableString *bigChunk = [NSMutableString string];
				for (int j=0; j< self.lattice.sideNumber; j++) {
					for (int k = 0; k<self.lattice.sideNumber; k++) {
						NSLog(@"d:%i,%i,%i=%c\n", i,j,k, [self.lattice getItemAti:i andJ:j andK:k]);
						[bigChunk appendFormat:@"d:%i,%i,%i=%c\n", i,j,k, [self.lattice getItemAti:i andJ:j andK:k]];
					}
				}
				NSData *data = [bigChunk dataUsingEncoding:NSUTF8StringEncoding];
				NSLog(@"writing data of length: %f KBytes for chunk: %i ( x 1000 x 1000 )", (float)data.length/1024.0f, i);
				[self.fileHandle writeData:data];
			}
		}
		[self.fileHandle closeFile];
		NSLog(@"export finished");
		
	}
}

- (void)exportToFile:(NSString *)filePath
{
	[self exportToFile:filePath withDefaultCharacter:'0'];
}
@end
