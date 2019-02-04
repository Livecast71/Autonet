//
//  LineButton.m
//  Autonet
//
//  Created by Livecast02 on 10-12-16.
//  Copyright © 2016 Autonet. All rights reserved.
//
#import "TableViewCatagorie.h"
#import "FileManager.h"
#import "ImageButton.h"
#import "LabelButton.h"
#import "AppDelegate.h"
@implementation TableViewCatagorie
@synthesize AllLines;
@synthesize tableResult;
@synthesize AllCatagories;
@synthesize TableOnderdelen;
-(void)setItem
{
    AllCatagories = [[FileManager getStandaardCategorieen:@""] mutableCopy];


    tableResult =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height-40)];
    [tableResult setRowHeight:60];
    [tableResult setDelegate:self];
    [tableResult setDataSource:self];
    [tableResult setBounces:NO];
    [tableResult setAlwaysBounceHorizontal:NO];
    [self addSubview:tableResult];                   
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
    return [AllCatagories count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Subcellstank"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Subcellstank"];
          [cell setSelected:NO];
       
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell.textLabel setFont:[UIFont systemFontOfSize:12]];
       
     }                   
    [cell.textLabel setText:[[AllCatagories objectAtIndex:indexPath.row] valueForKey:@"Naam"]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
          NSLog(@"test 3");


    TableOnderdelen.AllCatagories = [[FileManager getOnderdelen] mutableCopy];
  
    TableOnderdelen.AllCatagories = [[FileManager getOnderdelen_Categorie:TableOnderdelen.AllCatagories whatid:[[AllCatagories objectAtIndex:indexPath.row] valueForKey:@"CategorieId"]] mutableCopy];

    NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey: @"@firstObject" ascending: YES];

    NSArray *sorted = [[[ TableOnderdelen.AllCatagories valueForKey:@"DeelNamen"] valueForKey:@"Naam"] sortedArrayUsingDescriptors: @[sd]];
    for (int k =0; k < [sorted count]; k++) {
        NSInteger count = [[[TableOnderdelen.AllCatagories valueForKey:@"DeelNamen"] valueForKey:@"Naam"] indexOfObject:[sorted objectAtIndex:k]];
        NSMutableDictionary *copyitem = [TableOnderdelen.AllCatagories objectAtIndex:count];
        [TableOnderdelen.AllCatagories removeObjectAtIndex:count];
        [TableOnderdelen.AllCatagories addObject:copyitem];
    }

    NSLog(@"%@",TableOnderdelen.AllCatagories);

        [self.tableResult selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    [TableOnderdelen.tableResult reloadData];
   [TableOnderdelen.tableResult setScrollsToTop:YES];
        }
@end
