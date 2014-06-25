//
//  GalleryViewSource.m
//  OMG Photo Gallery
//
//  Created by Brendan S. Murphy on 5/24/11.
//  Copyright 2011 Yahoo! Inc. All rights reserved.
//

#import "GalleryViewSource.h"
#import "EGOCache.h"
#import "JSONKit.h"

#define NUM_OPS 1
#define DATA_MULTIPLIER_VAL 1
#define NUM_GALLERIES_IN_PAGE 10

@implementation GalleryViewSource

@synthesize modelOwner = _modelOwner;
@synthesize titleArray;
@synthesize descArray;
@synthesize numPhotosArray;
@synthesize galleryQueryArray;
@synthesize thumbURLArray;
@synthesize galleryIdArray;
@synthesize galleriesIdArray;
@synthesize galleriesStartIndex;
@synthesize galleriesCount;
@synthesize galleryStartIndex;
@synthesize galleryEndIndex;
@synthesize galleriesIdString;
@synthesize start;
@synthesize count;
@synthesize total;
@synthesize pageCnt;

static GalleryViewSource* _sharedGallerySource = nil;

NSString *galleriesQueryPrefixKey = @"galleriesQueryPrefix";
NSString *galleriesQuerySuffixKey = @"galleriesQuerySuffix";
NSString *galleryQueryPrefixKey = @"galleryQueryPrefix";
NSString *galleryQuerySuffixKey = @"galleryQuerySuffix";


- (id) initWithModelOwner: (id <GallerySourceProtocol>) modelOwner {    
    if(self == [super init]){
        self.modelOwner = modelOwner;
        
        self.pageCnt = 0;
        
        // clear cache for debugging
        if([[NSUserDefaults standardUserDefaults] boolForKey:@"CLEAR_CACHE"]){
            NSLog(@">>> clearing cache! <<<");
            [[EGOCache currentCache] clearCache];
        }
        
        // init arrays
        titleArray = [[NSMutableArray alloc] init];
        descArray = [[NSMutableArray alloc] init];
        numPhotosArray = [[NSMutableArray alloc] init];
        galleryQueryArray = [[NSMutableArray alloc] init];
        thumbURLArray = [[NSMutableArray alloc] init];
        galleryIdArray = [[NSMutableArray alloc] init];
        
        // create operationQueue for loading JSON
        operationQueue = [[NSOperationQueue alloc] init];
        [operationQueue setMaxConcurrentOperationCount:NUM_OPS];
        
        // list of available galleries
        galleriesIdArray =  [[NSMutableArray alloc] initWithObjects:@"Latest Galleries", @"Top Story Galleries", nil];

    }
    return self;
}


- (void)initLoadNextPage {    
    
    if(!self.galleriesIdArray.count) self.galleriesIdArray = nil;
    
    if(self.galleriesIdArray) {

        NSString *galleryName = [self.galleriesIdArray objectAtIndex:0];    
        self.galleriesIdString = [@"UUID: " stringByAppendingString: galleryName];    
        NSString *totalKey = [@"total: " stringByAppendingString: galleryName];  
        self.galleriesStartIndex = 0;    
        self.galleriesCount = (int)[[NSUserDefaults standardUserDefaults] integerForKey: totalKey];
        [self.galleriesIdArray removeObjectAtIndex:0];
        
    } else {
        
        self.galleriesStartIndex = self.pageCnt*NUM_GALLERIES_IN_PAGE;         
        self.galleriesCount = NUM_GALLERIES_IN_PAGE;
        pageCnt++;
        
    }
    
    [self initLoadJSON];    
}


- (void)initLoadJSON
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: YES];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadJSON) object:nil];
    [operationQueue addOperation:operation];
    [operation release];
    
}


- (void)loadJSON
{

    // get galleries JSON and parse into Foundation objects

    NSURL *queryStr;
    
    if(self.galleriesIdArray) {
        queryStr = [self getGalleriesQueryWithId:self.galleriesIdString andStart:self.galleriesStartIndex andCount:self.galleriesCount];
    } else {
        queryStr = [self getGalleriesQueryWithStart:self.galleriesStartIndex andCount:self.galleriesCount];
    }

    NSLog(@"queryStr: %@", queryStr);
    
    NSData *jsonData = [NSData dataWithContentsOfURL:queryStr options:NSDataReadingMapped error:nil];
    NSDictionary *results = [jsonData objectFromJSONData];
    [self performSelectorOnMainThread:@selector(didFinishLoadJSON:) withObject:results waitUntilDone:NO];
    
}


