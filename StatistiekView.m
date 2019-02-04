    //
    //  StatistiekView.m
    //  Autonet
    //
    //  Created by Livecast02 on 11-07-17.
    //  Copyright © 2017 Autonet. All rights reserved.
    //
#import "StatistiekView.h"
#import "CameraButton.h"
#import "FileManager.h"
#import "UIViewTemplate.h"
@implementation StatistiekView
@synthesize content;
@synthesize titleView;
@synthesize ScrollResult;

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {

        [self setBackgroundColor:[UIColor colorWithRed:0.965 green:0.933 blue:0.855 alpha:1.000]];
        [self setAlpha:0];
        [self setItems];
    }
    return self;
}
-(void)setItems
{
    content =[[UIView alloc]initWithFrame:CGRectMake(2,2, self.frame.size.width-4, self.frame.size.height-4)];
    [content setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:content];
    
    CameraButton *back =[[CameraButton alloc]initWithFrame:CGRectMake(4,3, 40, 40)];
    [back setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [back setBackgroundColor:[UIColor clearColor]];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [back.layer setBorderWidth:2];
    [back.layer  setBorderColor:[UIColor blackColor].CGColor];
    [back setItembig:[UIColor blackColor] setImage:@"back.png"];
    [self addSubview:back];

    [self.layer setCornerRadius:6];

    titleView =[[UILabel alloc]initWithFrame:CGRectMake(60, 5, 180, 30)];
    [titleView setText:@"Artikelnummers"];
    [titleView setFont:[UIFont boldSystemFontOfSize:20]];
    [titleView setNumberOfLines:2];
    [titleView setTextAlignment:NSTextAlignmentLeft];
    [titleView setTextColor:[UIColor blackColor]];
    [titleView setTag:27];
    [titleView setNumberOfLines:4];
    [titleView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:titleView];

    for (int i=0 ; i<46; i++) {
        NSMutableArray *daylist = [[NSMutableArray alloc] init];
        for (int k=0 ; k<28; k++) {
           UILabel *block2= [[UILabel alloc] initWithFrame:CGRectMake(70+(20*i), (150+(20*k)), 0.5, 20)];
            block2.backgroundColor = [UIColor colorWithRed:0.075 green:0.576 blue:0.796 alpha:1.000];
            [content  addSubview:block2];
            UILabel *block= [[UILabel alloc] initWithFrame:CGRectMake(50+(20*i), (150+(20*k)), 20, 0.3)];
            block.backgroundColor = [UIColor colorWithRed:0.075 green:0.576 blue:0.796 alpha:1.000];
            [content  addSubview:block];
            [daylist addObject:block];
        }
        UILabel *block3= [[UILabel alloc] initWithFrame:CGRectMake(50, 149, 0.5, self.frame.size.height-206)];
        block3.backgroundColor = [UIColor colorWithRed:0.075 green:0.576 blue:0.796 alpha:1.000];
        [content  addSubview:block3];
        UILabel *block4= [[UILabel alloc] initWithFrame:CGRectMake(50, self.frame.size.height-58, self.frame.size.width-102, 0.5)];
        block4.backgroundColor = [UIColor colorWithRed:0.075 green:0.576 blue:0.796 alpha:1.000];
        [content  addSubview:block4];
    }
    ScrollResult =[[UIScrollView alloc] initWithFrame:CGRectMake(50, 149, 920,560)];
    [ScrollResult setCanCancelContentTouches:NO];
    ScrollResult.showsHorizontalScrollIndicator = YES;
    [ScrollResult setBackgroundColor:[UIColor colorWithRed:1.000 green:1.000 blue:0.000 alpha:0.4]];
    ScrollResult.delaysContentTouches=NO;
    ScrollResult.clipsToBounds = YES;
    ScrollResult.scrollEnabled = YES;
    ScrollResult.pagingEnabled = NO;
    ScrollResult.delaysContentTouches=YES;
    [ScrollResult setDelegate:self];
    ScrollResult.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    [content addSubview:ScrollResult];                   
}
-(void)insertDeelID:(NSMutableDictionary*)set
{
     NSMutableArray *contentdict =[[FileManager getStatistiekenOnID:[set valueForKey:@"DeelId"]] mutableCopy];
    if ([[set valueForKey:@"DeelNamen"] count]>0) {
        [titleView setText:[NSString stringWithFormat:@"%@", [[[set valueForKey:@"DeelNamen"] firstObject] valueForKey:@"Naam"]]];
    }
    for (int k=0 ; k<[contentdict count]; k++) {
        UIViewTemplate *statest =[[UIViewTemplate alloc]initWithFrame:CGRectMake(10,0, 920,560)];
        statest.getlist =[[contentdict objectAtIndex:k] valueForKey:@"StatistiekDetails"];
        statest.startnumber = [[contentdict objectAtIndex:k] valueForKey:@"Waarde"];
        [statest setBackgroundColor:[UIColor clearColor]];
        [ScrollResult addSubview:statest];
     
            [ScrollResult setContentSize:CGSizeMake(920*k,560)];
    }
}
-(void)back
{
    [self setAlpha:0];
}
@end
