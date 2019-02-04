//
//  KernoOderdelenView.m
//  Autonet
//
//  Created by Livecast02 on 12-01-17.
//  Copyright © 2017 Autonet. All rights reserved.
//
#import "KernoOnderdelenView.h"
#import "DeelView.h"
@implementation KernoOnderdelenView
-(void)setVeldenKern:(NSArray*)velden
{
 
    UIScrollView *scrolside =[[UIScrollView alloc] initWithFrame:CGRectMake(5, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:scrolside];
    for (int i=0; i<[velden count]; i++) {
        DeelView *contentit =[[DeelView alloc] initWithFrame:CGRectMake((self.frame.size.height+5)*i, 2, self.frame.size.height, self.frame.size.height-10)];
        [contentit setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
        [contentit.layer setBorderWidth:2];
        [contentit.layer setCornerRadius:4];
        [contentit.layer setBorderColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000].CGColor];
        [scrolside addSubview:contentit];
        [contentit setDeel:[velden objectAtIndex:i]];
        [scrolside setContentSize:CGSizeMake(40+(self.frame.size.height+5)*(i+1.2), self.frame.size.height)];
    }
}
@end
