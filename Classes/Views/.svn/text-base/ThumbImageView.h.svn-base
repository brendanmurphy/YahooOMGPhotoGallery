//
//  ThumbImageView.h
//  OMG Photo Gallery
//
//  Created by Brendan S. Murphy on 5/24/11.
//  Copyright 2011 Yahoo! Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"
#import "EGOImageLoader.h"
#import "ThumbViewController.h"

#define kThumbTagOffset 1000	// We need this since tag 0 is otherwise shared between thumb 0 and its superview

@interface ThumbImageView : UIControl <EGOImageLoaderObserver> {
	Photo *photo;
	UIImageView *imageView;
	UIActivityIndicatorView *activityView;
	ThumbViewController *controller;
}

- (void)setPhoto:(Photo*)aPhoto;
- (void)addBorder;

@property(nonatomic,retain) Photo *photo;
@property(nonatomic,retain) UIImageView *imageView;
@property(nonatomic,assign) ThumbViewController *controller;

@end
