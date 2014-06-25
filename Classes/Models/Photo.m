//
//  Photo.m
//  OMG Photo Gallery
//
//  Created by Brendan S. Murphy on 5/24/11.
//  Copyright 2011 Yahoo! Inc. All rights reserved.
//

#import "Photo.h"

@implementation Photo

@synthesize imageURL=_imageURL, thumbURL=_thumbURL, image=_image, thumb=_thumb, headline=_headline, caption=_caption;


- (id)initWithImageURL:(NSURL*)URL andThumbURL:(NSURL*)thumbURL andHeadline:(NSString*)headline andCaption:(NSString*)caption {
	if (self == [super init]) {
		_imageURL=[URL retain];
		_thumbURL=[thumbURL retain];
		_headline=[headline retain];
        _caption=[caption retain];
	}
	
	return self;
}

- (id)initWithImageURL:(NSURL*)URL andHeadline:(NSString*)headline{
	return [self initWithImageURL:URL andThumbURL:URL andHeadline:headline andCaption:nil];
}

- (id)initWithImageURL:(NSURL*)URL andThumbURL:(NSURL*)thumbURL{
	return [self initWithImageURL:URL andThumbURL:thumbURL andHeadline:nil andCaption:nil];
}

- (id)initWithImageURL:(NSURL*)aURL{
	return [self initWithImageURL:aURL andThumbURL:aURL andHeadline:nil andCaption:nil];
}


- (BOOL)isEqual:(id)object{
	if ([object isKindOfClass:[Photo class]]) {
		if (((Photo*)object).imageURL == self.imageURL) {
			return YES;
		}
	}
	
	return NO;
}

- (NSURL *)thumbURL {
	return _thumbURL ? _thumbURL : _imageURL;
}

- (NSString*)description{
	return [NSString stringWithFormat:@"%@ , %@", [super description], self.imageURL];
}

- (void)dealloc{
	[_imageURL release]; _imageURL=nil;
	[_thumbURL release]; _thumbURL=nil;
	[_image release]; _image=nil;
	[_thumb release]; _thumb=nil;
	[_headline release]; _headline=nil;
    [_caption release]; _caption=nil;
	
	[super dealloc];
}

@end
