//
//  ThumbsScrollView.h
//  OMG Photo Gallery
//
//  Created by Brendan S. Murphy on 5/24/11.
//  Copyright 2011 Yahoo! Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoViewSource.h"
@class ThumbViewController;


@interface ThumbsScrollView : UIScrollView {
	PhotoViewSource *photoSource;
	ThumbViewController *controller;
	UIInterfaceOrientation laidOutForOrientation;
    int thumbInitY;
    NSString *titleStr;
	NSString *descStr;
	NSString *counStr;
    
    UILabel *titleLabel;
    UILabel *imageCountLabel;
    UILabel *imageCountLabel1;
    UILabel *descLabel;
    UIImageView *bgGradient;
    
    UIActivityIndicatorView *spinner;

}

@property(nonatomic, retain) PhotoViewSource *photoSource;
@property(nonatomic,assign) ThumbViewController *controller;
@property(nonatomic,assign) int thumbInitY;
@property(nonatomic, retain) NSString *titleStr;
@property(nonatomic, retain) NSString *descStr;
@property(nonatomic, retain) NSString *counStr;

@property(nonatomic,assign) UILabel *titleLabel;
@property(nonatomic, retain) UILabel *imageCountLabel;
@property(nonatomic, retain) UILabel *imageCountLabel1;
@property(nonatomic, retain) UILabel *descLabel;
@property(nonatomic, retain) UIImageView *bgGradient;

@property(nonatomic, retain) UIActivityIndicatorView *spinner;

- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)title andDesc:(NSString *)desc andCount:(NSString *)count;
- (void) createHeader;
- (UILabel *)newLabel:(UIColor *)color selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold numLines:(int)numLines;

@end
