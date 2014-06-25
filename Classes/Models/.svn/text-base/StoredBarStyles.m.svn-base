//
//  OMGStoredBarStyles.m
//  OMG Photo Gallery
//
//  Created by Brendan S. Murphy on 5/24/11.
//  Copyright 2011 Yahoo! Inc. All rights reserved.
//

#import "StoredBarStyles.h"

@implementation StoredBarStyles

@synthesize statusBarStyle,
						navBarStyle, navBarTranslucent, navBarTintColor,
						toolBarStyle, toolBarTranslucent, toolBarTintColor, toolBarHidden;

+ (id)storeFromController:(UIViewController *)controller {
	StoredBarStyles *storedStyles = [[[[self class] alloc] init] autorelease];
	
	storedStyles.statusBarStyle = [UIApplication sharedApplication].statusBarStyle;

	storedStyles.navBarTintColor = controller.navigationController.navigationBar.tintColor;
	storedStyles.navBarStyle = controller.navigationController.navigationBar.barStyle;
	storedStyles.navBarTranslucent = controller.navigationController.navigationBar.translucent;

	storedStyles.toolBarTintColor = controller.navigationController.toolbar.tintColor;
	storedStyles.toolBarStyle = controller.navigationController.toolbar.barStyle;
	storedStyles.toolBarTranslucent = controller.navigationController.toolbar.translucent;
	storedStyles.toolBarHidden = [controller.navigationController isToolbarHidden];
	
	return storedStyles;
}

- (void)restoreToController:(UIViewController *)controller withAnimation:(BOOL)isAnimated {
	controller.navigationController.navigationBar.barStyle = self.navBarStyle;
	controller.navigationController.navigationBar.tintColor = self.navBarTintColor;
	controller.navigationController.navigationBar.translucent = self.navBarTranslucent;
	
	if (!self.toolBarHidden) {
		controller.navigationController.toolbar.barStyle = self.navBarStyle;
		controller.navigationController.toolbar.tintColor = self.navBarTintColor;
		controller.navigationController.toolbar.translucent = self.navBarTranslucent;
	}
	
	if ([[UIApplication sharedApplication] respondsToSelector:@selector(setStatusBarHidden:withAnimation:)]) {
		[[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:isAnimated];
	} else {  // Deprecated in iOS 3.2+.
		id sharedApp = [UIApplication sharedApplication];  // Get around deprecation warnings.
		[sharedApp setStatusBarHidden:NO animated:isAnimated];
	}	
	
	[[UIApplication sharedApplication] setStatusBarStyle:self.statusBarStyle animated:isAnimated];
	
	[controller.navigationController setToolbarHidden:self.toolBarHidden animated:isAnimated];
}

- (void)dealloc {
	self.navBarTintColor = nil;
	self.toolBarTintColor = nil;
	[super dealloc];
}

@end
