//
//  ThumbImageView.m
//  OMG Photo Gallery
//
//  Created by Brendan S. Murphy on 5/24/11.
//  Copyright 2011 Yahoo! Inc. All rights reserved.
//

#import "ThumbImageView.h"
#import <QuartzCore/QuartzCore.h>

#define kThumbBorderColor [UIColor colorWithWhite:0.55 alpha:1.0]
#define kPhotoErrorPlaceholder [UIImage imageNamed:@"error_placeholder.png"]
#define kPhotoLoadingPlaceholder [UIImage imageNamed:@"GrayRect.png"]

@implementation ThumbImageView

@synthesize controller, photo, imageView;

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		
		UIImageView *newImageView = [[UIImageView alloc] initWithFrame:self.bounds];
		newImageView.contentMode = UIViewContentModeScaleAspectFill;
		newImageView.clipsToBounds = YES;	 
		self.imageView = newImageView;
		[self addSubview:newImageView];
		[newImageView release];
		
		activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
		activityView.userInteractionEnabled = NO;  // Spinner passes on tap events to image.
		[self addSubview:activityView];
		CGFloat activityLeft = (self.frame.size.width - activityView.frame.size.width) / 2;
		CGFloat activityTop = (self.frame.size.height - activityView.frame.size.height) / 2;
		activityView.frame = CGRectMake(activityLeft, activityTop, activityView.frame.size.width, activityView.frame.size.height);
		
		[self addTarget:self action:@selector(didTouch:) forControlEvents:UIControlEventTouchUpInside];
	}
	return self;
}


- (void)setPhoto:(Photo*)aPhoto{	
	if (aPhoto == nil) return;
	
	[photo release], photo = nil;
	photo = [aPhoto retain];
	
	self.imageView.image = [[EGOImageLoader sharedImageLoader] imageForURL:photo.thumbURL shouldLoadWithObserver:self];
	
	if (self.imageView.image != nil) {	// Loaded from cache.
		[activityView stopAnimating];
	} else {
		//[activityView startAnimating];
		self.imageView.image = kPhotoLoadingPlaceholder;
	}
}

- (void)addBorder{
	self.layer.borderColor = kThumbBorderColor.CGColor;
	self.layer.borderWidth = 1;
}

#pragma mark -
#pragma mark Button

- (void)didTouch:(id)sender {
	if (self.controller) {
		[self.controller didSelectThumbAtIndex:([self tag]-kThumbTagOffset) startSlideshow:NO];
	}	
}

- (void) setHighlighted: (BOOL) highlighted {
    [super setHighlighted: highlighted];
    self.alpha = highlighted ? 0.4f : 1.0f;
}

#pragma mark -
#pragma mark EGOImageLoader Callbacks

- (void)imageLoaderDidLoad:(NSNotification*)notification {
	if ([notification userInfo] == nil) return;
	if(![[[notification userInfo] objectForKey:@"imageURL"] isEqual:self.photo.thumbURL]) return;
	self.imageView.image = [[notification userInfo] objectForKey:@"image"];
	[activityView stopAnimating];
}

- (void)imageLoaderDidFailToLoad:(NSNotification*)notification {
	if ([notification userInfo] == nil) return;
	if(![[[notification userInfo] objectForKey:@"imageURL"] isEqual:self.photo.thumbURL]) return;
	self.imageView.image = kPhotoErrorPlaceholder;
	[activityView stopAnimating];
}

#pragma mark -
#pragma mark Dealloc

- (void)dealloc {
	[[EGOImageLoader sharedImageLoader] removeObserver:self];
	[[EGOImageLoader sharedImageLoader] cancelLoadForURL:self.photo.thumbURL];	
	self.controller = nil;
	self.imageView = nil;    
	[activityView release], activityView = nil;
	[super dealloc];
}


@end
