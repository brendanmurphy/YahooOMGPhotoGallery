//
//  PhotoImageView.m
//  OMG Photo Gallery
//
//  Created by Brendan S. Murphy on 5/24/11.
//  Copyright 2011 Yahoo! Inc. All rights reserved.
//

#import "PhotoImageView.h"
#import "Photo.h"
#import "PhotoScrollView.h"
#import "PhotoCaptionView.h"

#import <QuartzCore/QuartzCore.h>

#define kPhotoErrorPlaceholder [UIImage imageNamed:@"error_placeholder.png"]
#define kPhotoLoadingPlaceholder [UIImage imageNamed:@"photo_placeholder.png"]

#define ZOOM_VIEW_TAG 101

@interface PhotoImageView (Private)

- (void)layoutScrollViewAnimated:(BOOL)animated;

@end


@implementation PhotoImageView 

@synthesize photo, imageView=_imageView, scrollView=_scrollView;;

- (id)initWithFrame:(CGRect)frame {
		if (self == [super initWithFrame:frame]) {
				
		self.userInteractionEnabled = YES;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		
		_scrollView = [[PhotoScrollView alloc] initWithFrame:self.bounds];
		_scrollView.delegate = self;
		[self addSubview:_scrollView];
		
		_imageView = [[UIImageView alloc] initWithFrame:self.bounds];
		_imageView.contentMode = UIViewContentModeScaleAspectFit;
		_imageView.tag = ZOOM_VIEW_TAG;
		[_scrollView addSubview:_imageView];

		activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		activityView.userInteractionEnabled = NO;  // Spinner passes on tap events to image.
		[self addSubview:activityView];
		[activityView release];	
           
	}
		return self;
}

- (void)rotateToOrientation:(UIInterfaceOrientation)orientation{

	if (self.scrollView.zoomScale > 1.0f) {
		
		CGFloat height, width;
		height = MIN(CGRectGetHeight(self.imageView.frame) + self.imageView.frame.origin.x, CGRectGetHeight(self.bounds));
		width = MIN(CGRectGetWidth(self.imageView.frame) + self.imageView.frame.origin.y, CGRectGetWidth(self.bounds));
		self.scrollView.frame = CGRectMake((self.bounds.size.width / 2) - (width / 2), (self.bounds.size.height / 2) - (height / 2), width, height);
		
	} else {
		[self layoutScrollViewAnimated:NO];
	}
}


- (CABasicAnimation*)fadeAnimation{
	
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
	animation.fromValue = [NSNumber numberWithFloat:0.0f];
	animation.toValue = [NSNumber numberWithFloat:1.0f];
	animation.duration = .3f;
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];

	return animation;
}

- (void)setPhoto:(Photo*)aPhoto{
	
	if (aPhoto == nil) return; 
	if ([aPhoto isEqual:self.photo]) return;

	if (self.photo != nil) {
		[[EGOImageLoader sharedImageLoader] cancelLoadForURL:self.photo.imageURL];
	}
	
	[photo release];
	photo = nil;
	photo = [aPhoto retain];
	
	self.imageView.image = [[EGOImageLoader sharedImageLoader] imageForURL:photo.imageURL shouldLoadWithObserver:self];
	
	if (self.imageView.image != nil) {
        
		[activityView stopAnimating];
		[self.scrollView enableZooming];
		
		[[NSNotificationCenter defaultCenter] postNotificationName:@"EGOPhotoDidFinishLoading" object:[NSDictionary dictionaryWithObjectsAndKeys:self.photo, @"photo", [NSNumber numberWithBool:NO], @"failed", nil]];
		
	} else {
        
		[activityView startAnimating];
		[self.scrollView disableZooming];
        
        if([[EGOImageLoader sharedImageLoader] hasLoadedImageURL:photo.thumbURL]){
            self.imageView.image = [[EGOImageLoader sharedImageLoader] imageForURL:photo.thumbURL shouldLoadWithObserver:self];
        } else {
            self.imageView.image = kPhotoLoadingPlaceholder;
        }
        
	}
	
	[self layoutScrollViewAnimated:NO];
}

