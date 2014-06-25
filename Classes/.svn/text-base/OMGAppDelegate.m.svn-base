//
//  OMGAppDelegate.m
//  OMG Photo Gallery
//
//  Created by Brendan S. Murphy on 5/24/11.
//  Copyright 2011 Yahoo! Inc. All rights reserved.
//

#import "OMGAppDelegate.h"
#import "GalleryViewController.h"


@implementation OMGAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

+(void)initialize {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"defaults" ofType:@"plist"];
    NSDictionary *defaultsDict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultsDict];    
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    navigationController.view.backgroundColor = [UIColor colorWithRed:0.17 green:0.18 blue:0.20 alpha:1.0];
	[window addSubview:[navigationController view]];
	[window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

