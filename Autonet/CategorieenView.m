    //
    //  LineButton.m
    //  Autonet
    //
    //  Created by Livecast02 on 10-12-16.
    //  Copyright © 2016 Autonet. All rights reserved.
    //
#import "CategorieenView.h"
#import "FileManager.h"
#import "ImageButton.h"
#import "LabelButton.h"
#import "AppDelegate.h"
#import "FileManager.h"
#import "CameraButton.h"
@implementation CategorieenView
@synthesize AllLines;
@synthesize baseColor;
@synthesize contraColor;
@synthesize tableResult;
@synthesize search;
-(void)setItem:(UIColor*)color
{
    AppDelegate *appDelegate = [FileManager getDel];
    appDelegate.categorieenArray =[[FileManager getCategorieen:@""] mutableCopy];
    if ( [[appDelegate.categorieenArray valueForKey:@"Naam"] containsObject:@"Toegevoegde onderdelen"]) {
    } else {
        NSMutableDictionary *adnone = [[NSMutableDictionary alloc] init];
        [adnone setObject:@"Toegevoegde onderdelen" forKey:@"Naam"];
        [adnone setObject:[NSMutableArray alloc] forKey:@"Onderdelen"];
        [appDelegate.categorieenArray addObject:adnone];
    }

    baseColor =[UIColor colorWithRed:0.267 green:0.588 blue:0.722 alpha:1.000];

    search =[[ImageButton alloc]initWithFrame:CGRectMake(60, 0, self.frame.size.width-60,40)];
    [search addTarget:self action:@selector(move:) forControlEvents:UIControlEventTouchUpInside];
    [search setTitle:@"Kies eigen categorie..." forState:UIControlStateNormal];
    [search.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [search setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.000]];
    [search setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [search setTag:100];
    [self addSubview:search];
    [self.layer setCornerRadius:6];
    [self.layer setMasksToBounds:YES];
    UIButton *note =[[UIButton alloc]initWithFrame:CGRectMake(0,0, 68, 40)];
    [note setBackgroundColor:[UIColor colorWithRed:0.800 green:0.800 blue:0.800 alpha:1.000]];
    [note setTitle:@"clear" forState:UIControlStateNormal];
    [note addTarget:self action:@selector(select) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:note];
    [note.layer setCornerRadius:4];
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
-(void)select
{
    AppDelegate *appDelegate = [FileManager getDel];
    appDelegate.searchCatagorie =0;
    [appDelegate.viewcontroller.collectionOnderdelenView.onderdelen.search setText:@"Onderdelen..."];
    [search setTitle:@"" forState:UIControlStateNormal];
    appDelegate.onderdelenVoertuigArray = [[FileManager getOnderdelen_voertuig:[appDelegate.currentCarDictionary valueForKey:@"Onderdelen"]] mutableCopy];
    appDelegate.viewcontroller.collectionOnderdelenView.onderdelen.searchDict =NULL;
    [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
    [appDelegate.viewcontroller.collectionOnderdelenView.onderdelen contentReset:appDelegate.onderdelenVoertuigArray];
    appDelegate.onderdelenArray =[[FileManager getOnderdelen] mutableCopy];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.2f];
    [self setFrame:CGRectMake(self.frame.origin.x, 4, self.frame.size.width, 40)];
    [self.tableResult setFrame:CGRectMake(0, 40, self.tableResult.frame.size.width, 40)];
    [UIView commitAnimations];
    [search setTitle:@"Kies eigen categorie..." forState:UIControlStateNormal];
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
        [self.tableResult setFrame:CGRectMake(0, 40, self.tableResult.frame.size.width, 40*6)];
        [UIView commitAnimations];
    } else {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.2f];
        [self setFrame:CGRectMake(self.frame.origin.x, 4, self.frame.size.width, 40)];
        [self.tableResult setFrame:CGRectMake(0, 40, self.tableResult.frame.size.width, 40)];
        [UIView commitAnimations];

    }
}

- (void)reset

