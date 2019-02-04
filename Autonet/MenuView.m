//
//  LineButton.m
//  Autonet
//
//  Created by Livecast02 on 10-12-16.
//  Copyright © 2016 Autonet. All rights reserved.
//
#import "MenuView.h"
#import "TableView.h"
#import "AppDelegate.h"
#import "FileManager.h"
@implementation MenuView
@synthesize AllLines;
@synthesize baseColor;
@synthesize contraColor;
@synthesize info;
@synthesize fotos;
@synthesize inkoop;
@synthesize verkoop;
@synthesize aannamelijst;
@synthesize internet;
@synthesize search;
@synthesize Uploaden;
@synthesize content;
@synthesize onderdelen;
@synthesize ListVoertuigen;

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setItem:baseColor];
    }
    return self;
}

-(void)setItem:(UIColor*)color
{
    baseColor =color;
    contraColor =[UIColor colorWithRed:0.414 green:0.806 blue:0.849 alpha:1.000];
    AllLines =[[NSMutableArray alloc] init];
    content = [[LineView alloc] initWithFrame:CGRectMake(4, 4, 260, self.frame.size.height)];
    [content setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
    [self addSubview:content];
    [content.layer setCornerRadius:6];
    Uploaden =[[ImageButton alloc]initWithFrame:CGRectMake(250, 4, 50, 100)];
    [Uploaden addTarget:self action:@selector(move:) forControlEvents:UIControlEventTouchUpInside];
    [Uploaden setTitleColor:[UIColor colorWithRed:0.267 green:0.588 blue:0.722 alpha:1.000] forState:UIControlStateNormal];
    // [Uploaden setTitle:NSLocalizedString(@"Uploaden", @"Uploaden") forState:UIControlStateNormal];
    [Uploaden setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Uploaden setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
    [self addSubview:Uploaden];
    [Uploaden setItemtop:[UIColor whiteColor] setImage:@"m24_format_list_bulleted_black.png"];
    /*
    search =[[ImageButton alloc]initWithFrame:CGRectMake(250, 106, 50, 50)];
    [search addTarget:self action:@selector(move:) forControlEvents:UIControlEventTouchUpInside];
    [search setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
    [search setTag:100];
    [self addSubview:search];
    [search setItem:[UIColor whiteColor] setImage:@"search.png"];
     
     */
    info =[[ImageButton alloc]initWithFrame:CGRectMake(250, 106, 50, 50)];
    [info addTarget:self action:@selector(move:) forControlEvents:UIControlEventTouchUpInside];
    [info setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
    [info setTag:101];
    [self addSubview:info];
    [info setItem:[UIColor whiteColor] setImage:@"01.png"];
 
    aannamelijst =[[ImageButton alloc]initWithFrame:CGRectMake(250, 158, 50, 50)];
    [aannamelijst addTarget:self action:@selector(move:) forControlEvents:UIControlEventTouchUpInside];
    [aannamelijst setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
    [aannamelijst setTag:102];
    [self addSubview:aannamelijst];
    [aannamelijst setItem:[UIColor whiteColor] setImage:@"11.png"];
    onderdelen =[[ImageButton alloc]initWithFrame:CGRectMake(250, 210, 50, 50)];
    [onderdelen addTarget:self action:@selector(move:) forControlEvents:UIControlEventTouchUpInside];
    [onderdelen setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
    [onderdelen setTag:108];
    [self addSubview:onderdelen];
    [onderdelen setItem:[UIColor whiteColor] setImage:@"Carparts.png"];
    ImageButton *verzenden =[[ImageButton alloc]initWithFrame:CGRectMake(250, 263, 50, 50)];
    [verzenden addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];
    [verzenden setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
    [verzenden setTag:103];
    [self addSubview:verzenden];
    [verzenden setItem:[UIColor whiteColor] setImage:@"13.png"];
/*
    verkoop =[[ImageButton alloc]initWithFrame:CGRectMake(250, 366, 50, 50)];
    [verkoop addTarget:self action:@selector(move:) forControlEvents:UIControlEventTouchUpInside];
    [verkoop setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
    [verkoop setTag:105];
    [self addSubview:verkoop];
    [verkoop setItem:[UIColor whiteColor] setImage:@"verkoop.png"];
    inkoop =[[ImageButton alloc]initWithFrame:CGRectMake(250, 418, 50, 50)];
    [inkoop addTarget:self action:@selector(move:) forControlEvents:UIControlEventTouchUpInside];
    [inkoop setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
    [inkoop setTag:106];
    [self addSubview:inkoop];
    [inkoop setItem:[UIColor whiteColor] setImage:@"inkoop.png"];
    internet =[[ImageButton alloc]initWithFrame:CGRectMake(250, 462, 50, 50)];
    [internet addTarget:self action:@selector(move:) forControlEvents:UIControlEventTouchUpInside];
    [internet setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
    [internet setTag:107];
    [self addSubview:internet];
    [internet setItem:[UIColor whiteColor] setImage:@"8.png"];
     */
    ListVoertuigen =[[TableView alloc]initWithFrame:CGRectMake(10, 10, 240, self.frame.size.height-30)];
    [ListVoertuigen setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
    [self addSubview:ListVoertuigen];
    [ListVoertuigen setItem:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
}


-(void)send:(LineButton*)sender
{
    AppDelegate *appDelegate = [FileManager getDel];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.4f];
    appDelegate.viewcontroller.Loadingend.transform = CGAffineTransformMakeScale(1, 1);
    [appDelegate.viewcontroller.Loadingend setAlpha:1];
    [appDelegate.viewcontroller overlayAction];
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    appDelegate.viewcontroller.Loadingend.TotalVoertuigen =[[FileManager getVoertuigen] mutableCopy];
    [appDelegate.viewcontroller.Loadingend.tableupload reloadData];
    [UIView commitAnimations];
    }
-(void)move:(LineButton*)sender
{
 AppDelegate *appDelegate = [FileManager getDel];
 [appDelegate.viewcontroller overlayAction];



    [appDelegate.viewcontroller.navigaionView.collectionViewNav reloadData];
    [appDelegate.viewcontroller.menu.ListVoertuigen.tableResult reloadData];

    if (self.frame.origin.x <0)
    {
        if ([sender isEqual:Uploaden]) {
           [search setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
            [info setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
            [fotos setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
            [internet setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
            [inkoop setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
            [aannamelijst setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
            [verkoop setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
            [onderdelen setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationDuration:0.2f];
            [self setFrame:CGRectMake(4, 54, 300, self.frame.size.height)];
            [UIView commitAnimations];
            double delayInSeconds = 0.3;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
               [sender setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
                [self.content setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
                // [self setTitleColor:baseColor forState:normal];
                
            });
        }
        else
        {
           [search setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
            [info setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
            [fotos setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
            [internet setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
            [inkoop setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
            [aannamelijst setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
            [verkoop setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
            [onderdelen setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
        }
    } else {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.2f];
        [self setFrame:CGRectMake(-260, 54, 300, self.frame.size.height)];
        [search setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
        [info setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
        [fotos setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
        [internet setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
        [inkoop setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
        [aannamelijst setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
        [verkoop setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
         [onderdelen setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
        [UIView commitAnimations];
       
         
    }
    [sender setBackgroundColor:contraColor];
    [content setBackgroundColor:contraColor];
    //[self setTitleColor:contraColor forState:normal];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.2f];
    [appDelegate.viewcontroller.carView setAlpha:0];
    [appDelegate.viewcontroller.Collectionsearch setAlpha:0];

    [appDelegate.viewcontroller.collectionOnderdelenView.aannamelijstView reset];
    [appDelegate.viewcontroller.collectionOnderdelenView.catogorie reset];
    [appDelegate.viewcontroller.collectionOnderdelenView.onderdelen reset];
    
    [appDelegate.viewcontroller.collectionOnderdelenView setAlpha:0];



    [appDelegate.viewcontroller.listOnderdelenView setAlpha:0];
    [UIView commitAnimations];
    if (sender.tag ==101) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.2f];
      [appDelegate.viewcontroller.carView setAlpha:1];
        [UIView commitAnimations];
    } else if (sender.tag ==102) {
        appDelegate.aanname =NO;
        [appDelegate.viewcontroller.collectionOnderdelenView.aannamelijstView setAlpha:1];
        [appDelegate.viewcontroller.collectionOnderdelenView.voegOnderdeelToe setAlpha:1];
        [appDelegate.viewcontroller.collectionOnderdelenView.catogorieStandaard setAlpha:0];
          [appDelegate.viewcontroller.collectionOnderdelenView.onderdelen setFrame:CGRectMake(506, 4, 280, 40)];
        appDelegate.categorieenArray =[[FileManager getCategorieen:@""] mutableCopy];

        if ( [[appDelegate.categorieenArray valueForKey:@"Naam"] containsObject:@"Toegevoegde onderdelen"]) {
        }
        else
        {
           NSMutableDictionary *adnone = [[NSMutableDictionary alloc] init];
            [adnone setObject:@"Toegevoegde onderdelen" forKey:@"Naam"];
            [adnone setObject:[NSMutableArray alloc] forKey:@"Onderdelen"];
            [appDelegate.categorieenArray addObject:adnone];
        }
        [appDelegate.viewcontroller.collectionOnderdelenView.catogorie setAlpha:1];
        [appDelegate.viewcontroller.collectionOnderdelenView.catogorie.tableResult reloadData];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.2f];

        [appDelegate.viewcontroller.collectionOnderdelenView.aannamelijstView reset];
        [appDelegate.viewcontroller.collectionOnderdelenView.catogorie reset];
        [appDelegate.viewcontroller.collectionOnderdelenView.onderdelen reset];
        [appDelegate.viewcontroller.collectionOnderdelenView setAlpha:1];

        [UIView commitAnimations];
        



    if ( [[appDelegate.currentCarDictionary valueForKey:@"Onderdelen"] isKindOfClass:[NSMutableArray class]]) {
        
        [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
        NSString *docDir = [FileManager getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"Onderdelen", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
        NSFileManager *FileManager2 = [NSFileManager defaultManager];
        BOOL success = [FileManager2 fileExistsAtPath:itemFilePath];
        if (!success) {

          
        }
        else
        {

            NSMutableArray *copy = [[NSMutableArray alloc] init];
            [copy writeToFile:itemFilePath atomically: YES];
            NSString *stringinsert = [NSString stringWithFormat:@"%@_%@",@"Onderdelen", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
            NSInteger index = [appDelegate.alleVoertuigenArray indexOfObject:appDelegate.currentCarDictionary];
            [appDelegate.currentCarDictionary setObject:stringinsert forKey:@"Onderdelen"];
            [appDelegate.alleVoertuigenArray replaceObjectAtIndex:index withObject:appDelegate.currentCarDictionary];
            NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/Voertuigen.plist",docDir];
            [appDelegate.alleVoertuigenArray writeToFile:itemFilePath atomically: YES];
        }
       
     }
    else {

    if ([[appDelegate.currentCarDictionary valueForKey:@"Onderdelen"] length]>0)
        {

            ////////////NSLog(@"1");
        appDelegate.onderdelenVoertuigArray = [[FileManager getOnderdelen_voertuig:[appDelegate.currentCarDictionary valueForKey:@"Onderdelen"]] mutableCopy];
              [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
        }
        else
        {
             ////////////NSLog(@"2");
           appDelegate.onderdelenVoertuigArray =[[NSMutableArray alloc] init];
              [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
        }
    }
    } else if (sender.tag ==108) {
            appDelegate.aanname =YES;
        [appDelegate.viewcontroller.collectionOnderdelenView.aannamelijstView setAlpha:0];
        [appDelegate.viewcontroller.collectionOnderdelenView.voegOnderdeelToe setAlpha:0];
        [appDelegate.viewcontroller.collectionOnderdelenView.catogorieStandaard setAlpha:1];


        [appDelegate.viewcontroller.collectionOnderdelenView.onderdelen setFrame:CGRectMake(10, 4, 280, 40)];
        [appDelegate.viewcontroller.collectionOnderdelenView.catogorie setAlpha:0];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.2f];
        [appDelegate.viewcontroller.collectionOnderdelenView.aannamelijstView reset];
        [appDelegate.viewcontroller.collectionOnderdelenView.catogorie reset];
        [appDelegate.viewcontroller.collectionOnderdelenView.onderdelen reset];

        [appDelegate.viewcontroller.collectionOnderdelenView setAlpha:1];


        [UIView commitAnimations];
       
        if ( [[appDelegate.currentCarDictionary valueForKey:@"Onderdelen"] isKindOfClass:[NSMutableArray class]]) {
           [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
            NSString *docDir = [FileManager getDir];
            NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"Onderdelen", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
            NSFileManager *FileManager2 = [NSFileManager defaultManager];
            BOOL success = [FileManager2 fileExistsAtPath:itemFilePath];
            if (!success) {
               

               
            }
            else
                
            {

                NSMutableArray *copy = [[NSMutableArray alloc] init];
                [copy writeToFile:itemFilePath atomically: YES];

                NSString *stringinsert = [NSString stringWithFormat:@"%@_%@",@"Onderdelen", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];

                NSInteger index = [appDelegate.alleVoertuigenArray indexOfObject:appDelegate.currentCarDictionary];
                [appDelegate.currentCarDictionary setObject:stringinsert forKey:@"Onderdelen"];
                [appDelegate.alleVoertuigenArray replaceObjectAtIndex:index withObject:appDelegate.currentCarDictionary];
                NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/Voertuigen.plist",docDir];
                [appDelegate.alleVoertuigenArray writeToFile:itemFilePath atomically: YES];
           }
        }
        else
        {


           if ([[appDelegate.currentCarDictionary valueForKey:@"Onderdelen"] length]>0)
                
            {
               ////////////NSLog(@"4");
                appDelegate.onderdelenVoertuigArray = [[FileManager getOnderdelen_voertuig:[appDelegate.currentCarDictionary valueForKey:@"Onderdelen"]] mutableCopy];
                
                [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
            }
            else
            {

                 ////////////NSLog(@"5");
                   appDelegate.onderdelenVoertuigArray =[[NSMutableArray alloc] init];
                
                  [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
            }
        }
       
         
    } else if (sender.tag ==103) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.2f];
         [appDelegate.viewcontroller.listOnderdelenView setAlpha:1];
        [UIView commitAnimations];
        if ([[appDelegate.currentCarDictionary valueForKey:@"Onderdelen"] length]>0)
        {

               ////////////NSLog(@"6");
        appDelegate.onderdelenVoertuigArray = [[FileManager getOnderdelen_voertuig:[appDelegate.currentCarDictionary valueForKey:@"Onderdelen"]] mutableCopy];
            [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
        }
        else
        {

             ////////////NSLog(@"7");
            appDelegate.onderdelenVoertuigArray =[[NSMutableArray alloc] init];

            [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
        }
    } else if (sender.tag ==104) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.2f];
        [appDelegate.viewcontroller.carView setAlpha:0];
        [UIView commitAnimations];
    }
        [appDelegate.viewcontroller.collectionOnderdelenView.catogorie.search setTitle:@"Kies eigen categorie..." forState:UIControlStateNormal];


    if (appDelegate.viewcontroller.carView.alpha == 0 && appDelegate.viewcontroller.collectionOnderdelenView.alpha ==0) {

        appDelegate.viewcontroller.carView.alpha = 1;

    }

}
@end
