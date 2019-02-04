//
//  RemoveView.m
//  Autonet
//
//  Created by Livecast02 on 21-06-17.
//  Copyright © 2017 Autonet. All rights reserved.
//
#import "RemoveView.h"
#import "AppDelegate.h"
#import "FileManager.h"
@implementation RemoveView
@synthesize SelectedItems;
- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {

        [self setitems];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setAlpha:0];
    }
    return self;
}

-(void)setitems
{
    AppDelegate *appDelegate = [FileManager getDel];
    SelectedItems =[[NSMutableArray alloc]init];
        UIButton *Bewaar =[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-210, 10, 200, 40)];
    [Bewaar setTitle:@"Verwijder" forState:UIControlStateNormal];
    [Bewaar.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [Bewaar setBackgroundColor:[UIColor redColor]];
    [Bewaar addTarget:appDelegate.viewcontroller.collectionOnderdelenView action:@selector(remove:) forControlEvents:UIControlEventTouchUpInside];
    [Bewaar.layer setCornerRadius:4];
    [self addSubview:Bewaar];
}
-(void)Verwijder:(UIButton*)sender
{
}
-(void)apearit
{
    [self setAlpha:1];
}
@end
