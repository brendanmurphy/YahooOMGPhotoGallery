//
//  PhotoViewSource.m
//  OMG Photo Gallery
//
//  Created by Brendan S. Murphy on 5/24/11.
//  Copyright 2011 Yahoo! Inc. All rights reserved.
//

#import "PhotoViewSource.h"
#import "EGOImageLoader.h"
#import "EGOCache.h"
#import "Photo.h"

@implementation PhotoViewSource

@synthesize photos=_photos;

- (id)initWithEGOPhotos:(NSArray*)thePhotos{
	if (self == [super init]) {
		_photos = [thePhotos retain];
	}
	return self;
}

- (Photo*)photoAtIndex:(NSInteger)index{
	return [self.photos objectAtIndex:index];
}

- (NSInteger)count{
	return [self.photos count];
}

- (NSString*)description{
	return [NSString stringWithFormat:@"%@, %i Photos", [super description], [self.photos count], nil];
}

- (void)dealloc{
	[_photos release], _photos=nil;
	[super dealloc];
}


#pragma mark -
#pragma mark Customization
// Subclass and override these to customize.

- (UIColor *)navigationBarTintColor {
	return nil;
}

- (UIColor *)backgroundColor{
	return [UIColor blackColor];
}

- (UIColor *)thumbnailBackgroundColor{
	return [UIColor whiteColor];
}

- (NSInteger)thumbnailSize{
	return 75;
}

- (UIViewContentMode)thumbnailContentMode{
	return UIViewContentModeScaleAspectFill;
}

- (BOOL)thumbnailsHaveBorder{
	return YES;
}


@end
