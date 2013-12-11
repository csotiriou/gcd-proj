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

typedef enum {
	kLatticePreset10 = 1,
	kLatticePreset100,
	kLatticePreset200,
	kLatticePreset500
} LATTICE_PRESET;

typedef enum {
	kWordlistPreset10x10 = 1,
	kWordlistPreset100x10,
	kWordlistPreset300x10,
	kWordlistPreset10x100,
	kWordlistPreset10x1000
} WORDLIST_PRESET;


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
		self.matrixImporter = [[CSMatrixImporter alloc] init];
		[self.wordList loadWordListFromFile:[[NSBundle mainBundle] pathForResource:@"wordlist" ofType:@"wdl"]];
    }
    return self;
}

- (void)loadView
{
	[super loadView];
	[self hideProcessIndicator];
	[self refreshInfoLabel];
}


- (IBAction)runTestsSequentialButtonPressed:(id)sender {
	self.startDate = [NSDate date];
	[self setupProcessIndicatorWithLabelString:@"running sequential pattern matcher."];
	self.patternMatcher = [[PatternMatcherSequential alloc] initWithLattice:self.dnaLattice andWordList:self.wordList];
	self.patternMatcher.delegate = self;
	[self.patternMatcher performSelector:@selector(startScanning) withObject:nil afterDelay:0.1]; //delay to cope with a small bug that will run the pattern matcher before we are able to refresh the UI, although we have explicitly told to update the UI before the process starts.
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

- (void)patternMatcherDidStartScanning:(PatternMatcherBase *)matcher
{
	[self disableAllButtons];
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
	[self enableAllButtons];
}



- (void)refreshInfoLabel
{
	self.latticeSideLabel.stringValue = [NSString stringWithFormat:@"%i", self.dnaLattice.sideNumber];
	self.wordCountLabel.stringValue = [NSString stringWithFormat:@"%li", self.wordList.count];
	self.wordLengthLabel.stringValue = [NSString stringWithFormat:@"%li", self.wordList.wordLength];
}



- (void)disableAllButtons
{
	for (NSView *subView in self.view.subviews) {
		if ([subView isKindOfClass:[NSButton class]]) {
			[((NSButton *)subView) setEnabled:NO];
		}
	}
}

- (void)enableAllButtons
{
	for (NSView *subView in self.view.subviews) {
		if ([subView isKindOfClass:[NSButton class]]) {
			[((NSButton *)subView) setEnabled:YES];
		}
	}
}


- (IBAction)latticePresetOptionChanged:(NSPopUpButton *)sender {
	if (sender.selectedItem.tag == 0) {
		return;
	}
	NSString *fileName = nil;
	switch (sender.selectedItem.tag) {
		case kLatticePreset10:
			fileName = @"cube10";
			break;
		case kLatticePreset100:
			fileName = @"cube100";
			break;
		case kLatticePreset200:
			fileName = @"cube200";
			break;
		case kLatticePreset500:
			fileName = @"cube500";
			break;
		default:
			break;
	}
	self.matrixImporter = [[CSMatrixImporter alloc] init];
	[self loadDNAFileFromPath:[[NSBundle mainBundle] pathForResource:fileName ofType:@"desc"]];


	[self refreshInfoLabel];
}

- (IBAction)wordListPresetOptionChanged:(NSPopUpButton *)sender {
	if (sender.selectedItem.tag == 0) {
		return;
	}
	NSString *fileName = nil;
	switch (sender.selectedItem.tag) {
		case kWordlistPreset10x10:
			fileName = @"w10l10";
			break;
		case kWordlistPreset100x10:
			fileName = @"w100l10";
			break;
		case kWordlistPreset300x10:
			fileName = @"w300l10";
			break;
		case kWordlistPreset10x100:
			fileName = @"w10l100";
			break;
		default:
			break;
	}
	
	[self loadWDLFromPath:[[NSBundle mainBundle] pathForResource:fileName ofType:@"wdl"]];
	[self refreshInfoLabel];
}

- (IBAction)loadDNAFile:(id)sender {
	NSOpenPanel *openPanel = [NSOpenPanel openPanel];
	[openPanel setDirectoryURL:[NSURL fileURLWithPath:[@"~/" stringByStandardizingPath]]];
	[openPanel setAllowedFileTypes:@[@"desc"]];
	openPanel.allowsMultipleSelection = NO;
	openPanel.allowsOtherFileTypes = NO;
	
	NSInteger result = [openPanel runModal];
	if (result == NSOKButton) {
		NSURL *fileName = [openPanel URLs][0];
		DDLogVerbose(@"loading file from file url: %@", fileName.absoluteString);
		[self loadDNAFileFromPath:fileName.path];
		DDLogVerbose(@"loading done");
	}
	[self refreshInfoLabel];
	
	[self.latticePresetPopUpButton selectItem:self.latticePresetPopUpButton.itemArray[0]];
}

- (IBAction)loadWDL:(id)sender {
	NSOpenPanel *openPanel = [NSOpenPanel  openPanel];
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
	[self refreshInfoLabel];
	[self.wordListPresetPopupButton selectItem:self.wordListPresetPopupButton.itemArray[0]];
}

- (void)loadDNAFileFromPath:(NSString *)path
{

	[self.matrixImporter loadLatticeAtLocation:path completionBlock:^(DNALattice1d *lattice) {
		self.dnaLattice = lattice;
	}];
}

- (void)loadWDLFromPath:(NSString *)path
{
	[self.wordList loadWordListFromFile:path];
}
@end
