//
//  LineButton.m
//  Autonet
//
//  Created by Livecast02 on 10-12-16.
//  Copyright © 2016 Autonet. All rights reserved.
//
#import "BarView.h"
#import "LineButton.h"
#import "UIFont+FlatUI.h"
#import "AppDelegate.h"
#import "FileManager.h"
#import "CameraButton.h"
#import "UIFont+FlatUI.h"
@implementation BarView
@synthesize AllLines;
@synthesize baseColor;
@synthesize contraColor;
@synthesize kenteken;
@synthesize content;
@synthesize Uploaden;
@synthesize currentheight;
@synthesize ovelaylabel;
@synthesize logos;
@synthesize ipadname;
@synthesize autolabel;

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self setBackgroundColor:[UIColor colorWithRed:0.414 green:0.806 blue:0.849 alpha:1.000]];
        [self setItem:baseColor];
    }
    return self;
}

-(void)setItem:(UIColor*)color
{
 
    baseColor =color;
    contraColor =[UIColor colorWithRed:0.949 green:0.949 blue:0.949 alpha:1.0];
    AllLines =[[NSMutableArray alloc] init];
    CameraButton *back =[[CameraButton alloc]initWithFrame:CGRectMake(4,3, 40, 40)];
    [back setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [back setBackgroundColor:[UIColor clearColor]];
    [self addSubview:back];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [back.layer setBorderWidth:2];
    [back.layer  setBorderColor:[UIColor whiteColor].CGColor];
     [back setItembig:[UIColor whiteColor] setImage:@"back.png"];
    [self.layer setCornerRadius:6];

    logos= [[UIImageView alloc] initWithFrame:CGRectMake(50,3,177,42)];
    [logos setImage:[UIImage imageNamed:@"license_plate_nl.png"]];
    logos.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:logos];

    ovelaylabel= [[UILabel alloc] initWithFrame:CGRectMake(50,3,400,42)];
    [ovelaylabel setBackgroundColor:[UIColor whiteColor]];
    [ovelaylabel setTextAlignment:NSTextAlignmentCenter];
    [ovelaylabel setFont:[UIFont systemFontOfSize:20]];
    [self addSubview:ovelaylabel];
    [ovelaylabel setAlpha:0];
    [ovelaylabel.layer setCornerRadius:4];
    [ovelaylabel.layer setMasksToBounds:YES];

    kenteken =[[UILabel alloc] initWithFrame:CGRectMake(35,4,157,42)];
    [kenteken setBackgroundColor:[UIColor clearColor]];
    [kenteken setFont:[UIFont fontWithName:@"Kenteken" size:20]];
    [kenteken setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:kenteken];
    [content.layer setCornerRadius:6];

    NSMutableDictionary *person = [FileManager getUser:@""];
   ////////////NSLog(@"person %@", person);
    ipadname =[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width-205,5,200,35)];
    [ipadname setText:[person valueForKey:@"Naam"]];
    [ipadname setFont:[UIFont systemFontOfSize:20]];
    [ipadname setTextColor:[UIColor whiteColor]];
    [ipadname setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0]];
    [ipadname setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:ipadname];

    [ipadname.layer setBorderWidth:2];
    [ipadname.layer setBorderColor:[UIColor whiteColor].CGColor];
    [ipadname.layer setCornerRadius:5];

    autolabel =[[UILabel alloc]initWithFrame:CGRectMake(300,0,400,50)];
    [autolabel setText:@"text"];
    [autolabel setFont:[UIFont boldFlatFontOfSize:18]];
    [autolabel setTextColor:[UIColor blackColor]];
    [autolabel setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0]];
    [autolabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:autolabel];
}
-(void)back
{
    AppDelegate *appDelegate = [FileManager getDel];
    [appDelegate.viewcontroller.collectionOnderdelenView.aannamelijstView reset];
    [appDelegate.viewcontroller.collectionOnderdelenView.catogorie reset];
    [appDelegate.viewcontroller.collectionOnderdelenView.onderdelen reset];
      [appDelegate.viewcontroller.navigaionView setAlpha:1];
     [appDelegate.viewcontroller.overlay setAlpha:0];
        [appDelegate.viewcontroller overlayAction];
      [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}
-(void)loadingview
{
    }
-(void)select
{
    AppDelegate *appDelegate = [FileManager getDel];
    if (appDelegate.viewcontroller.scroll.alpha >0)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.2f];
        [appDelegate.viewcontroller.scroll setAlpha:0];
        [UIView commitAnimations];
    } else {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.2f];
        [appDelegate.viewcontroller.scroll setAlpha:1];
        [UIView commitAnimations];
       
     }
    [appDelegate.viewcontroller.collectionOnderdelenView.aannamelijstView reset];
    [appDelegate.viewcontroller.collectionOnderdelenView.catogorie reset];
    [appDelegate.viewcontroller.collectionOnderdelenView.onderdelen reset];
      [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}
-(void)move:(LineButton*)sender
{
    if (self.frame.origin.x <0)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.2f];
        [self setFrame:CGRectMake(54, 4, self.frame.size.width, self.frame.size.height)];
        [UIView commitAnimations];
    } else {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.2f];
        [self setFrame:CGRectMake(-920, 4, self.frame.size.width, self.frame.size.height)];
        [UIView commitAnimations];
    }
    [sender setBackgroundColor:contraColor];
    [content setBackgroundColor:contraColor];
    //[self setTitleColor:contraColor forState:normal];
    double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [sender setBackgroundColor:[UIColor whiteColor]];
        [self.content setBackgroundColor:[UIColor whiteColor]];
        // [self setTitleColor:baseColor forState:normal];
    });
    }


@end
