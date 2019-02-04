    //
    //  LineButton.m
    //  Autonet
    //
    //  Created by Livecast02 on 10-12-16.
    //  Copyright © 2016 Autonet. All rights reserved.
    //
#import "VeldenListView.h"
#import "FileManager.h"
#import "ImageButton.h"
#import "LabelButton.h"
#import "AppDelegate.h"
#import "FileManager.h"
@implementation VeldenListView
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
-(void)setItem:(NSArray*)velden
{

    AllVelden = [velden mutableCopy];
    AllVelden_voertuig = [[FileManager getVelden_voertuig:@""]  mutableCopy];
    NSString *queryit = [NSString stringWithFormat:@"VeldId = %li", (long)VeldId];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[AllVelden_voertuig  filteredArrayUsingPredicate:predicateit] mutableCopy];
    if ([items count]>0) {
        NSString *querydouble;
        if ([[[items firstObject] valueForKey:@"Waarde"]  isKindOfClass:[NSArray class]]) {
            NSMutableString *string =[[NSMutableString alloc] init];
            for (int k =0; k < [[[items firstObject] valueForKey:@"Waarde"] count]; k++) {
                [string appendString:[NSString stringWithFormat:@"(Waarde LIKE [cd]'%@')#", [[[items firstObject] valueForKey:@"Waarde"] objectAtIndex:k]]];
            }
            querydouble = [NSString stringWithFormat:@"%@", [[string stringByReplacingOccurrencesOfString:@")#(" withString:@") and ("] stringByReplacingOccurrencesOfString:@"#" withString:@""]];
        }
        else
        {
            querydouble = [NSString stringWithFormat:@"Waarde LIKE [cd]'%@'", [[items firstObject] valueForKey:@"Waarde"]];
        }
        Veld = [items firstObject];
            ////////////NSLog(@"%@", querydouble);
        NSPredicate *predicatedouble = [NSPredicate predicateWithFormat:querydouble];
        NSMutableArray *itemsExtra =  [[AllVelden filteredArrayUsingPredicate:predicatedouble] mutableCopy];

        
        if ([itemsExtra count]>0) {

            search =[[ImageButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,30)];
            [search addTarget:self action:@selector(move:) forControlEvents:UIControlEventTouchUpInside];
            [search setTitle:[[itemsExtra firstObject] valueForKey:@"WaardeLang"] forState:UIControlStateNormal];
            [search.titleLabel setFont:[UIFont systemFontOfSize:8]];
            [search.titleLabel setNumberOfLines:2];
            [search setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.000]];
            [search setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [search setTag:100];
            [search.layer setCornerRadius:4];
            [self addSubview:search];

            [self.layer setCornerRadius:6];
            [self.layer setMasksToBounds:YES];
        }
        else
        {
            search =[[ImageButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,30)];
            [search addTarget:self action:@selector(move:) forControlEvents:UIControlEventTouchUpInside];
            [search setTitle:@"Selecteer groep..." forState:UIControlStateNormal];
            [search.titleLabel setFont:[UIFont systemFontOfSize:8]];
            [search.titleLabel setNumberOfLines:2];
            [search setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.000]];
            [search setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [search setTag:100];
            [search.layer setCornerRadius:4];
            [self addSubview:search];
        }
    } else {

        search =[[ImageButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,30)];
        [search addTarget:self action:@selector(move:) forControlEvents:UIControlEventTouchUpInside];
        [search setTitle:@"Selecteer groep..." forState:UIControlStateNormal];
        [search.titleLabel setFont:[UIFont systemFontOfSize:8]];
        [search.titleLabel setNumberOfLines:2];
        [search setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.000]];
        [search setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [search setTag:100];
        [search.layer setCornerRadius:4];
        [self addSubview:search];
        [self.layer setCornerRadius:6];
        [self.layer setMasksToBounds:YES];

    }
    tableResult =[[UITableView alloc] initWithFrame:CGRectMake(0, 30, self.frame.size.width,self.frame.size.height-30)];
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
-(void)move:(LineButton*)sender
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.2f];

    if (self.frame.size.height==30)
    {
        [self setFrame:CGRectMake(self.frame.origin.x, 4, self.frame.size.width, 30*4.3)];
        [self.tableResult setFrame:CGRectMake(0, 30, self.tableResult.frame.size.width, 30*3.3)];
    } else {
        [self setFrame:CGRectMake(self.frame.origin.x, asY, self.frame.size.width, 30)];
        [self.tableResult setFrame:CGRectMake(0, 30, self.tableResult.frame.size.width, 30)];
    }

    [UIView commitAnimations];
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
        [existlabel setFrame:CGRectMake(8,0,130,30)];
        [existlabel setText:[[AllVelden objectAtIndex:indexPath.row] valueForKey:@"WaardeLang"]];
    } else {
        UILabel *kenteken =[[UILabel alloc] initWithFrame:CGRectMake(8,0,130,30)];
        [kenteken setBackgroundColor:[UIColor clearColor]];
        [kenteken setText:[[AllVelden objectAtIndex:indexPath.row] valueForKey:@"WaardeLang"]];
        [kenteken setFont:[UIFont systemFontOfSize:8]];
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
    return 30;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *appDelegate = [FileManager getDel];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.2f];
    [self setFrame:CGRectMake(self.frame.origin.x, asY, self.frame.size.width, 30)];
    [self.tableResult setFrame:CGRectMake(0, 30, self.tableResult.frame.size.width, 30)];
    NSString *queryit = [NSString stringWithFormat:@"VeldId = %li", (long)VeldId];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[AllVelden_voertuig  filteredArrayUsingPredicate:predicateit] mutableCopy];
    if ([items count]>0) {
        [Veld setObject:[[AllVelden objectAtIndex:indexPath.row] valueForKey:@"Waarde"] forKey:@"Waarde"];
        [AllVelden_voertuig replaceObjectAtIndex:(unsigned long)[AllVelden_voertuig indexOfObject:[items firstObject]] withObject:Veld];
        NSString *docDir = [FileManager getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"Velden", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
        [AllVelden_voertuig writeToFile:itemFilePath atomically: YES];
            //[appDelegate.viewcontroller.onderdelenView.collectionViewcopy reloadData];
        NSString *documentsDirectorybureau =  [NSString stringWithFormat:@"/Users/jeffreysnijder02/Desktop/Demo/%@",[NSString stringWithFormat:@"%@_%@.plist",@"Velden", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]]];
        [AllVelden_voertuig writeToFile:documentsDirectorybureau atomically: YES];
    } else {
        Veld =[[NSMutableDictionary alloc] init];
        [Veld setObject:[[AllVelden objectAtIndex:indexPath.row] valueForKey:@"Waarde"] forKey:@"Waarde"];
        [Veld setObject:[NSNumber numberWithInteger:VeldId] forKey:@"VeldId"];
        [AllVelden_voertuig addObject:Veld];
        NSString *docDir = [FileManager getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"Velden", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
        [AllVelden_voertuig writeToFile:itemFilePath atomically: YES];
            //[appDelegate.viewcontroller.onderdelenView.collectionViewcopy reloadData];
        NSString *documentsDirectorybureau =  [NSString stringWithFormat:@"/Users/jeffreysnijder02/Desktop/Demo/%@",[NSString stringWithFormat:@"%@_%@.plist",@"Velden", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]]];
        [AllVelden_voertuig writeToFile:documentsDirectorybureau atomically: YES];
    }
    [search setTitle:[[AllVelden objectAtIndex:indexPath.row] valueForKey:@"WaardeLang"] forState:UIControlStateNormal];
    [UIView commitAnimations];
}
@end
