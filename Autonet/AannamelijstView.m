    //
    //  LineButton.m
    //  Autonet
    //
    //  Created by Livecast02 on 10-12-16.
    //  Copyright © 2016 Autonet. All rights reserved.
    //
#import "AannamelijstView.h"
#import "FileManager.h"
#import "ImageButton.h"
#import "LabelButton.h"
#import "AppDelegate.h"
#import "FileManager.h"
#import "CameraButton.h"
@implementation AannamelijstView
@synthesize AllLines;
@synthesize baseColor;
@synthesize contraColor;
@synthesize searchDict;
@synthesize tableResult;
@synthesize search;
@synthesize Deelnamen;
@synthesize Delen;
@synthesize aannameLijstKeuze;
-(void)setItem:(UIColor*)color
{
    Delen =[[FileManager getAannamelijst:@""] mutableCopy];
    aannameLijstKeuze =[[NSMutableDictionary alloc] init];
    baseColor =[UIColor colorWithRed:0.267 green:0.588 blue:0.722 alpha:1.000];
    
    UIView *back =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,40)];
    [back setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:back];
    
    UIButton *click =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,40)];
    [click addTarget:self action:@selector(move:) forControlEvents:UIControlEventTouchUpInside];
    [click setTitle:@"Selecteer aannamelijst" forState:UIControlStateNormal];
    [click setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.000]];
    [click setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [click.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [click setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.000]];
    [self addSubview:click];
    
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
}
-(void)reloadall
{
    Delen =[[FileManager getAannamelijst:@""] mutableCopy];
    [tableResult reloadData];
}
-(void)move:(LineButton*)sender
{
    [self reloadall];
    if (self.frame.size.height==40)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.2f];
        [self setFrame:CGRectMake(self.frame.origin.x, 4, self.frame.size.width, 40*7)];
        [self.tableResult setFrame:CGRectMake(self.tableResult.frame.origin.x, 40, self.tableResult.frame.size.width, 40*6)];
        [UIView commitAnimations];
    } else {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.2f];
        [self setFrame:CGRectMake(self.frame.origin.x, 4, self.frame.size.width, 40)];
        [self.tableResult setFrame:CGRectMake(self.tableResult.frame.origin.x, 40, self.tableResult.frame.size.width, 40)];
        [UIView commitAnimations];
    }
}

- (void)reset

{
    [self setFrame:CGRectMake(self.frame.origin.x, 4, self.frame.size.width, 40)];
    [self.tableResult setFrame:CGRectMake(self.tableResult.frame.origin.x, 40, self.tableResult.frame.size.width, 40)];
}


#pragma mark - tabelDelegate method
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *content =[[UIView alloc] initWithFrame:CGRectMake(0,0,self.frame.size.width,80)];
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
        //AppDelegate *appDelegate = [FileManager getDel];
        //nsarray
    return [Delen count];
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
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    UILabel *existlabel = (UILabel *)[cell viewWithTag:105];
    if (existlabel) {
        [existlabel setFrame:CGRectMake(10,0,200,40)];
        [existlabel setText:[[Delen objectAtIndex:indexPath.row] valueForKey:@"Naam"]];
    } else {
        UILabel *kenteken =[[UILabel alloc] initWithFrame:CGRectMake(10,0,200,40)];
        [kenteken setBackgroundColor:[UIColor clearColor]];
        [kenteken setText:[[Delen objectAtIndex:indexPath.row] valueForKey:@"Naam"]];
        [kenteken setFont:[UIFont systemFontOfSize:12]];
        [kenteken setTextAlignment:NSTextAlignmentCenter];
        [kenteken setTag:105];
        [cell addSubview:kenteken];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)index{
    AppDelegate *appDelegate = [FileManager getDel];
    if (index ==0)
    {
    } else {
        double delayInSeconds = 0.3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [appDelegate.viewcontroller.overlay setAlpha:0.5];
            [appDelegate.viewcontroller.overlay progressChange:100];
            [self performSelectorInBackground:@selector(Opslaan) withObject:NULL];
        });
    }
}
-(void)Opslaan
{
    dispatch_async(dispatch_get_main_queue(), ^{
        AppDelegate *appDelegate = [FileManager getDel];
        NSString *docDir = [FileManager getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"Onderdelen", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
        NSMutableArray* copyplist = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
        if (copyplist) {
        }
        else
        {
            copyplist =[[NSMutableArray alloc] init];
        }
        NSMutableArray *set =[[NSMutableArray alloc] init];
        [set addObject:[[FileManager getAannamelijstenCategorieen] valueForKey:@"Groepen"]];
        for (int k =0; k < [set count]; k++) {
            NSMutableArray *copy =[[set objectAtIndex:k] valueForKey:@"Onderdelen"];
            for (int i =0; i < [copy count]; i++) {
                if ([[copyplist valueForKey:@"DeelId"] containsObject:[[copy objectAtIndex:i] valueForKey:@"OnderdeelId"]]) {
                }
                else
                {
                    if ([[copy objectAtIndex:i] count]>0) {
                        
                        [copyplist addObjectsFromArray:[FileManager insertDelen:[[copy objectAtIndex:i] valueForKey:@"OnderdeelId"]]];
                        
                    }
                }
            }
        }
        NSString *documentsDirectorybureau =  [NSString stringWithFormat:@"/Users/jeffreysnijder02/Desktop/Demo/%@_%@.plist",@"Onderdelen", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
        NSString *defItemString = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"Onderdelen", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
        [copyplist writeToFile:defItemString atomically: YES];
        [copyplist writeToFile:documentsDirectorybureau atomically: YES];
        double delayInSeconds = 0.3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [appDelegate.viewcontroller.overlay setAlpha:0];
            appDelegate.onderdelenVoertuigArray = [[FileManager getOnderdelen_voertuig:[appDelegate.currentCarDictionary valueForKey:@"Onderdelen"]] mutableCopy];                   
            [appDelegate.currentCollection.collectionViewcopy reloadData];
            [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
            [appDelegate.viewcontroller.overlay setAlpha:0];
            
        });
    });
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [FileManager UserAannamelijst:[Delen objectAtIndex:indexPath.row]];
    AppDelegate *appDelegate = [FileManager getDel];
    appDelegate.categorieenArray =[[FileManager getCategorieen:@""] mutableCopy];
    if ( [[appDelegate.categorieenArray valueForKey:@"Naam"] containsObject:@"Toegevoegde onderdelen"]) {
    } else {
        NSMutableDictionary *adnone = [[NSMutableDictionary alloc] init];
        [adnone setObject:@"Toegevoegde onderdelen" forKey:@"Naam"];
        [adnone setObject:[NSMutableArray alloc] forKey:@"Onderdelen"];
        [appDelegate.categorieenArray addObject:adnone];
    }
    [appDelegate.viewcontroller.collectionOnderdelenView.catogorie.tableResult reloadData];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.2f];
    [self setFrame:CGRectMake(self.frame.origin.x, 4, self.frame.size.width, 40)];
    [self.tableResult setFrame:CGRectMake(self.tableResult.frame.origin.x, 40, self.tableResult.frame.size.width, 40)];
    [UIView commitAnimations];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"aannamelijst aanmaken"
                                                   delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Aanmaken", nil];
    [alert setTag:406];
    [alert show];
    [tableResult reloadData];
}
@end
