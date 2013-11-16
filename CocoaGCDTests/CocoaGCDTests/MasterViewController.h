//
//  MasterViewController.h
//  CocoaGCDTests
//
//  Created by Christos Sotiriou on 16/11/13.
//  Copyright (c) 2013 Oramind. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MasterViewController : NSViewController
- (IBAction)runTestsSequentialButtonPressed:(id)sender;
- (IBAction)runTestsGCDButtonPressed:(id)sender;


@property (strong) IBOutlet NSTextField *progressLabel;
@property (strong) IBOutlet NSProgressIndicator *progressActivityIndicator;
@property (strong) IBOutlet NSTextView *resultsTextView;

@end
