    //
    //  LineButton.m
    //  Autonet
    //
    //  Created by Livecast02 on 10-12-16.
    //  Copyright © 2016 Autonet. All rights reserved.
    //
#import "ItemListView.h"
#import "AppDelegate.h"
#import "FileManager.h"
#import "ImageButton.h"
#import "LabelButton.h"
#import "AppDelegate.h"
#import "FileManager.h"
#import "UIFont+FlatUI.h"
#import "CarView.h"
@implementation ItemListView
@synthesize AllLines;
@synthesize baseColor;
@synthesize contraColor;
@synthesize AlleVoertuigen;
@synthesize tableResult;
@synthesize search;
@synthesize AllVelden;
@synthesize asY;
@synthesize VeldId;
@synthesize AllVelden_voertuig;
@synthesize Veld;
@synthesize Parentview;
@synthesize Parentlabel;
@synthesize onderdeelview;
@synthesize Airbag;
@synthesize Gordels;
@synthesize Opties;
@synthesize Schades;
@synthesize AllVeldenActive;
@synthesize Veldname;
@synthesize currentDictonary;
-(void)setItemExtraVelden:(NSArray*)velden
{
    AllVelden = [velden mutableCopy];
    NSMutableDictionary *go =[NSMutableDictionary dictionaryWithObjectsAndKeys:[velden valueForKey:@"Naam" ], @"WaardeLang",@"Ja", @"Waarde", nil];
    [AllVelden addObject:go];
    NSMutableDictionary *go2 =[NSMutableDictionary dictionaryWithObjectsAndKeys:[velden valueForKey:@"Naam" ], @"WaardeLang",@"Nee", @"Waarde", nil];
    [AllVelden addObject:go2];
    search =[[ImageButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,40)];
    [search addTarget:self action:@selector(movelist:) forControlEvents:UIControlEventTouchUpInside];
    [search.titleView setText:@"-onbekend-"];
    [search.titleLabel setFont:[UIFont regularFlatFontOfSize:14]];
    [search.titleLabel setNumberOfLines:2];
    [search setBackgroundColor:[UIColor clearColor]];
    [search setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [search setTag:100];
    [search.layer setCornerRadius:4];
    [self addSubview:search];
    [self.layer setCornerRadius:6];
    [self.layer setMasksToBounds:YES];
    [search setlabel];
    [search.titleView setText:@""];
    tableResult =[[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.frame.size.width,self.frame.size.height-40)];
    [tableResult setRowHeight:80];
    [tableResult setDelegate:self];
    [tableResult setDataSource:self];
    [tableResult setBackgroundColor:baseColor];
    [tableResult setAlwaysBounceHorizontal:NO];
    [self addSubview:tableResult];
    [tableResult.layer setCornerRadius:6];
    [tableResult.layer setMasksToBounds:YES];
    AllVeldenActive =[[NSMutableArray alloc] initWithArray:AllVelden];
}
-(void)setItemYESNOAirbag:(NSArray*)velden aanwezig:(NSMutableDictionary*)value
{
    Airbag = value;
    AllVelden =[[NSMutableArray alloc] init];
    for (int k =0; k < [velden count]; k++) {
        NSMutableDictionary *go =[NSMutableDictionary dictionaryWithObjectsAndKeys:[velden objectAtIndex:k], @"WaardeLang",[NSString stringWithFormat:@"%d", k], @"Waarde", nil];
        [AllVelden addObject:go];
    }
    AllVeldenActive =[[NSMutableArray alloc] initWithArray:AllVelden];
    NSString *querydouble = [NSString stringWithFormat:@"(Waarde LIKE [cd]'%@')", [value valueForKey:@"Aanwezig"]];
    NSPredicate *predicatedouble = [NSPredicate predicateWithFormat:querydouble];
    NSMutableArray *items2 = [[AllVelden filteredArrayUsingPredicate:predicatedouble] mutableCopy];
    search =[[ImageButton alloc]initWithFrame:CGRectMake(60, 0, self.frame.size.width-60,40)];
        //[search addTarget:self action:@selector(move:) forControlEvents:UIControlEventTouchUpInside];
    [search.titleView setText:@""];
    [search.titleLabel setFont:[UIFont regularFlatFontOfSize:14]];
    [search.titleLabel setNumberOfLines:2];
    [search setBackgroundColor:[UIColor clearColor]];
    [search setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [search setTag:100];
    [search.layer setCornerRadius:4];
    [self addSubview:search];
    
    [self.layer setCornerRadius:6];
    [self.layer setMasksToBounds:YES];
    [search setlabel];
    [search.upDownView setAlpha:0];
    [search.titleView setText:[[items2 firstObject] valueForKey:@"WaardeLang"]];
    UISwitch *UISwitchOne =[[UISwitch alloc] initWithFrame:CGRectMake(6, 4, 60, 40)];
    [UISwitchOne addTarget:self action:@selector(moveSwitch:) forControlEvents:(UIControlEventValueChanged | UIControlEventTouchDragInside)];
    [UISwitchOne setOnTintColor:[UIColor greenColor]];
    UISwitchOne.backgroundColor = [UIColor redColor];
    UISwitchOne.layer.cornerRadius = 16.0;
    [self addSubview:UISwitchOne];
    UISwitchOne.transform = CGAffineTransformMakeScale(0.8, 0.8);
    if (![[value valueForKey:@"Aanwezig"] boolValue]) {
        [search setBackgroundColor:[UIColor whiteColor]];
        [search.titleView setText:@"Afwezig"];
    } else {
        if ([[value valueForKey:@"Geactiveerd"] boolValue])
        {
            [search.titleView setText:@"Aanwezig/Geactiveerd"];
            [UISwitchOne setOn:YES];
            [search setBackgroundColor:[UIColor redColor]];
        }
        else
        {
            [search.titleView setText:@"Aanwezig/Ongeactiveerd"];
            [UISwitchOne setOn:NO];
            [search setBackgroundColor:[UIColor greenColor]];
        }
    }
}
-(void)moveSwitch:(UISwitch*)sender
{
    if (Gordels) {
        if (sender.isOn) {
            [Gordels setObject:[NSNumber numberWithFloat:1] forKey:@"Aanwezig"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Is de Gordels geactiveerd?"
                                                           delegate:self cancelButtonTitle:NULL otherButtonTitles:@"Geactiveerd", @"Niet geactiveerd", nil];
            [alert setTag:406];
            [alert show];
        }
        else
        {
            [Gordels setObject:[NSNumber numberWithFloat:0] forKey:@"Aanwezig"];
            [Gordels setObject:[NSNumber numberWithBool:0] forKey:@"Geactiveerd"];
            [search.titleView setText:@"Afwezig"];
            [search setBackgroundColor:[UIColor whiteColor]];
            AllVelden =   [FileManager insertgordels_voertuig:Gordels];
        }
        
    } else if (Airbag) {
        if (sender.isOn) {
            [Airbag setObject:[NSNumber numberWithFloat:1] forKey:@"Aanwezig"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Is de airbag geactiveerd?"
                                                           delegate:self cancelButtonTitle:NULL otherButtonTitles:@"Geactiveerd", @"Niet geactiveerd", nil];
            [alert setTag:406];
            [alert show];
        }
        else
        {
            [Airbag setObject:[NSNumber numberWithFloat:0] forKey:@"Aanwezig"];
            [Airbag setObject:[NSNumber numberWithBool:0] forKey:@"Geactiveerd"];
            [search.titleView setText:@"Afwezig"];
            [search setBackgroundColor:[UIColor whiteColor]];
            AllVelden =   [FileManager insertAirbags_voertuig:Airbag];
        }
    } else if (Opties) {
        if (sender.isOn) {
            [Opties setObject:[NSNumber numberWithFloat:1] forKey:@"Aanwezig"];
            [search.titleView setText:@"Aanwezig"];
            [search setBackgroundColor:[UIColor whiteColor]];
            AllVelden =   [FileManager insertOpties_voertuig:Opties];
        }
        else
        {
            [Opties setObject:[NSNumber numberWithFloat:0] forKey:@"Aanwezig"];
            [search.titleView setText:@"Afwezig"];
            [search setBackgroundColor:[UIColor whiteColor]];
            AllVelden =   [FileManager insertOpties_voertuig:Opties];
        }
    } else if (Schades) {
        if (sender.isOn) {
            [Schades setObject:[NSNumber numberWithFloat:1] forKey:@"Aanwezig"];
            [search.titleView setText:@"Ja"];
            [search setBackgroundColor:[UIColor whiteColor]];
            AllVelden =   [FileManager insertSchades_voertuig:Schades];
        }
        else
        {
            [Schades setObject:[NSNumber numberWithFloat:0] forKey:@"Aanwezig"];
            [search.titleView setText:@"Nee"];
            [search setBackgroundColor:[UIColor whiteColor]];
            AllVelden =   [FileManager insertSchades_voertuig:Schades];
        }
    } else {
    }
}
-(void)setItemYESNOOpties:(NSArray*)velden aanwezig:(NSMutableDictionary*)value
{
    Opties = value;
    AllVelden =[[NSMutableArray alloc] init];
    for (int k =0; k < [velden count]; k++) {
        NSMutableDictionary *go =[NSMutableDictionary dictionaryWithObjectsAndKeys:[velden objectAtIndex:k], @"WaardeLang",[NSString stringWithFormat:@"%d", k], @"Waarde", nil];
        [AllVelden addObject:go];
    }
    NSString *querydouble = [NSString stringWithFormat:@"(Waarde LIKE [cd]'%@')", [value valueForKey:@"Aanwezig"]];
    NSPredicate *predicatedouble = [NSPredicate predicateWithFormat:querydouble];
    NSMutableArray *items2 = [[AllVelden filteredArrayUsingPredicate:predicatedouble] mutableCopy];
    search =[[ImageButton alloc]initWithFrame:CGRectMake(60, 0, self.frame.size.width-60,40)];
        //[search addTarget:self action:@selector(move:) forControlEvents:UIControlEventTouchUpInside];
    [search.titleView setText:@""];
    [search.titleLabel setFont:[UIFont regularFlatFontOfSize:14]];
    [search.titleLabel setNumberOfLines:2];
    [search setBackgroundColor:[UIColor clearColor]];
    [search setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [search setTag:100];
    [search.layer setCornerRadius:4];
    [self addSubview:search];
    [self.layer setCornerRadius:6];
    [self.layer setMasksToBounds:YES];
    [search setlabel];
    [search.upDownView setAlpha:0];
    [search.titleView setText:[[items2 firstObject] valueForKey:@"WaardeLang"]];
    UISwitch *UISwitchOne =[[UISwitch alloc] initWithFrame:CGRectMake(6, 4, 60, 40)];
    [UISwitchOne addTarget:self action:@selector(moveSwitch:) forControlEvents:(UIControlEventValueChanged | UIControlEventTouchDragInside)];
    [UISwitchOne setOnTintColor:[UIColor greenColor]];
    UISwitchOne.backgroundColor = [UIColor redColor];
    UISwitchOne.layer.cornerRadius = 16.0;
    [self addSubview:UISwitchOne];
    UISwitchOne.transform = CGAffineTransformMakeScale(0.8, 0.8);
    if (![[value valueForKey:@"Aanwezig"] boolValue]) {
        [search setBackgroundColor:[UIColor whiteColor]];
        [search.titleView setText:@"Afwezig"];
        [UISwitchOne setOn:NO];
    } else {
        [search setBackgroundColor:[UIColor whiteColor]];
        [search.titleView setText:@"Aanwezig"];
        [UISwitchOne setOn:YES];
    }
    AllVeldenActive =[[NSMutableArray alloc] initWithArray:AllVelden];
}
-(void)setItemYESNOSchades:(NSArray*)velden aanwezig:(NSMutableDictionary*)value
{
    Schades = value;
    AllVelden =[[NSMutableArray alloc] init];
    for (int k =0; k < [velden count]; k++) {
        NSMutableDictionary *go =[NSMutableDictionary dictionaryWithObjectsAndKeys:[velden objectAtIndex:k], @"WaardeLang",[NSString stringWithFormat:@"%d", k], @"Waarde", nil];
        [AllVelden addObject:go];
    }
    NSString *querydouble = [NSString stringWithFormat:@"(Waarde LIKE [cd]'%@')", [value valueForKey:@"Ja"]];
    NSPredicate *predicatedouble = [NSPredicate predicateWithFormat:querydouble];
    NSMutableArray *items2 = [[AllVelden filteredArrayUsingPredicate:predicatedouble] mutableCopy];
    search =[[ImageButton alloc]initWithFrame:CGRectMake(60, 0, self.frame.size.width-60,40)];
        //[search addTarget:self action:@selector(move:) forControlEvents:UIControlEventTouchUpInside];
    [search.titleView setText:@""];
    [search.titleLabel setFont:[UIFont regularFlatFontOfSize:14]];
    [search.titleLabel setNumberOfLines:2];
    [search setBackgroundColor:[UIColor clearColor]];
    [search setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [search setTag:100];
    [search.layer setCornerRadius:4];
    [self addSubview:search];
    [self.layer setCornerRadius:6];
    [self.layer setMasksToBounds:YES];
    [search setlabel];
    [search.upDownView setAlpha:0];
    [search.titleView setText:[[items2 firstObject] valueForKey:@"WaardeLang"]];
    UISwitch *UISwitchOne =[[UISwitch alloc] initWithFrame:CGRectMake(6, 4, 60, 40)];
    [UISwitchOne addTarget:self action:@selector(moveSwitch:) forControlEvents:(UIControlEventValueChanged | UIControlEventTouchDragInside)];
    [UISwitchOne setOnTintColor:[UIColor greenColor]];
    UISwitchOne.backgroundColor = [UIColor redColor];
    UISwitchOne.layer.cornerRadius = 16.0;
    [self addSubview:UISwitchOne];
    UISwitchOne.transform = CGAffineTransformMakeScale(0.8, 0.8);
    if (![[value valueForKey:@"Aanwezig"] boolValue]) {
        [search setBackgroundColor:[UIColor whiteColor]];
        [search.titleView setText:@"Afwezig"];
        [UISwitchOne setOn:NO];
    } else {
        [search setBackgroundColor:[UIColor whiteColor]];
        [search.titleView setText:@"Aanwezig"];
        [UISwitchOne setOn:YES];
    }
    AllVeldenActive =[[NSMutableArray alloc] initWithArray:AllVelden];
}
-(void)setItemYESNOGordels:(NSArray*)velden aanwezig:(NSMutableDictionary*)value
{
    Gordels = value;
    AllVelden =[[NSMutableArray alloc] init];
    for (int k =0; k < [velden count]; k++) {
        NSMutableDictionary *go =[NSMutableDictionary dictionaryWithObjectsAndKeys:[velden objectAtIndex:k], @"WaardeLang",[NSString stringWithFormat:@"%d", k], @"Waarde", nil];
        [AllVelden addObject:go];
    }
    AllVeldenActive =[[NSMutableArray alloc] initWithArray:AllVelden];
    NSString *querydouble = [NSString stringWithFormat:@"(Waarde LIKE [cd]'%@')", [value valueForKey:@"Aanwezig"]];
    NSPredicate *predicatedouble = [NSPredicate predicateWithFormat:querydouble];
    NSMutableArray *items2 = [[AllVelden filteredArrayUsingPredicate:predicatedouble] mutableCopy];
    search =[[ImageButton alloc]initWithFrame:CGRectMake(60, 0, self.frame.size.width-60,40)];
        //[search addTarget:self action:@selector(move:) forControlEvents:UIControlEventTouchUpInside];
    [search.titleView setText:@""];
    [search.titleLabel setFont:[UIFont regularFlatFontOfSize:14]];
    [search.titleLabel setNumberOfLines:2];
    [search setBackgroundColor:[UIColor clearColor]];
    [search setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [search setTag:100];
    [search.layer setCornerRadius:4];
    [self addSubview:search];

    [self.layer setCornerRadius:6];
    [self.layer setMasksToBounds:YES];
    [search setlabel];
    [search.upDownView setAlpha:0];
    [search.titleView setText:[[items2 firstObject] valueForKey:@"WaardeLang"]];
    UISwitch *UISwitchOne =[[UISwitch alloc] initWithFrame:CGRectMake(6, 4, 60, 40)];
    [UISwitchOne addTarget:self action:@selector(moveSwitch:) forControlEvents:(UIControlEventValueChanged | UIControlEventTouchDragInside)];
    [UISwitchOne setOnTintColor:[UIColor greenColor]];
    UISwitchOne.backgroundColor = [UIColor redColor];
    UISwitchOne.layer.cornerRadius = 16.0;
    [self addSubview:UISwitchOne];
    UISwitchOne.transform = CGAffineTransformMakeScale(0.8, 0.8);
    if (![[value valueForKey:@"Aanwezig"] boolValue]) {
        [search setBackgroundColor:[UIColor whiteColor]];
        [search.titleView setText:@"Afwezig"];
    } else {
        if ([[value valueForKey:@"Geactiveerd"] boolValue])
        {
            [search.titleView setText:@"Aanwezig/Geactiveerd"];
            [UISwitchOne setOn:YES];
            [search setBackgroundColor:[UIColor redColor]];
        }
        else
        {
            [search.titleView setText:@"Aanwezig/Ongeactiveerd"];
            [UISwitchOne setOn:NO];
            [search setBackgroundColor:[UIColor greenColor]];
        }
    }
}
-(void)setItemVelden:(NSArray*)velden
{


    
    
    AllVelden = [velden mutableCopy];

    tableResult =[[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.frame.size.width,self.frame.size.height-40)];
    [tableResult setRowHeight:80];
    [tableResult setDelegate:self];
    [tableResult setDataSource:self];
    [tableResult setBackgroundColor:baseColor];
        //[tableResult setBounces:NO];
    [tableResult setAlwaysBounceHorizontal:NO];
    [self addSubview:tableResult];
    [tableResult.layer setCornerRadius:6];
    [tableResult.layer setMasksToBounds:YES];
    AllVeldenActive =[[NSMutableArray alloc] initWithArray:AllVelden];

    NSString *querydouble;
    if ([[[AllVelden_voertuig firstObject] valueForKey:@"Waarde"]  isKindOfClass:[NSArray class]]) {
        NSMutableString *string =[[NSMutableString alloc] init];
        for (int k =0; k < [[[AllVelden_voertuig firstObject] valueForKey:@"Waarde"] count]; k++) {
            [string appendString:[NSString stringWithFormat:@"(Waarde LIKE [cd]'%@')#", [[[AllVelden_voertuig firstObject] valueForKey:@"Waarde"] objectAtIndex:k]]];
        }
        querydouble = [NSString stringWithFormat:@"%@", [[string stringByReplacingOccurrencesOfString:@")#(" withString:@") and ("] stringByReplacingOccurrencesOfString:@"#" withString:@""]];
    } else {
        querydouble = [NSString stringWithFormat:@"Waarde LIKE [cd]'%@'", [[AllVelden_voertuig firstObject] valueForKey:@"Waarde"]];
    }
    Veld = [AllVelden_voertuig firstObject];
    NSPredicate *predicatedouble = [NSPredicate predicateWithFormat:querydouble];
    NSMutableArray *items2 = [[AllVelden filteredArrayUsingPredicate:predicatedouble] mutableCopy];
    if ([AllVelden_voertuig count]>0) {
        if ([items2 count]>0) {
            search =[[ImageButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,40)];
            [search addTarget:self action:@selector(movelist:) forControlEvents:UIControlEventTouchUpInside];
                //[search.titleView setText:[[items2 firstObject] valueForKey:@"WaardeLang"]];
            [search.titleLabel setFont:[UIFont regularFlatFontOfSize:14]];
            [search.titleLabel setNumberOfLines:2];
            [search setBackgroundColor:[UIColor blueColor]];
            [search setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [search setTag:100];
            [search.layer setCornerRadius:4];
            [self addSubview:search];
            [self.layer setCornerRadius:6];
            [self.layer setMasksToBounds:YES];
            [search setlabel];
            [search.titleView setText:[[items2 firstObject] valueForKey:@"WaardeLang"]];
        }
        else
        {
            search =[[ImageButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,40)];
            [search addTarget:self action:@selector(movelist:) forControlEvents:UIControlEventTouchUpInside];
                //[search.titleView setText:@""];
            [search.titleLabel setFont:[UIFont regularFlatFontOfSize:14]];
            [search.titleLabel setNumberOfLines:2];
            [search setBackgroundColor:[UIColor clearColor]];
            [search setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [search setTag:100];
            [search.layer setCornerRadius:4];
            [self addSubview:search];
            [search setlabel];
            [search.titleView setText:@""];
        }
    } else {
        search =[[ImageButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,40)];
        [search addTarget:self action:@selector(movelist:) forControlEvents:UIControlEventTouchUpInside];
            //[search.titleView setText:@""];
        [search.titleLabel setFont:[UIFont regularFlatFontOfSize:14]];
        [search.titleLabel setNumberOfLines:2];
        [search setBackgroundColor:[UIColor clearColor]];
        [search setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [search setTag:100];
        [search.layer setCornerRadius:4];
        [self addSubview:search];
        [self.layer setCornerRadius:6];
        [self.layer setMasksToBounds:YES];
        [search setlabel];
        [search.titleView setText:@""];
    }

}
-(void)setItemListAuto:(NSArray*)velden
{


    AllVelden = [[velden mutableCopy] firstObject];
    AppDelegate *appDelegate = [FileManager getDel];


    AllVelden_voertuig = [[NSMutableArray alloc] initWithArray:[FileManager getVelden:[NSString stringWithFormat:@"%li", (long)VeldId] and:[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]]];


    if ([AllVelden_voertuig count]>0) {
        NSString *querydouble;
        if ([[[AllVelden_voertuig firstObject] valueForKey:@"Waarde"]  isKindOfClass:[NSArray class]]) {
            NSMutableString *string =[[NSMutableString alloc] init];
            for (int k =0; k < [[[AllVelden_voertuig firstObject] valueForKey:@"Waarde"] count]; k++) {
                [string appendString:[NSString stringWithFormat:@"(Waarde LIKE [cd]'%@')#", [[[AllVelden_voertuig firstObject] valueForKey:@"Waarde"] objectAtIndex:k]]];
            }
            querydouble = [NSString stringWithFormat:@"%@", [[string stringByReplacingOccurrencesOfString:@")#(" withString:@") and ("] stringByReplacingOccurrencesOfString:@"#" withString:@""]];
        }
        else
        {
            querydouble = [NSString stringWithFormat:@"Waarde LIKE [cd]'%@'", [[AllVelden_voertuig firstObject] valueForKey:@"Waarde"]];
        }
        Veld = [AllVelden_voertuig firstObject];

        if ([AllVelden_voertuig count]==3) {

                ////////////NSLog(@"%@", Veldname);

            if ([Veldname isEqualToString:@"Motortype:"]) {
                

                querydouble = [NSString stringWithFormat:@"Waarde LIKE [cd]'%@'", [[AllVelden_voertuig  objectAtIndex:0] valueForKey:@"Waarde"]];
            }
            else if ([Veldname isEqualToString:@"2e Motortype:"]) {

                querydouble = [NSString stringWithFormat:@"Waarde LIKE [cd]'%@'", [[AllVelden_voertuig objectAtIndex:1] valueForKey:@"Waarde"]];
            }
            else if ([Veldname isEqualToString:@"3e Motortype:"]) {

                querydouble = [NSString stringWithFormat:@"Waarde LIKE [cd]'%@'", [[AllVelden_voertuig  objectAtIndex:2] valueForKey:@"Waarde"]];
            }



                ////////////NSLog(@"%@ %@", AllVelden_voertuig, querydouble);

        }
        else if ([AllVelden_voertuig count]==2) {



            if ([Veldname isEqualToString:@"Motortype:"]) {

                querydouble = [NSString stringWithFormat:@"Waarde LIKE [cd]'%@'", [[AllVelden_voertuig firstObject] valueForKey:@"Waarde"]];
            }
            else if ([Veldname isEqualToString:@"2e Motortype:"]) {

                querydouble = [NSString stringWithFormat:@"Waarde LIKE [cd]'%@'", [[AllVelden_voertuig lastObject] valueForKey:@"Waarde"]];
            }
            else if ([Veldname isEqualToString:@"2e Motortype:"]) {

                querydouble = [NSString stringWithFormat:@"Waarde LIKE [cd]'%@'", @"99999"];

            }

        }
        else if ([AllVelden_voertuig count]==1) {



            if ([Veldname isEqualToString:@"Motortype:"]) {

                querydouble = [NSString stringWithFormat:@"Waarde LIKE [cd]'%@'", [[AllVelden_voertuig firstObject] valueForKey:@"Waarde"]];
            }
            else if ([Veldname isEqualToString:@"2e Motortype:"]) {

                querydouble = [NSString stringWithFormat:@"Waarde LIKE [cd]'%@'", @"99999"];

            }
            else if ([Veldname isEqualToString:@"3e Motortype:"]) {

                querydouble = [NSString stringWithFormat:@"Waarde LIKE [cd]'%@'", @"99999"];

            }

        }


        NSPredicate *predicatedouble = [NSPredicate predicateWithFormat:querydouble];
        NSMutableArray *items2 = [[AllVelden filteredArrayUsingPredicate:predicatedouble] mutableCopy];



        if ([Veldname isEqualToString:@"Carrosserie"]) {
            appDelegate.Soort = [[items2 firstObject] valueForKey:@"WaardeLang"];
        }
        if ([items2 count]>0) {

                ////////////NSLog(@"%@", querydouble);

                ////////////NSLog(@"%@ %@", items2, AllVelden_voertuig);

            search =[[ImageButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,40)];
            [search addTarget:self action:@selector(move:) forControlEvents:UIControlEventTouchUpInside];
            [search.titleLabel setFont:[UIFont regularFlatFontOfSize:14]];
            [search.titleLabel setNumberOfLines:2];
            [search setBackgroundColor:[UIColor clearColor]];
            [search setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [search setTag:100];
            [search.layer setCornerRadius:4];
            [self addSubview:search];
            [self.layer setCornerRadius:6];
            [self.layer setMasksToBounds:YES];
            [search setlabel];


            [search.titleView setText:[[items2 lastObject] valueForKey:@"WaardeLang"]];

            tableResult =[[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.frame.size.width,self.frame.size.height-40)];
            [tableResult setRowHeight:80];
            [tableResult setDelegate:self];
            [tableResult setDataSource:self];
            [tableResult setBackgroundColor:baseColor];
                //[tableResult setBounces:NO];
            [tableResult setAlwaysBounceHorizontal:NO];
            [self addSubview:tableResult];
            [tableResult.layer setCornerRadius:6];
            [tableResult.layer setMasksToBounds:YES];
            AllVeldenActive =[[NSMutableArray alloc] initWithArray:AllVelden];
        }
        else
        {
            search =[[ImageButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,40)];
            [search addTarget:self action:@selector(move:) forControlEvents:UIControlEventTouchUpInside];
            [search.titleView setText:@""];
            [search.titleLabel setFont:[UIFont regularFlatFontOfSize:14]];
            [search.titleLabel setNumberOfLines:2];
            [search setBackgroundColor:[UIColor clearColor]];
            [search setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [search setTag:100];
            [search.layer setCornerRadius:4];
            [self addSubview:search];
            [search setlabel];
            [search.titleView setText:@""];
            tableResult =[[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.frame.size.width,self.frame.size.height-40)];
            [tableResult setRowHeight:80];
            [tableResult setDelegate:self];
            [tableResult setDataSource:self];
            [tableResult setBackgroundColor:baseColor];
                //[tableResult setBounces:NO];
            [tableResult setAlwaysBounceHorizontal:NO];
            [self addSubview:tableResult];
            [tableResult.layer setCornerRadius:6];
            [tableResult.layer setMasksToBounds:YES];
            AllVeldenActive =[[NSMutableArray alloc] initWithArray:AllVelden];
        }
    } else {
        search =[[ImageButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,40)];
        [search addTarget:self action:@selector(move:) forControlEvents:UIControlEventTouchUpInside];
        [search.titleView setText:@""];
        [search.titleLabel setFont:[UIFont regularFlatFontOfSize:14]];
        [search.titleLabel setNumberOfLines:2];
        [search setBackgroundColor:[UIColor clearColor]];
        [search setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [search setTag:100];
        [search.layer setCornerRadius:4];
        [self addSubview:search];
        [search setlabel];
        [search.titleView setText:@""];
        tableResult =[[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.frame.size.width,self.frame.size.height-40)];
        [tableResult setRowHeight:80];
        [tableResult setDelegate:self];
        [tableResult setDataSource:self];
        [tableResult setBackgroundColor:baseColor];
            //[tableResult setBounces:NO];
        [tableResult setAlwaysBounceHorizontal:NO];
        [self addSubview:tableResult];
        [tableResult.layer setCornerRadius:6];
        [tableResult.layer setMasksToBounds:YES];
        AllVeldenActive =[[NSMutableArray alloc] initWithArray:AllVelden];
    }
    
    
}
-(void)setItemSoorten:(NSArray*)velden
{
    AppDelegate *appDelegate = [FileManager getDel];
    AllVelden =[[NSMutableArray alloc] init];
    for (int k =0; k < [velden count]; k++) {
        NSMutableDictionary *go =[NSMutableDictionary dictionaryWithObjectsAndKeys:[[velden objectAtIndex:k] valueForKey:@"Naam"], @"Naam", [[velden objectAtIndex:k] valueForKey:@"VoertuigSoortId"], @"VoertuigSoortId", [[velden objectAtIndex:k] valueForKey:@"Naam"], @"WaardeLang", [[velden objectAtIndex:k] valueForKey:@"VoertuigSoortId"], @"Waarde", nil];
        [AllVelden addObject:go];
    }
    NSString *query = [NSString stringWithFormat:@"VoertuigSoortId == %i", [[[[FileManager getModel:[appDelegate.currentCarDictionary valueForKey:@"ModelId"]] firstObject] valueForKey:@"VoertuigSoortId"] intValue]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:query];
    NSArray *arrayextra =  [[AllVelden
                             filteredArrayUsingPredicate:predicate] mutableCopy];
    search =[[ImageButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,40)];
    [search addTarget:self action:@selector(movelist:) forControlEvents:UIControlEventTouchUpInside];
    [search.titleLabel setFont:[UIFont regularFlatFontOfSize:14]];
    [search.titleLabel setNumberOfLines:2];
    [search setBackgroundColor:[UIColor clearColor]];
    [search setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [search setTag:100];
    [search.layer setCornerRadius:4];
    [self addSubview:search];
    [self.layer setCornerRadius:6];
    [self.layer setMasksToBounds:YES];
    [search setlabel];
    [search.titleView setText:[[arrayextra objectAtIndex:0] valueForKey:@"WaardeLang"]];
        ////////////NSLog(@"arrayextra %@", [[arrayextra objectAtIndex:0] valueForKey:@"WaardeLang"]);
    tableResult =[[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.frame.size.width,self.frame.size.height-40)];
    [tableResult setRowHeight:80];
    [tableResult setDelegate:self];
    [tableResult setDataSource:self];
    [tableResult setBackgroundColor:baseColor];
        //[tableResult setBounces:NO];
    [tableResult setAlwaysBounceHorizontal:NO];
    [self addSubview:tableResult];
    [tableResult.layer setCornerRadius:6];
    [tableResult.layer setMasksToBounds:YES];
    AllVeldenActive =[[NSMutableArray alloc] initWithArray:AllVelden];
}
-(void)setItemgo:(NSDictionary*)velden;
{
    AppDelegate *appDelegate = [FileManager getDel];
    AllVelden =[[NSMutableArray alloc] init];
    NSString *reset = [[NSString stringWithFormat:@"%@",velden] stringByReplacingOccurrencesOfString:@"\n    " withString:@""];
    reset = [reset stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    reset = [reset stringByReplacingOccurrencesOfString:@";" withString:@","];
    reset = [reset stringByReplacingOccurrencesOfString:@"{" withString:@""];
    reset = [reset stringByReplacingOccurrencesOfString:@"}" withString:@""];
    reset = [reset stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    NSMutableArray *myArray = [[reset componentsSeparatedByString:@","] mutableCopy];
    [myArray removeLastObject];
    for (int k =0; k < [myArray count]; k++) {
        NSMutableArray *set = [[[myArray objectAtIndex:k] componentsSeparatedByString:@" = "] mutableCopy];
        NSMutableDictionary *go =[NSMutableDictionary dictionaryWithObjectsAndKeys:[set objectAtIndex:1], @"WaardeLang",[NSNumber numberWithInteger:k], @"Waarde", nil];
        [AllVelden addObject:go];
    }
    NSString *query = [NSString stringWithFormat:@"Waarde == %i", [[appDelegate.currentCarDictionary valueForKey:@"InternetSoortId"] intValue]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:query];
    NSArray *arrayextra =  [[AllVelden
                             filteredArrayUsingPredicate:predicate] mutableCopy];
    search =[[ImageButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,40)];
    [search addTarget:self action:@selector(movelist:) forControlEvents:UIControlEventTouchUpInside];
    [search.titleLabel setFont:[UIFont regularFlatFontOfSize:14]];
    [search.titleLabel setNumberOfLines:2];
    [search setBackgroundColor:[UIColor clearColor]];
    [search setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [search setTag:100];
    [search.layer setCornerRadius:4];
    [self addSubview:search];
    [self.layer setCornerRadius:6];
    [self.layer setMasksToBounds:YES];
    [search setlabel];
    [search.titleView setText:[[arrayextra firstObject] valueForKey:@"WaardeLang"]];
    tableResult =[[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.frame.size.width,self.frame.size.height-40)];
    [tableResult setRowHeight:80];
    [tableResult setDelegate:self];
    [tableResult setDataSource:self];
    [tableResult setBackgroundColor:baseColor];
        //[tableResult setBounces:NO];
    [tableResult setAlwaysBounceHorizontal:NO];
    [self addSubview:tableResult];
    [tableResult.layer setCornerRadius:6];
    [tableResult.layer setMasksToBounds:YES];
    AllVeldenActive =[[NSMutableArray alloc] initWithArray:AllVelden];
}
-(void)setItemCountry:(NSArray*)velden;
{
    AllVelden =[[NSMutableArray alloc] init];
    for (int k =0; k < [velden count]; k++) {
        NSMutableDictionary *go =[NSMutableDictionary dictionaryWithObjectsAndKeys:[[velden valueForKey:@"Naam" ] objectAtIndex:k], @"WaardeLang",[[velden valueForKey:@"LandId" ] objectAtIndex:k], @"Waarde", nil];
        [AllVelden addObject:go];
    }
    search =[[ImageButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,40)];
    [search addTarget:self action:@selector(movelist:) forControlEvents:UIControlEventTouchUpInside];
    [search.titleView setText:@""];
    [search.titleLabel setFont:[UIFont regularFlatFontOfSize:14]];
    [search.titleLabel setNumberOfLines:2];
    [search setBackgroundColor:[UIColor clearColor]];
    [search setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [search setTag:100];
    [search.layer setCornerRadius:4];
    [self addSubview:search];
    [self.layer setCornerRadius:6];
    [self.layer setMasksToBounds:YES];
    [search setlabel];
    [search.titleView setText:@""];
    tableResult =[[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.frame.size.width,self.frame.size.height-40)];
    [tableResult setRowHeight:80];
    [tableResult setDelegate:self];
    [tableResult setDataSource:self];
    [tableResult setBackgroundColor:baseColor];
        //[tableResult setBounces:NO];
    [tableResult setAlwaysBounceHorizontal:NO];
    [self addSubview:tableResult];
    [tableResult.layer setCornerRadius:6];
    [tableResult.layer setMasksToBounds:YES];
    AllVeldenActive =[[NSMutableArray alloc] initWithArray:AllVelden];
}
-(void)movelist:(LineButton*)sender
{
        ////////////NSLog(@"%f", self.frame.size.height);

    if ([Veldname isEqualToString:@"Test resultaten"]) {


        [onderdeelview.parentcell.superview bringSubviewToFront:onderdeelview.parentcell];
        [onderdeelview insertSubview:Parentlabel aboveSubview:[[onderdeelview subviews] lastObject]];
        
        if (self.frame.size.height==40)
        {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationDuration:0.2f];
            [Parentlabel setFrame:CGRectMake(Parentlabel.frame.origin.x, Parentlabel.frame.origin.y, Parentlabel.frame.size.width, 40*4.3)];
            [self setFrame:CGRectMake(self.frame.origin.x, asY, self.frame.size.width, 40*4.3)];
            [self.tableResult setFrame:CGRectMake(0, 40, self.tableResult.frame.size.width, 40*3.3)];
            [search.upDownView setImage:[UIImage imageNamed:@"Up.png"]];
            [UIView commitAnimations];
        }
        else
        {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationDuration:0.2f];
            [Parentlabel setFrame:CGRectMake(Parentlabel.frame.origin.x, Parentlabel.frame.origin.y, Parentlabel.frame.size.width, 40)];
            [self setFrame:CGRectMake(self.frame.origin.x, asY, self.frame.size.width, 40)];
            [self.tableResult setFrame:CGRectMake(0, 40, self.tableResult.frame.size.width, self.frame.size.height-40)];
                //[onderdeelview.parentcell setFrame:CGRectMake(onderdeelview.parentcell.frame.origin.x, onderdeelview.parentcell.frame.origin.y, onderdeelview.parentcell.frame.size.width, onderdeelview.sizeit)];
                // [onderdeelview setFrame:CGRectMake(onderdeelview.frame.origin.x, onderdeelview.frame.origin.y, onderdeelview.frame.size.width, onderdeelview.sizeit)];
            [UIView commitAnimations];
            [search.upDownView setImage:[UIImage imageNamed:@"Down.png"]];
        }
        

    } else {
        if (Parentview) {
            [[[Parentview subviews] firstObject] insertSubview:Parentlabel.foldscreen aboveSubview:[ [[[Parentview subviews] firstObject] subviews] lastObject]];
            [Parentlabel.foldscreen insertSubview:Parentlabel aboveSubview:[[Parentlabel.foldscreen subviews] lastObject]];

            if (self.frame.size.height==40)
            {
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationBeginsFromCurrentState:YES];
                [UIView setAnimationDuration:0.2f];
                [Parentlabel setFrame:CGRectMake(Parentlabel.frame.origin.x, Parentlabel.frame.origin.y, Parentlabel.frame.size.width, 40*4.3)];
                [self setFrame:CGRectMake(self.frame.origin.x, asY, self.frame.size.width, 40*4.3)];
                [self.tableResult setFrame:CGRectMake(0, 40, self.tableResult.frame.size.width, 40*3.3)];
                [Parentlabel.foldscreen setFrame:CGRectMake(Parentlabel.foldscreen.frame.origin.x, Parentlabel.foldscreen.frame.origin.y, Parentlabel.foldscreen.frame.size.width, Parentlabel.foldscreen.sizeit+(40*3.3))];
                [search.upDownView setImage:[UIImage imageNamed:@"Up.png"]];
                [UIView commitAnimations];
            }
            else
            {
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationBeginsFromCurrentState:YES];
                [UIView setAnimationDuration:0.2f];
                [Parentlabel setFrame:CGRectMake(Parentlabel.frame.origin.x, Parentlabel.frame.origin.y, Parentlabel.frame.size.width, 40)];
                [self setFrame:CGRectMake(self.frame.origin.x, asY, self.frame.size.width, 40)];
                [self.tableResult setFrame:CGRectMake(0, 40, self.tableResult.frame.size.width, self.frame.size.height-40)];
                [Parentlabel.foldscreen setFrame:CGRectMake(Parentlabel.foldscreen.frame.origin.x, Parentlabel.foldscreen.frame.origin.y, Parentlabel.foldscreen.frame.size.width, Parentlabel.foldscreen.sizeit)];
                [UIView commitAnimations];
                [search.upDownView setImage:[UIImage imageNamed:@"Down.png"]];
            }
        } else {
            [onderdeelview.parentcell.superview bringSubviewToFront:onderdeelview.parentcell];
            [onderdeelview insertSubview:Parentlabel aboveSubview:[[onderdeelview subviews] lastObject]];
            if (self.frame.size.height==40)
            {
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationBeginsFromCurrentState:YES];
                [UIView setAnimationDuration:0.2f];
                [Parentlabel setFrame:CGRectMake(Parentlabel.frame.origin.x, Parentlabel.frame.origin.y, Parentlabel.frame.size.width, 40*4.3)];
                [self setFrame:CGRectMake(self.frame.origin.x, asY, self.frame.size.width, 40*4.3)];
                [self.tableResult setFrame:CGRectMake(0, 40, self.tableResult.frame.size.width, 40*3.3)];
                [onderdeelview.parentcell setFrame:CGRectMake(onderdeelview.parentcell.frame.origin.x, onderdeelview.parentcell.frame.origin.y, onderdeelview.parentcell.frame.size.width, onderdeelview.sizeit+(40*3.3))];
                    //[onderdeelview setFrame:CGRectMake(onderdeelview.frame.origin.x, onderdeelview.frame.origin.y, onderdeelview.frame.size.width, onderdeelview.sizeit+(40*3.3))];
                [search.upDownView setImage:[UIImage imageNamed:@"Up.png"]];
                [UIView commitAnimations];
            }
            else
            {
                [UIView beginAnimations:nil context:NULL];
                [UIView setAnimationBeginsFromCurrentState:YES];
                [UIView setAnimationDuration:0.2f];
                [Parentlabel setFrame:CGRectMake(Parentlabel.frame.origin.x, Parentlabel.frame.origin.y, Parentlabel.frame.size.width, 40)];
                [self setFrame:CGRectMake(self.frame.origin.x, asY, self.frame.size.width, 40)];
                [self.tableResult setFrame:CGRectMake(0, 40, self.tableResult.frame.size.width, self.frame.size.height-40)];
                [onderdeelview.parentcell setFrame:CGRectMake(onderdeelview.parentcell.frame.origin.x, onderdeelview.parentcell.frame.origin.y, onderdeelview.parentcell.frame.size.width, onderdeelview.sizeit)];
                    // [onderdeelview setFrame:CGRectMake(onderdeelview.frame.origin.x, onderdeelview.frame.origin.y, onderdeelview.frame.size.width, onderdeelview.sizeit)];
                [UIView commitAnimations];
                [search.upDownView setImage:[UIImage imageNamed:@"Down.png"]];
            }
        }

    }
}
-(void)moveCell:(LineButton*)sender
{
        //AppDelegate *appDelegate = [FileManager getDel];
    [onderdeelview.parentcell.superview bringSubviewToFront:onderdeelview.parentcell];
    [onderdeelview insertSubview:Parentlabel aboveSubview:[[onderdeelview subviews] lastObject]];
    if (self.frame.size.height==40)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.2f];
        [Parentlabel setFrame:CGRectMake(Parentlabel.frame.origin.x, Parentlabel.frame.origin.y, Parentlabel.frame.size.width, 40*4.3)];
        [self setFrame:CGRectMake(self.frame.origin.x, asY, self.frame.size.width, 40*4.3)];
        [self.tableResult setFrame:CGRectMake(0, 40, self.tableResult.frame.size.width, 40*3.3)];
        [onderdeelview.parentcell setFrame:CGRectMake(onderdeelview.parentcell.frame.origin.x, onderdeelview.parentcell.frame.origin.y, onderdeelview.parentcell.frame.size.width, onderdeelview.sizeit+(40*3.3))];
            // [onderdeelview setFrame:CGRectMake(onderdeelview.frame.origin.x, onderdeelview.frame.origin.y, onderdeelview.frame.size.width, onderdeelview.sizeit+(40*3.3))];
        [search.upDownView setImage:[UIImage imageNamed:@"Up.png"]];
        [UIView commitAnimations];
    } else {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.2f];
        
        [Parentlabel setFrame:CGRectMake(Parentlabel.frame.origin.x, Parentlabel.frame.origin.y, Parentlabel.frame.size.width, 40)];
        [self setFrame:CGRectMake(self.frame.origin.x, asY, self.frame.size.width, 40)];
        [self.tableResult setFrame:CGRectMake(0, 40, self.tableResult.frame.size.width, self.frame.size.height-40)];
        [onderdeelview.parentcell setFrame:CGRectMake(onderdeelview.parentcell.frame.origin.x, onderdeelview.parentcell.frame.origin.y, onderdeelview.parentcell.frame.size.width, onderdeelview.sizeit)];
            //[onderdeelview setFrame:CGRectMake(onderdeelview.frame.origin.x, onderdeelview.frame.origin.y, onderdeelview.frame.size.width, onderdeelview.sizeit)];
        [UIView commitAnimations];
        [search.upDownView setImage:[UIImage imageNamed:@"Down.png"]];
    }
}
-(void)RefreshTableviewEmpty:(NSMutableArray*)sender
{
    AllVelden =[[NSMutableArray alloc] init];
    [tableResult reloadData];
}
-(void)RefreshTableview:(NSMutableArray*)sender
{
    NSMutableArray *copy =[[NSMutableArray alloc] init];
    for (int k=0 ; k<[ [AllVeldenActive valueForKey:@"Waarde"] count]; k++) {
        if ([[sender valueForKey:@"Waarde"] containsObject:[[AllVeldenActive valueForKey:@"Waarde"] objectAtIndex:k]] ) {
            NSString *querydouble = [NSString stringWithFormat:@"(Waarde Like [cd]'%@')", [[AllVeldenActive valueForKey:@"Waarde"] objectAtIndex:k]];
            NSPredicate *predicatedouble = [NSPredicate predicateWithFormat:querydouble];
            NSMutableArray *items2 = [[AllVeldenActive filteredArrayUsingPredicate:predicatedouble] mutableCopy];
            [copy addObject:[items2 firstObject]];
        }
        else
        {
        }
    }
    AllVelden =[[NSMutableArray alloc] initWithArray:copy];
    [tableResult reloadData];
}
-(void)return
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.2f];
    [Parentlabel setFrame:CGRectMake(Parentlabel.frame.origin.x, Parentlabel.frame.origin.y, Parentlabel.frame.size.width, 40)];
    [self setFrame:CGRectMake(self.frame.origin.x, asY, self.frame.size.width, 40)];
    [self.tableResult setFrame:CGRectMake(0, 40, self.tableResult.frame.size.width, self.frame.size.height-40)];
    [Parentlabel.foldscreen setFrame:CGRectMake(Parentlabel.foldscreen.frame.origin.x, Parentlabel.foldscreen.frame.origin.y, Parentlabel.foldscreen.frame.size.width, Parentlabel.foldscreen.sizeit)];
    [UIView commitAnimations];
    [search.upDownView setImage:[UIImage imageNamed:@"Down.png"]];
}
-(void)move:(LineButton*)nu
{
    AppDelegate *appDelegate = [FileManager getDel];
    if (![appDelegate.currentItemListView isEqual:self]) {
        [appDelegate.currentItemListView return];
    }

    
    [[[Parentview subviews] firstObject] insertSubview:Parentlabel.foldscreen aboveSubview:[ [[[Parentview subviews] firstObject] subviews] lastObject]];
    [Parentlabel.foldscreen insertSubview:Parentlabel aboveSubview:[[Parentlabel.foldscreen subviews] lastObject]];


    if (self.frame.size.height==40)
    {
        if ([AllVelden count]>4) {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationDuration:0.2f];
            [Parentlabel setFrame:CGRectMake(Parentlabel.frame.origin.x, Parentlabel.frame.origin.y, Parentlabel.frame.size.width, 40*4.3)];
            [self setFrame:CGRectMake(self.frame.origin.x, asY, self.frame.size.width, 40*4.3)];
            [self.tableResult setFrame:CGRectMake(0, 40, self.tableResult.frame.size.width, 40*3.3)];
            [Parentlabel.foldscreen setFrame:CGRectMake(Parentlabel.foldscreen.frame.origin.x, Parentlabel.foldscreen.frame.origin.y, Parentlabel.foldscreen.frame.size.width, Parentlabel.foldscreen.sizeit+(40*3.3))];
            [appDelegate setCurrentItemListView:self];
            [search.upDownView setImage:[UIImage imageNamed:@"Up.png"]];
            [UIView commitAnimations];
        }
        else
        {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationDuration:0.2f];
            [Parentlabel setFrame:CGRectMake(Parentlabel.frame.origin.x, Parentlabel.frame.origin.y, Parentlabel.frame.size.width, 40.3*([AllVelden count]+1))];
            [self setFrame:CGRectMake(self.frame.origin.x, asY, self.frame.size.width, 40.3*([AllVelden count]+1))];
            [self.tableResult setFrame:CGRectMake(0, 40, self.tableResult.frame.size.width, 40.3*([AllVelden count]+1))];
            [Parentlabel.foldscreen setFrame:CGRectMake(Parentlabel.foldscreen.frame.origin.x, Parentlabel.foldscreen.frame.origin.y, Parentlabel.foldscreen.frame.size.width, Parentlabel.foldscreen.sizeit+(40.3*([AllVelden count]+1)))];
            [search.upDownView setImage:[UIImage imageNamed:@"Up.png"]];
            [appDelegate setCurrentItemListView:self];
            [UIView commitAnimations];
        }
    } else {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.2f];
        [Parentlabel setFrame:CGRectMake(Parentlabel.frame.origin.x, Parentlabel.frame.origin.y, Parentlabel.frame.size.width, 40)];
        [self setFrame:CGRectMake(self.frame.origin.x, asY, self.frame.size.width, 40)];
        [self.tableResult setFrame:CGRectMake(0, 40, self.tableResult.frame.size.width, self.frame.size.height-40)];
        [Parentlabel.foldscreen setFrame:CGRectMake(Parentlabel.foldscreen.frame.origin.x, Parentlabel.foldscreen.frame.origin.y, Parentlabel.foldscreen.frame.size.width, Parentlabel.foldscreen.sizeit)];
        [UIView commitAnimations];
        [search.upDownView setImage:[UIImage imageNamed:@"Down.png"]];
    }
    [tableResult flashScrollIndicators];
}

#pragma mark - tabelDelegate method
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *content =[[UIView alloc] initWithFrame:CGRectMake(0,0,self.frame.size.width,0)];
    return content;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [tableView setSeparatorColor:[UIColor clearColor]];
    return [AllVelden count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        //AppDelegate *appDelegate = [FileManager getDel];
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Subcellstank"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Subcellstank"];
        [cell setBackgroundColor:[UIColor whiteColor]];
        [cell.contentView setBackgroundColor:[UIColor whiteColor]];
        [cell.accessoryView setBackgroundColor:[UIColor whiteColor]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    UILabel *existlabel = (UILabel *)[cell viewWithTag:105];
    if (existlabel) {
        [existlabel setFrame:CGRectMake(8,0,self.frame.size.width,40)];
        [existlabel setText:[[AllVelden objectAtIndex:indexPath.row] valueForKey:@"WaardeLang"]];
    } else {
        UILabel *kenteken =[[UILabel alloc] initWithFrame:CGRectMake(10,0,self.frame.size.width,40)];
        [kenteken setBackgroundColor:[UIColor clearColor]];
        [kenteken setText:[[AllVelden objectAtIndex:indexPath.row] valueForKey:@"WaardeLang"]];
        [kenteken setFont:[UIFont regularFlatFontOfSize:14]];
        [kenteken setTextAlignment:NSTextAlignmentLeft];
        [kenteken setTag:105];
        [kenteken setNumberOfLines:2];
        [cell addSubview:kenteken];
    }
    [cell.layer setCornerRadius:6];
    [cell.layer setMasksToBounds:YES];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *appDelegate = [FileManager getDel];


    NSString* CopyString = search.titleView.text;


    NSLog(@"Veldname %li", (long)VeldId);

    if ([Veldname isEqualToString:@"Test resultaten"]) {

        [onderdeelview.basepart setObject:[[AllVelden objectAtIndex:indexPath.row] valueForKey:@"Order"] forKey:@"TestStatusId"];
        [FileManager insertnew:onderdeelview.basepart];

            //////NSLog(@"%@", onderdeelview.basepart);

        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.2f];
        [Parentlabel setFrame:CGRectMake(Parentlabel.frame.origin.x, Parentlabel.frame.origin.y, Parentlabel.frame.size.width, 40)];
        [self setFrame:CGRectMake(self.frame.origin.x, asY, self.frame.size.width, 40)];
        [self.tableResult setFrame:CGRectMake(0, 40, self.tableResult.frame.size.width, self.frame.size.height-40)];
        [search.titleView setText:[[AllVelden objectAtIndex:indexPath.row] valueForKey:@"WaardeLang"]];

        [UIView commitAnimations];
        [search.upDownView setImage:[UIImage imageNamed:@"Down.png"]];
        [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];

    } else {

        AllVelden_voertuig = [[NSMutableArray alloc] initWithArray:[FileManager getVelden:[NSString stringWithFormat:@"%li", (long)VeldId] and:[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]]];

        for (int k =0; k < [[appDelegate.viewcontroller.carView.ScrollResult subviews] count]; k++) {
            if ([[[appDelegate.viewcontroller.carView.ScrollResult subviews] objectAtIndex:k] isKindOfClass:[ItemFold class]]) {
                ItemFold *item =(ItemFold*)[[appDelegate.viewcontroller.carView.ScrollResult subviews] objectAtIndex:k];
                NSMutableArray * sender =[[FileManager getVeldafhankelijkinlcude:[[AllVelden objectAtIndex:indexPath.row] valueForKey:@"Waarde"] include:[self tag]] mutableCopy];
                FieldLabelView *existlabel = (FieldLabelView *)[item viewWithTag:[[[sender firstObject] valueForKey:@"VeldId"] integerValue]];
                NSPredicate* predicate = [NSPredicate predicateWithFormat:@"self isKindOfClass: %@", [ItemListView class]];
                NSArray* filteredViews= [[existlabel subviews] filteredArrayUsingPredicate:predicate];
                if ([filteredViews count]>0) {

                    ItemListView *copy =[[existlabel subviews] lastObject];
                    [copy.search setBaseColor:[UIColor clearColor]];

                    if ([[[sender firstObject] valueForKey:@"Waarde"] length]) {
                        [copy.search setUserInteractionEnabled:YES];
                        [copy.search.titleView setText:@""];

                        [copy RefreshTableview:sender];

                    }
                    else
                    {
                        [copy.search setUserInteractionEnabled:NO];
                        [copy.search.titleView setText:@""];
                    }


                }
                else
                {


                }
            }
        }
        if (onderdeelview.parentcell) {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationDuration:0.2f];
            [Parentlabel setFrame:CGRectMake(Parentlabel.frame.origin.x, Parentlabel.frame.origin.y, Parentlabel.frame.size.width, 40)];
            [self setFrame:CGRectMake(self.frame.origin.x, asY, self.frame.size.width, 40)];
            [self.tableResult setFrame:CGRectMake(0, 40, self.tableResult.frame.size.width, self.frame.size.height-40)];
            [onderdeelview.parentcell setFrame:CGRectMake(onderdeelview.parentcell.frame.origin.x, onderdeelview.parentcell.frame.origin.y, onderdeelview.parentcell.frame.size.width, onderdeelview.sizeit)];
            [onderdeelview setFrame:CGRectMake(onderdeelview.frame.origin.x, onderdeelview.frame.origin.y, onderdeelview.frame.size.width, onderdeelview.sizeit)];
            [search.titleView setText:[[AllVelden objectAtIndex:indexPath.row] valueForKey:@"WaardeLang"]];

            [UIView commitAnimations];
            [search.upDownView setImage:[UIImage imageNamed:@"Down.png"]];
            [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
        } else {
                //AppDelegate *appDelegate = [FileManager getDel];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationDuration:0.2f];
            [Parentlabel setFrame:CGRectMake(Parentlabel.frame.origin.x, Parentlabel.frame.origin.y, Parentlabel.frame.size.width, 40)];
            [self setFrame:CGRectMake(self.frame.origin.x, asY, self.frame.size.width, 40)];
            [self.tableResult setFrame:CGRectMake(0, 40, self.tableResult.frame.size.width, self.frame.size.height-40)];
            [Parentlabel.foldscreen setFrame:CGRectMake(Parentlabel.foldscreen.frame.origin.x, Parentlabel.foldscreen.frame.origin.y, Parentlabel.foldscreen.frame.size.width, Parentlabel.foldscreen.sizeit)];
            [search.titleView setText:[[AllVelden objectAtIndex:indexPath.row] valueForKey:@"WaardeLang"]];
            [UIView commitAnimations];
            [search.upDownView setImage:[UIImage imageNamed:@"Down.png"]];
        }
        if (Gordels) {
            if ([[[AllVelden objectAtIndex:indexPath.row] valueForKey:@"WaardeLang"] isEqualToString:@"Aanwezig"])
            {
                [Gordels setObject:[NSNumber numberWithFloat:1] forKey:@"Aanwezig"];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Is de airbag geactiveerd?"
                                                               delegate:self cancelButtonTitle:NULL otherButtonTitles:@"Geactiveerd", @"Niet geactiveerd", nil];
                [alert setTag:406];
                [alert show];
            }
            else
            {
                [Gordels setObject:[NSNumber numberWithFloat:0] forKey:@"Aanwezig"];
                [search.titleView setTextColor:[UIColor blackColor]];
                [FileManager insertgordels_voertuig:Gordels];
                AllVelden =   [FileManager insertgordels_voertuig:Gordels];
            }
        } else if (Airbag) {
            if ([[[AllVelden objectAtIndex:indexPath.row] valueForKey:@"WaardeLang"] isEqualToString:@"Aanwezig"])
            {
                [Airbag setObject:[NSNumber numberWithFloat:1] forKey:@"Aanwezig"];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Is de airbag geactiveerd?"
                                                               delegate:self cancelButtonTitle:NULL otherButtonTitles:@"Geactiveerd", @"Niet geactiveerd", nil];
                [alert setTag:406];
                [alert show];
            }
            else
            {
                [Airbag setObject:[NSNumber numberWithFloat:0] forKey:@"Aanwezig"];
                [search.titleView setTextColor:[UIColor blackColor]];
                AllVelden =   [FileManager insertAirbags_voertuig:Airbag];
            }
        } else if (Opties) {
        } else {

            AppDelegate *appDelegate = [FileManager getDel];

            AllVelden_voertuig = [[FileManager getVelden:[NSString stringWithFormat:@"%li", (long)VeldId] and:[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]] mutableCopy];

                //////NSLog(@"%@", AllVelden_voertuig);

            if (AllVelden_voertuig) {

            }
            else
            {
                AllVelden_voertuig =[[NSMutableArray alloc] init];
            }



            if ([Veldname isEqualToString:@"Motortype:"]) {
                NSMutableDictionary *insertDictonary = [[NSMutableDictionary alloc] init];
                [insertDictonary setObject:[NSNumber numberWithInteger:VeldId] forKey:@"VeldId"];
                [insertDictonary setObject:[[AllVelden objectAtIndex:indexPath.row] valueForKey:@"Waarde"] forKey:@"Waarde"];



                if ([AllVelden_voertuig containsObject:insertDictonary]) {

                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Deze waarde is al eens ingevuld."
                                                                   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alert show];


                    [search.titleView setText:CopyString];

                }

                else
                {

                    if ([AllVelden_voertuig count] == 0)
                    {
                        [AllVelden_voertuig addObject:insertDictonary];

                        [FileManager getVelden_voertuigMulti:[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"] add:AllVelden_voertuig];
                        [search.titleView setText:[[AllVelden objectAtIndex:indexPath.row] valueForKey:@"WaardeLang"]];
                    }
                    else if ([AllVelden_voertuig count] == 1)
                    {
                        [AllVelden_voertuig removeAllObjects];
                        [AllVelden_voertuig addObject:insertDictonary];

                        [FileManager getVelden_voertuigMulti:[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"] add:AllVelden_voertuig];
                        [search.titleView setText:[[AllVelden objectAtIndex:indexPath.row] valueForKey:@"WaardeLang"]];
                    }
                    else if ([AllVelden_voertuig count] == 2)
                    {
                        [AllVelden_voertuig replaceObjectAtIndex:0 withObject:insertDictonary];

                        [FileManager getVelden_voertuigMulti:[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"] add:AllVelden_voertuig];
                        [search.titleView setText:[[AllVelden objectAtIndex:indexPath.row] valueForKey:@"WaardeLang"]];
                    }
                    else if ([AllVelden_voertuig count] == 3)
                    {

                        [AllVelden_voertuig replaceObjectAtIndex:0 withObject:insertDictonary];

                        [FileManager getVelden_voertuigMulti:[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"] add:AllVelden_voertuig];
                        [search.titleView setText:[[AllVelden objectAtIndex:indexPath.row] valueForKey:@"WaardeLang"]];
                    }



                        ////////////NSLog(@"%@", Veldname);


                }
            }
            else if ([Veldname isEqualToString:@"2e Motortype:"]) {
                NSMutableDictionary *insertDictonary = [[NSMutableDictionary alloc] init];
                [insertDictonary setObject:[NSNumber numberWithInteger:VeldId] forKey:@"VeldId"];
                [insertDictonary setObject:[[AllVelden objectAtIndex:indexPath.row] valueForKey:@"Waarde"] forKey:@"Waarde"];

                    ////////////NSLog(@"%@", insertDictonary);

                if ([AllVelden_voertuig containsObject:insertDictonary]) {

                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Deze waarde is al eens ingevuld."
                                                                   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alert show];

                    [search.titleView setText:CopyString];


                }

                else
                {



                    if ([AllVelden_voertuig count] == 0)
                    {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Vul het eerste veld motertype in."
                                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                        [alert show];


                        [search.titleView setText:@""];
                    }
                    else if ([AllVelden_voertuig count] == 1)
                    {
                        [AllVelden_voertuig addObject:insertDictonary];


                        [FileManager getVelden_voertuigMulti:[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"] add:AllVelden_voertuig];
                        [search.titleView setText:[[AllVelden objectAtIndex:indexPath.row] valueForKey:@"WaardeLang"]];
                    }
                    else if ([AllVelden_voertuig count] == 2)
                    {
                        [AllVelden_voertuig replaceObjectAtIndex:1 withObject:insertDictonary];


                        [FileManager getVelden_voertuigMulti:[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"] add:AllVelden_voertuig];
                        [search.titleView setText:[[AllVelden objectAtIndex:indexPath.row] valueForKey:@"WaardeLang"]];
                    }
                    else if ([AllVelden_voertuig count] == 3)
                    {
                        [AllVelden_voertuig replaceObjectAtIndex:1 withObject:insertDictonary];


                        [FileManager getVelden_voertuigMulti:[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"] add:AllVelden_voertuig];
                        [search.titleView setText:[[AllVelden objectAtIndex:indexPath.row] valueForKey:@"WaardeLang"]];
                    }


                        ////////////NSLog(@"%@", AllVelden_voertuig);

                }


            }
            else if ([Veldname isEqualToString:@"3e Motortype:"]) {

                NSMutableDictionary *insertDictonary = [[NSMutableDictionary alloc] init];
                [insertDictonary setObject:[NSNumber numberWithInteger:VeldId] forKey:@"VeldId"];
                [insertDictonary setObject:[[AllVelden objectAtIndex:indexPath.row] valueForKey:@"Waarde"] forKey:@"Waarde"];

                    ////////////NSLog(@"%@", insertDictonary);

                if ([AllVelden_voertuig containsObject:insertDictonary]) {

                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Deze waarde is al eens ingevuld."
                                                                   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alert show];
                    [search.titleView setText:@""];


                }

                else
                {

                    if ([AllVelden_voertuig count] == 0)
                    {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Vul het eerste veld motertype in."
                                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                        [alert show];


                        [search.titleView setText:@""];
                    }
                    if ([AllVelden_voertuig count] == 1)
                    {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Vul het tweede veld motortype eerst in."
                                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                        [alert show];

                        [search.titleView setText:@""];
                    }
                    else if ([AllVelden_voertuig count] == 2)
                    {
                        [AllVelden_voertuig addObject:insertDictonary];
                        [FileManager getVelden_voertuigMulti:[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"] add:AllVelden_voertuig];
                        [search.titleView setText:[[AllVelden objectAtIndex:indexPath.row] valueForKey:@"WaardeLang"]];
                    }
                    else if ([AllVelden_voertuig count] == 3)
                    {
                        [AllVelden_voertuig replaceObjectAtIndex:2 withObject:insertDictonary];
                        [FileManager getVelden_voertuigMulti:[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"] add:AllVelden_voertuig];
                        [search.titleView setText:[[AllVelden objectAtIndex:indexPath.row] valueForKey:@"WaardeLang"]];
                    }


                        ////////////NSLog(@"%@", AllVelden_voertuig);

                }


                    ////////////NSLog(@"AllVelden_voertuig %@", AllVelden_voertuig);

            }
            else
            {


                if ([@"HerkomstLandId" isEqualToString:Veldname])
                {

                    [appDelegate.currentCarDictionary setObject:[[AllVelden objectAtIndex:indexPath.row] valueForKey:@"Waarde"] forKey:Veldname];
                    NSInteger index = [appDelegate.alleVoertuigenArray indexOfObject:appDelegate.currentCarDictionary];
                    NSString *docDir = [FileManager getDir];
                    [appDelegate.alleVoertuigenArray replaceObjectAtIndex:index withObject:appDelegate.currentCarDictionary];
                    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/Voertuigen.plist",docDir];
                    [appDelegate.alleVoertuigenArray writeToFile:itemFilePath atomically: YES];
                }
                else if ([@"InternetPrijsSoort" isEqualToString:Veldname])
                {

                    [appDelegate.currentCarDictionary setObject:[[AllVelden objectAtIndex:indexPath.row] valueForKey:@"Waarde"] forKey:Veldname];
                    NSInteger index = [appDelegate.alleVoertuigenArray indexOfObject:appDelegate.currentCarDictionary];
                    NSString *docDir = [FileManager getDir];
                    [appDelegate.alleVoertuigenArray replaceObjectAtIndex:index withObject:appDelegate.currentCarDictionary];
                    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/Voertuigen.plist",docDir];
                    [appDelegate.alleVoertuigenArray writeToFile:itemFilePath atomically: YES];
                }
                else
                {
                    if ([[appDelegate.currentCarDictionary allKeys] containsObject:Veldname])
                    {

                        [appDelegate.currentCarDictionary setObject:[[AllVelden objectAtIndex:indexPath.row] valueForKey:@"Waarde"] forKey:Veldname];
                        NSInteger index = [appDelegate.alleVoertuigenArray indexOfObject:appDelegate.currentCarDictionary];
                        NSString *docDir = [FileManager getDir];
                        [appDelegate.alleVoertuigenArray replaceObjectAtIndex:index withObject:appDelegate.currentCarDictionary];
                        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/Voertuigen.plist",docDir];
                        [appDelegate.alleVoertuigenArray writeToFile:itemFilePath atomically: YES];
                    }
                    else
                    {
                        if (onderdeelview.parentcell) {

                            NSMutableArray *copyvelden = [[onderdeelview.basepart valueForKey:@"Velden"] mutableCopy];
                            Veld =[[NSMutableDictionary alloc] init];
                            [Veld setObject:[[AllVelden objectAtIndex:indexPath.row] valueForKey:@"Waarde"] forKey:@"Waarde"];
                            [Veld setObject:[NSNumber numberWithInteger:VeldId] forKey:@"VeldId"];

                                //////NSLog(@"%@", Veld);

                            if ([[copyvelden valueForKey:@"VeldId"] containsObject:[NSNumber numberWithInteger:VeldId]]) {
                                [copyvelden replaceObjectAtIndex:[[copyvelden valueForKey:@"VeldId"] indexOfObject:[NSNumber numberWithInteger:VeldId]] withObject:Veld];
                            }
                            else
                            {
                                [copyvelden addObject:Veld];
                            }
                            [onderdeelview.basepart setObject:copyvelden forKey:@"Velden"];
                            [FileManager insertnew:onderdeelview.basepart];

                            [search.titleView setText:[[AllVelden objectAtIndex:indexPath.row] valueForKey:@"WaardeLang"]];
                        }
                        else

                        {
                            Veld =[[NSMutableDictionary alloc] init];

                            [Veld setObject:[[AllVelden objectAtIndex:indexPath.row] valueForKey:@"Waarde"] forKey:@"Waarde"];
                            [Veld setObject:[NSNumber numberWithInteger:VeldId] forKey:@"VeldId"];
                            [FileManager getVelden_voertuig:[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"] add:Veld];
                        }
                    }

                }

            }
        }

    }


}
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)index{
    if (Airbag) {
        if (index ==0)
        {
            [Airbag setObject:[NSNumber numberWithBool:1] forKey:@"Geactiveerd"];
            [search.titleView setText:@"Aanwezig/Geactiveerd"];
            [search setBackgroundColor:[UIColor redColor]];
        }
        else if (index ==1)
        {
            [Airbag setObject:[NSNumber numberWithBool:0] forKey:@"Geactiveerd"];
            [search.titleView setText:@"Aanwezig/Niet geactiveerd"];
            [search setBackgroundColor:[UIColor greenColor]];
        }
        AllVelden =   [FileManager insertAirbags_voertuig:Airbag];
    } else if (Gordels) {
        if (index ==0)
        {
            [Gordels setObject:[NSNumber numberWithBool:1] forKey:@"Geactiveerd"];
            [search.titleView setText:@"Aanwezig/Geactiveerd"];
            [search setBackgroundColor:[UIColor redColor]];
        }
        else if (index ==1)
        {
            [Gordels setObject:[NSNumber numberWithBool:0] forKey:@"Geactiveerd"];
            [search.titleView setText:@"Aanwezig/Niet geactiveerd"];
            [search setBackgroundColor:[UIColor greenColor]];
        }
        AllVelden =   [FileManager insertgordels_voertuig:Gordels];
    }
}
@end
