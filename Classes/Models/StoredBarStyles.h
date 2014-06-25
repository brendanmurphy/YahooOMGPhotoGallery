//
//  OMGStoredBarStyles.h
//  OMG Photo Gallery
//
//  Created by Brendan S. Murphy on 5/24/11.
//  Copyright 2011 Yahoo! Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoredBarStyles : NSObject {
	UIStatusBarStyle statusBarStyle;
	UIBarStyle navBarStyle;
	BOOL navBarTranslucent;
	UIColor* navBarTintColor;	
	UIBarStyle toolBarStyle;
	BOOL toolBarTranslucent;
	UIColor* toolBarTintColor;	
	BOOL toolBarHidden;  
}

+ (id)storeFromController:(UIViewController *)controller;
- (void)restoreToController:(UIViewController *)controller withAnimation:(BOOL)isAnimated;

@property(nonatomic, assign) UIStatusBarStyle statusBarStyle;
@property(nonatomic, assign) UIBarStyle navBarStyle;
@property(nonatomic, assign) BOOL navBarTranslucent;
@property(nonatomic, retain) UIColor* navBarTintColor;	
@property(nonatomic, assign) UIBarStyle toolBarStyle;
@property(nonatomic, assign) BOOL toolBarTranslucent;
@property(nonatomic, retain) UIColor* toolBarTintColor;	
@property(nonatomic, assign) BOOL toolBarHidden;

@end
