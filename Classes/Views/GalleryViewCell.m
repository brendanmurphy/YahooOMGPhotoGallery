//
//  GalleryViewCell.m
//  OMG Photo Gallery
//
//  Created by Brendan S. Murphy on 5/24/11.
//  Copyright 2011 Yahoo! Inc. All rights reserved.
//


#import "GalleryViewCell.h"
#import "ThumbImageView.h"
#import <QuartzCore/QuartzCore.h>

#define LEFT_MARGIN 95
#define RIGHT_MARGIN 25

#define TITLE_TOP 10
#define TITLE_WIDTH 200
#define TITLE_FONT_SIZE 16
#define TITLE_DOUBLE_LINE_HEIGHT 40

#define DESC_WIDTH 200
#define DESC_HEIGHT 40
#define DESC_FONT_SIZE 13

#define CHEVRON_WIDTH 9
#define CHEVRON_HEIGHT 13
#define CHEVRON_MARGIN 8
#define CHECK_SIDE 17


#define THUMB_WIDTH 75
#define THUMB_HEIGHT 75
#define THUMB_MARGIN 10
#define THUMB_CORNER 0

@implementation GalleryViewCell

@synthesize titleLabel;
@synthesize descriptionLabel;
@synthesize chevron;
@synthesize thumbView;
@synthesize check;



- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        
       // title
		self.titleLabel = [self newLabel:[UIColor colorWithRed:0.93 green:0.08 blue:0.50 alpha:1.0] selectedColor:[UIColor whiteColor] fontSize:TITLE_FONT_SIZE bold:YES numLines:2];
		[self.contentView addSubview:self.titleLabel];
		[titleLabel release];

		// description
		self.descriptionLabel = [self newLabel:[UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize:DESC_FONT_SIZE bold:NO numLines:3];
		[self.contentView addSubview:descriptionLabel];
		[descriptionLabel release];
		
		// chevron
		chevron = [[UIImageView alloc] initWithFrame:CGRectZero];
		[self.contentView addSubview:chevron];
		chevron.image = [UIImage imageNamed:@"chevron2.png"];
		[chevron release];	


        // thumbView 
        thumbView = [[[ThumbImageView alloc] initWithFrame:CGRectMake(THUMB_MARGIN-2, THUMB_MARGIN-2, THUMB_WIDTH, THUMB_HEIGHT)] autorelease];        
        [thumbView addBorder];
        thumbView.imageView.contentMode = UIViewContentModeScaleAspectFill;
        thumbView.controller = (id)self;
        thumbView.userInteractionEnabled = NO;
        [self.contentView addSubview:thumbView];

        // check
		check = [[UIImageView alloc] initWithFrame:CGRectZero];
		[self.contentView addSubview:check];
		check.image = [UIImage imageNamed:@"check.png"];
		[check release];
        [self.check setHidden:YES];

        // div
		div = [[UIImageView alloc] initWithFrame:CGRectZero];
		[self.contentView addSubview:div];
		div.image = [UIImage imageNamed:@"div.png"];
		[div release];

        // diable default blue cell hilite
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }

    return self;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    //[self setSelected:YES animated:NO];
}
    
    
- (void)setCellWithTitle: (NSString *)titleStr andDesc: (NSString*)descStr andImgURL: (NSURL*)imgURL andNumPhotos: (NSString*) numPhotosStr {
	self.titleLabel.text = [titleStr stringByAppendingString:[NSString stringWithFormat:@" (%@)", numPhotosStr]];
	self.descriptionLabel.text = descStr;
    thumbView.photo = [[Photo alloc] initWithImageURL:imgURL];    
 }


- (void)layoutSubviews {    
    
    [super layoutSubviews];
    
    [self setNeedsDisplay];

    CGRect contentRect = self.contentView.bounds;
	CGRect frame;
	CGFloat descY;
	
    // title
    float titleWidth = self.frame.size.width - LEFT_MARGIN-RIGHT_MARGIN;
    // titleTextSize: 20 = single-line, 40 = double-line
    CGSize titleTextSize = [self.titleLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:TITLE_FONT_SIZE] constrainedToSize:CGSizeMake(titleWidth, 1000) lineBreakMode:UILineBreakModeTailTruncation];    
    frame = titleTextSize.height >= TITLE_DOUBLE_LINE_HEIGHT ? CGRectMake(LEFT_MARGIN, TITLE_TOP, titleWidth, TITLE_DOUBLE_LINE_HEIGHT) : CGRectMake(LEFT_MARGIN, TITLE_TOP, titleWidth, titleTextSize.height);    
    self.titleLabel.frame = frame;
	
	// description
    float descWidth = self.frame.size.width - LEFT_MARGIN-RIGHT_MARGIN;
    // double-line title: descY>TITLE_MAX_HEIGHT
    if(titleTextSize.height>=TITLE_DOUBLE_LINE_HEIGHT){
        descriptionLabel.numberOfLines = 2;
        descY = TITLE_TOP+TITLE_DOUBLE_LINE_HEIGHT - 7;
    } else {
        descriptionLabel.numberOfLines = 3;
        descY = TITLE_TOP+TITLE_DOUBLE_LINE_HEIGHT - 30;
    }
    float descHeight = self.frame.size.height - descY;
    frame = CGRectMake(LEFT_MARGIN, descY, descWidth, descHeight);
	self.descriptionLabel.frame = frame;
	
	// chevron
	frame = CGRectMake(contentRect.size.width-CHEVRON_WIDTH-CHEVRON_MARGIN,contentRect.size.height/2-CHEVRON_HEIGHT/2, CHEVRON_WIDTH, CHEVRON_HEIGHT);
    chevron.frame = frame;	
    
	// check
	frame = CGRectMake(3, THUMB_HEIGHT-CHECK_SIDE/2-2, CHECK_SIDE, CHECK_SIDE);
    check.frame = frame;	

    // div
	frame = CGRectMake(0, 0, contentRect.size.width, 2);
    div.frame = frame;	
   
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
    [super setSelected:selected animated:animated];    
	
    self.contentView.backgroundColor = selected ? [UIColor colorWithRed:0.93 green:0.08 blue:0.50 alpha:1.0] : [UIColor colorWithRed:0.17 green:0.18 blue:0.20 alpha:1.0];
    
	self.titleLabel.backgroundColor = [UIColor clearColor];
	self.titleLabel.highlighted = selected;
	self.titleLabel.opaque = !selected;
	self.descriptionLabel.backgroundColor = [UIColor clearColor];
	self.descriptionLabel.highlighted = selected;
	self.descriptionLabel.opaque = !selected;
    
    if(selected){
        [self.check setHidden:NO];
    }
    
}


- (UILabel *)newLabel:(UIColor *)color selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold numLines:(int)numLines
{
	UIFont *font = bold?[UIFont boldSystemFontOfSize:fontSize]:[UIFont systemFontOfSize:fontSize];
	UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	newLabel.opaque = YES;
	newLabel.textColor = color;
	newLabel.highlightedTextColor = selectedColor;
	newLabel.font = font;
	newLabel.numberOfLines = numLines;
	newLabel.lineBreakMode =  UILineBreakModeTailTruncation;	
	return newLabel;
}


- (void)dealloc {
	[super dealloc];
}


@end

