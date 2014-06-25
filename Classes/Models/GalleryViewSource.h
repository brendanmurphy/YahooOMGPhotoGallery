//
//  GalleryViewSource.h
//  OMG Photo Gallery
//
//  Created by Brendan S. Murphy on 5/24/11.
//  Copyright 2011 Yahoo! Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GalleryViewSource;

@protocol GallerySourceProtocol <NSObject>
@required
- (void) galleryViewSourceReady:(GalleryViewSource *)paramSender;
@end

@interface GalleryViewSource : NSObject {
    @public
    id<GallerySourceProtocol> _modelOwner;
    @private
    NSMutableArray *titleArray;
    NSMutableArray *descArray;
    NSMutableArray *numPhotosArray;
    NSMutableArray *galleryQueryArray;
    NSMutableArray *thumbURLArray;
    NSMutableArray *galleryIdArray;
    NSMutableArray *galleriesIdArray;
    NSOperationQueue *operationQueue;
    NSString *galleriesIdString;
    int galleriesStartIndex;
    int galleriesCount;
    int galleryStartIndex;
    int galleryEndIndex;
    int pageCnt;
    
    int start;
    int count;
    int total;
   
}

@property (nonatomic, retain) id<GallerySourceProtocol> modelOwner;
@property (nonatomic, retain) NSMutableArray *titleArray;
@property (nonatomic, retain) NSMutableArray *descArray;
@property (nonatomic, retain) NSMutableArray *numPhotosArray;
@property (nonatomic, retain) NSMutableArray *galleryQueryArray;
@property (nonatomic, retain) NSMutableArray *thumbURLArray;
@property (nonatomic, retain) NSMutableArray *galleryIdArray;
@property (nonatomic, retain) NSMutableArray *galleriesIdArray;

@property (nonatomic, assign) int galleriesStartIndex;
@property (nonatomic, assign) int galleriesCount;
@property (nonatomic, assign) int galleryStartIndex;
@property (nonatomic, assign) int galleryEndIndex;
@property (nonatomic, retain) NSString *galleriesIdString;

@property (nonatomic, assign) int start;
@property (nonatomic, assign) int count;
@property (nonatomic, assign) int total;
@property (nonatomic, assign) int pageCnt;
    
+ (GalleryViewSource*)sharedTableViewModel;
- (id) initWithModelOwner: (id <GallerySourceProtocol>) modelOwner;
- (void)initLoadJSON;
- (void)loadJSON;
- (void)didFinishLoadJSON:(NSDictionary *)results;
- (NSURL*)getGalleriesQueryWithId:(NSString*)galleriesID andStart:(int)start andCount:(int)end;
- (NSURL*)getGalleryQueryWithId:(NSString*)galleryID andStart:(int)start andCount:(int)end;
- (NSURL*)getGalleriesQueryWithStart:(int)strt andCount:(int)end;
- (void)initLoadNextPage;


@end
