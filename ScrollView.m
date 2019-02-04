//
//  ScrollView.m
//  Autonet
//
//  Created by Livecast02 on 06-02-17.
//  Copyright © 2017 Autonet. All rights reserved.
//
#import "ScrollView.h"
@implementation ScrollView
@synthesize imageView;

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self setBackgroundColor:[UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:0.5]];
        [self setImages:NULL];
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowOpacity = 0;
        [self setAlpha:0];
            //Imagepicker
    }
    return self;
}

-(void)setImages:(NSArray*)sender
{
    imageView=[[UICollectionImage alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width-10, self.frame.size.height-10)];
    [imageView setBackgroundColor:[UIColor whiteColor]];
    [imageView setAlpha:1];
    imageView.arrayItems = [[NSMutableArray alloc] initWithArray:sender];
    [self addSubview:imageView];
    [imageView setitems];
    [imageView setHeader:@"head"];
   
    UIButton *note =[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-70,30, 40, 40)];
    [note setImage:[UIImage imageNamed:@"gone.png"] forState:UIControlStateNormal];
    [note addTarget:self action:@selector(select) forControlEvents:UIControlEventTouchUpInside];
   [self addSubview:note];
    [note.layer setCornerRadius:4];
}
-(void)select
{
    if (self.alpha >0)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.2f];
        [self setAlpha:0];
        [UIView commitAnimations];
    } else {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.2f];
        [self setAlpha:1];
        [UIView commitAnimations];
       
     }
}
@end
