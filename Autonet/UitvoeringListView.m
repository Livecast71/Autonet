//
//  LineButton.m
//  Autonet
//
//  Created by Livecast02 on 10-12-16.
//  Copyright © 2016 Autonet. All rights reserved.
//
#import "UitvoeringListView.h"
#import "FileManager.h"
#import "ImageButton.h"
#import "LabelButton.h"
#import "AppDelegate.h"
#import "FileManager.h"
#import "UIFont+FlatUI.h"
@implementation UitvoeringListView
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
@synthesize Parentview;
@synthesize Parentlabel;
-(void)setItem:(NSArray*)velden
{
    AllVelden = [velden mutableCopy];
    NSString *queryit = [NSString stringWithFormat:@"VeldId = %li", (long)VeldId];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[AllVelden_voertuig  filteredArrayUsingPredicate:predicateit] mutableCopy];
    if ([items count]>0) {
              if ([[[items firstObject] valueForKey:@"Waarde"]  isKindOfClass:[NSArray class]]) {
              NSMutableString *string =[[NSMutableString alloc] init];
             for (int k =0; k < [[[items firstObject] valueForKey:@"Waarde"] count]; k++) {
                [string appendString:[NSString stringWithFormat:@"(Waarde LIKE [cd]'%@')#", [[[items firstObject] valueForKey:@"Waarde"] objectAtIndex:k]]];
             }

        }
        else
        {

        }
        Veld = [items firstObject];
   
        search =[[ImageButton alloc]initWithFrame:CGRectMake(60, 0, self.frame.size.width-60,40)];
        [search addTarget:self action:@selector(move:) forControlEvents:UIControlEventTouchUpInside];
        [search.titleView setText:@"Selecteer groep..."];
        [search.titleLabel setFont:[UIFont regularFlatFontOfSize:16]];
        [search.titleLabel setNumberOfLines:2];
        [search setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.000]];
        [search setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [search setTag:100];
        [search.layer setCornerRadius:4];
        [search setlabel];

        [search.titleView setText:@"Selecteer groep..."];
        [self addSubview:search];
        
    }
    else
    {
    search =[[ImageButton alloc]initWithFrame:CGRectMake(60, 0, self.frame.size.width-60,40)];
    [search addTarget:self action:@selector(move:) forControlEvents:UIControlEventTouchUpInside];
     [search.titleView setText:@"Selecteer groep..."];
    [search.titleLabel setFont:[UIFont regularFlatFontOfSize:16]];
    [search.titleLabel setNumberOfLines:2];
    [search setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.000]];
    [search setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [search setTag:100];
    [search.layer setCornerRadius:4];
    [search setlabel];
    [search.titleView setText:@"Selecteer groep..."];
    [self addSubview:search];

    [self.layer setCornerRadius:6];
    [self.layer setMasksToBounds:YES];

    }

    tableResult =[[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.frame.size.width,self.frame.size.height-40)];
    [tableResult setRowHeight:80];
    [tableResult setDelegate:self];
    [tableResult setDataSource:self];
    [tableResult setBackgroundColor:baseColor];
    //[tableResult setBounces:NO];
    [tableResult setAlwaysBounceHorizontal:NO];
    [tableResult.layer setCornerRadius:6];
    [tableResult.layer setMasksToBounds:YES];
    [self addSubview:tableResult];

        AllVelden_voertuig = [[FileManager getVelden_voertuig:@""]  mutableCopy];
}
-(void)move:(LineButton*)sender
{
      [[[Parentview subviews] firstObject] insertSubview:Parentlabel aboveSubview:[ [[[Parentview subviews] firstObject] subviews] lastObject]];
    if (self.frame.size.height==40)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.2f];
        [Parentlabel setFrame:CGRectMake(Parentlabel.frame.origin.x, Parentlabel.frame.origin.y, Parentlabel.frame.size.width, 40*4.3)];
           [self setFrame:CGRectMake(self.frame.origin.x, 4, self.frame.size.width, 40*4.3)];
        [self.tableResult setFrame:CGRectMake(0, 40, self.tableResult.frame.size.width, 40*3.3)];
         [search.upDownView setImage:[UIImage imageNamed:@"Up.png"]];
        [UIView commitAnimations];
    }
    else
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.2f];
         [Parentlabel setFrame:CGRectMake(Parentlabel.frame.origin.x, Parentlabel.frame.origin.y, Parentlabel.frame.size.width, 40)];
        [self setFrame:CGRectMake(self.frame.origin.x, asY, self.frame.size.width, 40)];
        [self.tableResult setFrame:CGRectMake(0, 40, self.tableResult.frame.size.width, self.frame.size.height-40)];
        [UIView commitAnimations];
            [search.upDownView setImage:[UIImage imageNamed:@"Down.png"]];
       
     }
}
-(UIColor *)reverseColorOf :(UIColor *)oldColor
{
    CGColorRef oldCGColor = oldColor.CGColor;
    NSInteger numberOfComponents = CGColorGetNumberOfComponents(oldCGColor);
    // can not invert - the only component is the alpha
    if (numberOfComponents == 1) {
        return [UIColor colorWithCGColor:oldCGColor];
    }
    const CGFloat *oldComponentColors = CGColorGetComponents(oldCGColor);
    CGFloat newComponentColors[numberOfComponents];
    NSInteger i = numberOfComponents - 1;
    newComponentColors[i] = oldComponentColors[i]; // alpha
    while (--i >= 0) {
        newComponentColors[i] = 1 - oldComponentColors[i];
    }
    CGColorRef newCGColor = CGColorCreate(CGColorGetColorSpace(oldCGColor), newComponentColors);
    UIColor *newColor = [UIColor colorWithCGColor:newCGColor];
    CGColorRelease(newCGColor);
    //=====For the GRAY colors 'Middle level colors'
    CGFloat white = 0;
    [oldColor getWhite:&white alpha:nil];
    if(white>0.3 && white < 0.67)
    {
        if(white >= 0.5)
            newColor = [UIColor darkGrayColor];
        else if (white < 0.5)
            newColor = [UIColor blackColor];
    }
    return newColor;
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
        [existlabel setFrame:CGRectMake(8,0,140,40)];
        [existlabel setText:[[[AllVelden objectAtIndex:indexPath.row]  firstObject] valueForKey:@"InternetNaam"]];
    }
    else
    {
        UILabel *kenteken =[[UILabel alloc] initWithFrame:CGRectMake(10,0,140,40)];
        [kenteken setBackgroundColor:[UIColor clearColor]];
        [kenteken setText:[[[AllVelden objectAtIndex:indexPath.row]  firstObject] valueForKey:@"InternetNaam"]];
        [kenteken setFont:[UIFont regularFlatFontOfSize:16]];
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
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *appDelegate = [FileManager getDel];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.2f];
    [Parentlabel setFrame:CGRectMake(Parentlabel.frame.origin.x, Parentlabel.frame.origin.y, Parentlabel.frame.size.width, 40)];
    [self setFrame:CGRectMake(self.frame.origin.x, asY, self.frame.size.width, 40)];
    [self.tableResult setFrame:CGRectMake(0, 40, self.tableResult.frame.size.width, self.frame.size.height-40)];
    NSString *queryit = [NSString stringWithFormat:@"VeldId = %li", (long)VeldId];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[AllVelden_voertuig  filteredArrayUsingPredicate:predicateit] mutableCopy];
    if ([items count]>0) {
           [Veld setObject:[[AllVelden objectAtIndex:indexPath.row] valueForKey:@"Waarde"] forKey:@"Waarde"];
        [AllVelden_voertuig replaceObjectAtIndex:(unsigned long)[AllVelden_voertuig indexOfObject:[items firstObject]] withObject:Veld];
        NSString *docDir = [FileManager getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"Velden", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
        [AllVelden_voertuig writeToFile:itemFilePath atomically: YES];
            // [appDelegate.viewcontroller.onderdelenView.collectionViewcopy reloadData];
         NSString *documentsDirectorybureau =  [NSString stringWithFormat:@"/Users/jeffreysnijder02/Desktop/Demo/%@",[NSString stringWithFormat:@"%@_%@.plist",@"Velden", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]]];
            [AllVelden_voertuig writeToFile:documentsDirectorybureau atomically: YES];
    }
    else
    {
        Veld =[[NSMutableDictionary alloc] init];
        [Veld setObject:[[AllVelden objectAtIndex:indexPath.row] valueForKey:@"Waarde"] forKey:@"Waarde"];
        [Veld setObject:[NSNumber numberWithInteger:VeldId] forKey:@"VeldId"];
        [AllVelden_voertuig addObject:Veld];
        NSString *docDir = [FileManager getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"Velden", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
        [AllVelden_voertuig writeToFile:itemFilePath atomically: YES];
       // [appDelegate.viewcontroller.onderdelenView.collectionViewcopy reloadData];
        NSString *documentsDirectorybureau =  [NSString stringWithFormat:@"/Users/jeffreysnijder02/Desktop/Demo/%@",[NSString stringWithFormat:@"%@_%@.plist",@"Velden", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]]];
        [AllVelden_voertuig writeToFile:documentsDirectorybureau atomically: YES];
    }
  [search.titleView setText:[[[AllVelden objectAtIndex:indexPath.row] firstObject] valueForKey:@"InternetNaam"]];
    [UIView commitAnimations];
    [search.upDownView setImage:[UIImage imageNamed:@"Down.png"]];

    
}
@end
