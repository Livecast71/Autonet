    //
    //  LineButton.m
    //  Autonet
    //
    //  Created by Livecast02 on 10-12-16.
    //  Copyright © 2016 Autonet. All rights reserved.
    //
#import "OnderdelenViewSelect.h"
#import "FileManager.h"
#import "ImageButton.h"
#import "LabelButton.h"
#import "AppDelegate.h"
#import "FileManager.h"
#import "CameraButton.h"
#import "MaakOnderdeel.h"
@implementation OnderdelenViewSelect
@synthesize AllLines;
@synthesize baseColor;
@synthesize contraColor;
@synthesize searchDict;
@synthesize tableResult;
@synthesize search;
@synthesize Deelnamen;
@synthesize Delen;
@synthesize parant;
-(void)setItem:(UIColor*)color
{
    AppDelegate *appDelegate = [FileManager getDel];
    Deelnamen =[[NSMutableArray alloc] init];
    NSMutableArray *copy =[[NSMutableArray alloc] init];
    Delen =[[NSMutableArray alloc] init];
    appDelegate.onderdelenArray =[[FileManager getOnderdelen] mutableCopy];
    Delen=appDelegate.onderdelenArray;
    for (int k =0; k < [appDelegate.onderdelenArray count]; k++) {
        for (int i =0; i < [[[appDelegate.onderdelenArray objectAtIndex:k] valueForKey:@"DeelNamen"] count]; i++) {
            NSMutableDictionary *set =[[NSMutableDictionary alloc] init];
            [set setObject:[[[[appDelegate.onderdelenArray objectAtIndex:k] valueForKey:@"DeelNamen"] objectAtIndex:i] valueForKey:@"Naam"] forKey:@"search"];
            [set setObject:[[appDelegate.onderdelenArray objectAtIndex:k] valueForKey:@"DeelId"] forKey:@"index"];
            [copy addObject:set];
        }
    }
    
    
    
    
    baseColor =[UIColor colorWithRed:0.267 green:0.588 blue:0.722 alpha:1.000];
    
    UIView *back =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,40)];
    [back setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:back];
    search =[[UITextView alloc]initWithFrame:CGRectMake(10, 0, self.frame.size.width-10,40)];
        //[search addTarget:self action:@selector(move:) forControlEvents:UIControlEventTouchUpInside];
    [search setText:@"Onderdelen..."];
        //[search.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [search setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.000]];
        //[search setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [search setTag:100];
    search.contentInset = UIEdgeInsetsMake(4,0,0,0);
    [search setDelegate:self];
    [self addSubview:search];
    
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
    
    [self.layer setCornerRadius:6];
    [self.layer setMasksToBounds:YES];
    tableResult =[[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.frame.size.width,self.frame.size.height-80)];
    [tableResult setRowHeight:80];
    [tableResult setDelegate:self];
    [tableResult setDataSource:self];
    [tableResult setBackgroundColor:baseColor];
        //[tableResult setBounces:NO];
    [tableResult setAlwaysBounceHorizontal:NO];
    [tableResult.layer setCornerRadius:6];
    [tableResult.layer setMasksToBounds:YES];
    [self addSubview:tableResult];
    
}
- (void)clearTextView:(id)sender{
    search.text = @"";
    [search resignFirstResponder];
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    AppDelegate *appDelegate = [FileManager getDel];                   
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
    double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if ([[appDelegate.currentItemDictonary valueForKey:@"CurrentItem"] isKindOfClass:[ItemFold class]]) {
            UIView *copy = [appDelegate.currentItemDictonary valueForKey:@"CurrentItem"];
            float scrollingSize =[[appDelegate.currentItemDictonary valueForKey:@"scrollingSize"] floatValue];
            CGRect frame = CGRectMake(copy.frame.origin.x, scrollingSize-150, copy.frame.size.width, copy.frame.size.height);
            [[appDelegate.currentItemDictonary valueForKey:@"Superview"] scrollRectToVisible:frame animated:NO];
        } else {
            UIView *copy = [appDelegate.currentItemDictonary valueForKey:@"CurrentItem"];
            float scrollingSize =[[appDelegate.currentItemDictonary valueForKey:@"scrollingSize"] floatValue];
            CGRect frame = CGRectMake(copy.frame.origin.x, scrollingSize-150, copy.frame.size.width, copy.frame.size.height);
            [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy scrollRectToVisible:frame animated:NO];
        }
    });
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
        NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey: @"search" ascending: YES];
        Delen = [[[appDelegate.onderdelenArray filteredArrayUsingPredicate:predicateit]  sortedArrayUsingDescriptors:@[sd]] mutableCopy];
        
        
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
    [(MaakOnderdeel*)parant reset:[[Delen objectAtIndex:indexPath.row] valueForKey:@"DeelId"]];
    [UIView commitAnimations];
}
@end
