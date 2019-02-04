//
//  MemoViewController.m
//  Autonet
//
//  Created by Livecast02 on 09-03-17.
//  Copyright © 2017 Autonet. All rights reserved.
//
#import "MemoViewController.h"
#import "UIFont+FlatUI.h"
#import "FileManager.h"
#import "AppDelegate.h"
#import "FieldLabelView.h"
#import "ExtraLabelView.h"
@interface MemoViewController ()
@end
@implementation MemoViewController
@synthesize popoverparant;
@synthesize basepart;
@synthesize Memotext;
@synthesize tableResult;
@synthesize AllVelden;
@synthesize search;
@synthesize shouldBeginEditing;
@synthesize selecteditem;
@synthesize onderdeel;
@synthesize Bewaar;

- (void)viewDidLoad {
  
        search =[[UITextView alloc]initWithFrame:CGRectMake(10, 10, 300,30)];
    [search setText:@"Vul in..."];
    [search setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.000]];
    [search setTag:100];
    [search setFont:[UIFont systemFontOfSize:20]];
    [search setDelegate:self];
    [search setKeyboardType:UIKeyboardTypeNumberPad];
    [search setTextAlignment:NSTextAlignmentCenter];
    [search.layer setCornerRadius:4];
    [self.view addSubview:search];
    search.textContainerInset = UIEdgeInsetsMake(0, 0, 4, 4);

 
    [search.layer setBorderWidth:1];
    [search.layer  setBorderColor:[UIColor blackColor].CGColor];



    Bewaar =[[UIButton alloc]initWithFrame:CGRectMake(+30, 50, 280, 40)];
    [Bewaar setTitle:@"Toevoegen" forState:UIControlStateNormal];
    [Bewaar.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [Bewaar setBackgroundColor:[UIColor colorWithRed:0.251 green:0.502 blue:0.000 alpha:1.000]];
    [Bewaar addTarget:self action:@selector(Bewaar:) forControlEvents:UIControlEventTouchUpInside];
    [Bewaar.layer setCornerRadius:4];
    [self.view addSubview:Bewaar];

    UIButton *slaop =[[UIButton alloc]initWithFrame:CGRectMake(10, self.view.frame.size.height-50, self.view.frame.size.width-20, 40)];
    [slaop setTitle:@"Return" forState:UIControlStateNormal];
    [slaop.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [slaop setBackgroundColor:[UIColor colorWithRed:0.251 green:0.502 blue:0.000 alpha:1.000]];
    [slaop addTarget:self.view action:@selector(Slaop:) forControlEvents:UIControlEventTouchUpInside];
    [slaop.layer setCornerRadius:4];
    [self.view addSubview:slaop];
     
    tableResult =[[UITableView alloc] initWithFrame:CGRectMake(0, 110, 324,self.view.frame.size.height-280)];
    [tableResult setRowHeight:80];
    [tableResult setAlwaysBounceHorizontal:NO];
    [tableResult setEditing:YES animated:NO];
    [self.view addSubview:tableResult];
    [self.view.layer setCornerRadius:6];
        ///self.view.layer.shadowOffset = CGSizeMake(0.5, 0);
        //self.view.layer.shadowOpacity = 0.5;
   
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated
{
      AllVelden = [[NSMutableArray alloc] initWithArray:[onderdeel.basepart valueForKey:@"Artikelnummers"]];
    [tableResult setDelegate:self];
    [tableResult setDataSource:self];
    [tableResult reloadData];

        [super viewDidAppear:animated];

}
- (IBAction)clearPressed:(id)sender
{
        [popoverparant dismissPopoverAnimated:YES];
}
- (IBAction)endpress:(id)sender
{
    AppDelegate *appDelegate = [FileManager getDel];
    [self.basepart setObject:Memotext.text forKey:@"Bijzonderheid"];
     if ([[self.basepart valueForKey:@"OnderdeelId"] integerValue] == 0) {
     }
     else
     {
    [FileManager insertnew:self.basepart];
    }
    [popoverparant dismissPopoverAnimated:YES];
    [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 
-(void)select:(NSMutableDictionary*)copyitem;
{
    selecteditem = copyitem;
    for (int k =0; k < [[selecteditem valueForKey:@"Artikelnummers"] count]; k++) {
       
         [AllVelden addObject:[[selecteditem valueForKey:@"Artikelnummers"] objectAtIndex:k]];
    }
    [tableResult reloadData];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.4f];
    self.view.transform = CGAffineTransformMakeScale(1, 1);
    [self.view setAlpha:1];
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
    self.view.transform = CGAffineTransformMakeScale(0.5, 0.5);
    [self.view setAlpha:0];
    [UIView commitAnimations];
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
    self.view.transform = CGAffineTransformMakeScale(0.5, 0.5);
    [self.view setAlpha:0];
    [UIView commitAnimations];
}
-(void)Bewaar:(UIButton*)sender
{
      ExtraLabelView *existlabel = (ExtraLabelView *)[onderdeel viewWithTag:888];
  
 
    //888
    if ([[AllVelden valueForKey:@"Nummer"] containsObject:search.text]||[search.text isEqualToString:@"Vul in..."]) {
    } else {

        ///kan er maar een hoofdartikelnumme rzijn

        if ([AllVelden count]== 0) {

            NSMutableDictionary *set =[[NSMutableDictionary alloc] init];
            [set setObject:[NSNumber numberWithBool:YES] forKey:@"Afgelezen"];
            [set setObject:@"" forKey:@"ArtikelnummerSoort"];
            [set setObject:[NSNumber numberWithBool:YES] forKey:@"HoofdArtikelnr"];
            [set setObject:search.text forKey:@"Nummer"];
            [AllVelden addObject:set];
            [tableResult reloadData];

        }
        else
        {
       
        NSMutableDictionary *set =[[NSMutableDictionary alloc] init];
        [set setObject:[NSNumber numberWithBool:YES] forKey:@"Afgelezen"];
        [set setObject:@"" forKey:@"ArtikelnummerSoort"];
        [set setObject:[NSNumber numberWithBool:NO] forKey:@"HoofdArtikelnr"];
        [set setObject:search.text forKey:@"Nummer"];
        [AllVelden addObject:set];
        [tableResult reloadData];

        }
       
         [search setText:@"Vul in..."];
        [search resignFirstResponder];
        NSString * result = [[AllVelden valueForKey:@"Nummer"] componentsJoinedByString:@", "];
       
         [onderdeel.basepart setValue:AllVelden forKey:@"Artikelnummers"];
        [FileManager getOnderdelenAndWrite:onderdeel.basepart];
      
        [existlabel.inhoudextra setText:result];
        
     }
}
-(void)Delete:(UIButton*)sender
{
    ExtraLabelView *existlabel = (ExtraLabelView *)[onderdeel viewWithTag:888];
    if ([[AllVelden valueForKey:@"Nummer"] containsObject:search.text]) {
        NSString *queryit = [NSString stringWithFormat:@"Nummer contains[cd] '%@'", search.text];
        NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
       
         [AllVelden removeObject:[[AllVelden filteredArrayUsingPredicate:predicateit] lastObject]];
        [search setText:@"Vul in..."];
        [search resignFirstResponder];
        [tableResult reloadData];
        NSString * result = [[AllVelden valueForKey:@"Nummer"] componentsJoinedByString:@", "];
       
         [onderdeel.basepart setValue:AllVelden forKey:@"Artikelnummers"];
      
        [existlabel.inhoudextra setText:result];
    } else {
    }
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
{
    if ([textView.text isEqualToString:@"Vul in..."]) {
        [textView setText:@""];
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{


    NSLog(@"%@", textView.text);
    NSPredicate *TestResult = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[a-zA-Z0-9-]{1,10}"];

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

-(void)move:(ImageButton*)sender
{
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
    UIView *content =[[UIView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,80)];
    return content;
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{


    ExtraLabelView *existlabel = (ExtraLabelView *)[onderdeel viewWithTag:888];


        [AllVelden removeObject:[AllVelden objectAtIndex:indexPath.row]];
        [search setText:@"Vul in..."];
        [search resignFirstResponder];
        NSString * result = [[AllVelden valueForKey:@"Nummer"] componentsJoinedByString:@", "];

    [onderdeel.basepart setValue:AllVelden forKey:@"Artikelnummers"];
    [FileManager getOnderdelenAndWrite:onderdeel.basepart];
    

        [existlabel.inhoudextra setText:result];

    if ([AllVelden count]>1) {

    NSMutableDictionary *itemRun = [AllVelden objectAtIndex:0];
    [itemRun setObject:[NSNumber numberWithBool:YES] forKey:@"HoofdArtikelnr"];
    [AllVelden replaceObjectAtIndex:0 withObject:itemRun];

    }

            [tableResult reloadData];




}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath
     toIndexPath:(NSIndexPath *)toIndexPath {



    NSMutableDictionary *item = [AllVelden objectAtIndex:fromIndexPath.row];

    for (int i = 0; i < [AllVelden count]; i++) {

        NSMutableDictionary *itemRun = [AllVelden objectAtIndex:i];
        [itemRun setObject:[NSNumber numberWithBool:NO] forKey:@"HoofdArtikelnr"];
        [AllVelden replaceObjectAtIndex:i withObject:itemRun];

    }


    [AllVelden removeObjectAtIndex:fromIndexPath.row];

    [AllVelden insertObject:item atIndex:toIndexPath.row];

    ExtraLabelView *existlabel = (ExtraLabelView *)[onderdeel viewWithTag:888];
    NSString * result = [[AllVelden valueForKey:@"Nummer"] componentsJoinedByString:@", "];

    [onderdeel.basepart setValue:AllVelden forKey:@"Artikelnummers"];
    [FileManager getOnderdelenAndWrite:onderdeel.basepart];

    [existlabel.inhoudextra setText:result];

    NSMutableDictionary *itemRun = [AllVelden objectAtIndex:0];
    [itemRun setObject:[NSNumber numberWithBool:YES] forKey:@"HoofdArtikelnr"];
    [AllVelden replaceObjectAtIndex:0 withObject:itemRun];

    NSLog(@"%@", AllVelden);

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
    [cell.textLabel setText:[[AllVelden objectAtIndex:indexPath.row] valueForKey:@"Nummer"]];
    [cell.textLabel setFont:[UIFont systemFontOfSize:20]];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [search setText:[[AllVelden valueForKey:@"Nummer"] objectAtIndex:indexPath.row]];
}
@end
