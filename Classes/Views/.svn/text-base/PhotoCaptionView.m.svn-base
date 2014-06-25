//
//  PhotoCaptionView1.m
//  OMG Photo Gallery
//
//  Created by Brendan S. Murphy on 5/24/11.
//  Copyright 2011 Yahoo! Inc. All rights reserved.
//

#import "PhotoCaptionView.h"

#define LEFT_MARGIN 10
#define RIGHT_MARGIN 10
#define TOP_MARGIN 10
#define HEADLINE_FONT_SIZE 14
#define CAPTION_FONT_SIZE 12


@implementation PhotoCaptionView

@synthesize headlineStr=_headlineStr;
@synthesize captionStr=_captionStr;
@synthesize ishidden=_ishidden;


- (id)initWithFrame:(CGRect)frame {
	
    if (self == [super initWithFrame:frame]) {        	
		
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		self.ishidden = YES;
		
        headlineLabel = [self newLabel:CGRectZero color:[UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize:HEADLINE_FONT_SIZE bold:YES numLines:0];
        captionLabel = [self newLabel:CGRectZero color:[UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize:CAPTION_FONT_SIZE bold:NO numLines:0];
        
        [self addSubview:headlineLabel];
        [self addSubview:captionLabel];
        [self layoutSubviews];
        
    }
	
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    if(self.superview.frame.size.width != self.superview.frame.size.width) return;
        
        CGSize textSize;
        
        // headlineLabel
        textSize = [self.headlineStr sizeWithFont:[UIFont boldSystemFontOfSize:HEADLINE_FONT_SIZE] constrainedToSize:CGSizeMake(self.superview.frame.size.width-RIGHT_MARGIN, self.superview.frame.size.height) lineBreakMode:UILineBreakModeWordWrap];
        headlineLabel.frame = CGRectMake(LEFT_MARGIN, TOP_MARGIN, self.superview.frame.size.width-RIGHT_MARGIN, textSize.height);
        
        // captionLabel
        textSize = [self.captionStr sizeWithFont:[UIFont systemFontOfSize:CAPTION_FONT_SIZE] constrainedToSize:CGSizeMake(self.superview.frame.size.width-RIGHT_MARGIN, self.superview.frame.size.height) lineBreakMode:UILineBreakModeWordWrap];
        captionLabel.frame = CGRectMake(LEFT_MARGIN, TOP_MARGIN+headlineLabel.frame.size.height+3, self.superview.frame.size.width-RIGHT_MARGIN, textSize.height);
        
        CGRect frame = self.frame;
        frame.size.width = self.superview.frame.size.width+5;
        frame.size.height = headlineLabel.frame.size.height+captionLabel.frame.size.height+2*TOP_MARGIN;
        self.frame = frame;
        
        [self setNeedsDisplay];
    
    
}


-(void) showWithHeadline:(NSString*)headlineStr andCaption:(NSString*)captionStr {
	
	if(self.ishidden && ![[UIApplication sharedApplication] isStatusBarHidden]){
        
        // reset text fields
        self.headlineStr = @"";
        self.captionStr = @"";
        headlineLabel.text = self.captionStr;
        captionLabel.text = self.headlineStr;
        [self layoutSubviews];
        
        self.hidden = NO;
        CGRect frame = self.frame;
		frame.origin.y = self.superview.frame.size.height;
		self.frame = frame;

        self.headlineStr = headlineStr;
        self.captionStr = captionStr;
        
        headlineLabel.text = self.headlineStr;
        if ([headlineStr rangeOfString:captionStr options:NSCaseInsensitiveSearch].location == NSNotFound && captionStr != @"caption not available...") {
            captionLabel.text = captionStr;
        } else {
            self.captionStr = @"";
        }
        
        [self layoutSubviews];
        
		CGContextRef context = UIGraphicsGetCurrentContext();
		[UIView beginAnimations:nil context:context];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationDuration:0.5];
        		
		frame = self.frame;
        CGFloat toolbarSize = UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]) ? 32.0f : 44.0f;
		frame.origin.y = self.superview.frame.size.height - self.frame.size.height-toolbarSize+1;
		self.frame = frame;
        
		[UIView commitAnimations];
        
        self.ishidden = NO;
        
	}
	
}


-(void) hide {
	
	if(!self.ishidden){
        
		CGContextRef context = UIGraphicsGetCurrentContext();
		[UIView beginAnimations:nil context:context];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationDuration:0.2];
		
		CGRect frame = self.frame;
		frame.origin.y = self.superview.frame.size.height;
		self.frame = frame;
		
		[UIView commitAnimations];

        self.ishidden = YES;
	}
	
}

-(void) hideNoAnim {
    
    if(!self.ishidden){
        CGRect frame = self.frame;
        frame.origin.y = self.superview.frame.size.height;
        self.frame = frame;
        self.hidden = YES;
        self.ishidden = YES;
    }
    
}

- (UILabel *)newLabel:(CGRect)frame  color:(UIColor *)color selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold numLines:(int)numLines
{
	UIFont *font = bold?[UIFont boldSystemFontOfSize:fontSize]:[UIFont systemFontOfSize:fontSize];
	UILabel *newLabel = [[UILabel alloc] initWithFrame:frame];
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
    [super dealloc];
    [headlineLabel release];
    [captionLabel release];
}


@end
