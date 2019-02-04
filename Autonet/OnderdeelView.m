    //
    //  OnderdeelView.m
    //  Autonet
    //
    //  Created by Livecast02 on 19-12-16.
    //  Copyright © 2016 Autonet. All rights reserved.
    //
#import "OnderdeelView.h"
#import "DeelView.h"
#import "UIFont+FlatUI.h"
#import "FieldLabelView.h"
#import "ExtraLabelView.h"
#import "VeldenListView.h"
#import "ImageScrollView.h"
#import "AppDelegate.h"
#import "CameraButton.h"
#import "FileManager.h"
#import "ItemSwitch.h"
#import "OnderdeelButton.h"
@implementation OnderdeelView
@synthesize itemview;
@synthesize veldenArray;
@synthesize indexand;
@synthesize titletopview;
@synthesize parentcell;
@synthesize sizeit;
@synthesize upDownView;
@synthesize contentdict;
@synthesize basepart;
@synthesize imageArray;
@synthesize imageView;
@synthesize itemSwitch;

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
}
-(void)setItemcoursCell:(NSMutableDictionary*)coursCell
{
    sizeit = self.frame.size.height;
    
    AppDelegate *appDelegate = [FileManager getDel];
    UIView *backview =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [backview setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:backview];
    
    titletopview =[[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width-20, 55)];
    [titletopview setFont:[UIFont regularFlatFontOfSize:16]];
    [titletopview setTextColor:[UIColor blackColor]];
    [titletopview setBackgroundColor:[UIColor whiteColor]];
    [titletopview setTextAlignment:NSTextAlignmentLeft];
    [self addSubview:titletopview];
    
    UIButton *click =[[UIButton alloc]initWithFrame:CGRectMake(10, 0, self.frame.size.width-200, 55)];
    [click addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:click];
    if (appDelegate.aanname) {
        
        [appDelegate.viewcontroller.collectionOnderdelenView.aannamelijstView setAlpha:0];
        [appDelegate.viewcontroller.collectionOnderdelenView.voegOnderdeelToe setAlpha:0];
        [appDelegate.viewcontroller.collectionOnderdelenView.catogorieStandaard setAlpha:1];
        [appDelegate.viewcontroller.collectionOnderdelenView.catogorie setAlpha:0];
        
        UILabel *labelvooraard =[[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-210, 10, 200, 40)];
        [labelvooraard setText:[self status:basepart]];
        [labelvooraard setTextAlignment:NSTextAlignmentRight];
        [labelvooraard setTextColor:[UIColor redColor]];
        [self addSubview:labelvooraard];
        
    } else {
        
        [appDelegate.viewcontroller.collectionOnderdelenView.aannamelijstView setAlpha:1];
        [appDelegate.viewcontroller.collectionOnderdelenView.voegOnderdeelToe setAlpha:1];
        [appDelegate.viewcontroller.collectionOnderdelenView.catogorieStandaard setAlpha:0];
        [appDelegate.viewcontroller.collectionOnderdelenView.catogorie setAlpha:1];
        
        itemSwitch =[[ItemSwitch alloc] initWithFrame:CGRectMake(self.frame.size.width-170, 10, 200, 40)];
        [itemSwitch setitems:@"Aanwezig"];
        [self addSubview:itemSwitch];
    }
        //50 × 28 pixels
    upDownView =[[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 12.5, 7)];
    [upDownView setImage:[UIImage imageNamed:@"Up.png"]];
    [self addSubview:upDownView];
}
-(void)selectRemove:(UISwitch*)zender
{
    
}

