//
//  LoadingOverlayView.h
//  Autonet
//
//  Created by Livecast02 on 31-01-18.
//  Copyright © 2018 Autonet. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "DACircularProgressView.h"
#import "DALabeledCircularProgressView.h"
@interface LoadingOverlayView : UIView
{
NSTimer *ToLang;
NSInteger count;
float total;
}
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) DACircularProgressView *progressView;
@property (strong, nonatomic) DACircularProgressView *largeProgressView;
@property (strong, nonatomic) DACircularProgressView *largestProgressView;
@property (strong, nonatomic) DALabeledCircularProgressView *labeledProgressView;
@property (strong, nonatomic) DALabeledCircularProgressView *labeledLargeProgressView;
-(void)loadingviews;
- (void)stopAnimation;
- (void)startAnimation;
- (void)progressChange:(NSInteger)time;
@end
