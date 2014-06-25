//
//  PhotoViewSource.h
//  OMG Photo Gallery
//
//  Created by Brendan S. Murphy on 5/24/11.
//  Copyright 2011 Yahoo! Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Photo;

@interface PhotoViewSource : NSObject {
@private
	NSArray *_photos;
}

@property(nonatomic,retain) NSArray *photos;

- (id)initWithEGOPhotos:(NSArray*)photos;
- (Photo*)photoAtIndex:(NSInteger)index;
- (NSInteger)count;

// Override these in a subclass to customize.

- (UIColor *)navigationBarTintColor;
- (UIColor *)backgroundColor;
- (UIColor *)thumbnailBackgroundColor;
- (NSInteger)thumbnailSize;
- (UIViewContentMode)thumbnailContentMode;
- (BOOL)thumbnailsHaveBorder;

@end