- (void)prepareForReuse{
	
	//	reset view
	self.tag = -1;
	
}

- (void)setupImageViewWithImage:(UIImage*)theImage {	
	
	[activityView stopAnimating];
	self.imageView.image = theImage; 
	[self layoutScrollViewAnimated:NO];

	[[self layer] addAnimation:[self fadeAnimation] forKey:@"opacity"];
	
	[self.scrollView enableZooming];

}

- (void)layoutScrollViewAnimated:(BOOL)animated{

	if (animated) {
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.0001];
	}
	
	CGFloat hfactor = self.imageView.image.size.width / self.frame.size.width;
	CGFloat vfactor = self.imageView.image.size.height / self.frame.size.height;
	
	CGFloat factor = MAX(hfactor, vfactor);
	
	CGFloat maxZoomScale = MAX(factor, 2.0);  // Zooming less than 2.0 just looks weird.
	self.scrollView.maximumZoomScale = maxZoomScale;
    self.scrollView.storedMaxZoomScale = maxZoomScale;
	
	CGFloat newWidth = self.imageView.image.size.width / factor;
	CGFloat newHeight = self.imageView.image.size.height / factor;
	
	CGFloat leftOffset = (self.frame.size.width - newWidth) / 2;
	CGFloat topOffset = (self.frame.size.height - newHeight) / 2;
	
	self.scrollView.frame = CGRectMake(leftOffset, topOffset, newWidth, newHeight);
	self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
	self.scrollView.contentOffset = CGPointMake(0.0f, 0.0f);
	self.imageView.frame = self.scrollView.bounds;
    
    CGRect frame = activityView.frame;
    frame.origin.x = self.frame.size.width/2 - frame.size.width/2;
    frame.origin.y = self.frame.size.height/2 - frame.size.height/2;
    activityView.frame = frame;

	if (animated) {
		[UIView commitAnimations];
	}
}

#pragma mark -
#pragma mark EGOImageLoader Callbacks

- (void)imageLoaderDidLoad:(NSNotification*)notification {	
	
	if ([notification userInfo] == nil) return;
	if(![[[notification userInfo] objectForKey:@"imageURL"] isEqual:self.photo.imageURL]) return;
	
	[self setupImageViewWithImage:[[notification userInfo] objectForKey:@"image"]];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"EGOPhotoDidFinishLoading" object:[NSDictionary dictionaryWithObjectsAndKeys:self.photo, @"photo", [NSNumber numberWithBool:NO], @"failed", nil]];
	
}

- (void)imageLoaderDidFailToLoad:(NSNotification*)notification {
	
	if ([notification userInfo] == nil) return;
	if(![[[notification userInfo] objectForKey:@"imageURL"] isEqual:self.photo.imageURL]) return;
	
	self.imageView.image = kPhotoErrorPlaceholder;
	[self layoutScrollViewAnimated:NO];

	[self.scrollView disableZooming];
	[activityView stopAnimating];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"EGOPhotoDidFinishLoading" object:[NSDictionary dictionaryWithObjectsAndKeys:self.photo, @"photo", [NSNumber numberWithBool:YES], @"failed", nil]];
	
}

#pragma mark -
#pragma mark UIScrollView Delegate Methods


- (void)printOffset{
	NSLog(@"offset: %@", NSStringFromCGPoint(self.scrollView.contentOffset));
}

- (void)reallyKillZoom{
	
	[self.scrollView setZoomScale:1.0f animated:NO];
	self.imageView.frame = self.scrollView.bounds;
	[self layoutScrollViewAnimated:NO];

}

