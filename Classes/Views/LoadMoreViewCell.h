//
//  LoadMoreViewCell.h
//  OMG Photo Gallery
//
//  Created by Brendan S. Murphy on 5/24/11.
//  Copyright 2011 Yahoo! Inc. All rights reserved.
//


#import <UIKit/UIKit.h>
@class ThumbImageView;

@interface LoadMoreViewCell : UITableViewCell {
	
	UILabel *loadingLabel;
    UIActivityIndicatorView *spinner;
    BOOL inLoadingSate;
    UIImageView *div;

}

@property (nonatomic, retain) UILabel *loadingLabel;
@property(nonatomic,retain) UIActivityIndicatorView *spinner;
@property(nonatomic,assign) BOOL inLoadingSate;

- (UILabel *)newLabel:(UIColor *)color selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold numLines:(int)numLines;
- (void)setLoadingState:(BOOL)setBool;


@end



