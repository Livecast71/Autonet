//
//  SelectionView.m
//  Autonet
//
//  Created by Livecast02 on 08-06-17.
//  Copyright © 2017 Autonet. All rights reserved.
//
#import "SelectionView.h"
#import "TableViewCatagorie.h"
#import "TableViewOnderdelen.h"
#import "TableViewSelectie.h"
#import "BottumBarOnderdelen.h"
#import "AppDelegate.h"
#import "FileManager.h"
#import "CameraButton.h"
@implementation SelectionView
@synthesize CatogieView;
@synthesize OnderdelenTable;
@synthesize SelectieView;


- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self setBackgroundColor:[UIColor colorWithRed:0.965 green:0.933 blue:0.855 alpha:1.000]];
        [self setAlpha:1];
        [self setItems];
        [self setAlpha:0];
    }
    return self;
}


-(void)setItems
{
    CameraButton *back =[[CameraButton alloc]initWithFrame:CGRectMake(8,7, 40, 40)];
    [back setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [back setBackgroundColor:[UIColor colorWithRed:0.353 green:0.769 blue:0.812 alpha:1.000]];
    [self addSubview:back];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [back.layer setBorderWidth:2];
    [back.layer  setBorderColor:[UIColor whiteColor].CGColor];
    [back setItembig:[UIColor whiteColor] setImage:@"back.png"];
    [self.layer setCornerRadius:6];                   
    CatogieView =[[TableViewCatagorie alloc] initWithFrame:CGRectMake(10, 50, (self.frame.size.width/3)-15, self.frame.size.height-150)];
    [CatogieView setBackgroundColor:[UIColor whiteColor]];
    [CatogieView setAlpha:1];
    [self addSubview:CatogieView];

    [CatogieView setItem];
    OnderdelenTable =[[TableViewOnderdelen alloc] initWithFrame:CGRectMake(10+(self.frame.size.width/3), 50, (self.frame.size.width/3)-15, self.frame.size.height-150)];
    [OnderdelenTable setBackgroundColor:[UIColor whiteColor]];
    [OnderdelenTable setAlpha:1];
    [self addSubview:OnderdelenTable];
    [OnderdelenTable setItem];
    [CatogieView setTableOnderdelen:OnderdelenTable];
    SelectieView =[[TableViewSelectie alloc] initWithFrame:CGRectMake(10+((self.frame.size.width/3)*2), 50, (self.frame.size.width/3)-20, self.frame.size.height-180)];
    [SelectieView setBackgroundColor:[UIColor whiteColor]];
    [SelectieView setAlpha:1];
    [self addSubview:SelectieView];

    [SelectieView setItem];
    [SelectieView.layer setBorderColor:[UIColor blackColor].CGColor];
    [SelectieView.layer setBorderWidth:1];
    [OnderdelenTable setTableViewSelectie:SelectieView];
    BottumBarOnderdelen *bar =[[BottumBarOnderdelen alloc] initWithFrame:CGRectMake(10, self.frame.size.height-70, self.frame.size.width-20, 60)];
    [bar setBackgroundColor:[UIColor colorWithRed:0.949 green:0.949 blue:0.949 alpha:1.0]];
    [self addSubview:bar];

    UIButton *Bewaar =[[UIButton alloc]initWithFrame:CGRectMake(10,10, 100, 40)];
    [Bewaar setTitle:@"Bewaar" forState:UIControlStateNormal];
    [Bewaar.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [Bewaar setBackgroundColor:[UIColor colorWithRed:0.251 green:0.502 blue:0.000 alpha:1.000]];
    [Bewaar addTarget:self action:@selector(Opslaan) forControlEvents:UIControlEventTouchUpInside];
    [Bewaar.layer setCornerRadius:4];
    [Bewaar.layer setBorderWidth:2];
    [Bewaar.layer  setBorderColor:[UIColor whiteColor].CGColor];
    [bar addSubview:Bewaar];
}
-(void)back:(CameraButton*)sender
{
   
    [self setAlpha:0];
}
-(void)Opslaan
{
    AppDelegate *appDelegate = [FileManager getDel];
  
        [appDelegate.viewcontroller.overlay setAlpha:0.5];
    [appDelegate.viewcontroller.overlay progressChange:100];
            double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    for (int k =0; k < [self.SelectieView.AllCatagories count]; k++) {
     
        
        NSMutableDictionary *coursCell =[[[FileManager getEmptyPart] firstObject] mutableCopy];

         for (int k =0; k < [[coursCell allKeys] count]; k++) {

               if ([[[coursCell allKeys] objectAtIndex:k] isEqualToString:@"AannamelijstOnderdeelId"]) {
                     [coursCell setObject:[[NSUUID UUID] UUIDString] forKey:[[coursCell allKeys] objectAtIndex:k]];
                }
               else if ([[[coursCell allKeys] objectAtIndex:k] isEqualToString:@"VoertuigId"]) {

                    if ([[appDelegate.currentCarDictionary allKeys] containsObject:@"VoertuigId"]) {
                   [coursCell setObject:[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"] forKey:[[coursCell allKeys] objectAtIndex:k]];

                    }
               }
               else if ([[[coursCell allKeys] objectAtIndex:k] isEqualToString:@"MerkId"]) {

                    if ([[appDelegate.currentCarDictionary allKeys] containsObject:@"MerkId"]) {

                  [coursCell setObject:[appDelegate.currentCarDictionary valueForKey:@"MerkId"] forKey:[[coursCell allKeys] objectAtIndex:k]];

                    }
               }
               else if ([[[coursCell allKeys] objectAtIndex:k] isEqualToString:@"ModelId"]) {

                    if ([[appDelegate.currentCarDictionary allKeys] containsObject:@"ModelId"]) {

                   [coursCell setObject:[appDelegate.currentCarDictionary valueForKey:@"ModelId"] forKey:[[coursCell allKeys] objectAtIndex:k]];

                    }
               }
               else if ([[[coursCell allKeys] objectAtIndex:k] isEqualToString:@"AldocModel"]) {

                   if ([[appDelegate.currentCarDictionary allKeys] containsObject:@"AldocModel"]) {

                   [coursCell setObject:[appDelegate.currentCarDictionary valueForKey:@"AldocModel"] forKey:[[coursCell allKeys] objectAtIndex:k]];

                   }
                   else

                   {
                       [coursCell setObject:@"" forKey:[[coursCell allKeys] objectAtIndex:k]];
                   }
               }


                else
                {

                        if ([[coursCell valueForKey:[[coursCell allKeys] objectAtIndex:k]] isKindOfClass:[NSNumber class]]) {


                            if ([coursCell valueForKey:[[coursCell allKeys] objectAtIndex:k]] == [NSNumber numberWithBool:NO]||[coursCell valueForKey:[[coursCell allKeys] objectAtIndex:k]] == [NSNumber numberWithBool:YES]) {


                                //////NSLog(@"%@ BOOL %@",[test valueForKey:[[test allKeys] objectAtIndex:k]],  [[test allKeys] objectAtIndex:k]);
                                [coursCell setObject:[NSNumber numberWithBool:NO] forKey:[[coursCell allKeys] objectAtIndex:k]];
                            }
                            else
                            {


                                //////NSLog(@"%@ NSNumber %@",[test valueForKey:[[test allKeys] objectAtIndex:k]],  [[test allKeys] objectAtIndex:k]);
                                [coursCell setObject:[NSNumber numberWithInt:0] forKey:[[coursCell allKeys] objectAtIndex:k]];
                            }

                        }
                        else if ([[coursCell valueForKey:[[coursCell allKeys] objectAtIndex:k]] isKindOfClass:[NSString class]]) {


                           //////NSLog(@"%@ NSString %@",[test valueForKey:[[test allKeys] objectAtIndex:k]],  [[test allKeys] objectAtIndex:k]);
                            [coursCell setObject:@"" forKey:[[coursCell allKeys] objectAtIndex:k]];

                        }
                        else if ([[coursCell valueForKey:[[coursCell allKeys] objectAtIndex:k]] isKindOfClass:[NSArray class]]) {



                            //////NSLog(@"%@ NSArray %@",[test valueForKey:[[test allKeys] objectAtIndex:k]] , [[test allKeys] objectAtIndex:k]);
                            [coursCell setObject:[[NSArray alloc] init] forKey:[[coursCell allKeys] objectAtIndex:k]];

                        }
                        else

                        {

                              //////NSLog(@"%@ onduidelijk %@",[test valueForKey:[[test allKeys] objectAtIndex:k]] , [[test allKeys] objectAtIndex:k]);
                            [coursCell setObject:[coursCell valueForKey:[[coursCell allKeys] objectAtIndex:k]] forKey:[[coursCell allKeys] objectAtIndex:k]];

                        }

                }

        }
       
           [coursCell setObject:[[self.SelectieView.AllCatagories objectAtIndex:k] valueForKey:@"DeelId"] forKey:@"DeelId"];
              
     [FileManager insertnew:coursCell];
    appDelegate.onderdelenVoertuigArray = [[FileManager getOnderdelen_voertuig:[appDelegate.currentCarDictionary valueForKey:@"Onderdelen"]] mutableCopy];
       
     }
        [appDelegate.viewcontroller.collectionOnderdelenView.catogorieStandaard.tableResult reloadData];
    [appDelegate.viewcontroller.selectionView setAlpha:0];
    [appDelegate.viewcontroller.maakOnderdeel setAlpha:0];
          [appDelegate.viewcontroller overlayAction];
    double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
          [appDelegate.viewcontroller.overlay setAlpha:0];
        [self.SelectieView.AllCatagories removeAllObjects];
        [self.SelectieView.tableResult reloadData];
        [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
    });
    [self setAlpha:0];
       });                   
}
@end
