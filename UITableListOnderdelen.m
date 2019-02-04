//
//  UITableListOnderdelen.m
//  Autonet
//
//  Created by Livecast02 on 07-02-17.
//  Copyright © 2017 Autonet. All rights reserved.
//
#import "UITableListOnderdelen.h"
#import "FileManager.h"
#import "AppDelegate.h"
#import "UIFont+FlatUI.h"
@implementation UITableListOnderdelen
@synthesize AlleOnderdelen;
@synthesize tableResult;

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        [self buildItems];
        [self setAlpha:0];
        [self setAlpha:1];
    }
    return self;
}


-(void)buildItems
{
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Categorieen"
                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    AlleOnderdelen = [[[FileManager getOnderdelen_voertuig_kern:@"Velden"] sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
    tableResult =[[UITableView alloc] initWithFrame:CGRectMake(0, 40, 300 ,self.frame.size.height-40)];
    [tableResult setRowHeight:40];
    [tableResult setDelegate:self];
    [tableResult setDataSource:self];
    [tableResult setAlwaysBounceHorizontal:NO];
    [self addSubview:tableResult];
    [tableResult.layer setCornerRadius:6];
    [tableResult.layer setMasksToBounds:YES];

}
#pragma mark - tabelDelegate method
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *content =[[UIView alloc] initWithFrame:CGRectMake(0,0,self.frame.size.width,50)];
    return content;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AppDelegate *appDelegate = [FileManager getDel];
    //nsarray
    return [appDelegate.onderdelenVoertuigArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *appDelegate = [FileManager getDel];
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Subcellstank"];
    NSMutableDictionary *coursCell =[appDelegate.onderdelenVoertuigArray objectAtIndex:indexPath.row];
    NSArray *copy =[FileManager getOnderdelen:[[coursCell valueForKey:@"DeelId"] integerValue]];                   
    UILabel *kenteken;
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Subcellstank"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        kenteken =[[UILabel alloc] initWithFrame:CGRectMake(0,10,250,40)];
        [kenteken setBackgroundColor:[UIColor clearColor]];
        [kenteken setFont:[UIFont regularFlatFontOfSize:12]];
        [kenteken setTextAlignment:NSTextAlignmentRight];
        [kenteken setNumberOfLines:2];
        [cell addSubview:kenteken];
    }
    [kenteken setText: [[[[copy firstObject] valueForKey:@"DeelNamen"] firstObject] valueForKey:@"Naam"]];

    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
/*
 - (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
 }
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    /*
    AppDelegate *appDelegate = [FileManager getDel];
    NSMutableDictionary *coursCell =[appDelegate.Onderdelen_voertuig objectAtIndex:indexPath.row];
    NSArray *velden = [FileManager getVeldenOnlist:[[coursCell valueForKey:@"DeelVelden"] valueForKey:@"VeldId"]];
     
     */
}
@end
