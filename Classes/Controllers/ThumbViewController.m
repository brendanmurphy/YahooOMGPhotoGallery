//
//  ThumbViewController.m
//  OMG Photo Gallery
//
//  Created by Brendan S. Murphy on 5/24/11.
//  Copyright 2011 Yahoo! Inc. All rights reserved.
//

#import "ThumbViewController.h"
#import "PhotoViewController.h"
#import "ThumbViewSource.h"
#import "Photo.h"

@implementation ThumbViewController

@synthesize photoSource=_photoSource, storedStyles;
@synthesize galleryURL;
@synthesize titleStr;
@synthesize descStr;
@synthesize counStr;
@synthesize model = _model;
@synthesize numImages = numImages;
@synthesize galleryId;


- (id)initWithGalleryURL:(NSURL*)targetURL andTitle:(NSString *)title andDescription:(NSString *)desc andCount:(NSString *)count andId:(NSString *)id;
{	
	
	if(self == [super init]){

        self.wantsFullScreenLayout = YES;

		self.galleryURL = targetURL;
		self.titleStr = title;
		self.descStr = desc;
		self.counStr = count;
        self.numImages = count.intValue;
        self.galleryId = id;
        
        NSLog(@"galleryURL: %@", galleryURL);
        
        // load thumbView data - call 'thumbViewModelReady' when loaded
        self.model = [ThumbViewSource sharedThumbViewModel];
        [self.model initWithModelOwner: self andGalleryURL: self.galleryURL andGalleryId: self.galleryId];
        [self.model initLoadJSON];
        
	}
	
	return self;
	
}


- (void) thumbViewModelReady:(ThumbViewSource *)paramSender {

    self.counStr = [NSString stringWithFormat:@"%d", self.model.numImages];
    
    NSMutableArray *photoArray = [[[NSMutableArray alloc]init]autorelease];
    
    int numItems = [self.model.thumbURLArray count];
    for (int i = 0; i < numItems; i++) {
        
        NSURL *thumbURL = [self.model.thumbURLArray objectAtIndex:i];
        NSURL *imageURL = [self.model.imgURLArray objectAtIndex:i];
        NSString *headline = [self.model.headlineArray objectAtIndex:i];
        NSString *caption = [self.model.captionArray objectAtIndex:i];
        Photo *photo = [[[Photo alloc] initWithImageURL:imageURL andThumbURL:thumbURL andHeadline:headline andCaption:caption]autorelease];
        [photoArray addObject:photo];
        
    }
    
    PhotoViewSource *source = [[[PhotoViewSource alloc] initWithEGOPhotos:photoArray]autorelease];    
    _photoSource = [source retain];
    _scrollView.photoSource = _photoSource;
    
    [_scrollView setNeedsLayout];   
    
    [self.navigationController setToolbarHidden:NO animated:YES];
    
}


- (void)loadView {    
    _scrollView = [[ThumbsScrollView alloc] initWithFrame:CGRectZero andTitle:self.titleStr andDesc:self.descStr andCount:self.counStr ];
	_scrollView.photoSource = _photoSource;
	_scrollView.controller = self;
	self.view = _scrollView;
}


- (NSArray*)photoToolbarItems{
    playButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"play2.png"] style:UIBarButtonItemStylePlain target:self action:@selector(playButtonTapped:)] autorelease];
	UIBarButtonItem *flexableSpace = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
	return [NSArray arrayWithObjects:flexableSpace, playButton, flexableSpace, nil];
}


- (void)viewDidLoad {
    [self setToolbarItems:[self photoToolbarItems]];
    self.navigationController.toolbar.tintColor = nil;
	self.navigationController.toolbar.barStyle = UIBarStyleBlack;
	self.navigationController.toolbar.translucent = YES;
}


- (void)playButtonTapped:(id)sender{
    [self didSelectThumbAtIndex:0 startSlideshow:YES];
}


- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
    
    [self.navigationController setToolbarHidden:YES animated:NO];
	
	if (!self.storedStyles) {
		self.storedStyles = [StoredBarStyles storeFromController:self];
	}

    // customize styles
	self.navigationItem.titleView = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"titleLogo.png"]]autorelease];
	self.title = NSLocalizedString(@"Gallery", @"WHAT: Gallery button title  WHERE: ThumbViewController.m");
	self.view.backgroundColor = [UIColor colorWithRed:0.17 green:0.18 blue:0.20 alpha:1.0];
    
    if(_scrollView.photoSource){
        [self.navigationController setToolbarHidden:NO animated:YES];
    }

}


- (void)viewWillDisappear:(BOOL)animated{
	if (self.storedStyles) [self.storedStyles restoreToController:self withAnimation:animated];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
	[super didReceiveMemoryWarning];		
	// Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
	[super viewDidUnload];
	[_scrollView release], _scrollView = nil;
}


- (void)didSelectThumbAtIndex:(NSInteger)index startSlideshow:(BOOL)startSlideshow {
	PhotoViewController *photoController = [[PhotoViewController alloc] initWithPhotoSource:self.photoSource];
	[self.navigationController pushViewController:photoController animated:YES];
	[photoController moveToPhotoAtIndex:index animated:NO];
    if(startSlideshow)[photoController playButtonTapped:nil];
	[photoController release];
}


- (void)dealloc {
    [self.model release];
	[_photoSource release], _photoSource = nil;
	[_scrollView release], _scrollView = nil;
	self.storedStyles = nil;
	[super dealloc];
}


@end
