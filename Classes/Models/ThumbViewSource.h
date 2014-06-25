//
//  ThumbViewSource.h
//  OMG Photo Gallery
//
//  Created by Brendan S. Murphy on 5/24/11.
//  Copyright 2011 Yahoo! Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ThumbViewSource;

@protocol ThumbViewSourceProtocol <NSObject>
@required
- (void) thumbViewModelReady:(ThumbViewSource *)paramSender;
@end

@interface ThumbViewSource : NSObject {
    @public
    id<ThumbViewSourceProtocol> _modelOwner;
    @private
    NSURL *_galleryURL;
    NSMutableArray *_thumbURLArray;
    NSMutableArray *_imgURLArray;
    NSMutableArray *_captionArray;
    NSMutableArray *_headlineArray;
    NSOperationQueue *operationQueue;
    NSInteger _numImages;
    NSString *_galleryId;
}

@property (nonatomic, retain) id<ThumbViewSourceProtocol> modelOwner;
@property (nonatomic, retain) NSURL *galleryURL;
@property (nonatomic, retain) NSMutableArray *thumbURLArray;
@property (nonatomic, retain) NSMutableArray *imgURLArray;
@property (nonatomic, retain) NSMutableArray *captionArray;
@property (nonatomic, retain) NSMutableArray *headlineArray;
@property (nonatomic, assign) NSInteger numImages;
@property (nonatomic, retain) NSString *galleryId;
    
+ (ThumbViewSource*)sharedThumbViewModel;
- (id) initWithModelOwner: (id <ThumbViewSourceProtocol>) modelOwner  andGalleryURL: (NSURL*) galleryURL andGalleryId: (NSString*) galleryId;
- (void) initLoadJSON;
- (void) loadJSON;
- (void) didFinishLoadJSON:(NSDictionary *)results;

@end
