//
//  GalleryViewCell.h
//  OMG Photo Gallery
//
//  Created by Brendan S. Murphy on 5/24/11.
//  Copyright 2011 Yahoo! Inc. All rights reserved.
//


#import <UIKit/UIKit.h>
@class ThumbImageView;

@interface GalleryViewCell : UITableViewCell {
	
	UILabel *titleLabel;
	UILabel *descriptionLabel;
	UIImageView *chevron;
    UIImageView *check;
    UIImageView *div;
    ThumbImageView *thumbView;

}

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *descriptionLabel;
@property (nonatomic, retain) UIImageView *chevron;
@property (nonatomic, retain) UIImageView *check;
@property(nonatomic,retain) ThumbImageView *thumbView;

- (void)setCellWithTitle: (NSString *)titleStr andDesc: (NSString*)descStr andImgURL: (NSURL*)imgURL andNumPhotos: (NSString*) numPhotosStr;
- (UILabel *)newLabel:(UIColor *)color selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold numLines:(int)numLines;


@end



