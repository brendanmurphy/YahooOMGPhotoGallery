//
//  LoadMoreViewCell.m
//  OMG Photo Gallery
//
//  Created by Brendan S. Murphy on 5/24/11.
//  Copyright 2011 Yahoo! Inc. All rights reserved.
//


#import "LoadMoreViewCell.h"

#define TITLE_FONT_SIZE 16

@implementation LoadMoreViewCell

@synthesize loadingLabel;
@synthesize spinner;
@synthesize inLoadingSate;



- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        
       // title
		self.loadingLabel = [self newLabel:[UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize:TITLE_FONT_SIZE bold:NO numLines:1];
        self.loadingLabel.textAlignment = UITextAlignmentCenter;
		[self.contentView addSubview:self.loadingLabel];
		[loadingLabel release];
        
        // diable default blue cell hilite
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // spinner
        spinner = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite]autorelease];
        [self addSubview:spinner];
        
        // div
		div = [[UIImageView alloc] initWithFrame:CGRectZero];
		[self.contentView addSubview:div];
		div.image = [UIImage imageNamed:@"div.png"];
		[div release];

        
    }

    return self;
}


- (void)setLoadingState:(BOOL)loadingBool {    
    self.inLoadingSate = loadingBool;
    if(self.inLoadingSate){
        self.loadingLabel.text = NSLocalizedString(@"Loading...", @"WHAT: Loading message  WHERE: LoadMoreViewCell.m");        
        [self.spinner startAnimating];
    } else {
        self.loadingLabel.text = NSLocalizedString(@"Tap to load more results...", @"WHAT: Tap to load more results message  WHERE: LoadMoreViewCell.m");
        [self.spinner stopAnimating];
    }
    [self setNeedsLayout];
}


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
}
    
    
- (void)layoutSubviews {    
    
    [super layoutSubviews];
    [self setNeedsDisplay];

    // title
    float titleWidth = self.frame.size.width;
    CGSize titleTextSize = [self.loadingLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:TITLE_FONT_SIZE] constrainedToSize:CGSizeMake(titleWidth, 1000) lineBreakMode:UILineBreakModeTailTruncation];    
    
    // spinner
    self.spinner.frame = CGRectMake(self.contentView.bounds.size.width/2-self.spinner.bounds.size.width, 20, self.spinner.bounds.size.width, self.spinner.bounds.size.height);
    
    if(self.inLoadingSate){
        self.loadingLabel.frame = CGRectMake(0, 50, titleWidth, titleTextSize.height);
	} else {
        self.loadingLabel.frame = CGRectMake(0, 30, titleWidth, titleTextSize.height);
    }
    
    // div
	CGRect frame = CGRectMake(0, 0, self.contentView.bounds.size.width, 2);
    div.frame = frame;	


}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
    [super setSelected:selected animated:animated];    
	
    self.contentView.backgroundColor = selected ? [UIColor colorWithRed:0.93 green:0.08 blue:0.50 alpha:1.0] : [UIColor colorWithRed:0.17 green:0.18 blue:0.20 alpha:1.0];
    
	self.loadingLabel.backgroundColor = [UIColor clearColor];
	self.loadingLabel.highlighted = selected;
	self.loadingLabel.opaque = !selected;
	
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

