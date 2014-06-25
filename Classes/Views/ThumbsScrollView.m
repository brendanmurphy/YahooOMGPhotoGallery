//
//  ThumbsScrollView.m
//  OMG Photo Gallery
//
//  Created by Brendan S. Murphy on 5/24/11.
//  Copyright 2011 Yahoo! Inc. All rights reserved.
//

#import "ThumbsScrollView.h"
#import "Photo.h"
#import "ThumbImageView.h"


#define HEADER_HORIZ_MARGIN 10
#define HEADER_VERT_MARGIN 5
#define TITLE_TOP 5
#define TITLE_WIDTH 300
#define TITLE_FONT_SIZE 16
#define COUNT_FONT_SIZE 14
#define COUNT1_FONT_SIZE 22
#define DESC_WIDTH 300
#define DESC_FONT_SIZE 13

@implementation ThumbsScrollView

#define kThumbMinimumSpace 3

@synthesize controller, photoSource, thumbInitY, titleStr, descStr, counStr, titleLabel, imageCountLabel, imageCountLabel1, descLabel, bgGradient, spinner;


- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)title andDesc:(NSString *)desc andCount:(NSString *)count{
	if ((self = [super initWithFrame:frame])) {
        
        spinner = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite]autorelease];
        [spinner startAnimating]; 
        [self addSubview:spinner];
        
        self.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        self.backgroundColor = [UIColor colorWithRed:0.17 green:0.18 blue:0.20 alpha:1.0];
        
		self.titleStr = title;
		self.descStr = desc;
		self.counStr = count;
        
        [self createHeader];
        
	}
	return self;    
}


