//
//  GalleryViewController.h
//  OMG Photo Gallery
//
//  Created by Brendan S. Murphy on 5/24/11.
//  Copyright 2011 Yahoo! Inc. All rights reserved.
//

#import "GalleryViewSource.h"

@interface GalleryViewController : UITableViewController <GallerySourceProtocol> {
    GalleryViewSource *_model;
    UIActivityIndicatorView *spinner;
    BOOL shouldAutoRotate;
    
    UIView *aboutView;	
    UIBarButtonItem *doneButton;
	UIBarButtonItem *aboutButton;
    
}
@property (nonatomic, retain) GalleryViewSource *model;
@property (nonatomic, retain) IBOutlet UIView *aboutView;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, retain) UIBarButtonItem *flipButton;


- (void)showLoadingView;
- (void)hideLoadingView;
- (void)hideLoadingViewDone:(NSString*)animationID finished:(NSNumber*)finished context:(void*)context;
- (void)setNavBarColor:(NSString*)colorStr;
- (void) galleryViewSourceReady:(GalleryViewSource *)paramSender;

-(IBAction) mobileSiteBtnTapped;
-(IBAction) copyrightBtnTapped;
-(IBAction) privicyBtnTapped;
-(IBAction) termsOfServiceBtnTapped;
-(IBAction) helpBtnTapped;


@end
