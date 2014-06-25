//
//  PhotoCaptionView1.h
//  OMG Photo Gallery
//
//  Created by Brendan S. Murphy on 5/24/11.
//  Copyright 2011 Yahoo! Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PhotoCaptionView : UIView {
    NSString *_headlineStr;
	NSString *_captionStr;
	UILabel *headlineLabel;
	UILabel *captionLabel;
	BOOL _ishidden;
}

@property (nonatomic, retain) NSString *headlineStr;
@property (nonatomic, retain) NSString *captionStr;
@property (nonatomic, assign) BOOL ishidden;


-(void) showWithHeadline:(NSString*)headlineStr andCaption:(NSString*)captionStr;
-(void) hide;
- (UILabel *)newLabel:(CGRect)frame  color:(UIColor *)color selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold numLines:(int)numLines;
-(void) hideNoAnim;


@end