- (void) createHeader {
    
	// titleLabel
	self.titleLabel = [self newLabel:[UIColor colorWithRed:0.93 green:0.08 blue:0.50 alpha:1.0] selectedColor:[UIColor whiteColor] fontSize:TITLE_FONT_SIZE bold:YES numLines:10];
	self.titleLabel.text = self.titleStr;
	
	// imageCountLabel
	NSString *imageCountStr = [NSString stringWithFormat:@"(%@ photos)", self.counStr];
	self.imageCountLabel = [self newLabel:[UIColor colorWithRed:0.63 green:0.64 blue:0.65 alpha:1.0] selectedColor:[UIColor whiteColor] fontSize:COUNT_FONT_SIZE bold:NO numLines:10];
	self.imageCountLabel.text = imageCountStr;	
	
	// descLabel
	self.descLabel = [self newLabel:[UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize:DESC_FONT_SIZE bold:NO numLines:10];
	self.descLabel.text = self.descStr;
	
	// bgGradient
	self.bgGradient = [[[UIImageView alloc] initWithFrame:CGRectZero]autorelease];
	self.bgGradient.image = [UIImage imageNamed:@"thumbViewBgGradient.png"];
    
    // add imageCountLabel1
    self.imageCountLabel1 = [self newLabel:[UIColor colorWithRed:0.49 green:0.49 blue:0.50 alpha:1.0] selectedColor:[UIColor whiteColor] fontSize:COUNT1_FONT_SIZE bold:NO numLines:10];
    self.imageCountLabel1.textAlignment = UITextAlignmentCenter;
    self.imageCountLabel1.text = imageCountStr;	

    // add subviews
    [self addSubview:self.bgGradient];    
	[self addSubview:self.titleLabel];    
	[self addSubview:self.imageCountLabel];    
	[self addSubview:self.descLabel];
    [self addSubview:self.imageCountLabel1];
    
    [self setNeedsLayout];
    
}


- (void)layoutSubviews {
	
    [super layoutSubviews];
    
    // layout header
    
    // titleLabel
    CGSize titleTextSize = [self.titleStr sizeWithFont:[UIFont boldSystemFontOfSize:TITLE_FONT_SIZE] constrainedToSize:CGSizeMake(self.frame.size.width, 1000) lineBreakMode:UILineBreakModeWordWrap];
    self.titleLabel.frame = CGRectMake(HEADER_HORIZ_MARGIN, TITLE_TOP, self.frame.size.width, titleTextSize.height);
    
    // imageCountLabel
    NSString *imageCountStr = [NSString stringWithFormat:@"(%@ photos)", self.counStr];
    CGSize imageCountTextSize = [imageCountStr sizeWithFont:[UIFont systemFontOfSize:COUNT_FONT_SIZE] constrainedToSize:CGSizeMake(TITLE_WIDTH, 1000) lineBreakMode:UILineBreakModeWordWrap];
    self.imageCountLabel.frame = CGRectMake(HEADER_HORIZ_MARGIN, TITLE_TOP+titleTextSize.height, self.frame.size.width, imageCountTextSize.height);
    
    // descLabel
   	CGSize descTextSize = [self.descStr sizeWithFont:[UIFont systemFontOfSize:DESC_FONT_SIZE] constrainedToSize:CGSizeMake(self.frame.size.width, 1000) lineBreakMode:UILineBreakModeWordWrap];
    self.descLabel.frame = CGRectMake(HEADER_HORIZ_MARGIN, TITLE_TOP+titleTextSize.height+imageCountTextSize.height+2, self.frame.size.width-15, descTextSize.height);
    
    // gradient
    self.bgGradient.frame = CGRectMake(0, 0, self.frame.size.width, titleTextSize.height+descTextSize.height+imageCountTextSize.height+4*HEADER_VERT_MARGIN);
    thumbInitY = bgGradient.frame.size.height;

    // spinner
    if(self.photoSource && spinner){
        [spinner removeFromSuperview];
        spinner = nil;
    } else if (spinner) {
        CGRect spinnerFrame = spinner.frame;
        spinnerFrame.origin.x = self.frame.size.width / 2.0 - spinner.frame.size.width / 2.0;
        spinnerFrame.origin.y = thumbInitY+spinner.frame.size.height+30;
        spinner.frame = spinnerFrame;
    }
    
    // layout thumbnails
    
	int viewWidth = self.bounds.size.width;
	int thumbSize = [self.photoSource thumbnailSize];
	
	int itemsPerRow = floor((viewWidth - kThumbMinimumSpace) / (thumbSize + kThumbMinimumSpace));	
	if (itemsPerRow < 1) itemsPerRow = 1;	// Ensure at least one per row.
	
	int spaceWidth = round((viewWidth - thumbSize * itemsPerRow) / (itemsPerRow + 1));
	int spaceHeight = spaceWidth;
	
	int x = spaceWidth;
	int y = spaceHeight+thumbInitY;
	
    int photoCount = [self.photoSource count];
    
	// Add/move thumbs.
	for (int i = 0; i < photoCount; i++) {
		
		int tag = kThumbTagOffset + i;
		
		ThumbImageView *thumbView = (ThumbImageView *)[self viewWithTag:tag];
		CGRect thumbFrame = CGRectMake(x, y, thumbSize, thumbSize);
		if (!thumbView) {		
			Photo *photo = [self.photoSource photoAtIndex:i];
			thumbView = [[ThumbImageView alloc] initWithFrame:thumbFrame];
			
            if ([self.photoSource thumbnailsHaveBorder]) {
                [thumbView addBorder];
            }
            thumbView.imageView.contentMode = [self.photoSource thumbnailContentMode];			
			thumbView.photo = photo;
			thumbView.controller = self.controller;
			thumbView.tag = tag;	// Used when thumb is tapped.
			[self addSubview:thumbView];
			[thumbView release];
		}
		thumbView.frame = thumbFrame;
		
		// set the position of the next thumb
		if ((i+1) % itemsPerRow == 0) {
			x = spaceWidth;
			y += thumbSize + spaceHeight;
		} else {
			x += thumbSize + spaceWidth;
		}
	}
    
    if(photoCount%4 == 0){
        y -=thumbSize;
    }

    // imageCountLabel1
    imageCountTextSize = [imageCountStr sizeWithFont:[UIFont systemFontOfSize:COUNT1_FONT_SIZE] constrainedToSize:CGSizeMake(TITLE_WIDTH, 1000) lineBreakMode:UILineBreakModeWordWrap];
    self.imageCountLabel1.frame = CGRectMake(0, y+85, self.frame.size.width, imageCountTextSize.height);
    
    
    // calculate content size
	int rowCount = ceil(photoCount / (float)itemsPerRow);
	int rowHeight = thumbSize + spaceHeight;
	self.contentSize = CGSizeMake(viewWidth, (rowHeight * rowCount + spaceHeight + thumbInitY + imageCountTextSize.height + 20));

}


- (UILabel *)newLabel:(UIColor *)color selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold numLines:(int)numLines
{
	UIFont *font = bold?[UIFont boldSystemFontOfSize:fontSize]:[UIFont systemFontOfSize:fontSize];
    UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	newLabel.opaque = YES;
	newLabel.textColor = color;
	newLabel.backgroundColor = [UIColor clearColor];
	newLabel.highlightedTextColor = selectedColor;
	newLabel.font = font;
	newLabel.numberOfLines = numLines;
	newLabel.lineBreakMode =  UILineBreakModeWordWrap;
	return newLabel;    
}


- (void)dealloc {
	self.photoSource = nil;
	[super dealloc];
}


@end
