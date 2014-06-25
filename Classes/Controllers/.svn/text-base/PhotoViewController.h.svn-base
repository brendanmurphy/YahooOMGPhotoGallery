//
//  PhotoViewController.h
//  OMG Photo Gallery
//
//  Created by Brendan S. Murphy on 5/24/11.
//  Copyright 2011 Yahoo! Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageLoader.h"
#import "StoredBarStyles.h"
#import <MessageUI/MessageUI.h>

@class PhotoImageView, PhotoViewSource, Photo, PhotoCaptionView;

@interface PhotoViewController : UIViewController <UIScrollViewDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate> {
@private
	PhotoViewSource *_photoSource;
	NSMutableArray *_photoViews;
	PhotoCaptionView *_captionView;
	UIScrollView *_scrollView;	
	NSTimer *timer;	
	NSInteger pageIndex;
	BOOL rotating;
	UIBarButtonItem *leftButton;
	UIBarButtonItem *rightButton;
    UIBarButtonItem *playButton;
	UIBarButtonItem *actionButton;
	StoredBarStyles *storedStyles;
    NSTimer *slideshowTimer;
}

- (id)initWithPhotoSource:(PhotoViewSource*)aSource;	//	multiple photos
- (id)initWithImageURL:(NSURL*)aURL;	//	single photo view
- (void)setStatusBarHidden:(BOOL)isHidden withAnimation:(BOOL)withAnimation;
- (void)moveToPhotoAtIndex:(NSInteger)index animated:(BOOL)animated;
- (void)showCaptionView:(BOOL)showBool;
- (void)startSlideshow;
- (void)stopSlideshow;
- (void)updateSlideshow:(NSTimer*)timer;
- (void)playButtonTapped:(id)sender;

@property(nonatomic,readonly) PhotoViewSource *photoSource;
@property(nonatomic,retain) NSMutableArray *photoViews;
@property(nonatomic,retain) PhotoCaptionView *captionView;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic, retain) StoredBarStyles *storedStyles;

@end