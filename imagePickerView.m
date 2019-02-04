    //
    //  UIImagePickerView.m
    //  Autonet
    //
    //  Created by Livecast02 on 08-08-17.
    //  Copyright © 2017 Autonet. All rights reserved.
    //
#import "imagePickerView.h"
#import "AppDelegate.h"
#import "LineButton.h"
#import "FileManager.h"
#import "alertViewController.h"
@implementation imagePickerView
@synthesize searchBarTo;
@synthesize collectionViewImages;
@synthesize shouldBeginEditing;
@synthesize fetchedResultsControllerCopy;
@synthesize arrayItems;
@synthesize extraArrayItems;
@synthesize header;
@synthesize localDictonary;
@synthesize localArray;
@synthesize ItemID;
@synthesize currentFold;

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setAlpha:1];
        [self setLoadingItems];
        self.layer.shadowOffset = CGSizeMake(1, 1);
        self.layer.shadowOpacity = 1;
        [self.layer setCornerRadius:5];
        self.transform = CGAffineTransformMakeScale(0.5, 0.5);
        [self setAlpha:0];
            //Imagepicker
    }
    return self;
}
-(void)setLoadingItems
{
    arrayItems =[[FileManager getFotos_voertuig:@""] mutableCopy];
    localArray =[[NSMutableArray alloc] init];
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    [layout setHeaderReferenceSize:CGSizeMake(2, 2)];
    [layout setFooterReferenceSize:CGSizeMake(2, 2)];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    collectionViewImages=[[UICollectionView alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width-10, self.frame.size.height-10) collectionViewLayout:layout];
    [collectionViewImages setDataSource:self];
    [collectionViewImages setDelegate:self];
    [collectionViewImages registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [collectionViewImages setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:collectionViewImages];
    
    UIButton *note =[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-50,10, 40, 40)];
    [note setImage:[UIImage imageNamed:@"gone.png"] forState:UIControlStateNormal];
    [note addTarget:self action:@selector(select) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:note];
    [note.layer setCornerRadius:4];
}
-(void)select
{
    arrayItems =[[FileManager getFotos_voertuig:@""] mutableCopy];
    [collectionViewImages reloadData];
    if (self.alpha >0)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.2f];
        self.transform = CGAffineTransformMakeScale(0.5, 0.5);
        [self setAlpha:0];
        [UIView commitAnimations];
    } else {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.2f];
        self.transform = CGAffineTransformMakeScale(1, 1);
        [self setAlpha:1];
        [UIView commitAnimations];
    }
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}
#pragma mark - Fetched Result Controller section
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [arrayItems count];
}
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor grayColor];
    NSString *docDir = [FileManager getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/thumb_%@",docDir,[[arrayItems valueForKey:@"Orgnaam"] objectAtIndex:indexPath.row]];

    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:itemFilePath];
    if (fileExists) {

        UIImage *set =[UIImage imageWithContentsOfFile:itemFilePath];
        UIImageView *img = [[UIImageView alloc] initWithImage:[self generatePhotoThumbnail:set withSide:200]];
        [img setFrame:CGRectMake(0,0, 120*2, 90*2)];
        [cell addSubview:img];
    } else {
        itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@",docDir,[[arrayItems valueForKey:@"Orgnaam"] objectAtIndex:indexPath.row]];

        UIImage *set =[UIImage imageWithContentsOfFile:itemFilePath];
        UIImageView *img = [[UIImageView alloc] initWithImage:[self generatePhotoThumbnail:set withSide:200]];
        [img setFrame:CGRectMake(0,0, 120*2, 90*2)];
        [cell addSubview:img];

    }
    return cell;
}
- (void)activateDeletionMode:(UILongPressGestureRecognizer *)gr
{
}
- (UIImage *)generatePhotoThumbnail:(UIImage *)image withSide:(CGFloat)ratio
{
        // Create a thumbnail version of the image for the event object.
    CGSize size = image.size;
    CGSize croppedSize;
    CGFloat offsetX = 0.0;
    CGFloat offsetY = 0.0;
    if (size.width > size.height) {
        offsetX = (size.height - size.width) / 2;
        croppedSize = CGSizeMake(size.height, size.height);
    } else {
        offsetY = (size.width - size.height) / 2;
        croppedSize = CGSizeMake(size.width, size.width);
    }
    CGRect clippedRect = CGRectMake(offsetX * -1, offsetY * -1, croppedSize.width, croppedSize.height);
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], clippedRect);
    CGRect rect = CGRectMake(0.0, 0.0, ratio, ratio);
    UIGraphicsBeginImageContext(rect.size);
    [[UIImage imageWithCGImage:imageRef] drawInRect:rect];
    UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return thumbnail;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    AppDelegate *appDelegate = [FileManager getDel];


    NSString *docDir = [FileManager getDir];

        ////NSLog(@"basepart %@", appDelegate.currentOnderdeel.basepart);

        ////NSLog(@"localDictonary %@", self.localDictonary);

        ////NSLog(@"localArray %@",self.localArray);

    NSString *idit =[appDelegate newUUID];


    alertViewController * alert=   [alertViewController
                                    alertControllerWithTitle:@"Vraag:"
                                    message:@"Wilt u deze foto op internet gebruiken?"
                                    preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *NeeAction = [UIAlertAction actionWithTitle:@"Ja" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){


        if (self.localDictonary == NULL) {

            self.localDictonary = [[NSMutableDictionary alloc] init];

        }
        [self.localDictonary setValue:[NSNumber numberWithBool:YES] forKey:@"Internet"];
            //[self.localDictonary setValue:[appDelegate.currentOnderdeel.basepart valueForKey:@"AannamelijstOnderdeelId"] forKey:@"id"];
        NSNumber *number2 = [NSNumber numberWithBool:YES];
        [self.localDictonary setValue:number2 forKey:@"InAutomate"];
        [self.localDictonary setValue:idit forKey:@"FotoGrootId"];
        [self.localDictonary setValue:[NSNumber numberWithInteger:[self.localArray count]+1] forKey:@"FotoId"];
        [self.localDictonary setValue:idit forKey:@"FotoThumpId"];
        [self.localDictonary setValue:[NSString stringWithFormat:@"%@.jpg", idit] forKey:@"Orgnaam"];
        [self.localDictonary setValue:[NSNumber numberWithInteger:[self.localArray count]+1] forKey:@"Positie"];
        [self.localArray addObject:self.localDictonary];
        [FileManager insertFotos_onderdelenid:self.localArray setid:self.ItemID];
        [appDelegate.viewcontroller dismissViewControllerAnimated:YES completion:NULL];



        double delayInSeconds = 0.3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if (appDelegate.viewcontroller.fotoPickerView.currentFold.imageScrollView.imageView.arrayInternet) {
            }
            else
            {
                appDelegate.viewcontroller.fotoPickerView.currentFold.imageScrollView.imageView.arrayInternet =[[NSMutableArray alloc] init];
            }
            if (appDelegate.viewcontroller.fotoPickerView.currentFold.imageScrollView.imageView.arrayItems){
            }
            else
            {
                appDelegate.viewcontroller.fotoPickerView.currentFold.imageScrollView.imageView.arrayItems =[[NSMutableArray alloc] init];
            }
            [appDelegate.viewcontroller.fotoPickerView.currentFold.imageScrollView.imageView.arrayInternet addObject:[self.localDictonary valueForKey:@"Internet"]];
            [appDelegate.viewcontroller.fotoPickerView.currentFold.imageScrollView.imageView.arrayItems addObject:[self.localDictonary valueForKey:@"Orgnaam"]];
            [appDelegate.viewcontroller.fotoPickerView.currentFold.imageScrollView.imageView.collectionViewcopy reloadData];
            [self.collectionViewImages reloadData];
                //currentOnderdeel
     
            [self select];



        });


    }];
    [alert addAction:NeeAction];
    UIAlertAction *JaAction = [UIAlertAction actionWithTitle:@"Nee" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){

        if (self.localDictonary == NULL) {

            self.localDictonary = [[NSMutableDictionary alloc] init];

        }
        [self.localDictonary setValue:[NSNumber numberWithBool:NO] forKey:@"Internet"];
            // [self.localDictonary setValue:[appDelegate.currentOnderdeel.basepart valueForKey:@"AannamelijstOnderdeelId"] forKey:@"id"];
        NSNumber *number2 = [NSNumber numberWithBool:YES];
        [self.localDictonary setValue:number2 forKey:@"InAutomate"];
        [self.localDictonary setValue:idit forKey:@"FotoGrootId"];
        [self.localDictonary setValue:[NSNumber numberWithInteger:[self.localArray count]+1] forKey:@"FotoId"];
        [self.localDictonary setValue:idit forKey:@"FotoThumpId"];
        [self.localDictonary setValue: [NSString stringWithFormat:@"%@.jpg", idit] forKey:@"Orgnaam"];
        [self.localDictonary setValue:[NSNumber numberWithInteger:[self.localArray count]+1] forKey:@"Positie"];
        [self.localArray addObject:self.localDictonary];
        [FileManager insertFotos_onderdelenid:self.localArray setid:self.ItemID];
        [appDelegate.viewcontroller dismissViewControllerAnimated:YES completion:NULL];




        
        double delayInSeconds = 0.3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if (appDelegate.viewcontroller.fotoPickerView.currentFold.imageScrollView.imageView.arrayInternet) {
            }
            else
            {
                appDelegate.viewcontroller.fotoPickerView.currentFold.imageScrollView.imageView.arrayInternet =[[NSMutableArray alloc] init];
            }
            if (appDelegate.viewcontroller.fotoPickerView.currentFold.imageScrollView.imageView.arrayItems){
            }
            else
            {
                appDelegate.viewcontroller.fotoPickerView.currentFold.imageScrollView.imageView.arrayItems =[[NSMutableArray alloc] init];
            }
            [appDelegate.viewcontroller.fotoPickerView.currentFold.imageScrollView.imageView.arrayInternet addObject:[self.localDictonary valueForKey:@"Internet"]];
            [appDelegate.viewcontroller.fotoPickerView.currentFold.imageScrollView.imageView.arrayItems addObject:[self.localDictonary valueForKey:@"Orgnaam"]];
            [appDelegate.viewcontroller.fotoPickerView.currentFold.imageScrollView.imageView.collectionViewcopy reloadData];
            [self.collectionViewImages reloadData];
            [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
            [self select];
        });


    }];
    [alert addAction:JaAction];
    UIAlertAction *againAction = [UIAlertAction actionWithTitle:@"Nog een foto maken." style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){


        if (self.localDictonary == NULL) {

            self.localDictonary = [[NSMutableDictionary alloc] init];

        }
        [self.localDictonary setValue:[NSNumber numberWithBool:YES] forKey:@"Internet"];
        [self.localDictonary setValue:[appDelegate.currentOnderdeel.basepart valueForKey:@"AannamelijstOnderdeelId"] forKey:@"id"];
        NSNumber *number2 = [NSNumber numberWithBool:YES];
        [self.localDictonary setValue:number2 forKey:@"InAutomate"];
        [self.localDictonary setValue:idit forKey:@"FotoGrootId"];
        [self.localDictonary setValue:[NSNumber numberWithInteger:[self.localArray count]+1] forKey:@"FotoId"];
        [self.localDictonary setValue:idit forKey:@"FotoThumpId"];
        [self.localDictonary setValue: [NSString stringWithFormat:@"%@.jpg", idit] forKey:@"Orgnaam"];
        [self.localDictonary setValue:[NSNumber numberWithInteger:[self.localArray count]+1] forKey:@"Positie"];
        [self.localArray addObject:self.localDictonary];
        [FileManager insertFotos_onderdelenid:self.localArray setid:self.ItemID];



    }];
    [alert addAction:againAction];
    UIAlertAction *playAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){

        [appDelegate.viewcontroller dismissViewControllerAnimated:YES completion:NULL];
    }];
    [alert addAction:playAction];
    [appDelegate.viewcontroller presentViewController:alert animated:YES completion:nil];



    NSString *fileFilePath = [NSString stringWithFormat:@"%@/Caches/%@",docDir,[[arrayItems valueForKey:@"Orgnaam"] objectAtIndex:indexPath.row]];
    appDelegate.currentimage =[UIImage imageWithContentsOfFile:fileFilePath];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@",docDir,[NSString stringWithFormat:@"%@.jpg", idit]];
    NSData *data2 = [NSData dataWithData:UIImageJPEGRepresentation(appDelegate.currentimage , 1.0f)];
    [data2 writeToFile:itemFilePath atomically:YES];
    /*

     ////NSLog(@"%@", appDelegate.alleVoertuigenArray);

     if ([[[appDelegate.alleVoertuigenArray objectAtIndex:indexPath.row] valueForKey:@"Onderdelen"] isKindOfClass:[NSArray class]]) {

     } else {
     if ([[[appDelegate.alleVoertuigenArray objectAtIndex:indexPath.row] valueForKey:@"Onderdelen"] length]>0)

     {

     appDelegate.onderdelenVoertuigArray = [[FileManager getOnderdelen_voertuig:[[appDelegate.alleVoertuigenArray objectAtIndex:indexPath.row] valueForKey:@"Onderdelen"]] mutableCopy];

     [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
     } else {

     appDelegate.onderdelenVoertuigArray =[[NSMutableArray alloc] init];

     [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
     }

     }

     */


}
-(void) alertView2:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    AppDelegate *appDelegate = [FileManager getDel];
    if (alertView.tag ==407) {
        if (buttonIndex ==1)
        {
            [localDictonary setValue:[NSNumber numberWithBool:YES] forKey:@"Internet"];
            [localDictonary setValue:[appDelegate.currentOnderdeel.basepart valueForKey:@"AannamelijstOnderdeelId"] forKey:@"id"];
            NSNumber *number2 = [NSNumber numberWithBool:YES];
            [localDictonary setValue:number2 forKey:@"InAutomate"];
            [localArray addObject:localDictonary];
            [FileManager insertFotos_onderdelenid:localArray setid:ItemID];
            [appDelegate.viewcontroller dismissViewControllerAnimated:YES completion:NULL];
            double delayInSeconds = 0.3;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                if (appDelegate.viewcontroller.fotoPickerView.currentFold.imageScrollView.imageView.arrayInternet) {
                }
                else
                {
                    appDelegate.viewcontroller.fotoPickerView.currentFold.imageScrollView.imageView.arrayInternet =[[NSMutableArray alloc] init];
                }
                if (appDelegate.viewcontroller.fotoPickerView.currentFold.imageScrollView.imageView.arrayItems){
                }
                else
                {
                    appDelegate.viewcontroller.fotoPickerView.currentFold.imageScrollView.imageView.arrayItems =[[NSMutableArray alloc] init];
                }
                [appDelegate.viewcontroller.fotoPickerView.currentFold.imageScrollView.imageView.arrayInternet addObject:[self.localDictonary valueForKey:@"Internet"]];
                [appDelegate.viewcontroller.fotoPickerView.currentFold.imageScrollView.imageView.arrayItems addObject:[self.localDictonary valueForKey:@"Orgnaam"]];
                [appDelegate.viewcontroller.fotoPickerView.currentFold.imageScrollView.imageView.collectionViewcopy reloadData];
                
                [self.collectionViewImages reloadData];
                
                    //currentOnderdeel
                [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
                [self select];
                
            });
        }
        else if (buttonIndex ==2)
        {
            AppDelegate *appDelegate = [FileManager getDel];
            [localDictonary setValue:[NSNumber numberWithBool:NO] forKey:@"Internet"];
            [localDictonary setValue:[appDelegate.currentOnderdeel.basepart valueForKey:@"AannamelijstOnderdeelId"] forKey:@"id"];
            NSNumber *number2 = [NSNumber numberWithBool:YES];
            [localDictonary setValue:number2 forKey:@"InAutomate"];
            [localArray addObject:localDictonary];
            [FileManager insertFotos_onderdelenid:localArray setid:ItemID];
            [appDelegate.viewcontroller dismissViewControllerAnimated:YES completion:NULL];
            double delayInSeconds = 0.3;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                if (appDelegate.viewcontroller.fotoPickerView.currentFold.imageScrollView.imageView.arrayInternet) {
                }
                else
                {
                    appDelegate.viewcontroller.fotoPickerView.currentFold.imageScrollView.imageView.arrayInternet =[[NSMutableArray alloc] init];
                }
                if (appDelegate.viewcontroller.fotoPickerView.currentFold.imageScrollView.imageView.arrayItems){
                }
                else
                {
                    appDelegate.viewcontroller.fotoPickerView.currentFold.imageScrollView.imageView.arrayItems =[[NSMutableArray alloc] init];
                }
                [appDelegate.viewcontroller.fotoPickerView.currentFold.imageScrollView.imageView.arrayInternet addObject:[self.localDictonary valueForKey:@"Internet"]];
                [appDelegate.viewcontroller.fotoPickerView.currentFold.imageScrollView.imageView.arrayItems addObject:[self.localDictonary valueForKey:@"Orgnaam"]];
                [appDelegate.viewcontroller.fotoPickerView.currentFold.imageScrollView.imageView.collectionViewcopy reloadData];
                
                [self.collectionViewImages reloadData];
                [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
                [self select];
            });
        }
        else if (buttonIndex ==3)
        {
        }
    } else {
        if (buttonIndex==1) {
            [localDictonary setValue:[NSNumber numberWithBool:YES] forKey:@"Internet"];
            [localDictonary setValue:[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"] forKey:@"id"];
            NSNumber *number2 = [NSNumber numberWithBool:YES];
            [localDictonary setValue:number2 forKey:@"InAutomate"];
            [FileManager insertFotosIn_voertuig:localDictonary];
            double delayInSeconds = 0.3;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                AppDelegate *appDelegate = [FileManager getDel];
                [appDelegate.viewcontroller.menu move:appDelegate.viewcontroller.Uploaden];
                for (int k =0; k < [[appDelegate.viewcontroller.carView subviews] count]; k++) {
                    for (int i =0; i < [[[[appDelegate.viewcontroller.carView subviews] objectAtIndex:k]  subviews] count]; i++) {
                        [[[[[appDelegate.viewcontroller.carView subviews] objectAtIndex:k]  subviews] objectAtIndex:i] removeFromSuperview];
                    }
                    [[[appDelegate.viewcontroller.carView subviews] objectAtIndex:k] removeFromSuperview];
                }
                [appDelegate.viewcontroller.carView setItem:[UIColor whiteColor]];

                [appDelegate.viewcontroller.barview.kenteken sizeToFit];
                [appDelegate.viewcontroller.barview.kenteken setCenter:appDelegate.viewcontroller.barview.logos.center];


                if ([[appDelegate.currentCarDictionary objectForKey:@"KentekenBuitenlands"] boolValue]){

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
                

                [appDelegate.viewcontroller.menu move:(LineButton*)appDelegate.viewcontroller.menu.info];

                [self select];
            });
        }
        else  if (buttonIndex==2) {
            [localDictonary setValue:[NSNumber numberWithBool:NO] forKey:@"Internet"];
            [localDictonary setValue:[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"] forKey:@"id"];
            NSNumber *number2 = [NSNumber numberWithBool:YES];
            [localDictonary setValue:number2 forKey:@"InAutomate"];
            [FileManager insertFotosIn_voertuig:localDictonary];
            double delayInSeconds = 0.3;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                AppDelegate *appDelegate = [FileManager getDel];
                [appDelegate.viewcontroller.menu move:appDelegate.viewcontroller.Uploaden];
                for (int k =0; k < [[appDelegate.viewcontroller.carView subviews] count]; k++) {
                    for (int i =0; i < [[[[appDelegate.viewcontroller.carView subviews] objectAtIndex:k]  subviews] count]; i++) {
                        [[[[[appDelegate.viewcontroller.carView subviews] objectAtIndex:k]  subviews] objectAtIndex:i] removeFromSuperview];
                    }
                    [[[appDelegate.viewcontroller.carView subviews] objectAtIndex:k] removeFromSuperview];
                }
                [appDelegate.viewcontroller.carView setItem:[UIColor whiteColor]];
                
                if ([[appDelegate.currentCarDictionary valueForKey:@"Kenteken"] length]<2) {
                    [appDelegate.viewcontroller.barview.ovelaylabel setText:[NSString stringWithFormat:@"voertuig ID: %@",[[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"] stringValue]]];
                    [appDelegate.viewcontroller.barview.ovelaylabel setBackgroundColor:[UIColor whiteColor]];
                    [appDelegate.viewcontroller.barview.ovelaylabel setAlpha:1];
                    [appDelegate.viewcontroller.barview.kenteken setAlpha:0];
                    [appDelegate.viewcontroller.barview.logos setAlpha:0];

                }
                else
                {
                    [appDelegate.viewcontroller.barview.kenteken setText:[appDelegate.currentCarDictionary valueForKey:@"KentekenOpgemaakt"]];
                    [appDelegate.viewcontroller.barview.kenteken setBackgroundColor:[UIColor clearColor]];
                    [appDelegate.viewcontroller.barview.ovelaylabel setAlpha:0];
                    [appDelegate.viewcontroller.barview.kenteken setAlpha:1];
                    [appDelegate.viewcontroller.barview.logos setAlpha:1];

                }


                [appDelegate.viewcontroller.menu move:(LineButton*)appDelegate.viewcontroller.menu.info];

                [self select];
            });
        }
        else if (buttonIndex ==3)
        {
        }

    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(120*2, 90*2);
}
-(void)setitems
{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    [layout setHeaderReferenceSize:CGSizeMake(2, 2)];
    [layout setFooterReferenceSize:CGSizeMake(2, 2)];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    collectionViewImages=[[UICollectionView alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width-10, self.frame.size.height-10) collectionViewLayout:layout];
    [collectionViewImages setDataSource:self];
    [collectionViewImages setDelegate:self];
    [collectionViewImages registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [collectionViewImages setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:collectionViewImages];
}
-(BOOL)shouldAutorotate{
    return NO;
}
-(void) resetimage:(NSMutableArray*)array gotoIndex:(NSIndexPath*)get
{
}                   
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}
@end
