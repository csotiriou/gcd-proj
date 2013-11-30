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
#import "PatternMatcherGCD2.h"

@interface MasterViewController () <PatternMatcherBaseDelegate>
@property (nonatomic, strong) PatternMatcherBase *patternMatcher;
@property (nonatomic, strong) id<LatticeCommon> dnaLattice;
@property (nonatomic, strong) CSWordList *wordList;
@property (nonatomic, strong) CSMatrixImporter *matrixImporter;
@property (nonatomic, strong) NSDate *startDate;
@end

@implementation MasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.dnaLattice = [[DNALattice1d alloc] initWithSideNumber:500 andChar:'a'];
		self.wordList = [[CSWordList alloc] init];
		[self.wordList loadWordListFromFile:[[NSBundle mainBundle] pathForResource:@"wordlist" ofType:@"wdl"]];
    }
    return self;
}

- (void)loadView
{
	[super loadView];
	[self hideProcessIndicator];
}


- (IBAction)runTestsSequentialButtonPressed:(id)sender {
	self.startDate = [NSDate date];
	[self setupProcessIndicatorWithLabelString:@"running sequential pattern matcher."];
	self.patternMatcher = [[PatternMatcherSequential alloc] initWithLattice:self.dnaLattice andWordList:self.wordList];
	self.patternMatcher.delegate = self;
	[self.patternMatcher startScanning];
}

- (IBAction)runTestsGCDButtonPressed:(id)sender {
	self.startDate = [NSDate date];
	[self setupProcessIndicatorWithLabelString:@"running GCD pattern matcher tests."];
	self.patternMatcher = [[PatternMatcherGCD alloc] initWithLattice:self.dnaLattice andWordList:self.wordList];
	self.patternMatcher.delegate = self;
	[self.patternMatcher startScanning];
}

- (IBAction)runTestsGCD2ButtonPressed:(id)sender {
	self.startDate = [NSDate date];
	[self setupProcessIndicatorWithLabelString:@"running GCD 2 pattern matcher tests."];
	self.patternMatcher = [[PatternMatcherGCD2 alloc] initWithLattice:self.dnaLattice andWordList:self.wordList];
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
	DDLogVerbose(@"results: %@", results.description);
	[self hideProcessIndicator];
	
	NSDate *endDate = [NSDate date];
	NSTimeInterval timeInterval = [endDate timeIntervalSinceDate:self.startDate];
	NSString *resultStr = [NSString stringWithFormat:@"Finished running %@. Time taken: %f seconds.", NSStringFromClass([matcher class]), timeInterval];
	self.resultsTextView.string = resultStr;
}
- (IBAction)loadDNAFile:(id)sender {
	NSOpenPanel *openPanel = [[NSOpenPanel alloc] init];
	[openPanel setDirectoryURL:[NSURL fileURLWithPath:[@"~/" stringByStandardizingPath]]];
	[openPanel setAllowedFileTypes:@[@"desc"]];
	openPanel.allowsMultipleSelection = NO;
	openPanel.allowsOtherFileTypes = NO;
	
	NSInteger result = [openPanel runModal];
	if (result == NSOKButton) {
		NSURL *fileName = [openPanel URLs][0];
		DDLogVerbose(@"loading file from file url: %@", fileName.absoluteString);
//		[self.wordList loadWordListFromFile:fileName.path];
		self.matrixImporter = [[CSMatrixImporter alloc] init];
		[self.matrixImporter loadLatticeAtLocation:fileName.path completionBlock:^(DNALattice1d *lattice) {
			self.dnaLattice = lattice;
		}];
		DDLogVerbose(@"loading done");
	}
	
}

- (IBAction)loadWDL:(id)sender {
	NSOpenPanel *openPanel = [[NSOpenPanel alloc] init];
	[openPanel setDirectoryURL:[NSURL fileURLWithPath:[@"~/" stringByStandardizingPath]]];
	[openPanel setAllowedFileTypes:@[@"wdl"]];
	openPanel.allowsMultipleSelection = NO;
	openPanel.allowsOtherFileTypes = NO;
	
	NSInteger result = [openPanel runModal];
	if (result == NSOKButton) {
		NSURL *fileName = [openPanel URLs][0];
		DDLogVerbose(@"loading file from file url: %@", fileName.absoluteString);
		[self.wordList loadWordListFromFile:fileName.path];
		DDLogVerbose(@"loading done");
	}
}
@end