{
    [self setFrame:CGRectMake(self.frame.origin.x, 4, self.frame.size.width, 40)];
    [self.tableResult setFrame:CGRectMake(0, 40, self.tableResult.frame.size.width, 40)];

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
    AppDelegate *appDelegate = [FileManager getDel];
        //nsarray
    return [appDelegate.categorieenArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *appDelegate = [FileManager getDel];
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
        [existlabel setText:[[appDelegate.categorieenArray objectAtIndex:indexPath.row] valueForKey:@"Naam"]];
    } else {
        UILabel *kenteken =[[UILabel alloc] initWithFrame:CGRectMake(10,0,200,40)];
        [kenteken setBackgroundColor:[UIColor clearColor]];
        [kenteken setText:[[appDelegate.categorieenArray objectAtIndex:indexPath.row] valueForKey:@"Naam"]];
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
        NSLog(@"test 2");

    AppDelegate *appDelegate = [FileManager getDel];
    if ([[[appDelegate.categorieenArray objectAtIndex:indexPath.row] valueForKey:@"Naam"] isEqualToString:@"Toegevoegde onderdelen"]) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.2f];
        [self setFrame:CGRectMake(self.frame.origin.x, 4, self.frame.size.width, 40)];
        [self.tableResult setFrame:CGRectMake(0, 40, self.tableResult.frame.size.width, 40)];
        [search setTitle:[[appDelegate.categorieenArray objectAtIndex:indexPath.row] valueForKey:@"Naam"] forState:UIControlStateNormal];
        NSMutableString *copy =[[NSMutableString alloc] init];
        for (int k =0; k < [appDelegate.categorieenArray count]; k++) {
            if ([[[appDelegate.categorieenArray objectAtIndex:k] valueForKey:@"Naam"] isEqualToString:@"Toegevoegde onderdelen"]) {
            }
            else
            {
                NSString * result = [[[[appDelegate.categorieenArray objectAtIndex:k] valueForKey:@"Onderdelen"] valueForKey:@"OnderdeelId"] componentsJoinedByString:@") and !(DeelId ="];
                [copy appendString:result];
            }
        }


        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"!(DeelId =%@)", copy]];
        NSMutableArray *allitems = [[FileManager getOnderdelen_voertuig:[appDelegate.currentCarDictionary valueForKey:@"Onderdelen"]] mutableCopy];
        appDelegate.onderdelenVoertuigArray =  [[allitems filteredArrayUsingPredicate:predicate] mutableCopy];
        [appDelegate.viewcontroller.collectionOnderdelenView.onderdelen contentReset:appDelegate.onderdelenVoertuigArray];
        [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
        [UIView commitAnimations];
    } else {

        if ([[[appDelegate.categorieenArray objectAtIndex:indexPath.row] valueForKey:@"Onderdelen"] count]>0) {

            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationDuration:0.2f];
            [self setFrame:CGRectMake(self.frame.origin.x, 4, self.frame.size.width, 40)];
            [self.tableResult setFrame:CGRectMake(0, 40, self.tableResult.frame.size.width, 40)];



            [search setTitle:[[appDelegate.categorieenArray objectAtIndex:indexPath.row] valueForKey:@"Naam"] forState:UIControlStateNormal];



            NSString * result = [[[[appDelegate.categorieenArray objectAtIndex:indexPath.row] valueForKey:@"Onderdelen"] valueForKey:@"OnderdeelId"] componentsJoinedByString:@") or (DeelId ="];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"(DeelId =%@)", result]];
            NSMutableArray *allitems = [[FileManager getOnderdelen_voertuig:[appDelegate.currentCarDictionary valueForKey:@"Onderdelen"]] mutableCopy];
            appDelegate.onderdelenVoertuigArray =  [[allitems filteredArrayUsingPredicate:predicate] mutableCopy];
            [appDelegate.viewcontroller.collectionOnderdelenView.onderdelen contentReset:appDelegate.onderdelenVoertuigArray];
            [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
            [UIView commitAnimations];

        }

        else
        {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationDuration:0.2f];
            [self setFrame:CGRectMake(self.frame.origin.x, 4, self.frame.size.width, 40)];
            [UIView commitAnimations];
        }
    }
}
@end
