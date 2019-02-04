//
//  ImageScrollView.m
//  Autonet
//
//  Created by Livecast02 on 08-03-17.
//  Copyright © 2017 Autonet. All rights reserved.
//
#import "ImageScrollView.h"
#import "UICollectionImage.h"
#import "CameraButton.h"
#import "OnderdeelView.h"
@implementation ImageScrollView
@synthesize imageView;
-(void) setImagesEmpty
{
    imageView=[[UICollectionImage alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width-10, self.frame.size.height-10)];
    [imageView setBackgroundColor:[UIColor whiteColor]];
    [imageView.layer setBorderWidth:2];
    [imageView.layer  setBorderColor:[UIColor lightGrayColor].CGColor];
    [imageView setAlpha:1];
    [self addSubview:imageView];
    [imageView setitems];
    imageView.layer.shadowOffset = CGSizeMake(0.5, 0);
    imageView.layer.shadowOpacity = 0.5;
}
-(void)setimages:(NSMutableArray*)sender setOnline:(NSMutableArray*)internet;
{
    imageView=[[UICollectionImage alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width-10, self.frame.size.height-10)];
    [imageView setBackgroundColor:[UIColor whiteColor]];
    [imageView.layer setBorderWidth:2];
    [imageView.layer  setBorderColor:[UIColor lightGrayColor].CGColor];
    [imageView setAlpha:1];
    if ([[self superview] isKindOfClass:[OnderdeelView class]]) {
          [imageView setHeader:@"onderdeel"];
    } else {
          [imageView setHeader:@"autoonderdeel"];
    }
    if ([sender count]>0) {
        imageView.arrayItems = [[NSMutableArray alloc] initWithArray:sender];
        imageView.arrayInternet = [[NSMutableArray alloc] initWithArray:internet];
    } else {
        imageView.arrayItems = [[NSMutableArray alloc] init];
         imageView.arrayInternet = [[NSMutableArray alloc] init];
    }
    [self addSubview:imageView];
    [imageView setitems];
  
    imageView.layer.shadowOffset = CGSizeMake(0.5, 0);
    imageView.layer.shadowOpacity = 0.5;
}
@end
