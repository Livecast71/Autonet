    //
    //  ItemFold.m
    //  Autonet
    //
    //  Created by Livecast02 on 01-03-17.
    //  Copyright © 2017 Autonet. All rights reserved.
    //
#import "ItemFold.h"
#import "FileManager.h"
#import "UIFont+FlatUI.h"
#import "FieldLabelView.h"
#import "AppDelegate.h"
#import "BigLabelView.h"
#import "CameraButton.h"
#import "alertViewController.h"
#import "imagePickerViewController.h"
@implementation ItemFold
@synthesize titleView;
@synthesize upDownView;
@synthesize sizeit;
@synthesize contentdict;
@synthesize basepart;
@synthesize imageArray;
@synthesize activateCameraRoll;
@synthesize cameraRoll;
@synthesize imageScrollView;
@synthesize extraArray;
@synthesize backview;
@synthesize pickercontroller;

-(void)ItemBase:(NSMutableDictionary*)item
{

    backview =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [backview setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:backview];

    titleView =[[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width-20, 55)];
    [titleView setText:[NSString stringWithFormat:@"  %@", [item valueForKey:@"Title"]]];
    [titleView setFont:[UIFont boldFlatFontOfSize:16]];
    [titleView setTextColor:[UIColor blackColor]];
    [titleView setBackgroundColor:[UIColor whiteColor]];
    [titleView setTextAlignment:NSTextAlignmentLeft];
    [self addSubview:titleView];

}
-(void)ItemFold:(NSMutableDictionary*)item
{
    AppDelegate *appDelegate = [FileManager getDel];
    sizeit = [[item valueForKey:@"Height"] floatValue];

    [self ItemBase:item];
    upDownView =[[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 12.5, 7)];
    [upDownView setImage:[UIImage imageNamed:@"Down.png"]];
    [self addSubview:upDownView];

    if ([[item valueForKey:@"Title"] isEqualToString:@"Foto's"]) {

        NSString *docDir = [FileManager getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"FotosInfo", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
        NSMutableArray* copyplist = [NSMutableArray arrayWithContentsOfFile:itemFilePath];

        CameraButton *camera =[[CameraButton alloc]initWithFrame:CGRectMake(10,70, 50, 50)];
        [camera addTarget:self action:@selector(CameraAction:) forControlEvents:UIControlEventTouchUpInside];
        [camera setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [camera setBackgroundColor:[UIColor whiteColor]];
        [camera.layer setBorderWidth:2];
        [camera.layer  setBorderColor:[UIColor grayColor].CGColor];
        [camera setItembig:[UIColor grayColor] setImage:@"camer.png"];
        camera.currentCollection =imageScrollView.imageView;
        [self addSubview:camera];

        imageScrollView =[[ImageScrollView alloc] initWithFrame:CGRectMake(70, 70, self.frame.size.width-80, 120)];
        [imageScrollView.layer setBorderWidth:2];
        [imageScrollView.layer  setBorderColor:[UIColor lightGrayColor].CGColor];
        [imageScrollView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:imageScrollView];

        if ([copyplist count]>0) {
            [imageScrollView setimages:[copyplist valueForKey:@"Orgnaam"] setOnline:[copyplist valueForKey:@"Internet"]];
        }
        else
        {
            [imageScrollView setimages: [[NSMutableArray alloc] init] setOnline: [[NSMutableArray alloc] init]];
        }
        sizeit = [[item valueForKey:@"Height"] floatValue]+40;
    }

    else if ([[item valueForKey:@"Title"] isEqualToString:@"Airbags"]||[[item valueForKey:@"Title"] isEqualToString:@"Gordelspanners"]||[[item valueForKey:@"Title"] isEqualToString:@"Schades"]||[[item valueForKey:@"Title"] isEqualToString:@"Opties"]) {

        for (int k =0; k <[extraArray count]; k++) {

            FieldLabelView *labelview =[[FieldLabelView alloc] init];


            if (k % 2)
            {
                [labelview setFrame:CGRectMake(20, 50+(60*(k/2)), 400, 50)];
            }
            else
            {
                [labelview setFrame:CGRectMake(470, 50+(60*(k/2)), 400, 50)];
            }

            if ([[item valueForKey:@"Title"] isEqualToString:@"Airbags"]) {
                [labelview setAirbags:[extraArray objectAtIndex:k]];
            }
            else if ([[item valueForKey:@"Title"] isEqualToString:@"Gordelspanners"]) {
                [labelview setGordels:[extraArray objectAtIndex:k]];

            }
            else if ([[item valueForKey:@"Title"] isEqualToString:@"Schades"]) {
                [labelview setSchades:[extraArray objectAtIndex:k]];

            }
            else if ([[item valueForKey:@"Title"] isEqualToString:@"Opties"]) {
                [labelview setOpties:[extraArray objectAtIndex:k]];
            }
            [labelview setFoldscreen:self];
            [labelview setBackgroundColor:[UIColor clearColor]];
            [self addSubview:labelview];
        }
    } else if ([[item valueForKey:@"Title"] isEqualToString:@"Bijzonderheden"]) {

        NSArray *array = [item valueForKey:@"List"];
        sizeit = self.frame.size.height;
        for (int k =0; k <[array count]; k++) {

            BigLabelView *labelview =[[BigLabelView alloc] init];
            if ([[[array objectAtIndex:k] valueForKey:@"title_active"] isEqualToString:@"YES"]) {

               [labelview setFrame:CGRectMake([[[array objectAtIndex:k] valueForKey:@"x"] floatValue], 40+[[[array objectAtIndex:k] valueForKey:@"y"] floatValue], 40*[[[array objectAtIndex:k] valueForKey:@"block"] floatValue], 100)];
            }
            else
            {
                [labelview setFrame:CGRectMake([[[array objectAtIndex:k] valueForKey:@"x"] floatValue], 40+[[[array objectAtIndex:k] valueForKey:@"y"] floatValue], 40*[[[array objectAtIndex:k] valueForKey:@"block"] floatValue], 100)];
            }
            [labelview setBackgroundColor:[UIColor clearColor]];
            [self addSubview:labelview];
            [labelview setItem:[array objectAtIndex:k]];
            [labelview setFoldscreen:self];
        }
    } else {
        NSArray *array = [item valueForKey:@"List"];
        sizeit = self.frame.size.height;
        for (int k =0; k <[array count]; k++) {

            FieldLabelView *labelview =[[FieldLabelView alloc] init];
            if ([[[array objectAtIndex:k] valueForKey:@"title_active"] isEqualToString:@"YES"]) {

               [labelview setFrame:CGRectMake([[[array objectAtIndex:k] valueForKey:@"x"] floatValue], 40+[[[array objectAtIndex:k] valueForKey:@"y"] floatValue], 40*[[[array objectAtIndex:k] valueForKey:@"block"] floatValue], 50)];
            }
            else
            {
                 [labelview setFrame:CGRectMake([[[array objectAtIndex:k] valueForKey:@"x"] floatValue], 40+[[[array objectAtIndex:k] valueForKey:@"y"] floatValue], 40*[[[array objectAtIndex:k] valueForKey:@"block"] floatValue], 50)];
            }
            [labelview setBackgroundColor:[UIColor clearColor]];
            [self addSubview:labelview];
            [labelview setItemVeldCar:[array objectAtIndex:k]];
            [labelview setFoldscreen:self];
        }
    }
    UIButton *click =[[UIButton alloc]initWithFrame:CGRectMake(10, 0, self.frame.size.width-20, 55)];
    [click addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:click];
}
-(void)selectfold:(UIButton*)set
{
    [upDownView setImage:[UIImage imageNamed:@"Up.png"]];
}
-(void)select:(UIButton*)set
{
    AppDelegate *appDelegate = [FileManager getDel];
    UIScrollView *copy = (UIScrollView*)[self superview];
    [copy  setContentSize:CGSizeMake(copy.frame.size.width, copy.contentSize.height-(self.frame.size.height+self.frame.origin.x))];
    if (self.frame.size.height==55) {
        for (int i =0; i < [appDelegate.viewcontroller.carView.AllItems count]; i++) {
            if ( i > [appDelegate.viewcontroller.carView.AllItems indexOfObject:self])
                
            {
                ItemFold *set =[appDelegate.viewcontroller.carView.AllItems objectAtIndex:i];
                
                [set setFrame:CGRectMake(set.frame.origin.x, set.frame.origin.y+(sizeit-55), set.frame.size.width, set.frame.size.height)];
                [appDelegate.viewcontroller.carView.ScrollResult setContentSize:CGSizeMake(appDelegate.viewcontroller.carView.content.frame.size.width, set.frame.size.height+set.frame.origin.y)];
                
            }
        }
        [contentdict setValue:@"YES" forKey:@"Verplicht"];
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, sizeit+55)];
        [backview setFrame:CGRectMake(backview.frame.origin.x, backview.frame.origin.y, backview.frame.size.width, sizeit)];
            //[self.parentcell setFrame:CGRectMake(self.parentcell.frame.origin.x, self.parentcell.frame.origin.y, self.parentcell.frame.size.width, sizeit+65)];
        [backview.layer setMasksToBounds:NO];
        [self.layer setMasksToBounds:NO];
        [upDownView setImage:[UIImage imageNamed:@"Up.png"]];
    } else {
        for (int i =0; i < [appDelegate.viewcontroller.carView.AllItems count]; i++) {
            if ( i > [appDelegate.viewcontroller.carView.AllItems indexOfObject:self])
                
            {
                ItemFold *set =[appDelegate.viewcontroller.carView.AllItems objectAtIndex:i];
                
                [set setFrame:CGRectMake(set.frame.origin.x, set.frame.origin.y-(sizeit-55), set.frame.size.width, set.frame.size.height)];
                [appDelegate.viewcontroller.carView.ScrollResult setContentSize:CGSizeMake(appDelegate.viewcontroller.carView.content.frame.size.width, set.frame.size.height+set.frame.origin.y)];
                
            }
        }
        [contentdict setValue:@"NO" forKey:@"Verplicht"];
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 55)];
        [backview setFrame:CGRectMake(backview.frame.origin.x, backview.frame.origin.y, backview.frame.size.width, 55)];
        [backview.layer setMasksToBounds:YES];
        [self.layer setMasksToBounds:YES];
        [upDownView setImage:[UIImage imageNamed:@"Down.png"]];
    }
    [copy  setContentSize:CGSizeMake(copy.frame.size.width, copy.contentSize.height+(self.frame.size.height+self.frame.origin.x))];
}
- (IBAction)CameraAction:(ImageButton *)sender
{
    AppDelegate *appDelegate = [FileManager getDel];
    activateCameraRoll =sender;
    appDelegate.viewcontroller.fotoPickerView.currentFold = self;
    alertViewController * alert=   [alertViewController
                                    alertControllerWithTitle:@"Maak een keuze!"
                                    message:@""
                                    preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *neeAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
    }];
    [alert addAction:neeAction];
    UIAlertAction *playAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        self.pickercontroller = [[imagePickerViewController alloc] init];
        self.pickercontroller.delegate = self;
        self.pickercontroller.allowsEditing = YES;
