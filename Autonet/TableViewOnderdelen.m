//
//  LineButton.m
//  Autonet
//
//  Created by Livecast02 on 10-12-16.
//  Copyright © 2016 Autonet. All rights reserved.
//
#import "TableViewOnderdelen.h"
#import "FileManager.h"
#import "ImageButton.h"
#import "LabelButton.h"
#import "AppDelegate.h"
@implementation TableViewOnderdelen
@synthesize AllLines;
@synthesize tableResult;
@synthesize AllCatagories;
@synthesize tableViewSelectie;
-(void)setItem
{
   
    AllCatagories = [[FileManager getOnderdelen] mutableCopy];
   
    tableResult =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height-40)];
    [tableResult setRowHeight:80];
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
  
    //nsarray
   return [AllCatagories count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Subcellstank"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Subcellstank"];
      
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell.textLabel setFont:[UIFont systemFontOfSize:12]];
    }
 
      
    [cell.textLabel setText:[[[[AllCatagories objectAtIndex:indexPath.row] valueForKey:@"DeelNamen"] firstObject] valueForKey:@"Naam"]];
        return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{


    NSLog(@"test 4");

if ([[tableViewSelectie.AllCatagories valueForKey:@"DeelId"] containsObject:[[AllCatagories objectAtIndex:indexPath.row] valueForKey:@"DeelId"]]) {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Dit onderdeel staat al in de lijst!"
                                                   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
else
{
   [tableViewSelectie.AllCatagories addObject:[AllCatagories objectAtIndex:indexPath.row]];
   
   [tableViewSelectie.tableResult reloadData];
   
   
    [self.tableResult selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
}
@end
