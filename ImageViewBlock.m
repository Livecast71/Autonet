    //
    //  ImageViewBlock.m
    //  Autonet
    //
    //  Created by Livecast02 on 17-10-17.
    //  Copyright © 2017 Autonet. All rights reserved.
    //
#import "ImageViewBlock.h"
#import "FileManager.h"
#import "AppDelegate.h"
#import "ItemFold.h"
@implementation ImageViewBlock
@synthesize imagecontent;
@synthesize curentindex;
@synthesize currentimage;
@synthesize UISwitchOne;

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setimtems];
        [self setAlpha:0];
    }
    return self;
}
-(void)setimtems
{                   
    imagecontent = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,self.frame.size.width,self.frame.size.height)];
    [imagecontent setImage:[UIImage imageNamed:@"imagecontent.png"]];
    [imagecontent setBackgroundColor:[UIColor whiteColor]];
    [imagecontent.layer setMasksToBounds:YES];
    [self addSubview:imagecontent];


    UIView *menubar =[[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width-310,10,300,50)];
    [menubar setBackgroundColor:[UIColor whiteColor]];
    [menubar.layer setBorderWidth:1];
    [menubar.layer setCornerRadius:10];
    [menubar setTag:1];
    [self addSubview:menubar];

    UIButton *removebutton =[[UIButton alloc]initWithFrame:CGRectMake(5,5, 100, 40)];
    [removebutton setBackgroundColor:[UIColor redColor]];
    [removebutton setTitle:@"Verwijder" forState:UIControlStateNormal];
    [removebutton addTarget:self action:@selector(removebuttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [removebutton.layer setCornerRadius:4];
    [menubar addSubview:removebutton];

    UIButton *note =[[UIButton alloc]initWithFrame:CGRectMake(300-50,5, 40, 40)];
    [note setImage:[UIImage imageNamed:@"gone.png"] forState:UIControlStateNormal];
    [note addTarget:self action:@selector(select) forControlEvents:UIControlEventTouchUpInside];
    [note setAlpha:0.5];
    [note.layer setCornerRadius:4];
    [menubar addSubview:note];
    
    UILabel *internetoverlay =[[UILabel alloc]initWithFrame:CGRectMake(125,0,100,50)];
    [internetoverlay setText:@"Op internet"];
    [internetoverlay setTextColor:[UIColor blackColor]];
    [internetoverlay setFont:[UIFont systemFontOfSize:12]];
    [internetoverlay setBackgroundColor:[UIColor whiteColor]];
    [internetoverlay setTextAlignment:NSTextAlignmentLeft];
    [internetoverlay.layer setCornerRadius:5];
    [menubar addSubview:internetoverlay];

    UISwitchOne =[[UISwitch alloc] initWithFrame:CGRectMake(195, 8, 60, 40)];
    [UISwitchOne addTarget:self action:@selector(moveOnintenet:) forControlEvents:(UIControlEventValueChanged | UIControlEventTouchDragInside)];
    [UISwitchOne setOnTintColor:[UIColor greenColor]];
    UISwitchOne.backgroundColor = [UIColor redColor];
    UISwitchOne.layer.cornerRadius = 16.0;
    [menubar addSubview:UISwitchOne];
}                                      
-(void)moveOnintenet:(UISwitch*)sender
{
    AppDelegate *appDelegate = [FileManager getDel];
    if ([[[appDelegate.currentCollection superview] superview] isKindOfClass:[OnderdeelView class]])
    {
        OnderdeelView *copyitem = (OnderdeelView*)[[appDelegate.currentCollection superview] superview];
        NSMutableDictionary *OpDictonary  =[[copyitem.basepart valueForKey:@"FotosInfo"] objectAtIndex:curentindex.row];                   
        if ([sender isOn])
        {
           [OpDictonary setObject:[NSNumber numberWithBool:YES] forKey:@"Internet"];
        }
        else                   
        {
           [OpDictonary setObject:[NSNumber numberWithBool:NO] forKey:@"Internet"];
        }
        NSMutableArray *copyfoto =[[NSMutableArray alloc] init];
        [copyfoto setArray:(NSArray*) [copyitem.basepart valueForKey:@"FotosInfo"]];
        [copyfoto replaceObjectAtIndex:curentindex.row withObject:OpDictonary];
        [copyitem.basepart setObject:copyfoto forKey:@"FotosInfo"];                   
        [FileManager insertnew:copyitem.basepart];
        [appDelegate.currentCollection.arrayInternet replaceObjectAtIndex:curentindex.row withObject:[OpDictonary valueForKey:@"Internet"]];
        [appDelegate.currentCollection.arrayItems replaceObjectAtIndex:curentindex.row withObject:[OpDictonary valueForKey:@"Orgnaam"]];
        [appDelegate.currentCollection.collectionViewcopy reloadData];                   
    } else                   
    {
        NSMutableArray *arrayItems =[[FileManager getFotos_voertuig:@""] mutableCopy];
        if (arrayItems) {
        }
        else
        {
           arrayItems =[[NSMutableArray alloc] init];
        }
        NSMutableDictionary *OpDictonary  =[arrayItems objectAtIndex:curentindex.row];
        NSNumber *number2 = [NSNumber numberWithBool:YES];
        [OpDictonary setValue:number2 forKey:@"InAutomate"];
        if ([sender isOn])                   
        {
           [OpDictonary setObject:[NSNumber numberWithBool:YES] forKey:@"Internet"];
        }
        else                   
        {
           [OpDictonary setObject:[NSNumber numberWithBool:NO] forKey:@"Internet"];
        }
        [arrayItems replaceObjectAtIndex:curentindex.row withObject:OpDictonary];                   
        [FileManager insertFotos:arrayItems];
        [appDelegate.currentCollection.arrayInternet replaceObjectAtIndex:curentindex.row withObject:[OpDictonary valueForKey:@"Internet"]];
        [appDelegate.currentCollection.arrayItems replaceObjectAtIndex:curentindex.row withObject:[OpDictonary valueForKey:@"Orgnaam"]];
        [appDelegate.currentCollection.collectionViewcopy reloadData];
        [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];                                      
    }                   
}
-(void)removebuttonAction:(UIButton*)sender
{
    AppDelegate *appDelegate = [FileManager getDel];
    if ([[[appDelegate.currentCollection superview] superview] isKindOfClass:[OnderdeelView class]])
    {
        OnderdeelView *copyitem = (OnderdeelView*)[[appDelegate.currentCollection superview] superview];
        NSMutableArray *copyfoto =[copyitem.basepart valueForKey:@"FotosInfo"];
        [copyfoto removeObjectAtIndex:curentindex.row];
        [copyitem.basepart setObject:copyfoto forKey:@"FotosInfo"];
        [appDelegate.currentCollection.arrayInternet removeObjectAtIndex:curentindex.row];
        [appDelegate.currentCollection.arrayItems removeObjectAtIndex:curentindex.row];
        [appDelegate.currentCollection.collectionViewcopy reloadData];
        [FileManager insertnew:copyitem.basepart];
        [self setAlpha:0];
    } else                   
    {
        NSMutableArray *arrayItems =[[FileManager getFotos_voertuig:@""] mutableCopy];
        [arrayItems removeObjectAtIndex:curentindex.row];
        [FileManager insertFotos:arrayItems];
        [appDelegate.currentCollection.arrayInternet removeObjectAtIndex:curentindex.row];
        [appDelegate.currentCollection.arrayItems removeObjectAtIndex:curentindex.row];
        [appDelegate.currentCollection.collectionViewcopy reloadData];
        [self setAlpha:0];                   
    }
}
-(void)select
{
    [self setAlpha:0];
}
@end
