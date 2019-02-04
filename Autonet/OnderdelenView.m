//
//  LineButton.m
//  Autonet
//
//  Created by Livecast02 on 10-12-16.
//  Copyright © 2016 Autonet. All rights reserved.
//
#import "OnderdelenView.h"
#import "FileManager.h"
#import "ImageButton.h"
#import "LabelButton.h"
#import "AppDelegate.h"
#import "FileManager.h"
#import "CameraButton.h"
@implementation OnderdelenView
@synthesize AllLines;
@synthesize baseColor;
@synthesize contraColor;
@synthesize searchDict;
@synthesize tableResult;
@synthesize search;
@synthesize Deelnamen;
@synthesize Delen;
-(void)setItemOnderdelen:(UIColor*)color
{
    AppDelegate *appDelegate = [FileManager getDel];
    Deelnamen =[[NSMutableArray alloc] init];
    Delen =[[NSMutableArray alloc] init];
    appDelegate.onderdelenArray =[[FileManager getOnderdelen] mutableCopy];
    Delen=appDelegate.onderdelenArray;
    for (int k =0; k < [appDelegate.onderdelenArray count]; k++) {
        for (int i =0; i < [[[appDelegate.onderdelenArray objectAtIndex:k] valueForKey:@"DeelNamen"] count]; i++) {
           NSMutableDictionary *set =[[NSMutableDictionary alloc] init];
            [set setObject:[[[[appDelegate.onderdelenArray objectAtIndex:k] valueForKey:@"DeelNamen"] objectAtIndex:i] valueForKey:@"Naam"] forKey:@"search"];
            [set setObject:[[appDelegate.onderdelenArray objectAtIndex:k] valueForKey:@"DeelId"] forKey:@"index"];
            [Deelnamen addObject:set];
        }
    }


    NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey: @"search" ascending: YES];
    NSMutableArray *items2 =   [[Deelnamen sortedArrayUsingDescriptors:@[sd]] mutableCopy];
    NSLog(@"%@", items2);

    
    baseColor =[UIColor colorWithRed:0.267 green:0.588 blue:0.722 alpha:1.000];


    UIView *back =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,40)];
    [back setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:back];

    search =[[UITextView alloc]initWithFrame:CGRectMake(10, 0, self.frame.size.width-10,40)];
    [search setText:@"Onderdelen..."];
    [search setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.000]];
    [search setTag:100];
    search.contentInset = UIEdgeInsetsMake(4,0,0,0);
    [search setDelegate:self];
    [self addSubview:search];

    [self.layer setCornerRadius:6];
    [self.layer setMasksToBounds:YES];
    int kClearButtonWidth = 15;
    int kClearButtonHeight = kClearButtonWidth;
        //add the clear button
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearButton setImage:[UIImage imageNamed:@"UITextFieldClearButton.png"] forState:UIControlStateNormal];
    [clearButton setImage:[UIImage imageNamed:@"UITextFieldClearButtonPressed.png"] forState:UIControlStateHighlighted];
    clearButton.frame = CGRectMake(0, 0, kClearButtonWidth, kClearButtonHeight);
    clearButton.center = CGPointMake((search.frame.size.width-15) - kClearButtonWidth , kClearButtonHeight);
    [clearButton addTarget:self action:@selector(clearTextView:) forControlEvents:UIControlEventTouchUpInside];
    [search addSubview:clearButton];

    tableResult =[[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.frame.size.width,self.frame.size.height-40)];
    [tableResult setRowHeight:80];
    [tableResult setDelegate:self];
    [tableResult setDataSource:self];
    [tableResult setBackgroundColor:baseColor];
    [tableResult setAlwaysBounceHorizontal:NO];
    [self addSubview:tableResult];
    [tableResult.layer setCornerRadius:6];
    [tableResult.layer setMasksToBounds:YES];

 
}
-(void)contentReset:(NSMutableArray*)Onderdelen
{
    AppDelegate *appDelegate = [FileManager getDel];
    appDelegate.onderdelenArray=Onderdelen;
    Delen=Onderdelen;
    for (int k =0; k < [Onderdelen count]; k++) {
        for (int i =0; i < [[[Onderdelen objectAtIndex:k] valueForKey:@"DeelNamen"] count]; i++) {
           NSMutableDictionary *set =[[NSMutableDictionary alloc] init];
            [set setObject:[[[[Onderdelen objectAtIndex:k] valueForKey:@"DeelNamen"] objectAtIndex:i] valueForKey:@"Naam"] forKey:@"search"];
            [set setObject:[[Onderdelen objectAtIndex:k] valueForKey:@"DeelId"] forKey:@"index"];
            [Deelnamen addObject:set];
        }
    }
        [tableResult reloadData];
}
- (void)clearTextView:(id)sender{
    AppDelegate *appDelegate = [FileManager getDel];
      search.text = @"";
        appDelegate.viewcontroller.collectionOnderdelenView.onderdelen.searchDict =NULL;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.2f];
    [self setFrame:CGRectMake(self.frame.origin.x, 4, self.frame.size.width, 40)];
    [self.tableResult setFrame:CGRectMake(self.tableResult.frame.origin.x, 40, self.tableResult.frame.size.width, 40)];
    [UIView commitAnimations];
    Delen =appDelegate.onderdelenArray;
    [tableResult reloadData];
    [search resignFirstResponder];
    [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{                   
        [textView setText:@""];
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
-(void)textViewDidChange:(UITextView *)textView
{
  if (self.frame.size.height==40)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.2f];
        [self setFrame:CGRectMake(self.frame.origin.x, 4, self.frame.size.width, 40*8)];
        [self.tableResult setFrame:CGRectMake(self.tableResult.frame.origin.x, 40, self.tableResult.frame.size.width, 40*7)];
        [UIView commitAnimations];
        }
    AppDelegate *appDelegate = [FileManager getDel];
    NSString *query = [NSString stringWithFormat:@"search contains [cd]'%@'", textView.text];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:query];
    NSArray *arrayextra =  [[Deelnamen
                             filteredArrayUsingPredicate:predicate] mutableCopy];
                             
    NSMutableOrderedSet *filteredArray = [[[NSMutableOrderedSet alloc] initWithArray:[arrayextra valueForKey:@"index"]] mutableCopy];
    if ([filteredArray count]>0) {
        NSString *queryit = [NSString stringWithFormat:@"(DeelId =%@)", [[filteredArray array] componentsJoinedByString:@") or (DeelId ="]];
        NSPredicate *predicateit = [NSPredicate predicateWithFormat:[queryit stringByReplacingOccurrencesOfString:@"(DeelId =)" withString:@""]];
        Delen = [[appDelegate.onderdelenArray filteredArrayUsingPredicate:predicateit] mutableCopy];
    } else {
        Delen =appDelegate.onderdelenArray;
    }
    [tableResult reloadData];
}
-(void)select
{
    AppDelegate *appDelegate = [FileManager getDel];
    appDelegate.searchCatagorie =0;
    [appDelegate.viewcontroller.collectionOnderdelenView.onderdelen.search setText:@""];
    appDelegate.viewcontroller.collectionOnderdelenView.onderdelen.searchDict =NULL;
    [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
    //searchCatagorie
}
-(void)move:(LineButton*)sender
{
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
        [existlabel setText:[[[[Delen valueForKey:@"DeelNamen"] objectAtIndex:indexPath.row]  firstObject] valueForKey:@"Naam"]];
    } else {
        UILabel *kenteken =[[UILabel alloc] initWithFrame:CGRectMake(10,0,200,40)];
        [kenteken setBackgroundColor:[UIColor clearColor]];
        [kenteken setText:[[[[Delen valueForKey:@"DeelNamen"] objectAtIndex:indexPath.row]  firstObject] valueForKey:@"Naam"]];
        [kenteken setFont:[UIFont systemFontOfSize:12]];
        [kenteken setTextAlignment:NSTextAlignmentLeft];
        [kenteken setTag:105];
        [cell addSubview:kenteken];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *appDelegate = [FileManager getDel];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.2f];
    [self setFrame:CGRectMake(self.frame.origin.x, 4, self.frame.size.width, 40)];
    [self.tableResult setFrame:CGRectMake(self.tableResult.frame.origin.x, 40, self.tableResult.frame.size.width, 40)];
 
    [search setText:[[[[Delen valueForKey:@"DeelNamen"] objectAtIndex:indexPath.row]  firstObject] valueForKey:@"Naam"]];
    searchDict = [Delen objectAtIndex:indexPath.row];
   
    [search resignFirstResponder];
      
    [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
     Delen =appDelegate.onderdelenArray;
    [tableResult reloadData];
    [UIView commitAnimations];
}
@end
