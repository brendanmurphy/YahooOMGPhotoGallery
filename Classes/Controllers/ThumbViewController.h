//
//  ThumbViewController.h
//  OMG Photo Gallery
//
//  Created by Brendan S. Murphy on 5/24/11.
//  Copyright 2011 Yahoo! Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoViewSource.h"
#import "ThumbsScrollView.h"
#import "StoredBarStyles.h"
#import "ThumbViewSource.h"

@interface ThumbViewController : UIViewController <ThumbViewSourceProtocol> {
	PhotoViewSource *_photoSource;
	ThumbsScrollView *_scrollView;
	StoredBarStyles *storedStyles;
    ThumbViewSource *_model;    
    NSURL *galleryURL;
	NSString *titleStr;
	NSString *descStr;
	NSString *counStr;
    NSInteger numImages;
    NSString *galleryId;
    UIBarButtonItem *playButton;
}

- (id)initWithGalleryURL:(NSURL*)targetURL andTitle:(NSString *)title andDescription:(NSString *)desc andCount:(NSString *)count andId:(NSString *)id;
- (void)didSelectThumbAtIndex:(NSInteger)index startSlideshow:(BOOL)startSlideshow;

@property(nonatomic,readonly) PhotoViewSource *photoSource;
@property(nonatomic, retain) StoredBarStyles *storedStyles;
@property (nonatomic, retain) NSURL *galleryURL;
@property (nonatomic, retain) NSString *titleStr;
@property (nonatomic, retain) NSString *descStr;
@property (nonatomic, retain) NSString *counStr;
@property (nonatomic, retain) ThumbViewSource *model;
@property (nonatomic, assign) NSInteger numImages;
@property (nonatomic, retain)  NSString *galleryId;

- (void) thumbViewModelReady:(ThumbViewSource *)paramSender;
//- (CGFloat)createHeader;
//- (UILabel *)newLabel:(CGRect)frame  color:(UIColor *)color selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold numLines:(int)numLines;

@end