- (void)didFinishLoadJSON:(NSDictionary *)results
{
    
    // use try - catch block here
    // need to handle case where count == 1 too
    
    // get query
    results = [results objectForKey:@"query"];
    
    // ignore empty data sets
    if ([[results objectForKey:@"count"] intValue] <= 0) return;

    // get meta data
    NSDictionary *metaResults = [results objectForKey:@"meta"];
    self.start = [[metaResults objectForKey:@"start"] intValue];
    self.count = [[metaResults objectForKey:@"count"] intValue];
    self.total = [[metaResults objectForKey:@"total"] intValue];
    
//    NSLog(@"self.start: %d", self.start);
//    NSLog(@"self.count: %d", self.count);
//    NSLog(@"self.total: %d", self.total);
    
    // get slideshows
    results = [[results objectForKey:@"results"] objectForKey:@"slideshows"];
    
    //NSLog(@"didFinishLoadJSON: %@", results);
    
    for (int i = 0; i<DATA_MULTIPLIER_VAL; i++) {
        
        // parse slideshows JSON
        for (NSDictionary *item in results) {
            
            // titleArray
            NSString *title = [item objectForKey:@"title"];
            [titleArray addObject:(title.length > 0 ? title : @"No Title")];
            
            // descArray
            NSString *desc =[item objectForKey:@"description"];
            [descArray addObject:(desc.length > 0 ? desc : @"No Description")];
            
            // thumbURLArray
            NSString *thumbUrl = [[[[item objectForKey:@"cover_photo"] objectForKey:@"imageInstances"] objectForKey:@"square"] objectForKey:@"url"];  
            [thumbURLArray addObject:(thumbUrl.length > 0 ? [NSURL URLWithString:thumbUrl] : [NSURL URLWithString:@""])];
            
            // numPhotosArray 
            
            // BUG: api currently only returning 10 max
            int numPhotos = [[item objectForKey:@"total_photos"] intValue];
            
            int maxPhotos = [[NSUserDefaults standardUserDefaults] integerForKey:@"maxNumImages"];
            
            // do this until bug fixed
            numPhotos = maxPhotos;//(numPhotos > maxPhotos) ? maxPhotos : numPhotos;
            
            [numPhotosArray addObject:[NSNumber numberWithInt:numPhotos]];
            
            // galleryQueryArray (construct YQL query string for each gallery)
            NSURL *queryUrl = [self getGalleryQueryWithId:[item objectForKey:@"id"] andStart:self.galleryStartIndex andCount:numPhotos];
            [galleryQueryArray addObject:queryUrl];

            // idArray 
            [galleryIdArray addObject:[item objectForKey:@"id"]];
            
        }
        
    }
    
    // tell my owner that model is ready
    [self.modelOwner galleryViewSourceReady:self];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: NO];
    
}


- (NSURL*)getGalleriesQueryWithStart:(int)strt andCount:(int)cnt {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *rangeStr = [NSString stringWithFormat:@"(%i,%i)",strt, cnt];
    NSString *queryStr = [prefs stringForKey:@"galleriesQuery_noListID"];
    queryStr = [queryStr stringByReplacingOccurrencesOfString:@"SLIDESHOWS_RANGE" withString:rangeStr];
    queryStr = [queryStr stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    return [NSURL URLWithString:queryStr];
}


- (NSURL*)getGalleriesQueryWithId:(NSString*)galleriesIdKeyStr andStart:(int)strt andCount:(int)cnt {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *rangeStr = [NSString stringWithFormat:@"(%i,%i)",strt, cnt];
    NSString *galleriesQueryPrefix = [prefs stringForKey:galleriesQueryPrefixKey];
    galleriesQueryPrefix = [galleriesQueryPrefix stringByReplacingOccurrencesOfString:@"SLIDESHOWS_RANGE" withString:rangeStr];
    NSString *galleriesQuerySuffix = [prefs stringForKey:galleriesQuerySuffixKey];
    NSString* queryStr = [galleriesQueryPrefix stringByAppendingString:[prefs stringForKey:galleriesIdKeyStr]];
    queryStr = [queryStr stringByAppendingString:galleriesQuerySuffix];
    queryStr = [queryStr stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]; 
    return [NSURL URLWithString:queryStr];
}


- (NSURL*)getGalleryQueryWithId:(NSString*)galleryID andStart:(int)strt andCount:(int)cnt {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *rangeStr = [NSString stringWithFormat:@"(%i,%i)",strt, cnt];
    NSString *galleryQueryPrefix = [prefs stringForKey:galleryQueryPrefixKey];
    galleryQueryPrefix = [galleryQueryPrefix stringByReplacingOccurrencesOfString:@"SLIDESHOW_RANGE" withString:rangeStr];
    NSString *galleryQuerySuffix = [prefs stringForKey:galleryQuerySuffixKey];
    NSString *queryStr =[galleryQueryPrefix stringByAppendingString:galleryID];
    queryStr = [queryStr stringByAppendingString:galleryQuerySuffix];
    queryStr = [queryStr stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];            
    return [NSURL URLWithString:queryStr];
}


+(GalleryViewSource*)sharedTableViewModel
{
	@synchronized([GalleryViewSource class])
	{
		if (!_sharedGallerySource)
			[[[self alloc] init]autorelease];
        
		return _sharedGallerySource;
	}
    
	return nil;
}


+(id)alloc
{
	@synchronized([GalleryViewSource class])
	{
		NSAssert(_sharedGallerySource == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedGallerySource = [super alloc];
		return _sharedGallerySource;
	}
    
	return nil;
}


- (void)dealloc
{
    [operationQueue release];
    [titleArray release];
    [descArray release];
    [numPhotosArray release];
    [galleryQueryArray release];
    [thumbURLArray release];
    [galleryIdArray release];
    [galleriesIdArray release];
    [super dealloc];
}


@end