-(void)setVeldenEmpty:(NSArray*)velden
{
    AppDelegate *appDelegate = [FileManager getDel];
    UILabel *colorlabel =[[UILabel alloc]initWithFrame:CGRectMake(190,10,10,30)];
    [colorlabel setBackgroundColor:[UIColor colorWithRed:0.719543 green:0.000000 blue:1.000000 alpha:0.000000]];
    [self addSubview:colorlabel];
    [colorlabel setTag:1];
    [colorlabel setBackgroundColor:[UIColor colorWithRed:0.439289 green:0.764236 blue:0.506794 alpha:1.000000]];
        ////////////NSLog(@"%@", basepart);
    float Number;
    if ([velden count] % 2)
    {
        
        Number =(([velden count]+1)*55)/2;
        
    } else {
        
        Number =((([velden count])*55)/2);
    }
    sizeit = self.frame.size.height;
    
    UIView *backview =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [backview setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:backview];
    
    UIView *conteswitch =[[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width-200, (((760+Number)-10)-120), 180, 120)];
    [conteswitch setBackgroundColor:[UIColor clearColor]];
    [self addSubview:conteswitch];
    [conteswitch.layer setBorderWidth:2];
    [conteswitch.layer  setBorderColor:[UIColor lightGrayColor].CGColor];
    
    UILabel *internet =[[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 50)];
    [internet setFont:[UIFont regularFlatFontOfSize:16]];
    [internet setTextColor:[UIColor blackColor]];
    [internet setText:@"Op internet"];
    [internet setBackgroundColor:[UIColor clearColor]];
    [internet setTextAlignment:NSTextAlignmentLeft];
    [conteswitch addSubview:internet];
    
    UISwitch *UISwitchOne =[[UISwitch alloc] initWithFrame:CGRectMake(120, 10, 60, 40)];
    [UISwitchOne addTarget:self action:@selector(moveOnintenet:) forControlEvents:(UIControlEventValueChanged | UIControlEventTouchDragInside)];
    [conteswitch addSubview:UISwitchOne];
    [UISwitchOne setOnTintColor:[UIColor greenColor]];
    UISwitchOne.backgroundColor = [UIColor redColor];
    UISwitchOne.layer.cornerRadius = 16.0;
    [UISwitchOne setOn:[[basepart valueForKey:@"internetOol"] boolValue]];
    UISwitchOne.transform = CGAffineTransformMakeScale(0.8, 0.8);
    
    UILabel *Gedemonteerd =[[UILabel alloc] initWithFrame:CGRectMake(15, 35, 110, 50)];
    [Gedemonteerd setFont:[UIFont regularFlatFontOfSize:16]];
    [Gedemonteerd setTextColor:[UIColor blackColor]];
    [Gedemonteerd setText:@"Aan auto"];
    [Gedemonteerd setBackgroundColor:[UIColor clearColor]];
    [Gedemonteerd setTextAlignment:NSTextAlignmentLeft];
    [conteswitch addSubview:Gedemonteerd];
    
    UISwitch *UISwitchGedemonteerd =[[UISwitch alloc] initWithFrame:CGRectMake(120, 45, 60, 40)];
    [UISwitchGedemonteerd addTarget:self action:@selector(moveOnauto:) forControlEvents:(UIControlEventValueChanged | UIControlEventTouchDragInside)];
    [UISwitchGedemonteerd setOnTintColor:[UIColor greenColor]];
    UISwitchGedemonteerd.backgroundColor = [UIColor redColor];
    UISwitchGedemonteerd.layer.cornerRadius = 16.0;
    [UISwitchGedemonteerd setOn:[[basepart valueForKey:@"isAanAuto"] boolValue]];
    UISwitchGedemonteerd.transform = CGAffineTransformMakeScale(0.8, 0.8);
    [conteswitch addSubview:UISwitchGedemonteerd];
    
    UILabel *Afgemonteerd =[[UILabel alloc] initWithFrame:CGRectMake(15, 70, 110, 50)];
    [Afgemonteerd setFont:[UIFont regularFlatFontOfSize:16]];
    [Afgemonteerd setTextColor:[UIColor blackColor]];
    [Afgemonteerd setText:@"Demonteren"];
    [Afgemonteerd setBackgroundColor:[UIColor clearColor]];
    [Afgemonteerd setTextAlignment:NSTextAlignmentLeft];
    [conteswitch addSubview:Afgemonteerd];
    
    UISwitch *UISwitchAfgemonteerd =[[UISwitch alloc] initWithFrame:CGRectMake(120, 80, 60, 40)];
    [UISwitchAfgemonteerd addTarget:self action:@selector(moveAfgemonteerd:) forControlEvents:(UIControlEventValueChanged | UIControlEventTouchDragInside)];
    [conteswitch addSubview:UISwitchAfgemonteerd];
    [UISwitchAfgemonteerd setOnTintColor:[UIColor greenColor]];
    UISwitchAfgemonteerd.backgroundColor = [UIColor redColor];
    UISwitchAfgemonteerd.layer.cornerRadius = 16.0;
    [UISwitchAfgemonteerd setOn:[[basepart valueForKey:@"Demonteren"] boolValue]];
    UISwitchAfgemonteerd.transform = CGAffineTransformMakeScale(0.8, 0.8);
    
    CameraButton *camera =[[CameraButton alloc]initWithFrame:CGRectMake(10,((760+Number)-10)-120, 40, 40)];
    [camera addTarget:appDelegate.viewcontroller action:@selector(CameraAction407:) forControlEvents:UIControlEventTouchUpInside];
    [camera setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [camera setBackgroundColor:[UIColor whiteColor]];
    [camera.layer setBorderWidth:2];
    [camera.layer  setBorderColor:[UIColor grayColor].CGColor];
    [camera setItembig:[UIColor grayColor] setImage:@"camer.png"];
    camera.currentOnderdeel =self;
    [self addSubview:camera];
    
    imageArray =[[[FileManager getFotos_onderdelen:[contentdict valueForKey:@"DeelId"]] firstObject] valueForKey:@"FotosInfo"];
    
    imageView =[[ImageScrollView alloc] initWithFrame:CGRectMake(60, ((760+Number)-10)-120, self.frame.size.width-300, 120)];
    [imageView setBackgroundColor:[UIColor whiteColor]];
    [imageView.layer setBorderWidth:2];
    [imageView.layer  setBorderColor:[UIColor lightGrayColor].CGColor];
    [imageView.imageView setHeader:@"sub"];
    if ([imageArray count]>0) {
        [imageView setimages:[imageArray valueForKey:@"Orgnaam"] setOnline:[imageArray valueForKey:@"Internet"]];
    } else {
        [imageView setimages: [[NSMutableArray alloc] init] setOnline: [[NSMutableArray alloc] init]];
    }
    [self addSubview:imageView];
    
    
    camera.currentCollection =imageView.imageView;
    camera.currentOnderdeel = self;
    
    titletopview =[[UILabel alloc] initWithFrame:CGRectMake(30, 0, self.frame.size.width-20, 55)];
    [titletopview setFont:[UIFont regularFlatFontOfSize:16]];
    [titletopview setTextColor:[UIColor blackColor]];
    [titletopview setBackgroundColor:[UIColor whiteColor]];
    [titletopview setTextAlignment:NSTextAlignmentLeft];
    [self addSubview:titletopview];
    
    OnderdeelButton *info =[[OnderdeelButton alloc]initWithFrame:CGRectMake(self.frame.size.width-50, 10, 30, 30)];
    [info setImage:[UIImage imageNamed:@"info.png"] forState:UIControlStateNormal];
    [info addTarget:self action:@selector(statisteken:) forControlEvents:UIControlEventTouchUpInside];
    [info setPart:basepart];
    [self addSubview:info];
    
    
    UIButton *click =[[UIButton alloc]initWithFrame:CGRectMake(10, 0, self.frame.size.width-220, 55)];
    [click setBackgroundColor:[UIColor clearColor]];
    [click addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:click];
    
    upDownView =[[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 12.5, 7)];
    [upDownView setImage:[UIImage imageNamed:@"Down.png"]];
    [self addSubview:upDownView];
    
    if ([velden count]>0) {
        
        for (int i=0; i<[velden count]; i++) {
            
            FieldLabelView *labelview =[[FieldLabelView alloc] init];
            [labelview setBackgroundColor:[UIColor clearColor]];
            [labelview setTag:105+i];
            [labelview setParantView:self];
            [labelview setItemVeld:[velden objectAtIndex:i]];
            [labelview setVeldID:[[[velden objectAtIndex:i] valueForKey:@"VeldId"] integerValue]];
            
            if (i % 2) {
                [labelview setFrame:CGRectMake(10+((self.frame.size.width-20)/2), 55+(55*((i-1)/2)), (self.frame.size.width-20)/2, 55)];
                
                
            }
            else {
                
                [labelview setFrame:CGRectMake(10, 55+(55*(i/2)), (self.frame.size.width-20)/2, 55)];
                
            }
            
            [self addSubview:labelview];
        }
        
        
    }
    UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(10,65+((55*([velden count]+1)/2)),920,1)];
    [title setBackgroundColor:[UIColor colorWithRed:0.897069 green:0.897069 blue:0.897069 alpha:1.000000]];
    [title setTextAlignment:NSTextAlignmentRight];
    [title setTag:1];
    [self addSubview:title];
    
    float begin =65+(55*([velden count]/2))+60;
    NSArray *ExtraOnderdelen =[[NSArray alloc] initWithObjects:@"GarantieMaanden", @"GarantieToelichting",@"EigenOmschrijving", @"TestToelichting", @"Bijzonderheid",@"Bijzonderheid2", @"BijzonderheidInternet",@"Artikelnummers", nil];
    for (int i=0; i<[ExtraOnderdelen count]; i++) {
        
            ////////////NSLog(@"2 TestStatusId");
        
        ExtraLabelView *labelview =[[ExtraLabelView alloc] init];
        [labelview setTag:105+i];
        
        if (i % 2)
        {
            if ([[ExtraOnderdelen objectAtIndex:i] isEqualToString:@"GarantieMaanden"]||[[ExtraOnderdelen objectAtIndex:i] isEqualToString:@"GarantieToelichting"]) {
                [labelview setFrame:CGRectMake(10+((self.frame.size.width-20)/2), (begin-50)+55+(55*((i-1)/2)), (self.frame.size.width-20)/2, 55)];
            } else {
                [labelview setFrame:CGRectMake(10+((self.frame.size.width-20)/2), begin+(110*((i-1)/2)), (self.frame.size.width-20)/2, 110)];
            }
        }
        else
        {
            if ([[ExtraOnderdelen objectAtIndex:i] isEqualToString:@"GarantieMaanden"]||[[ExtraOnderdelen objectAtIndex:i] isEqualToString:@"GarantieToelichting"]) {
                [labelview setFrame:CGRectMake(10, (begin-50)+55+(55*(i/2)), (self.frame.size.width-20)/2, 55)];
            }            else if ([[ExtraOnderdelen objectAtIndex:i] isEqualToString:@"Artikelnummers"]) {
                [labelview setFrame:CGRectMake(10, begin+(110*(i/2)), (self.frame.size.width-20)/2, 110)];
                [labelview setTag:888];
            }            else {
                [labelview setFrame:CGRectMake(10, begin+(110*(i/2)), (self.frame.size.width-20)/2, 110)];
            }
        }
        [labelview setBackgroundColor:[UIColor clearColor]];
        [labelview setParantView:self];
        [labelview setItemExtras:[ExtraOnderdelen objectAtIndex:i]];
        [self addSubview:labelview];
    }
    
    FieldLabelView *copy =  [self.subviews lastObject];
    FieldLabelView *labelview =[[FieldLabelView alloc] initWithFrame:CGRectMake(10, ((copy.frame.origin.y+295)-10)-125,200, 50)];
    [labelview setBackgroundColor:[UIColor clearColor]];
    [labelview setParantView:self];
    [labelview setPrijs:@"Prijs"];
    [self addSubview:labelview];
    
    
    CameraButton *price =[[CameraButton alloc]initWithFrame:CGRectMake(420,((copy.frame.origin.y+295)-6)-175, 40, 40)];
    [price addTarget:appDelegate.viewcontroller action:@selector(PrijsAction:) forControlEvents:UIControlEventTouchUpInside];
    [price setBackgroundColor:[UIColor whiteColor]];
    [price.layer setBorderWidth:2];
    [price.layer  setBorderColor:[UIColor grayColor].CGColor];
    [price setItembig:[UIColor grayColor] setImage:@"euro.png"];
    [self addSubview:price];
    
    UILabel *Statusview =[[UILabel alloc] initWithFrame:CGRectMake(620, ((copy.frame.origin.y+295)-100)-175,400, 50)];
    [Statusview setBackgroundColor:[UIColor clearColor]];
    [Statusview setText:[self status:basepart]];
    [self addSubview:Statusview];
    
    CameraButton *Nummers =[[CameraButton alloc]initWithFrame:CGRectMake(620,((760+Number)-6)-280, 40, 40)];
    [Nummers addTarget:appDelegate.viewcontroller action:@selector(MemoAction:) forControlEvents:UIControlEventTouchUpInside];
    [Nummers setBackgroundColor:[UIColor whiteColor]];
    [Nummers.layer setBorderWidth:2];
    [Nummers.layer  setBorderColor:[UIColor grayColor].CGColor];
    [Nummers setCurrentOnderdeel:self];
    [Nummers setItembig:[UIColor grayColor] setImage:@"verkoop.png"];
    [self addSubview:Nummers];
    
    
}
-(NSString*)status:(NSDictionary*)deel
{
    NSString *returnstring;
    if ([[deel valueForKey:@"isPrullenbak"] boolValue]) {
        
        
        returnstring = @" Status: In Prullenbak";
    } else {
        if ([[deel valueForKey:@"isInVoorraad"] boolValue]) {
            
            returnstring = @" Status: In voorraad";
        }
        else if ([[deel valueForKey:@"isVerkocht"] boolValue]) {
            
            returnstring = @" Status: Is verkocht";
        }
        else if ([[deel valueForKey:@"isVermist"] boolValue]) {
            
            returnstring = @" Status: Is vermist";
        }
        else
        {
            
            returnstring = @" Status: Aangemaakt";
        }
    }
    return returnstring;
}
-(void)moveOnauto:(UISwitch*)sender
{
    if (sender.isOn) {
        [basepart setObject:[NSNumber numberWithBool:YES] forKeyedSubscript:@"isAanAuto"];
    } else {
        [basepart setObject:[NSNumber numberWithBool:NO] forKeyedSubscript:@"isAanAuto"];
    }
        // [basepart setObject:@"" forKeyedSubscript:@"internetOol"];
    [FileManager insertnew:basepart];
}
-(void)moveAfgemonteerd:(UISwitch*)sender
{
    if (sender.isOn) {
        [basepart setObject:[NSNumber numberWithBool:YES] forKeyedSubscript:@"Demonteren"];
    } else {
        [basepart setObject:[NSNumber numberWithBool:NO] forKeyedSubscript:@"Demonteren"];
    }
        // [basepart setObject:@"" forKeyedSubscript:@"internetOol"];
    [FileManager insertnew:basepart];
}
-(void)moveOnintenet:(UISwitch*)sender
{
    if (sender.isOn) {
        [basepart setObject:[NSNumber numberWithBool:YES] forKeyedSubscript:@"internetOol"];
    } else {
        [basepart setObject:[NSNumber numberWithBool:NO] forKeyedSubscript:@"internetOol"];
    }
        //[basepart setObject:@"" forKeyedSubscript:@"internetOol"];
    [FileManager insertnew:basepart];
}
-(void)selectAritkel
{
    AppDelegate *appDelegate = [FileManager getDel];
    [appDelegate.viewcontroller.maakartikel select:basepart];
}
-(void)setVelden:(NSArray*)velden
{
    AppDelegate *appDelegate = [FileManager getDel];
    UILabel *colorlabel =[[UILabel alloc]initWithFrame:CGRectMake(190,10,10,30)];
    [colorlabel setBackgroundColor:[UIColor colorWithRed:0.719543 green:0.000000 blue:1.000000 alpha:0.000000]];
    [self addSubview:colorlabel];
    [colorlabel setTag:1];
    [colorlabel setBackgroundColor:[UIColor colorWithRed:0.439289 green:0.764236 blue:0.506794 alpha:1.000000]];
    
    
    
    float Number;
    if ([velden count] % 2)
    {
        
        Number =(([velden count]+1)*55)/2;
        
    } else {
        
        Number =((([velden count])*55)/2);
    }
    UIView *backview =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [backview setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:backview];
    
    
    sizeit = self.frame.size.height;
    
    UIView *conteswitch =[[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width-200, (((760+Number)-10)-120), 180, 120)];
    [conteswitch setBackgroundColor:[UIColor clearColor]];
    [conteswitch.layer setBorderWidth:2];
    [conteswitch.layer  setBorderColor:[UIColor lightGrayColor].CGColor];
    [self addSubview:conteswitch];
    
    UILabel *internet =[[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 50)];
    [internet setFont:[UIFont regularFlatFontOfSize:16]];
    [internet setTextColor:[UIColor blackColor]];
    [internet setText:@"Op internet"];
    [internet setBackgroundColor:[UIColor clearColor]];
    [internet setTextAlignment:NSTextAlignmentLeft];
    [conteswitch addSubview:internet];
    
    UISwitch *UISwitchOne =[[UISwitch alloc] initWithFrame:CGRectMake(120, 10, 60, 40)];
    [UISwitchOne setOnTintColor:[UIColor greenColor]];
    UISwitchOne.backgroundColor = [UIColor redColor];
    UISwitchOne.layer.cornerRadius = 16.0;
    [UISwitchOne setOn:[[basepart valueForKey:@"internetOol"] boolValue]];
    UISwitchOne.transform = CGAffineTransformMakeScale(0.8, 0.8);
    [UISwitchOne addTarget:self action:@selector(moveOnintenet:) forControlEvents:(UIControlEventValueChanged | UIControlEventTouchDragInside)];
    [conteswitch addSubview:UISwitchOne];
    
    UILabel *Gedemonteerd =[[UILabel alloc] initWithFrame:CGRectMake(15, 35, 110, 50)];
    [Gedemonteerd setFont:[UIFont regularFlatFontOfSize:16]];
    [Gedemonteerd setTextColor:[UIColor blackColor]];
    [Gedemonteerd setText:@"Aan auto"];
    [Gedemonteerd setBackgroundColor:[UIColor clearColor]];
    [Gedemonteerd setTextAlignment:NSTextAlignmentLeft];
    [conteswitch addSubview:Gedemonteerd];
    
    UISwitch *UISwitchGedemonteerd =[[UISwitch alloc] initWithFrame:CGRectMake(120, 45, 60, 40)];
    [UISwitchGedemonteerd addTarget:self action:@selector(moveOnauto:) forControlEvents:(UIControlEventValueChanged | UIControlEventTouchDragInside)];
    [UISwitchGedemonteerd setOnTintColor:[UIColor greenColor]];
    UISwitchGedemonteerd.backgroundColor = [UIColor redColor];
    UISwitchGedemonteerd.layer.cornerRadius = 16.0;
    [UISwitchGedemonteerd setOn:[[basepart valueForKey:@"isAanAuto"] boolValue]];
    UISwitchGedemonteerd.transform = CGAffineTransformMakeScale(0.8, 0.8);
    [conteswitch addSubview:UISwitchGedemonteerd];
    
    UILabel *Afgemonteerd =[[UILabel alloc] initWithFrame:CGRectMake(15, 70, 110, 50)];
    [Afgemonteerd setFont:[UIFont regularFlatFontOfSize:16]];
    [Afgemonteerd setTextColor:[UIColor blackColor]];
    [Afgemonteerd setText:@"Demonteren"];
    [Afgemonteerd setBackgroundColor:[UIColor clearColor]];
    [Afgemonteerd setTextAlignment:NSTextAlignmentLeft];
    [conteswitch addSubview:Afgemonteerd];
    
    UISwitch *UISwitchAfgemonteerd =[[UISwitch alloc] initWithFrame:CGRectMake(120, 80, 60, 40)];
    [UISwitchAfgemonteerd addTarget:self action:@selector(moveAfgemonteerd:) forControlEvents:(UIControlEventValueChanged | UIControlEventTouchDragInside)];
    [conteswitch addSubview:UISwitchAfgemonteerd];
    UISwitchAfgemonteerd.backgroundColor = [UIColor redColor];
    UISwitchAfgemonteerd.layer.cornerRadius = 16.0;
    [UISwitchAfgemonteerd setOn:[[basepart valueForKey:@"Demonteren"] boolValue]];
    UISwitchAfgemonteerd.transform = CGAffineTransformMakeScale(0.8, 0.8);
    [UISwitchAfgemonteerd setOnTintColor:[UIColor greenColor]];
    
    CameraButton *camera =[[CameraButton alloc]initWithFrame:CGRectMake(10,((760+Number)-10)-120, 40, 40)];
    [camera addTarget:appDelegate.viewcontroller action:@selector(CameraAction407:) forControlEvents:UIControlEventTouchUpInside];
    [camera setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [camera setBackgroundColor:[UIColor whiteColor]];
    [camera.layer setBorderWidth:2];
    [camera.layer  setBorderColor:[UIColor grayColor].CGColor];
    [camera setItembig:[UIColor grayColor] setImage:@"camer.png"];
    camera.currentOnderdeel =self;
    [self addSubview:camera];
    
    imageArray =[[[FileManager getFotos_onderdelen:[contentdict valueForKey:@"DeelId"]] firstObject] valueForKey:@"FotosInfo"];
    imageView =[[ImageScrollView alloc] initWithFrame:CGRectMake(60, ((760+Number)-10)-120, self.frame.size.width-300, 120)];
    [imageView setBackgroundColor:[UIColor whiteColor]];
    [imageView.layer setBorderWidth:2];
    [imageView.imageView setHeader:@"sub"];
    if ([imageArray count]>0) {
        [imageView setimages:[imageArray valueForKey:@"Orgnaam"] setOnline:[imageArray valueForKey:@"Internet"]];
    } else {
        [imageView setimages: [[NSMutableArray alloc] init] setOnline: [[NSMutableArray alloc] init]];
    }
    [imageView.layer  setBorderColor:[UIColor lightGrayColor].CGColor];
    [self addSubview:imageView];
    
    sizeit = self.frame.size.height;
    camera.currentCollection =imageView.imageView;
    camera.currentOnderdeel =self;
    
    titletopview =[[UILabel alloc] initWithFrame:CGRectMake(30, 0, self.frame.size.width-20, 55)];
    [titletopview setFont:[UIFont regularFlatFontOfSize:16]];
    [titletopview setTextColor:[UIColor blackColor]];
    [titletopview setBackgroundColor:[UIColor whiteColor]];
    [titletopview setTextAlignment:NSTextAlignmentLeft];
    [self addSubview:titletopview];
    
    OnderdeelButton *info =[[OnderdeelButton alloc]initWithFrame:CGRectMake(self.frame.size.width-50, 10, 30, 30)];
    [info setImage:[UIImage imageNamed:@"info.png"] forState:UIControlStateNormal];
    [info addTarget:self action:@selector(statisteken:) forControlEvents:UIControlEventTouchUpInside];
    [info setPart:basepart];
    [self addSubview:info];
    
    UIButton *click =[[UIButton alloc]initWithFrame:CGRectMake(10, 0, self.frame.size.width-220, 55)];
    [click setBackgroundColor:[UIColor clearColor]];
    [click addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:click];
    
    upDownView =[[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 12.5, 7)];
    [upDownView setImage:[UIImage imageNamed:@"Down.png"]];
    [self addSubview:upDownView];
    
    if ([velden count]>0) {
        
        for (int i=0; i<[velden count]; i++) {
            
            
            FieldLabelView *labelview =[[FieldLabelView alloc] init];
            labelview.limit = [[[velden objectAtIndex:i] valueForKey:@"LengteMax"] intValue];
            
            if ( labelview.limit==0) {
                
                labelview.limit = 500;
            }
            
                ////////////NSLog(@"%li",  (long)labelview.limit);
            
            if (i % 2){
                [labelview setFrame:CGRectMake(10+((self.frame.size.width-20)/2), 55+(55*((i-1)/2)), (self.frame.size.width-20)/2, 55)];
                
            }            else {
                [labelview setFrame:CGRectMake(10, 55+(55*(i/2)), (self.frame.size.width-20)/2, 55)];
            }
            [labelview setBackgroundColor:[UIColor clearColor]];
            [labelview setTag:105+i];
            [labelview setParantView:self];
            [labelview setItemVeld:[velden objectAtIndex:i]];
            [labelview setVeldID:[[[velden objectAtIndex:i] valueForKey:@"VeldId"] integerValue]];
            [self addSubview:labelview];
            
        }
    }
    
    UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(10,65+((55*([velden count]+1)/2)),920,1)];
    [title setBackgroundColor:[UIColor colorWithRed:0.897069 green:0.897069 blue:0.897069 alpha:1.000000]];
    [title setTextAlignment:NSTextAlignmentRight];
    [title setTag:1];
    [self addSubview:title];
    
    float begin =65+(55*([velden count]/2))+60;
    NSArray *ExtraOnderdelen =[[NSArray alloc] initWithObjects:@"GarantieMaanden", @"GarantieToelichting", @"EigenOmschrijving", @"TestToelichting", @"Bijzonderheid",@"Bijzonderheid2", @"BijzonderheidInternet",@"Artikelnummers", nil];
    for (int i=0; i<[ExtraOnderdelen count]; i++) {
        
        
        
        ExtraLabelView *labelview =[[ExtraLabelView alloc] init];
        labelview.limit = 500+i;
        [labelview setTag:105+i];
        
        if (i % 2)
        {
            
            if ([[ExtraOnderdelen objectAtIndex:i] isEqualToString:@"GarantieMaanden"]||[[ExtraOnderdelen objectAtIndex:i] isEqualToString:@"GarantieToelichting"]) {
                [labelview setFrame:CGRectMake(10+((self.frame.size.width-20)/2), (begin-50)+55+(55*((i-1)/2)), (self.frame.size.width-20)/2, 55)];
            }
            else if ([[ExtraOnderdelen objectAtIndex:i] isEqualToString:@"Artikelnummers"]) {
                [labelview setFrame:CGRectMake(10+((self.frame.size.width-20)/2), begin+(110*((i-1)/2)), (self.frame.size.width-20)/2, 110)];
                [labelview setTag:888];
            }
            else if ([[ExtraOnderdelen objectAtIndex:i] isEqualToString:@"TestToelichting"]) {
                
                [labelview setFrame:CGRectMake(10+((self.frame.size.width-20)/2), (begin-50)+55+(55*((i-1)/2)), (self.frame.size.width-20)/2, 165)];
            }
            else {
                [labelview setFrame:CGRectMake(10+((self.frame.size.width-20)/2), begin+(110*((i-1)/2)), (self.frame.size.width-20)/2, 110)];
                [labelview setTag:105+i];
            }
        }
        else
        {
            if ([[ExtraOnderdelen objectAtIndex:i] isEqualToString:@"GarantieMaanden"]||[[ExtraOnderdelen objectAtIndex:i] isEqualToString:@"GarantieToelichting"]) {
                [labelview setFrame:CGRectMake(10, (begin-50)+55+(55*(i/2)), (self.frame.size.width-20)/2, 55)];
                [labelview setTag:105+i];
            }
            else if ([[ExtraOnderdelen objectAtIndex:i] isEqualToString:@"Artikelnummers"]) {
                [labelview setFrame:CGRectMake(10, begin+(110*(i/2)), (self.frame.size.width-20)/2, 110)];
                [labelview setTag:888];
            }
            else {
                
                if ([[ExtraOnderdelen objectAtIndex:i] isEqualToString:@"EigenOmschrijving"]) {
                    
                    NSMutableDictionary *veldenCopy = [[NSMutableDictionary alloc] init];
                    [veldenCopy setObject:@"Test resultaten" forKey:@"InternetOmschrijving"];
                    [veldenCopy setObject:[NSNumber numberWithInteger:0] forKey:@"VeldId"];
                    [veldenCopy setObject: [FileManager getTeststatussen] forKey:@"VeldWaarden"];
                    
                    FieldLabelView *labelTestToelichting =[[FieldLabelView alloc] initWithFrame:CGRectMake(10, (begin-50)+55+(55*(i/2)), (self.frame.size.width-20)/2, 55)];
                    labelTestToelichting.limit = 500;
                    
                    [labelTestToelichting setBackgroundColor:[UIColor clearColor]];
                    [labelTestToelichting setTag:1000+i];
                    [labelTestToelichting setParantView:self];
                    [labelTestToelichting setItemVeld:veldenCopy];
                    [labelTestToelichting setVeldID:[[veldenCopy valueForKey:@"VeldId"] integerValue]];
                    [self addSubview:labelTestToelichting];
                    
                    if ([[basepart valueForKey:@"TestStatusId"] isKindOfClass:[NSString class]]) {
                    }
                    else
                    {
                        
                        if ([[basepart valueForKey:@"TestStatusId"] integerValue] >0) {
                            
                            
                            ItemListView* copylist = [[[self.subviews lastObject] subviews] lastObject];
                            
                            [copylist.search.titleView setText:[[[FileManager getTeststatussenOnID:[[basepart valueForKey:@"TestStatusId"] integerValue]] firstObject] valueForKey:@"Waarde"]];
                            
                        }
                    }
                }
                else
                {
                }
                
                [labelview setFrame:CGRectMake(10, begin+(110*(i/2)), (self.frame.size.width-20)/2, 110)];
                [labelview setTag:105+i];
                
                
                
            }
        }
        [labelview setBackgroundColor:[UIColor clearColor]];
        [self addSubview:labelview];
        [labelview setParantView:self];
        [labelview setItemExtras:[ExtraOnderdelen objectAtIndex:i]];
    }
    
    FieldLabelView *copy =  [self.subviews lastObject];
    
    FieldLabelView *labelviewPrijs =[[FieldLabelView alloc] initWithFrame:CGRectMake(10, ((copy.frame.origin.y+295)-10)-175,200, 50)];
    [labelviewPrijs setBackgroundColor:[UIColor clearColor]];
    [labelviewPrijs setParantView:self];
    [labelviewPrijs setPrijs:@"Prijs"];
    [self addSubview:labelviewPrijs];
    
    CameraButton *price =[[CameraButton alloc]initWithFrame:CGRectMake(420,((copy.frame.origin.y+295)-6)-175, 40, 40)];
    [price addTarget:appDelegate.viewcontroller action:@selector(PrijsAction:) forControlEvents:UIControlEventTouchUpInside];
    [price setBackgroundColor:[UIColor whiteColor]];
    [price.layer setBorderWidth:2];
    [price.layer  setBorderColor:[UIColor grayColor].CGColor];
    [price setItembig:[UIColor grayColor] setImage:@"euro.png"];
    [self addSubview:price];
    
    UILabel *Statusview =[[UILabel alloc] initWithFrame:CGRectMake(620, ((copy.frame.origin.y+295)-10)-175,200, 50)];
    [Statusview setBackgroundColor:[UIColor clearColor]];
    [Statusview setText:[self status:basepart]];
    [self addSubview:Statusview];
    
    CameraButton *Nummers =[[CameraButton alloc]initWithFrame:CGRectMake(620,((760+Number)-6)-280, 40, 40)];
    [Nummers addTarget:appDelegate.viewcontroller action:@selector(MemoAction:) forControlEvents:UIControlEventTouchUpInside];
    [Nummers setBackgroundColor:[UIColor whiteColor]];
    [Nummers.layer setBorderWidth:2];
    [Nummers.layer  setBorderColor:[UIColor grayColor].CGColor];
    [Nummers setCurrentOnderdeel:self];
    [Nummers setItembig:[UIColor grayColor] setImage:@"verkoop.png"];
    [self addSubview:Nummers];
    
}
-(void)statisteken:(OnderdeelButton*)sender
{
    AppDelegate *appDelegate = [FileManager getDel];
    [appDelegate.viewcontroller.statistiekView setAlpha:1];
    
}
-(void)select:(UIButton*)set
{
    
    AppDelegate *appDelegate = [FileManager getDel];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Verplicht LIKE [cd]'YES'"];
    NSMutableArray *test =  [[appDelegate.onderdelenVoertuigArray filteredArrayUsingPredicate:predicate] mutableCopy];
    
    for (int k=0 ; k<[test count]; k++) {
        NSMutableDictionary *contentFound = [test objectAtIndex:k];
        NSInteger index = [appDelegate.onderdelenVoertuigArray indexOfObject:contentFound];
        [contentFound setValue:@"NO" forKey:@"Verplicht"];
        [appDelegate.onderdelenVoertuigArray replaceObjectAtIndex:index withObject:contentFound];
    }
    if (self.frame.size.height==55) {
        [contentdict setValue:@"YES" forKey:@"Verplicht"];
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, sizeit+55)];
        [self.parentcell setFrame:CGRectMake(self.parentcell.frame.origin.x, self.parentcell.frame.origin.y, self.parentcell.frame.size.width, sizeit+65)];
        [upDownView setImage:[UIImage imageNamed:@"Down.png"]];
    } else {
        [FileManager getOnderdelenAndWrite:self.basepart];
        [contentdict setValue:@"NO" forKey:@"Verplicht"];
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 55)];
        [self.parentcell setFrame:CGRectMake(self.parentcell.frame.origin.x, self.parentcell.frame.origin.y, self.parentcell.frame.size.width, 65)];
        [upDownView setImage:[UIImage imageNamed:@"Up.png"]];
    }
    
    appDelegate.indexand =self.indexand;
    [appDelegate.onderdelenVoertuigArray replaceObjectAtIndex:indexand.row withObject:contentdict];
    [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
    [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy selectItemAtIndexPath:appDelegate.indexand animated:NO scrollPosition:UICollectionViewScrollPositionTop];
    
}

@end
