//
//  PhotoScrollView.h
//  OMG Photo Gallery
//
//  Created by Brendan S. Murphy on 5/24/11.
//  Copyright 2011 Yahoo! Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PhotoScrollView : UIScrollView {
	CGFloat storedMaxZoomScale;
}
@property (nonatomic, assign) CGFloat storedMaxZoomScale;

- (void)disableZooming;
- (void)enableZooming;

@end
