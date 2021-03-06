//
//  MasterViewController.h
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 16/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/**
 The GUI of the application 
 */
@interface MasterViewController : NSViewController
@property (strong) IBOutlet NSTextField *progressLabel;
@property (strong) IBOutlet NSProgressIndicator *progressActivityIndicator;
@property (strong) IBOutlet NSTextView *resultsTextView;
@property (strong) IBOutlet NSTextField *latticeSideLabel;
@property (strong) IBOutlet NSTextField *wordCountLabel;
@property (strong) IBOutlet NSTextField *wordLengthLabel;
@property (strong) IBOutlet NSPopUpButton *latticePresetPopUpButton;
@property (strong) IBOutlet NSPopUpButton *wordListPresetPopupButton;


- (IBAction)latticePresetOptionChanged:(NSPopUpButton *)sender;
- (IBAction)wordListPresetOptionChanged:(NSPopUpButton *)sender;


- (IBAction)loadDNAFile:(id)sender;
- (IBAction)loadWDL:(id)sender;

- (IBAction)runTestsSequentialButtonPressed:(id)sender;
- (IBAction)runTestsGCDButtonPressed:(id)sender;
- (IBAction)runTestsGCD2ButtonPressed:(id)sender;

@end
