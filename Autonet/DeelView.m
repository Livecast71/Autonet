    //
    //  Deel.m
    //  Autonet
    //
    //  Created by Livecast02 on 21-12-16.
    //  Copyright © 2016 Autonet. All rights reserved.
    //
#import "DeelView.h"
#import "VeldenListView.h"
#import "DeelText.h"
#import "CameraButton.h"
#import "ImageButton.h"
@implementation DeelView

-(void)setDeel:(NSMutableDictionary*)velden
{
    UILabel *idlabel =[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 150, 100)];
    [idlabel setText:[NSString stringWithFormat:@"%@", [velden valueForKey:@"InternetOmschrijving"]]];
    [idlabel setFont:[UIFont boldSystemFontOfSize:12]];
    [idlabel setNumberOfLines:2];
    [idlabel setTextAlignment:NSTextAlignmentLeft];
    [idlabel setTextColor:[UIColor blackColor]];
    [idlabel setTag:27];
    [idlabel setNumberOfLines:4];
    [idlabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:idlabel];

    [idlabel sizeToFit];
    if ([[velden valueForKey:@"VeldWaarden"] count]>0) {
        
        VeldenListView *catogorie =[[VeldenListView alloc]initWithFrame:CGRectMake(4, idlabel.frame.size.height+7, 138, 30)];
        [catogorie setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
        [catogorie setVeldId:[[velden valueForKey:@"VeldId"] integerValue]];
        catogorie.asY =catogorie.frame.origin.y;
        [catogorie.layer setCornerRadius:4];
        [catogorie setItem:[velden valueForKey:@"VeldWaarden"]];
        [self addSubview:catogorie];

    } else {
        DeelText *nameVerbruik = [[DeelText alloc] initWithFrame:CGRectMake(4, idlabel.frame.size.height+7, 138, 30)];
        [nameVerbruik setBackgroundColor:[UIColor whiteColor]];
        [nameVerbruik setText:@"Vul in"];
        [nameVerbruik setFont:[UIFont systemFontOfSize:12]];
        [nameVerbruik setTextColor:[UIColor blackColor]];
        [nameVerbruik setTextAlignment:NSTextAlignmentCenter];
        [nameVerbruik setDataDetectorTypes:UIDataDetectorTypeAll];
        [nameVerbruik setEditable:YES];
        [nameVerbruik.layer setCornerRadius:4];
        nameVerbruik.layer.shadowOffset = CGSizeMake(0, 0);
        nameVerbruik.layer.shadowOpacity = 0;
        [self addSubview:nameVerbruik];
    }
}
@end
