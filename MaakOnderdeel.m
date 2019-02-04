//
//  MaakOnderdeel.m
//  Autonet
//
//  Created by Livecast02 on 17-05-17.
//  Copyright © 2017 Autonet. All rights reserved.
//
#import "MaakOnderdeel.h"
#import "CameraButton.h"
#import "DeelView.h"
#import "FileManager.h"
#import "OnderdeelView.h"
#import "AppDelegate.h"
#import "OnderdelenViewSelect.h"
@implementation MaakOnderdeel
@synthesize onderdelen;

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {

        [self setBackgroundColor:[UIColor colorWithRed:0.965 green:0.933 blue:0.855 alpha:1.000]];
        [self setAlpha:0];
    }
    return self;
}


-(void)setItems
{
    AppDelegate *appDelegate = [FileManager getDel];
        CameraButton *back =[[CameraButton alloc]initWithFrame:CGRectMake(8,7, 40, 40)];
    [back setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [back setBackgroundColor:[UIColor colorWithRed:0.353 green:0.769 blue:0.812 alpha:1.000]];
    [self addSubview:back];

    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [back.layer setBorderWidth:2];
    [back.layer  setBorderColor:[UIColor whiteColor].CGColor];
    [back setItembig:[UIColor whiteColor] setImage:@"back.png"];
    [self.layer setCornerRadius:6];
    UIButton *Bewaar =[[UIButton alloc]initWithFrame:CGRectMake(50,7, 100, 40)];
    [Bewaar setTitle:@"Bewaar" forState:UIControlStateNormal];
    [Bewaar.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [Bewaar setBackgroundColor:[UIColor colorWithRed:0.251 green:0.502 blue:0.000 alpha:1.000]];
    [Bewaar addTarget:self action:@selector(Opslaan) forControlEvents:UIControlEventTouchUpInside];
    [Bewaar.layer setCornerRadius:4];
    [Bewaar.layer setBorderWidth:2];
    [Bewaar.layer  setBorderColor:[UIColor whiteColor].CGColor];
    [self addSubview:Bewaar];

        NSMutableDictionary *coursCell =[[appDelegate.onderdelenVoertuigArray firstObject] mutableCopy];
   
    NSArray *velden =[FileManager getOnderdelen:[[coursCell valueForKey:@"DeelId"] integerValue]];
    [coursCell setObject:[FileManager getOnderdelenWaardes:[coursCell valueForKey:@"DeelId"]] forKey:@"Velden"];
        OnderdeelView *onderdeel =[[OnderdeelView alloc]initWithFrame:CGRectMake(5, 55, self.frame.size.width-20, 50)];
    [onderdeel setTag:27];
    [self addSubview:onderdeel];
        onderdeel.indexand =0;
    [onderdeel setBackgroundColor:[UIColor clearColor]];
    onderdeel.layer.shadowOffset = CGSizeMake(0, 0);
    onderdeel.layer.shadowOpacity = 0;
    onderdeel.contentdict =[[FileManager getOnderdelenWaardes:[coursCell valueForKey:@"DeelId"]] mutableCopy];
    onderdeel.basepart =  coursCell;
    [onderdeel setVeldenEmpty:velden];
    //onderdeel.parentcell =nu;
    onderdeel.sizeit =50;
        onderdelen =[[OnderdelenViewSelect alloc]initWithFrame:CGRectMake(self.frame.size.width-290, 7, 280, 40)];
    [onderdeel setBackgroundColor:[UIColor colorWithRed:0.439289 green:0.764236 blue:0.506794 alpha:0.5]];
    [self addSubview:onderdelen];
    
    [onderdelen setAlpha:0];
    [onderdelen.layer setBorderColor:[UIColor colorWithRed:0.525 green:0.706 blue:0.871 alpha:1.000].CGColor];
    onderdelen.parant =self;
    onderdelen.layer.borderWidth = 2;
    [onderdelen.layer setCornerRadius:4];
    [onderdelen setItem:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
}


-(void)reset:(NSString*)DeelId
{
  AppDelegate *appDelegate = [FileManager getDel];
    OnderdeelView *existlabel = (OnderdeelView *)[self viewWithTag:27];
    [existlabel removeFromSuperview];


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
    [coursCell setObject:DeelId forKey:@"DeelId"];
    NSArray *velden =[[FileManager getOnderdelen:[[coursCell valueForKey:@"DeelId"] intValue]] mutableCopy];
    NSArray *names = [FileManager getOnderdelenWaardes:[coursCell valueForKey:@"DeelId"]];
    [coursCell setObject:[names valueForKey:@"DeelVelden"] forKey:@"Velden"];
    float Number =55;
    if ([velden count] % 2)
    {
       
         Number =(([velden count]+1)*55)/2;
       
     }
    else {
       
         Number =((([velden count])*55)/2);
    }
    OnderdeelView *onderdeel =[[OnderdeelView alloc]initWithFrame:CGRectMake(5, 55, self.frame.size.width-20, 760+ Number)];
    [onderdeel setTag:27];
    [self insertSubview:onderdeel belowSubview:onderdelen];
    onderdeel.indexand =0;
    [onderdeel setBackgroundColor:[UIColor clearColor]];
    onderdeel.layer.shadowOffset = CGSizeMake(0, 0);
    onderdeel.layer.shadowOpacity = 0;
    onderdeel.contentdict =[[FileManager getOnderdelenWaardes:[coursCell valueForKey:@"DeelId"]] mutableCopy];
    onderdeel.basepart = coursCell;
    [onderdeel setVeldenEmpty:velden];
  
    onderdeel.sizeit =150+Number;
    if ([[names valueForKey:@"DeelNamen"] count]>0) {
       
         [onderdeel.titletopview setText:[NSString stringWithFormat:@"%@", [[[names valueForKey:@"DeelNamen"] firstObject] valueForKey:@"Naam"]]];
       
     }
  
}
-(void)back:(CameraButton*)sender
{
    AppDelegate *appDelegate = [FileManager getDel];
    OnderdeelView *existlabel = (OnderdeelView *)[self viewWithTag:27];
    [FileManager RemoveNew:existlabel.basepart];
    //[existlabel.basepart
    [existlabel removeFromSuperview];
    [onderdelen removeFromSuperview];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.2f];
    [appDelegate.viewcontroller.selectionView setAlpha:1];
    [appDelegate.viewcontroller.maakOnderdeel setAlpha:0];
    [UIView commitAnimations];
    [appDelegate.viewcontroller overlayAction];
  [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
   
    appDelegate.onderdelenVoertuigArray = [[FileManager getOnderdelen_voertuig:[appDelegate.currentCarDictionary valueForKey:@"Onderdelen"]] mutableCopy];
      [appDelegate.viewcontroller.collectionOnderdelenView.catogorieStandaard.tableResult reloadData];
}
-(void)Opslaan
{
    AppDelegate *appDelegate = [FileManager getDel];
    [appDelegate.viewcontroller overlayAction];
    OnderdeelView *existlabel = (OnderdeelView *)[self viewWithTag:27];
    [FileManager insertnew:existlabel.basepart];
    appDelegate.onderdelenVoertuigArray = [[FileManager getOnderdelen_voertuig:[appDelegate.currentCarDictionary valueForKey:@"Onderdelen"]] mutableCopy];
      [appDelegate.viewcontroller.collectionOnderdelenView.catogorieStandaard.tableResult reloadData];
    [existlabel removeFromSuperview];
    [onderdelen removeFromSuperview];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.2f];
    [appDelegate.viewcontroller.selectionView setAlpha:0];
    [appDelegate.viewcontroller.maakOnderdeel setAlpha:0];
    [UIView commitAnimations];
         [appDelegate.viewcontroller overlayAction];
         
     double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
  
        [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
    });                   
}
@end
