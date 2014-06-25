//
//  PhotoImageView.h
//  OMG Photo Gallery
//
//  Created by Brendan S. Murphy on 5/24/11.
//  Copyright 2011 Yahoo! Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageLoader.h"

@class Photo, PhotoScrollView, PhotoCaptionView;

@interface PhotoImageView : UIView <EGOImageLoaderObserver, UIScrollViewDelegate>{
@private
	PhotoScrollView *_scrollView;
	Photo *photo;
	UIImageView *_imageView;
	UIActivityIndicatorView *activityView;	
}

@property(nonatomic,retain) Photo *photo;
@property(nonatomic,retain) UIImageView *imageView;
@property(nonatomic,retain) PhotoScrollView *scrollView;

- (void)setPhoto:(Photo*)aPhoto;
- (void)killScrollViewZoom;
- (void)layoutScrollViewAnimated:(BOOL)animated;
- (void)prepareForReuse;
- (void)rotateToOrientation:(UIInterfaceOrientation)orientation;

@end
