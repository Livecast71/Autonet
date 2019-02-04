    //
    //  LineButton.m
    //  Autonet
    //
    //  Created by Livecast02 on 10-12-16.
    //  Copyright © 2016 Autonet. All rights reserved.
    //
#import "TableView.h"
#import "FileManager.h"
#import "ImageButton.h"
#import "LabelButton.h"
#import "AppDelegate.h"
@implementation TableView
@synthesize AllLines;
@synthesize baseColor;
@synthesize contraColor;
@synthesize tableResult;
-(void)setItem:(UIColor*)color
{
    AppDelegate *appDelegate = [FileManager getDel];
    baseColor =[UIColor colorWithRed:0.267 green:0.588 blue:0.722 alpha:1.000];

    [self.layer setCornerRadius:6];
    [self.layer setMasksToBounds:YES];
    
    LabelButton *VernieuwLabel =[[LabelButton alloc]initWithFrame:CGRectMake(0, 0, 240, 36)];
    [VernieuwLabel setText:@"Kies een voertuig"];
    [VernieuwLabel setTextColor:[UIColor blackColor]];
    [VernieuwLabel setTextAlignment:NSTextAlignmentCenter];
    [VernieuwLabel setBackgroundColor:[UIColor colorWithRed:0.267 green:0.588 blue:0.722 alpha:1.000]];
    [self addSubview:VernieuwLabel];
    [VernieuwLabel setItem:[UIColor whiteColor] ];
    AllLines =[[NSMutableArray alloc] init];
    appDelegate.alleVoertuigenArray =[[NSMutableArray alloc] initWithArray:[FileManager getArray:@"Voertuigen"]];
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


#pragma mark - tabelDelegate method
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *content =[[UIView alloc] initWithFrame:CGRectMake(0,0,self.frame.size.width,80)];
    /*
     imageContent =[[UIView alloc] initWithFrame:CGRectMake(0,0,self.frame.size.width,((self.frame.size.height)/4)+30)];
     [imageContent setBackgroundColor:[UIColor blackColor]];
     [content addSubview:imageContent];
     currentheight=150;
     UIImageView *image= [[UIImageView alloc] initWithFrame:CGRectMake(0,0,self.frame.size.width, ((self.frame.size.height-40)/4))];
     [image setImage:[self Download:[NSString stringWithFormat:@"http://aaserver15s.autodisk.nl/800/%@", [[appDelegate.currentimages valueForKey:@"Photo"] firstObject]]]];
     image.contentMode = UIViewContentModeScaleAspectFill;
     contentViewSize =image.frame;
     cachedImageViewSize =image.frame;
     [imageContent addSubview:image];
     [image setAlpha:1];
     [images addObject:image];
     [imageContent.layer setMasksToBounds:YES];
     
     */
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
    return [appDelegate.alleVoertuigenArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Subcellstank"];
    UILabel *kenteken;
    UILabel *ovelaylabel;
    UIImageView *logos;

    AppDelegate *appDelegate = [FileManager getDel];

    if (kenteken == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Subcellstank"];
        [cell setBackgroundColor:baseColor];
        [cell.contentView setBackgroundColor:baseColor];
        [cell.accessoryView setBackgroundColor:baseColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        logos = [[UIImageView alloc] initWithFrame:CGRectMake(15,10,177,42)];
        [logos setImage:[UIImage imageNamed:@"license_plate_nl.png"]];
        logos.contentMode = UIViewContentModeScaleAspectFill;
        [cell addSubview:logos];
        kenteken =[[UILabel alloc] initWithFrame:CGRectMake(-5,10,200,42)];
        [kenteken setBackgroundColor:[UIColor clearColor]];
        [kenteken setFont:[UIFont fontWithName:@"Kenteken" size:20]];
        [kenteken setTextAlignment:NSTextAlignmentCenter];
        [cell addSubview:kenteken];

        ovelaylabel= [[UILabel alloc] initWithFrame:CGRectMake(15,50,400,50)];
        [ovelaylabel setBackgroundColor:[UIColor clearColor]];
        [ovelaylabel setFont:[UIFont systemFontOfSize:12]];
        [ovelaylabel setTextAlignment:NSTextAlignmentLeft];
        [ovelaylabel setTextColor:[UIColor whiteColor]];
        [ovelaylabel setNumberOfLines:3];
        [cell addSubview:ovelaylabel];

        [ovelaylabel setAlpha:0];
        [ovelaylabel.layer setCornerRadius:4];
        [ovelaylabel.layer setMasksToBounds:YES];


        [kenteken sizeToFit];
        [kenteken setCenter:logos.center];
        [ovelaylabel setAlpha:1];
    }

    [ovelaylabel setAlpha:0];
    if ([[[appDelegate.alleVoertuigenArray objectAtIndex:indexPath.row] valueForKey:@"Kenteken"] length]<2) {

        [kenteken setText:[[appDelegate.alleVoertuigenArray objectAtIndex:indexPath.row] valueForKey:@"KentekenOpgemaakt"]];
        [ovelaylabel setText:[NSString stringWithFormat:@"%@ %@\nID: %@",[[[FileManager getMerk:[[appDelegate.alleVoertuigenArray objectAtIndex:indexPath.row] valueForKey:@"MerkId"]] firstObject] valueForKey:@"Naam"], [[[[[FileManager getModel:[[appDelegate.alleVoertuigenArray objectAtIndex:indexPath.row] valueForKey:@"ModelId"]] firstObject] valueForKey:@"Namen"] valueForKey:@"InternetNaam"] componentsJoinedByString:@","], [[appDelegate.alleVoertuigenArray objectAtIndex:indexPath.row] valueForKey:@"VoertuigId"]]];
        [kenteken sizeToFit];
        [kenteken setCenter:logos.center];
        [ovelaylabel setAlpha:1];
    } else {
        [kenteken setText:[[appDelegate.alleVoertuigenArray objectAtIndex:indexPath.row] valueForKey:@"KentekenOpgemaakt"]];
        [ovelaylabel setText:[NSString stringWithFormat:@"%@ %@\nID: %@",[[[FileManager getMerk:[[appDelegate.alleVoertuigenArray objectAtIndex:indexPath.row] valueForKey:@"MerkId"]] firstObject] valueForKey:@"Naam"], [[[[[FileManager getModel:[[appDelegate.alleVoertuigenArray objectAtIndex:indexPath.row] valueForKey:@"ModelId"]] firstObject] valueForKey:@"Namen"] valueForKey:@"InternetNaam"] componentsJoinedByString:@","], [[appDelegate.alleVoertuigenArray objectAtIndex:indexPath.row] valueForKey:@"VoertuigId"]]];
        [kenteken sizeToFit];
        [kenteken setCenter:logos.center];
        [ovelaylabel setAlpha:1];
    }
    
    
        ////////////NSLog(@"%@", [[appDelegate.AlleVoertuigen objectAtIndex:indexPath.row] objectForKey:@"KentekenBuitenlands"]);
    
    if ([[[appDelegate.alleVoertuigenArray objectAtIndex:indexPath.row] objectForKey:@"KentekenBuitenlands"] boolValue]){
        [kenteken setFrame:CGRectMake(kenteken.frame.origin.x, kenteken.frame.origin.y, kenteken.frame.size.width+6, kenteken.frame.size.height+6)];
        [kenteken setBackgroundColor:[UIColor whiteColor]];
        [logos setAlpha:0];
        [kenteken.layer setBorderWidth:1];
        [kenteken setTextAlignment:NSTextAlignmentCenter];
        
    } else {
        [logos setAlpha:1];
        [kenteken setBackgroundColor:[UIColor clearColor]];
        [kenteken.layer setBorderWidth:0];
        [kenteken setTextAlignment:NSTextAlignmentCenter];
        
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
/*
 - (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
 }
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *appDelegate = [FileManager getDel];
    
    appDelegate.currentCarDictionary =[appDelegate.alleVoertuigenArray objectAtIndex:indexPath.row];
    appDelegate.categorieenStandaardArray =[[FileManager getStandaardCategorieen:@""] mutableCopy];
    [appDelegate.viewcontroller.collectionOnderdelenView.catogorie.tableResult reloadData];
    [appDelegate.viewcontroller.menu move:appDelegate.viewcontroller.Uploaden];
    
    for (int k =0; k < [[appDelegate.viewcontroller.carView subviews] count]; k++) {
        for (int i =0; i < [[[[appDelegate.viewcontroller.carView subviews] objectAtIndex:k]  subviews] count]; i++) {
            [[[[[appDelegate.viewcontroller.carView subviews] objectAtIndex:k]  subviews] objectAtIndex:i] removeFromSuperview];
        }
        [[[appDelegate.viewcontroller.carView subviews] objectAtIndex:k] removeFromSuperview];
        
    }
    [appDelegate.viewcontroller.carView setItem:[UIColor whiteColor]];
    if ([[[appDelegate.alleVoertuigenArray objectAtIndex:indexPath.row] valueForKey:@"Kenteken"] length]<2) {
        [appDelegate.viewcontroller.barview.ovelaylabel setText:[NSString stringWithFormat:@"voertuig ID: %@",[[[appDelegate.alleVoertuigenArray objectAtIndex:indexPath.row] valueForKey:@"VoertuigId"] stringValue]]];
        [appDelegate.viewcontroller.barview.ovelaylabel setBackgroundColor:[UIColor whiteColor]];
        [appDelegate.viewcontroller.barview.ovelaylabel setAlpha:1];
        [appDelegate.viewcontroller.barview.kenteken setAlpha:0];
        [appDelegate.viewcontroller.barview.logos setAlpha:0];
        [appDelegate.viewcontroller.barview.autolabel setText:[NSString stringWithFormat:@"%@ %@ ID: %@",[[[FileManager getMerk:[[appDelegate.alleVoertuigenArray objectAtIndex:indexPath.row] valueForKey:@"MerkId"]] firstObject] valueForKey:@"Naam"], [[[[[FileManager getModel:[[appDelegate.alleVoertuigenArray objectAtIndex:indexPath.row] valueForKey:@"ModelId"]] firstObject] valueForKey:@"Namen"] valueForKey:@"InternetNaam"] componentsJoinedByString:@","], [[appDelegate.alleVoertuigenArray objectAtIndex:indexPath.row] valueForKey:@"VoertuigId"]]];
    } else {
        [appDelegate.viewcontroller.barview.kenteken setText:[[appDelegate.alleVoertuigenArray objectAtIndex:indexPath.row] valueForKey:@"KentekenOpgemaakt"]];
        [appDelegate.viewcontroller.barview.kenteken setBackgroundColor:[UIColor clearColor]];
        
        [appDelegate.viewcontroller.barview.kenteken sizeToFit];
        [appDelegate.viewcontroller.barview.kenteken setCenter:appDelegate.viewcontroller.barview.logos.center];
        
        if ([[[appDelegate.alleVoertuigenArray objectAtIndex:indexPath.row] objectForKey:@"KentekenBuitenlands"] boolValue]){
            
            [appDelegate.viewcontroller.barview.kenteken setBackgroundColor:[UIColor whiteColor]];
            [appDelegate.viewcontroller.barview.kenteken setFrame:CGRectMake(appDelegate.viewcontroller.barview.kenteken.frame.origin.x, appDelegate.viewcontroller.barview.kenteken.frame.origin.y, appDelegate.viewcontroller.barview.kenteken.frame.size.width+6, appDelegate.viewcontroller.barview.kenteken.frame.size.height+6)];
            [appDelegate.viewcontroller.barview.kenteken setBackgroundColor:[UIColor whiteColor]];
            [appDelegate.viewcontroller.barview.logos setAlpha:0];
            [appDelegate.viewcontroller.barview.kenteken.layer setBorderWidth:1];
            [appDelegate.viewcontroller.barview.kenteken setTextAlignment:NSTextAlignmentCenter];
            
        }
        
        else
        {
            
            [appDelegate.viewcontroller.barview.kenteken setBackgroundColor:[UIColor clearColor]];
            [appDelegate.viewcontroller.barview.logos setAlpha:1];
            [appDelegate.viewcontroller.barview.kenteken.layer setBorderWidth:0];
            [appDelegate.viewcontroller.barview.kenteken setTextAlignment:NSTextAlignmentRight];
            [appDelegate.viewcontroller.barview.kenteken.layer setBorderWidth:0];
            [appDelegate.viewcontroller.barview.kenteken setTextAlignment:NSTextAlignmentCenter];
            
        }
        
        [appDelegate.viewcontroller.barview.ovelaylabel setAlpha:0];
        [appDelegate.viewcontroller.barview.kenteken setAlpha:1];
        
        [appDelegate.viewcontroller.barview.autolabel setText:[NSString stringWithFormat:@"%@ %@ ID: %@",[[[FileManager getMerk:[[appDelegate.alleVoertuigenArray objectAtIndex:indexPath.row] valueForKey:@"MerkId"]] firstObject] valueForKey:@"Naam"], [[[[[FileManager getModel:[[appDelegate.alleVoertuigenArray objectAtIndex:indexPath.row] valueForKey:@"ModelId"]] firstObject] valueForKey:@"Namen"] valueForKey:@"InternetNaam"] componentsJoinedByString:@","], [[appDelegate.alleVoertuigenArray objectAtIndex:indexPath.row] valueForKey:@"VoertuigId"]]];
    }
    
    
    if ([[[appDelegate.alleVoertuigenArray objectAtIndex:indexPath.row] valueForKey:@"Onderdelen"] isKindOfClass:[NSArray class]]) {

            ////////////NSLog(@"1");

        appDelegate.onderdelenVoertuigArray =[[NSMutableArray alloc] init];
    } else {
        if ([[[appDelegate.alleVoertuigenArray objectAtIndex:indexPath.row] valueForKey:@"Onderdelen"] length]>0)
            
        {
            
                ////////////NSLog(@"2");
            appDelegate.onderdelenVoertuigArray = [[FileManager getOnderdelen_voertuig:[[appDelegate.alleVoertuigenArray objectAtIndex:indexPath.row] valueForKey:@"Onderdelen"]] mutableCopy];
            


        }
        else
        {
                ////////////NSLog(@"3");
            appDelegate.onderdelenVoertuigArray =[[NSMutableArray alloc] init];
            

        }

        
    }
    
    [appDelegate.viewcontroller.menu move:(LineButton*)appDelegate.viewcontroller.menu.info];

    [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
    
}
@end
