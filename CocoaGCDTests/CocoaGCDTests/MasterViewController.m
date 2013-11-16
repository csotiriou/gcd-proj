//
//  MasterViewController.m
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 16/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import "MasterViewController.h"
#import <CSMatrixFramework/CSMatrixFramework.h>
#import "PatternMatcherGCD.h"
#import "PatternMatcherSequential.h"

@interface MasterViewController () <PatternMatcherBaseDelegate>
@property (nonatomic, strong) PatternMatcherBase *patternMatcher;
@property (nonatomic, strong) id<LatticeCommon> dnaLattice;
@property (nonatomic, strong) NSArray *dictionaryToSearch;
@end

@implementation MasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.dnaLattice = [[DNALattice1d alloc] initWithSideNumber:100 andChar:'a'];
		self.dictionaryToSearch = @[@"aaa", @"bb", @"aaa", @"bb", @"aaa", @"bb", @"aaa", @"bb", @"aaa", @"bb", @"aaa", @"bb", @"aaa", @"bb", @"aaa", @"bb"];
    }
    return self;
}

- (void)loadView
{
	[super loadView];
	[self hideProcessIndicator];
}


- (IBAction)runTestsSequentialButtonPressed:(id)sender {
	[self setupProcessIndicatorWithLabelString:@"running sequential pattern matcher tests."];
	self.patternMatcher = [[PatternMatcherSequential alloc] initWithLattice:self.dnaLattice andDictionaryToSearch:self.dictionaryToSearch];
	self.patternMatcher.delegate = self;
	[self.patternMatcher startScanning];
}

- (IBAction)runTestsGCDButtonPressed:(id)sender {
	[self setupProcessIndicatorWithLabelString:@"running GCD pattern matcher tests."];
	self.patternMatcher = [[PatternMatcherGCD alloc] initWithLattice:self.dnaLattice andDictionaryToSearch:self.dictionaryToSearch];
	self.patternMatcher.delegate = self;
	[self.patternMatcher startScanning];
}

- (void)setupProcessIndicatorWithLabelString:(NSString *)textInLabel
{
	[self.progressLabel setStringValue:textInLabel];
	self.progressActivityIndicator.alphaValue = 1.0f;
	[self.progressActivityIndicator startAnimation:self];
}

- (void)hideProcessIndicator
{
	[self.progressLabel setStringValue:@"Idle"];
	self.progressActivityIndicator.alphaValue = 0.0f;
	[self.progressActivityIndicator stopAnimation:self];
}

- (void)patternMatcher:(PatternMatcherBase *)matcher didFinishWithResults:(NSDictionary *)results
{
	DDLogVerbose(@"task was done.");
	[self hideProcessIndicator];
}
@end