#if (TARGET_IPHONE_SIMULATOR)
        self.pickercontroller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
#else
        self.pickercontroller.sourceType =  UIImagePickerControllerSourceTypeCamera;
#endif
        [appDelegate.viewcontroller presentViewController: self.pickercontroller animated:YES completion:NULL];
    }];
    [alert addAction:playAction];
    [appDelegate.viewcontroller presentViewController:alert animated:YES completion:nil];
}                   
- (void)imagePickerController:(imagePickerViewController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info;                   
{                   
    AppDelegate *appDelegate = [FileManager getDel];
    appDelegate.currentimage =(UIImage*)[info valueForKey:@"UIImagePickerControllerEditedImage"];
    NSMutableArray *arrayItems =[[FileManager getFotos_voertuig:@""] mutableCopy];
    alertViewController * alert=   [alertViewController
                                    alertControllerWithTitle:@"Vraag:"
                                    message:@"Wilt u deze foto op internet gebruiken?"
                                    preferredStyle:UIAlertControllerStyleAlert];
        //alert.shouldAutorotate = NO;
    UIAlertAction *jaAction = [UIAlertAction actionWithTitle:@"Ja" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSString *idit =[appDelegate newUUID];
        NSString *docDir = [FileManager getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@",docDir,[NSString stringWithFormat:@"%@.jpg", idit]];
        NSData *data2 = [NSData dataWithData:UIImageJPEGRepresentation( appDelegate.currentimage, 1.0f)];
        [data2 writeToFile:itemFilePath atomically:YES];
        NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] init];
        [dataDictionary setValue:idit forKey:@"FotoGrootId"];
        NSNumber *number = [NSNumber numberWithInteger:[self.imageScrollView.imageView.arrayItems count]+1];
        NSNumber *number1 = [NSNumber numberWithBool:YES];
        [dataDictionary setValue:number1 forKey:@"Internet"];
        NSNumber *number2 = [NSNumber numberWithBool:YES];
        [dataDictionary setValue:number2 forKey:@"InAutomate"];
        [dataDictionary setValue:[NSString stringWithFormat:@"%@.jpg", idit] forKey:@"Orgnaam"];
        [dataDictionary setValue:number forKey:@"Positie"];
        [dataDictionary setValue:number forKey:@"FotoId"];
        [arrayItems addObject:dataDictionary];
        [FileManager insertFotos:arrayItems];
        if (self.imageScrollView.imageView.arrayInternet) {
        }
        else
        {
            self.imageScrollView.imageView.arrayInternet =[[NSMutableArray alloc] init];
        }
        if ( self.imageScrollView.imageView.arrayItems){
        }
        else
        {
            self.imageScrollView.imageView.arrayItems =[[NSMutableArray alloc] init];
        }
        ////////////NSLog(@"%@", dataDictionary);
        [self.imageScrollView.imageView.arrayInternet addObject:[dataDictionary valueForKey:@"Internet"]];
        [self.imageScrollView.imageView.arrayItems addObject:[NSString stringWithFormat:@"%@.jpg", idit]];
        [self.imageScrollView.imageView.collectionViewcopy reloadData];
        [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
        [appDelegate.viewcontroller dismissViewControllerAnimated:YES completion:NULL];
    }];
    [alert addAction:jaAction];
    UIAlertAction *neeAction = [UIAlertAction actionWithTitle:@"Nee" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        AppDelegate *appDelegate = [FileManager getDel];
        NSString *idit =[appDelegate newUUID];
        NSString *docDir = [FileManager getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@",docDir,[NSString stringWithFormat:@"%@.jpg", idit]];
        NSData *data2 = [NSData dataWithData:UIImageJPEGRepresentation( appDelegate.currentimage, 1.0f)];
        [data2 writeToFile:itemFilePath atomically:YES];
        NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] init];
        [dataDictionary setValue:idit forKey:@"FotoGrootId"];
        NSNumber *number = [NSNumber numberWithInteger:[self.imageScrollView.imageView.arrayItems count]+1];
        NSNumber *number2 = [NSNumber numberWithBool:NO];
        [dataDictionary setValue:number2 forKey:@"InAutomate"];
        NSNumber *number1 = [NSNumber numberWithBool:NO];
        [dataDictionary setValue:number1 forKey:@"Internet"];
        [dataDictionary setValue:[NSString stringWithFormat:@"%@.jpg", idit] forKey:@"Orgnaam"];
        [dataDictionary setValue:number forKey:@"Positie"];
        [dataDictionary setValue:number forKey:@"FotoId"];
        [arrayItems addObject:dataDictionary];
        [FileManager insertFotos:arrayItems];
        if (self.imageScrollView.imageView.arrayInternet) {
        }
        else
        {
            self.imageScrollView.imageView.arrayInternet =[[NSMutableArray alloc] init];
        }
        if (self.imageScrollView.imageView.arrayItems){
        }
        else
        {
            self.imageScrollView.imageView.arrayItems =[[NSMutableArray alloc] init];
        }
            ////////////NSLog(@"%@", dataDictionary);
        [self.imageScrollView.imageView.arrayInternet addObject:[dataDictionary valueForKey:@"Internet"]];
        [self.imageScrollView.imageView.arrayItems addObject:[NSString stringWithFormat:@"%@.jpg", idit]];
        [self.imageScrollView.imageView.collectionViewcopy reloadData];
        [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
        [appDelegate.viewcontroller dismissViewControllerAnimated:YES completion:NULL];
    }];
    [alert addAction:neeAction];
    UIAlertAction *nogeenAction = [UIAlertAction actionWithTitle:@"Nog een foto" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        AppDelegate *appDelegate = [FileManager getDel];
        NSString *idit =[appDelegate newUUID];
        NSString *docDir = [FileManager getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@",docDir,[NSString stringWithFormat:@"%@.jpg", idit]];
        NSData *data2 = [NSData dataWithData:UIImageJPEGRepresentation( appDelegate.currentimage, 1.0f)];
        [data2 writeToFile:itemFilePath atomically:YES];
        NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] init];
        [dataDictionary setValue:idit forKey:@"FotoGrootId"];
        NSNumber *number = [NSNumber numberWithInteger:[self.imageScrollView.imageView.arrayItems count]+1];
        NSNumber *number2 = [NSNumber numberWithBool:NO];
        [dataDictionary setValue:number2 forKey:@"InAutomate"];
        NSNumber *number1 = [NSNumber numberWithBool:YES];
        [dataDictionary setValue:number1 forKey:@"Internet"];
        [dataDictionary setValue:[NSString stringWithFormat:@"%@.jpg", idit] forKey:@"Orgnaam"];
        [dataDictionary setValue:number forKey:@"Positie"];
        [dataDictionary setValue:number forKey:@"FotoId"];
        [arrayItems addObject:dataDictionary];
        [FileManager insertFotos:arrayItems];
        if (self.imageScrollView.imageView.arrayInternet) {
        }
        else
        {
            self.imageScrollView.imageView.arrayInternet =[[NSMutableArray alloc] init];
        }
        if (self.imageScrollView.imageView.arrayItems){
        }
        else
        {
            self.imageScrollView.imageView.arrayItems =[[NSMutableArray alloc] init];
        }
            ////////////NSLog(@"%@", dataDictionary);
        [self.imageScrollView.imageView.arrayInternet addObject:[dataDictionary valueForKey:@"Internet"]];
        [self.imageScrollView.imageView.arrayItems addObject:[NSString stringWithFormat:@"%@.jpg", idit]];
        [self.imageScrollView.imageView.collectionViewcopy reloadData];
        [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
        [appDelegate.viewcontroller dismissViewControllerAnimated:NO completion:NULL];
        self.pickercontroller = [[imagePickerViewController alloc] init];
        self.pickercontroller.delegate = self;
        self.pickercontroller.allowsEditing = YES;
#if (TARGET_IPHONE_SIMULATOR)
        self.pickercontroller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
#else
        self.pickercontroller.sourceType =  UIImagePickerControllerSourceTypeCamera;
#endif
        [appDelegate.viewcontroller presentViewController: self.pickercontroller animated:NO completion:NULL];
    }];
    [alert addAction:nogeenAction];
    UIAlertAction *playAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        [appDelegate.viewcontroller dismissViewControllerAnimated:YES completion:NULL];
    }];
    [alert addAction:playAction];

    [appDelegate.window.rootViewController.presentedViewController presentViewController:alert animated:YES completion:nil];
}
- (IBAction)PrijsAction:(ImageButton *)sender
{
}
@end
