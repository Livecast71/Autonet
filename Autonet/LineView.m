//
//  LineButton.m
//  Autonet
//
//  Created by Livecast02 on 10-12-16.
//  Copyright © 2016 Autonet. All rights reserved.
//
#import "LineView.h"
@implementation LineView
@synthesize AllLines;
@synthesize baseColor;
@synthesize contraColor;
-(void)setItem:(UIColor*)color
{
    baseColor =color;
    AllLines =[[NSMutableArray alloc] init];
    [self.layer setCornerRadius:6];
}


@end