- (void)killScrollViewZoom{
	
	if (!self.scrollView.zoomScale > 1.0f) return;

	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	[UIView setAnimationDidStopSelector:@selector(reallyKillZoom)];
	[UIView setAnimationDelegate:self];

	CGFloat hfactor = self.imageView.image.size.width / self.frame.size.width;
	CGFloat vfactor = self.imageView.image.size.height / self.frame.size.height;
	
	CGFloat factor = MAX(hfactor, vfactor);
		
	CGFloat newWidth = self.imageView.image.size.width / factor;
	CGFloat newHeight = self.imageView.image.size.height / factor;
		
	CGFloat leftOffset = (self.frame.size.width - newWidth) / 2;
	CGFloat topOffset = (self.frame.size.height - newHeight) / 2;

	self.scrollView.frame = CGRectMake(leftOffset, topOffset, newWidth, newHeight);
	self.imageView.frame = self.scrollView.bounds;
	[UIView commitAnimations];

}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
	return [self.scrollView viewWithTag:ZOOM_VIEW_TAG];
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"stopSlideShow" object:nil];
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale{
			
	if (scrollView.zoomScale > 1.0f) {		
		CGFloat height, width; //, originX, originY;
		//height = MIN(CGRectGetHeight(self.imageView.frame) + self.imageView.frame.origin.x, CGRectGetHeight(self.bounds));
		//width = MIN(CGRectGetWidth(self.imageView.frame) + self.imageView.frame.origin.y, CGRectGetWidth(self.bounds));

		
		if (CGRectGetMaxX(self.imageView.frame) > self.bounds.size.width) {
			width = CGRectGetWidth(self.bounds);
			//originX = 0.0f;
		} else {
			width = CGRectGetMaxX(self.imageView.frame);
			
			if (self.imageView.frame.origin.x < 0.0f) {
				//originX = 0.0f;
			} else {
				//originX = self.imageView.frame.origin.x;
			}	
		}
		
		if (CGRectGetMaxY(self.imageView.frame) > self.bounds.size.height) {
			height = CGRectGetHeight(self.bounds);
			//originY = 0.0f;
		} else {
			height = CGRectGetMaxY(self.imageView.frame);
			
			if (self.imageView.frame.origin.y < 0.0f) {
				//originY = 0.0f;
			} else {
				//originY = self.imageView.frame.origin.y;
			}
		}

		CGRect frame = self.scrollView.frame;
		self.scrollView.frame = CGRectMake((self.bounds.size.width / 2) - (width / 2), (self.bounds.size.height / 2) - (height / 2), width, height);
		if (!CGRectEqualToRect(frame, self.scrollView.frame)) {		
			
			CGFloat offsetY, offsetX;

			if (frame.origin.y < self.scrollView.frame.origin.y) {
				offsetY = self.scrollView.contentOffset.y - (self.scrollView.frame.origin.y - frame.origin.y);
			} else {				
				offsetY = self.scrollView.contentOffset.y - (frame.origin.y - self.scrollView.frame.origin.y);
			}
			
			if (frame.origin.x < self.scrollView.frame.origin.x) {
				offsetX = self.scrollView.contentOffset.x - (self.scrollView.frame.origin.x - frame.origin.x);
			} else {				
				offsetX = self.scrollView.contentOffset.x - (frame.origin.x - self.scrollView.frame.origin.x);
			}

			if (offsetY < 0) offsetY = 0;
			if (offsetX < 0) offsetX = 0;
			
			self.scrollView.contentOffset = CGPointMake(offsetX, offsetY);
		}

	} else {
		[self layoutScrollViewAnimated:YES];
	}
}


#pragma mark -
#pragma mark Dealloc

- (void)dealloc {
	
	//NSLog(@"dealloc EGOPhotoImageView");
	
	[[EGOImageLoader sharedImageLoader] removeObserver:self];
	[[EGOImageLoader sharedImageLoader] cancelLoadForURL:self.photo.imageURL];
	
	[_imageView release]; _imageView=nil;
	[_scrollView release]; _scrollView=nil;
	[photo release]; photo=nil;
		[super dealloc];
	
}


@end
