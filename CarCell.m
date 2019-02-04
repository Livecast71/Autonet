//
//  CarCell.m
//  Autonet
//
//  Created by Livecast02 on 13-04-17.
//  Copyright © 2017 Autonet. All rights reserved.
//
#import "CarCell.h"
#import "UIFont+FlatUI.h"
@implementation CarCell
@synthesize imgset;
@synthesize logos;
@synthesize kenteken;
@synthesize onderdelenView;
@synthesize label;
-(void)setItems
{
   
    imgset = [[UIImageView alloc] init];
    [imgset setTag:40];
    [self addSubview:imgset];

    logos= [[UIImageView alloc] initWithFrame:CGRectMake(0,3,177,42)];
    [logos setImage:[UIImage imageNamed:@"license_plate_nl.png"]];
    logos.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:logos];

    kenteken =[[UILabel alloc] initWithFrame:CGRectMake(-15,4,157,42)];
    [kenteken setBackgroundColor:[UIColor clearColor]];
    [kenteken setFont:[UIFont fontWithName:@"Kenteken" size:20]];
    [kenteken setTextAlignment:NSTextAlignmentRight];
    [self addSubview:kenteken];

    onderdelenView=[[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-100, self.frame.size.width,  100)];
    [onderdelenView setBackgroundColor:[UIColor colorWithRed:1.000000 green:1.000000 blue:1.000000 alpha:0.5]];
    [onderdelenView setAlpha:1];
    [self addSubview:onderdelenView];
    
    label =[[UILabel alloc] initWithFrame:CGRectMake(20, 10, self.frame.size.width-40,  60)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont regularFlatFontOfSize:16]];
    [label setTextAlignment:NSTextAlignmentLeft];
    [onderdelenView addSubview:label];
}
@end
