//
//  LoadingOverlayView.m
//  Autonet
//
//  Created by Livecast02 on 31-01-18.
//  Copyright © 2018 Autonet. All rights reserved.
//
#import "LoadingOverlayView.h"
#import "AppDelegate.h"
@implementation LoadingOverlayView
@synthesize progressView;
@synthesize largeProgressView;
@synthesize largestProgressView;
@synthesize labeledProgressView;
@synthesize labeledLargeProgressView;
@synthesize timer;

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self setBackgroundColor:[UIColor grayColor]];
        [self loadingviews];
        [self setAlpha:0];
    }
    return self;
}

-(void)loadingviews
{
    progressView = [[DACircularProgressView alloc] initWithFrame:CGRectMake(140.0f, 50.0f, 72, 72)];
    progressView.roundedCorners = YES;
    progressView.trackTintColor = [UIColor clearColor];
    [self addSubview:progressView];
    [progressView setAlpha:1];
    labeledProgressView = [[DALabeledCircularProgressView alloc] initWithFrame:CGRectMake(200.0f, 40.0f, 74, 74)];
    labeledProgressView.roundedCorners = YES;
    labeledProgressView.trackTintColor = [UIColor clearColor];
    [self addSubview:labeledProgressView];
    [labeledProgressView setAlpha:1];
    labeledLargeProgressView = [[DALabeledCircularProgressView alloc] initWithFrame:CGRectMake(200.0f, 40.0f, 74, 74)];
    labeledLargeProgressView.roundedCorners = YES;
    labeledLargeProgressView.roundedCorners = NO;
    [self addSubview:labeledLargeProgressView];
    [labeledLargeProgressView setAlpha:1];
    [labeledLargeProgressView setCenter:self.center];
    [labeledProgressView setCenter:self.center];
    [progressView setCenter:self.center];
}
- (void)startAnimation
{
}
- (void)progressChange:(NSInteger)time
{


    //NSLog(@"%li", (long)time);

     [progressView setProgress:0.f animated:NO];                   
                   
        total = total+0.1f;
        NSArray *progressViews = @[progressView,
                                   labeledProgressView];
        for (DACircularProgressView *progressView in progressViews) {
           CGFloat progress = ![self.timer isValid] ? total : progressView.progress + 0.002f;
            [progressView setProgress:progress animated:YES];
            if (progressView.progress >= 1.0f) {
               [progressView setProgress:0.f animated:NO];
                total =0.0;
                //[self setAlpha:0];
            }
        }                                      
}
- (void)stopAnimation
{
    [self.timer invalidate];
    self.timer = nil;
     [self setAlpha:0];
}                   
@end
