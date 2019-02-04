//
//  MaakArtikel.m
//  Autonet
//
//  Created by Livecast02 on 30-05-17.
//  Copyright © 2017 Autonet. All rights reserved.
//
#import "MaakArtikel.h"
#import "AppDelegate.h"
#import "FileManager.h"
@implementation MaakArtikel
@synthesize tableResult;
@synthesize AllVelden;
@synthesize search;
@synthesize shouldBeginEditing;
@synthesize selecteditem;
@synthesize Bewaar;


- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setAlpha:1];
        [self buidItems];
        self.layer.shadowOffset = CGSizeMake(1, 1);
        self.layer.shadowOpacity = 1;
        [self setCenter:CGPointMake(super.center.x, super.frame.size.height/4)];
        self.transform = CGAffineTransformMakeScale(0.5, 0.5);
        [self setAlpha:0];
    }
    return self;
}


-(void)buidItems
{
    AllVelden = [[NSMutableArray alloc] init];
    search =[[UITextView alloc]initWithFrame:CGRectMake(10, 10, self.frame.size.width-20,30)];
    [search setText:@"Vul in..."];
    [search setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.000]];
    [search setTag:100];
    [search setFont:[UIFont systemFontOfSize:20]];
    [search setDelegate:self];
    [search setKeyboardType:UIKeyboardTypeNumberPad];
    [search setTextAlignment:NSTextAlignmentCenter];
    [search.layer setCornerRadius:4];
    [self addSubview:search];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textViewDidChange:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:search];

    [search.layer setBorderWidth:1];
    [search.layer  setBorderColor:[UIColor blackColor].CGColor];
        tableResult =[[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.frame.size.width,self.frame.size.height-130)];
    [tableResult setRowHeight:80];
    [tableResult setDelegate:self];
    [tableResult setDataSource:self];
    [tableResult setAlwaysBounceHorizontal:NO];
    [self addSubview:tableResult];
    [self.layer setCornerRadius:6];
    ///self.layer.shadowOffset = CGSizeMake(0.5, 0);
    //self.layer.shadowOpacity = 0.5;
    UIButton *Delete =[[UIButton alloc]initWithFrame:CGRectMake(10, self.frame.size.height-100, (self.frame.size.width-30)/2, 40)];
    [Delete setTitle:@"Delete" forState:UIControlStateNormal];
    [Delete.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [Delete setBackgroundColor:[UIColor colorWithRed:0.992 green:0.420 blue:0.031 alpha:1.000]];
    [Delete addTarget:self action:@selector(Delete:) forControlEvents:UIControlEventTouchUpInside];
    [Delete.layer setCornerRadius:4];
    [self addSubview:Delete];
    Bewaar =[[UIButton alloc]initWithFrame:CGRectMake(((self.frame.size.width-30)/2)+20, self.frame.size.height-100, (self.frame.size.width-30)/2, 40)];
    [Bewaar setTitle:@"Toevoegen" forState:UIControlStateNormal];
    [Bewaar.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [Bewaar setBackgroundColor:[UIColor colorWithRed:0.251 green:0.502 blue:0.000 alpha:1.000]];
    [Bewaar addTarget:self action:@selector(Bewaar:) forControlEvents:UIControlEventTouchUpInside];
    [Bewaar.layer setCornerRadius:4];
    [self addSubview:Bewaar];
    UIButton *slaop =[[UIButton alloc]initWithFrame:CGRectMake(10, self.frame.size.height-50, self.frame.size.width-20, 40)];
    [slaop setTitle:@"Return" forState:UIControlStateNormal];
    [slaop.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [slaop setBackgroundColor:[UIColor colorWithRed:0.251 green:0.502 blue:0.000 alpha:1.000]];
    [slaop addTarget:self action:@selector(Slaop:) forControlEvents:UIControlEventTouchUpInside];
    [slaop.layer setCornerRadius:4];
    [self addSubview:slaop];
}
-(void)select:(NSMutableDictionary*)copyitem;
{
    selecteditem = copyitem;
       ////////////NSLog(@"selecteditem %@", [selecteditem valueForKey:@"Artikelnummers"]);
        for (int k =0; k < [[selecteditem valueForKey:@"Artikelnummers"] count]; k++) {
       
          [AllVelden addObject:[[selecteditem valueForKey:@"Artikelnummers"] objectAtIndex:k]];
        }
        [tableResult reloadData];
   
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.4f];
    self.transform = CGAffineTransformMakeScale(1, 1);
    [self setAlpha:1];
    [UIView commitAnimations];
    [search becomeFirstResponder];
}
-(void)gone
{
AppDelegate *appDelegate = [FileManager getDel];
  
   
     appDelegate.onderdelenVoertuigArray = [[FileManager getOnderdelen_voertuig:[appDelegate.currentCarDictionary valueForKey:@"Onderdelen"]] mutableCopy];
    [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
    [AllVelden removeAllObjects];
      [search setText:@"Vul in..."];
        [search resignFirstResponder];
        [tableResult reloadData];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.4f];
    self.transform = CGAffineTransformMakeScale(0.5, 0.5);
    [self setAlpha:0];
    [UIView commitAnimations];
    ////////////NSLog(@"%@", selecteditem);
}
-(void)Slaop:(UIButton*)sender
{
    AppDelegate *appDelegate = [FileManager getDel];
    [selecteditem setObject:AllVelden forKey:@"Artikelnummers"];
    [FileManager insertnew:selecteditem];
      appDelegate.onderdelenVoertuigArray = [[FileManager getOnderdelen_voertuig:[appDelegate.currentCarDictionary valueForKey:@"Onderdelen"]] mutableCopy];
      
    [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
    [AllVelden removeAllObjects];
      [search setText:@"Vul in..."];
        [search resignFirstResponder];
        [tableResult reloadData];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.4f];
    self.transform = CGAffineTransformMakeScale(0.5, 0.5);
    [self setAlpha:0];
    [UIView commitAnimations];
    ////////////NSLog(@"%@", selecteditem);
}
-(void)Bewaar:(UIButton*)sender
{
    if ([AllVelden containsObject:search.text]) {
    } else {
       
        [AllVelden addObject:search.text];
        [tableResult reloadData];
       
         [search setText:@"Vul in..."];
        [search resignFirstResponder];
    }
}
-(void)Delete:(UIButton*)sender
{
    if ([AllVelden containsObject:search.text]) {
        [AllVelden removeObject:search.text];
        [search setText:@"Vul in..."];
        [search resignFirstResponder];
        [tableResult reloadData];
    } else {
    }
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
{





    NSLog(@"%@", textView.text);
    if ([textView.text isEqualToString:@"Vul in..."]) {
        [textView setText:@""];
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{

    NSPredicate *TestResult = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", "[a-zA-Z0-9-]{1,10}"];

    NSLog(@"%@", textView.text);

    if ([TestResult evaluateWithObject:textView.text] == YES)

    {
        [Bewaar setAlpha:1];
        [textView setTextColor:[UIColor blackColor]];
    } else {
        if (textView.text.length ==0) {

            [Bewaar setAlpha:1];
        }
        else
        {
            [Bewaar setAlpha:0];

        }
        [textView setTextColor:[UIColor redColor]];

    }


}
-(void) SetItems:(NSMutableArray*)sender
{
    if ([sender count]>0) {
        AllVelden = sender;
    } else {
        AllVelden = [[NSMutableArray alloc] init];
    }
    [tableResult reloadData];
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
    [tableView setSeparatorColor:[UIColor blackColor]];
    return [AllVelden count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Subcellstank"];
        if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Subcellstank"];
       
         [cell setBackgroundColor:[UIColor whiteColor]];
        [cell.contentView setBackgroundColor:[UIColor whiteColor]];
        [cell.accessoryView setBackgroundColor:[UIColor whiteColor]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
         
    }
    [cell.textLabel setText:[AllVelden objectAtIndex:indexPath.row]];
    [cell.textLabel setFont:[UIFont systemFontOfSize:20]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [search setText:[AllVelden objectAtIndex:indexPath.row]];
}
@end
