//
//  PhotoScrollView.m
//  OMG Photo Gallery
//
//  Created by Brendan S. Murphy on 5/24/11.
//  Copyright 2011 Yahoo! Inc. All rights reserved.
//

#import "PhotoScrollView.h"
#import "PhotoImageView.h"

@implementation PhotoScrollView

@synthesize storedMaxZoomScale;

- (id)initWithFrame:(CGRect)frame {
		if (self == [super initWithFrame:frame]) {
				// Initialization code
		
		self.backgroundColor = [UIColor redColor];
		self.scrollEnabled = YES;
		self.pagingEnabled = NO;
		self.clipsToBounds = NO;
		self.maximumZoomScale = 1.0f;  // Will be set from PhotoImageView.
		self.minimumZoomScale = 1.0f;
		self.showsVerticalScrollIndicator = NO;
		self.showsHorizontalScrollIndicator = NO;
		self.alwaysBounceVertical = NO;
		self.alwaysBounceHorizontal = NO;
		self.bouncesZoom = YES;
		self.bounces = YES;
		self.scrollsToTop = NO;
		self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
		self.decelerationRate = UIScrollViewDecelerationRateFast;
		
		}
		return self;
}

- (void)zoomRectWithCenter:(CGPoint)center{

	if (self.zoomScale > 1.0f) {
		//	zoom out
		[((PhotoImageView*)self.superview) killScrollViewZoom];
	} else {
		
		CGFloat zoomToScale = 1.85;
		CGFloat rectSide = MIN(self.contentSize.width, self.contentSize.height) / zoomToScale;
		
		//	zoom in
		CGFloat xCoor = center.x - rectSide / 2.0;
		CGFloat yCoor = center.y - rectSide / 2.0;
		
		if (xCoor < 0.0f) xCoor = 0.0f;
		if (yCoor < 0.0f) yCoor = 0.0f;
					
		[self zoomToRect:CGRectMake(xCoor, yCoor, rectSide, rectSide) animated:YES];
		
	}
    
}

- (void)toggleBars{
	[[NSNotificationCenter defaultCenter] postNotificationName:@"EGOPhotoViewToggleBars" object:nil];
}

#pragma mark -
#pragma mark Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	[super touchesEnded:touches withEvent:event];
	UITouch *touch = [touches anyObject];
	
	if (touch.tapCount == 1) {
		[self performSelector:@selector(toggleBars) withObject:nil afterDelay:.2];
	} else if (touch.tapCount == 2) {
		[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(toggleBars) object:nil];
		[self zoomRectWithCenter:[[touches anyObject] locationInView:self]];
	}
    [[NSNotificationCenter defaultCenter] postNotificationName:@"stopSlideShow" object:nil];
}

#pragma mark -
#pragma mark Disable/enabling zooming

- (void)disableZooming {
	if (!storedMaxZoomScale) {  // Guard against setting to 1.0 if we disable twice.
		self.storedMaxZoomScale = self.maximumZoomScale;
	}
	self.maximumZoomScale = 1.0;
}

- (void)enableZooming {
	if (storedMaxZoomScale) {
		self.maximumZoomScale = self.storedMaxZoomScale;
	}
}

#pragma mark -
#pragma mark Dealloc

- (void)dealloc {
		[super dealloc];
}


@end
