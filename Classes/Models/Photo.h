//
//  Photo.h
//  OMG Photo Gallery
//
//  Created by Brendan S. Murphy on 5/24/11.
//  Copyright 2011 Yahoo! Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Photo : NSObject {
	
	NSURL *_imageURL;
	NSURL *_thumbURL;
	UIImage *_image;
	UIImage *_thumb;
	NSString *_headline;
    NSString *_caption;
	
}

- (id)initWithImageURL:(NSURL*)aURL andThumbURL:(NSURL*)thumbURL andHeadline:(NSString*)headline andCaption:(NSString*)caption;
- (id)initWithImageURL:(NSURL*)URL andHeadline:(NSString*)headline;
- (id)initWithImageURL:(NSURL*)URL andThumbURL:(NSURL*)thumbURL;
- (id)initWithImageURL:(NSURL*)aURL;

@property(nonatomic,retain) NSURL *imageURL;
@property(nonatomic,retain) NSURL *thumbURL;
@property(nonatomic,retain) UIImage *image;
@property(nonatomic,retain) UIImage *thumb;
@property(nonatomic,retain) NSString *headline;
@property(nonatomic,retain) NSString *caption;

@end
