//
//  AppDelegate.m
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 30/10/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import "AppDelegate.h"
#import "DNALattice.h"

@interface AppDelegate()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Insert code here to initialize your application
	DNALattice *lattice = [[DNALattice alloc] initWithSideNumber:100 andChar:'q'];
	
	
//	printf("%c", [lattice getItemAti:0 andJ:0 andK:0]);
//	char alpha[3][3][3] = { {'a','b','c'}, {'d','e','f'}, {'g','h','i'}};
//	
//	char ***_cube3d;
//
//	int size = 3;
//
//	_cube3d = (char ***)malloc(size * (sizeof(char**)));
//	for (int i = 0; i< size; i++) {
//		_cube3d[i] = (char **)malloc(size * sizeof(char*));
//		for (int j = 0; j<size; j++) {
//			_cube3d[i][j] = (char *)malloc(size * sizeof(char));
//		}
//	}
//	
//	
//	for (int i = 0; i< size; i++) {
//		for (int j = 0; j<size; j++) {
//			for (int k = 0; k<size; k++) {
//				_cube3d[i][j][k] = 'a';
//			}
//		}
//	}
	
}

@end
