    //
    //  Loadingview.m
    //  Autonet
    //
    //  Created by Livecast02 on 15-12-16.
    //  Copyright © 2016 Autonet. All rights reserved.
    //
#import "NavigationView.h"
#import "UIFont+FlatUI.h"
#import "FileManager.h"
#import "ImageButton.h"
#import "CameraButton.h"
#import "AppDelegate.h"
#import "CarCell.h"
#import "QRCodeReaderViewController.h"
#import "QRCodeReader.h"
#import "JSONKit.h"
#import "SBJson.h"
@implementation NavigationView
@synthesize collectionViewNav;
@synthesize progressBar;
@synthesize copylist;
@synthesize shouldBeginEditing;

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setAlpha:1];
        [self setLoadingItems];
            //Imagepicker
    }
    return self;
}

-(void)setLoadingItems
{
    for (int k =0; k < [[self subviews] count]; k++) {
        [[[self subviews] objectAtIndex:k] removeFromSuperview];
    }
    [self setBackgroundColor:[UIColor whiteColor]];
    copylist =[[NSMutableArray alloc] init];
    AppDelegate *appDelegate = [FileManager getDel];
    appDelegate.alleVoertuigenArray =[[NSMutableArray alloc] initWithArray:[FileManager getArray:@"Voertuigen"]];
    progressBar = [[UIProgressView alloc] init];
    progressBar.frame = CGRectMake(0,50,self.frame.size.width,20);
    progressBar.progress = 0;
    [self addSubview:progressBar];

    UILabel *line =[[UILabel alloc]initWithFrame:CGRectMake(0,50,self.frame.size.width,2)];
    [line setBackgroundColor:[UIColor colorWithRed:0.719543 green:0.000000 blue:1.000000 alpha:0.000000]];
    [self addSubview:line];
    UIImageView *logos= [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-192)/2,(self.frame.size.height-20)/2,192,50)];
    [logos setImage:[UIImage imageNamed:@"logo.png"]];
    logos.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:logos];

    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [layout setHeaderReferenceSize:CGSizeMake(10, 50)];
    [layout setFooterReferenceSize:CGSizeMake(10, 50)];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    collectionViewNav=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, self.frame.size.width, self.frame.size.height-60) collectionViewLayout:layout];
    [collectionViewNav setDataSource:self];
    [collectionViewNav setDelegate:self];
    [collectionViewNav registerClass:[CarCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [collectionViewNav setBackgroundColor:[UIColor clearColor]];
    [self addSubview:collectionViewNav];

    UIView *onderdelenView=[[UIView alloc] initWithFrame:CGRectMake(-10, 0, self.frame.size.width+20,  44)];
    [onderdelenView setBackgroundColor:[UIColor whiteColor]];
    [onderdelenView setAlpha:1];
    [self addSubview:onderdelenView];

    UISearchBar *searchBarTo= [[UISearchBar alloc] initWithFrame:CGRectMake(20, 4, 280, 40)];
    [searchBarTo setTintColor:[UIColor whiteColor]];
    [searchBarTo setBarTintColor:[UIColor whiteColor]];
    [searchBarTo setKeyboardType:UIKeyboardTypeNumberPad];
    [searchBarTo setDelegate:self];
    searchBarTo.clipsToBounds = YES;
    [searchBarTo.layer setBorderColor:[UIColor colorWithRed:0.525 green:0.706 blue:0.871 alpha:1.000].CGColor];
    searchBarTo.layer.borderWidth = 2;
    [searchBarTo.layer setCornerRadius:4];
    [searchBarTo setText:@"Zoek Auto..."];
    [onderdelenView  addSubview:searchBarTo];

    ImageButton *reload =[[ImageButton alloc]initWithFrame:CGRectMake(self.frame.size.width-45, 6, 36, 36)];
    [reload addTarget:self action:@selector(Action:) forControlEvents:UIControlEventTouchUpInside];
    [reload setBackgroundColor:[UIColor colorWithRed:0.267 green:0.588 blue:0.722 alpha:1.000]];
    [self addSubview:reload];

    [reload setItembig:[UIColor whiteColor] setImage:@"m24_refresh_blackdp.png"];
    ImageButton *verzenden =[[ImageButton alloc]initWithFrame:CGRectMake(self.frame.size.width-90, 6, 36, 36)];
    [verzenden addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];
    [verzenden setBackgroundColor:[UIColor colorWithRed:0.267 green:0.588 blue:0.722 alpha:1.000]];
    [verzenden setItembig:[UIColor whiteColor] setImage:@"upload.png"];
    [self addSubview:verzenden];

    UIButton *scan =[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-160, 6, 60, 36)];
    [scan setBackgroundColor:[UIColor orangeColor]];
    [scan setTitle:@"Scan" forState:UIControlStateNormal];
    [scan addTarget:self action:@selector(scanAction:) forControlEvents:UIControlEventTouchUpInside];
    [scan.layer setCornerRadius:6];
    [scan.titleLabel setFont:[UIFont regularFlatFontOfSize:20]];
    [scan.layer setMasksToBounds:YES];
    [self addSubview:scan];

    UILabel *version =[[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width-200)/2,0,200,40)];
    [version setText:[[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey]];
    [version setFont:[UIFont systemFontOfSize:16]];
    [version setBackgroundColor:[UIColor clearColor]];
    [version setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:version];

}                   
-(void)send:(LineButton*)sender
{
    AppDelegate *appDelegate = [FileManager getDel];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.4f];
    appDelegate.viewcontroller.Loadingend.transform = CGAffineTransformMakeScale(1, 1);
    [appDelegate.viewcontroller.Loadingend setAlpha:1];
    [appDelegate.viewcontroller overlayAction];
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    appDelegate.viewcontroller.Loadingend.TotalVoertuigen =[[FileManager getVoertuigen] mutableCopy];
    [appDelegate.viewcontroller.Loadingend.tableupload reloadData];
    [UIView commitAnimations];
}
- (IBAction)scanAction:(id)sender
{
    AppDelegate *appDelegate = [FileManager getDel];
    if ([QRCodeReader supportsMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]]) {
        static QRCodeReaderViewController *vc = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            QRCodeReader *reader = [QRCodeReader readerWithMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
            vc                   = [QRCodeReaderViewController readerWithCancelButtonTitle:@"Cancel" codeReader:reader startScanningAtLoad:YES showSwitchCameraButton:YES showTorchButton:YES];
            vc.modalPresentationStyle = UIModalPresentationFormSheet;
        });
        vc.delegate = self;
        [vc setCompletionWithBlock:^(NSString *resultAsString) {
        }];
        [appDelegate.viewcontroller presentViewController:vc animated:YES completion:NULL];
    } else {
            ////////////NSLog(@"en nu");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Reader not supported by the current device" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}
#pragma mark - QRCodeReader Delegate Methods
- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    AppDelegate *appDelegate = [FileManager getDel];
    [reader stopScanning];
    NSMutableDictionary *dict = [result mutableObjectFromJSONString];
    NSString *docDir = [FileManager getDir];
    NSString *locatioCat = [NSString stringWithFormat:@"%@/Caches/Login.plist",docDir];
    [dict writeToFile:locatioCat atomically: YES];
    [appDelegate.viewcontroller dismissViewControllerAnimated:YES completion:NULL];
}
- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    AppDelegate *appDelegate = [FileManager getDel];
    [appDelegate.viewcontroller dismissViewControllerAnimated:YES completion:NULL];
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchBar.text =@"";
}// called when text starts editing
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}// return NO to not resign first responder
- (void) searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
    AppDelegate *appDelegate = [FileManager getDel];
    NSMutableCharacterSet *carSet = [NSMutableCharacterSet characterSetWithCharactersInString:@"0123456789."];
    BOOL isNumber = [[searchText stringByTrimmingCharactersInSet:carSet] isEqualToString:@""];

    double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){

    if (isNumber) {
        NSString *search =[NSString stringWithFormat:@"%i", [theSearchBar.text intValue]];
        NSMutableString *string =[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"AldocModel contains[cd] '%@'||AldocType contains[cd] '%@'||Kenteken contains[cd] '%@'", search, search, search]];
        if ([searchText length]>0) {
            self->shouldBeginEditing =YES;
            if ([[self searchModel:searchText] length] >0||[[self searchMerk:search] length] ==0)
            {
                [string appendString:[self searchModel:search]];
            }
            else if([[self searchMerk:searchText] length]>0||[[self searchModel:search] length] ==0) {
                [string appendString:[self searchModel:search]];
            }
            else if([[self searchMerk:searchText] length]>0||[[self searchModel:search] length] >0) {
                [string appendString:[NSString stringWithFormat:@"%@ %@",[self searchModel:searchText],[self searchMerk:search]]];
            }
            NSPredicate *resultPredicate = [NSPredicate
                                            predicateWithFormat:string];
            NSMutableArray *result = [[appDelegate.alleVoertuigenArray filteredArrayUsingPredicate:resultPredicate] mutableCopy];
            if ([result count]>0 && [searchText length]>0) {
                self->copylist =[[appDelegate.alleVoertuigenArray filteredArrayUsingPredicate:resultPredicate] mutableCopy];
            }
        }
        else
        {
            self->shouldBeginEditing =NO;
        }
        [self->collectionViewNav reloadData];

    } else {
        NSMutableString *string =[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"AldocModel contains[cd] '%@'||AldocType contains[cd] '%@'||Kenteken contains[cd] '%@'", searchText, searchText,searchText]];
        if ([searchText length]>0) {
            self->shouldBeginEditing =YES;
            if ([[self searchModel:theSearchBar.text] length] >0||[[self searchMerk:searchText] length] ==0)
            {
                [string appendString:[self searchModel:theSearchBar.text]];
            }
            else if([[self searchMerk:theSearchBar.text] length]>0||[[self searchModel:theSearchBar.text] length] ==0) {
                [string appendString:[self searchModel:theSearchBar.text]];
            }
            else if([[self searchMerk:theSearchBar.text] length]>0||[[self searchModel:theSearchBar.text] length] >0) {
                [string appendString:[NSString stringWithFormat:@"%@ %@",[self searchModel:theSearchBar.text],[self searchMerk:searchText]]];
            }
            NSPredicate *resultPredicate = [NSPredicate
                                            predicateWithFormat:string];
            NSMutableArray *result = [[[FileManager getMerkOnNaam:theSearchBar.text] filteredArrayUsingPredicate:resultPredicate] mutableCopy];
            if ([result count]>0 && [theSearchBar.text length]>0) {
                self->copylist =[[[FileManager getMerkOnNaam:theSearchBar.text] filteredArrayUsingPredicate:resultPredicate] mutableCopy];
            }
        }
        else
        {
            self->shouldBeginEditing =NO;
        }
        [self->collectionViewNav reloadData];
    }
            });
}
-(NSString*)searchModel:(NSString*)searchText
{
    NSString *docDir = [FileManager getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Merken"];
    NSMutableArray* copyplist = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"Naam contains[cd] '%@'",
                                    searchText];
    NSMutableArray *result2 = [[copyplist filteredArrayUsingPredicate:resultPredicate] mutableCopy];
    NSMutableString *string =[[NSMutableString alloc] init];
    for (int k =0; k < [result2 count]; k++) {
        if ([result2 count]==1) {
            [string appendString:[NSString stringWithFormat:@"||MerkId = %@", [[result2 objectAtIndex:k] valueForKey:@"MerkId"]]];
        }
        else
        {
            if ([[result2 objectAtIndex:k] isEqual:[result2 lastObject]]) {
                [string appendString:[NSString stringWithFormat:@"MerkId = %@", [[result2 objectAtIndex:k] valueForKey:@"MerkId"]]];
            }
            else if ([[result2 objectAtIndex:k] isEqual:[result2 firstObject]]) {
                [string appendString:[NSString stringWithFormat:@"||MerkId = %@||", [[result2 objectAtIndex:k] valueForKey:@"MerkId"]]];
            }
            else
                [string appendString:[NSString stringWithFormat:@"MerkId = %@||", [[result2 objectAtIndex:k] valueForKey:@"MerkId"]]];
        }
    }
    return string;
}
-(NSString*)searchMerk:(NSString*)searchText
{
        ////////////NSLog(@"searchMerk");
    NSString *docDir = [FileManager getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Modellen"];
    NSMutableArray* copyplist = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"Naam contains[cd] '%@'",
                                    searchText];
    NSMutableArray *result2 = [[copyplist filteredArrayUsingPredicate:resultPredicate] mutableCopy];
        //    MerkId = 49;
        //    ModelId = 3213;
    NSMutableString *string =[[NSMutableString alloc] init];
    for (int k =0; k < [result2 count]; k++) {
        if ([result2 count]==1) {
            [string appendString:[NSString stringWithFormat:@"||ModelId = %@", [[result2 objectAtIndex:k] valueForKey:@"MerkId"]]];
        }
        else
        {
            if ([[result2 objectAtIndex:k] isEqual:[result2 lastObject]]) {
                [string appendString:[NSString stringWithFormat:@"ModelId = %@", [[result2 objectAtIndex:k] valueForKey:@"ModelId"]]];
            }
            else if ([[result2 objectAtIndex:k] isEqual:[result2 firstObject]]) {
                [string appendString:[NSString stringWithFormat:@"||ModelId = %@||", [[result2 objectAtIndex:k] valueForKey:@"ModelId"]]];
            }
            else
                [string appendString:[NSString stringWithFormat:@"ModelId = %@||", [[result2 objectAtIndex:k] valueForKey:@"ModelId"]]];
        }
    }
    return string;
}
-(void)Action:(ImageButton*)sender
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];

    [appDelegate.viewcontroller.overlay setAlpha:0.5];
    [appDelegate.viewcontroller.overlay progressChange:100];
    [appDelegate.viewcontroller.Loading clearPressed:NULL];
}
-(void)Action2:(ImageButton*)sender
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSError *error;
    NSArray *pathsCachescopy = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryCachescopy = [pathsCachescopy objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [documentsDirectoryCachescopy stringByAppendingPathComponent:@"/Cachescopy"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error]; //Create folder
    }
    NSString *LocVoertuigen = [NSString stringWithFormat:@"%@/Caches/%@",documentsDirectoryCachescopy, @"Voertuigen.plist"];
    NSString *pathcopy = [NSString stringWithFormat:@"%@/Cachescopy/%@",documentsDirectoryCachescopy, @"Voertuigen.plist"];
    [[NSFileManager defaultManager] moveItemAtPath:LocVoertuigen toPath:pathcopy error:&error];
    NSString* path3 = [[NSBundle mainBundle] pathForResource:@"CarItemsfold" ofType:@"plist"];
    NSMutableArray* items = [NSMutableArray arrayWithContentsOfFile:path3];
    NSString *docDir = [FileManager getDir];
    NSString *locatioCat = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"CarItemsfold"];
    [items writeToFile:locatioCat atomically: YES];
    NSString *documentsDirectorybureau =  [NSString stringWithFormat:@"/Users/jeffreysnijder02/Desktop/Demo/%@",[NSString stringWithFormat:@"%@.plist",@"CarItemsfold"]];
    [items writeToFile:documentsDirectorybureau atomically: YES];
    [appDelegate.viewcontroller.navigaionView setLoadingItems];
    [appDelegate.viewcontroller.Loading setLoadingItems];
    [appDelegate.viewcontroller.Loading setAlpha:1];
}
-(void)back:(UIButton*)sender
{
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(1080/2.6, 818/2.6);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
#pragma mark - Fetched Result Controller section                                      
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    AppDelegate *appDelegate = [FileManager getDel];
    if (shouldBeginEditing) {
        return [copylist count];
    } else {
        return [appDelegate.alleVoertuigenArray count];
    }
}
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *appDelegate = [FileManager getDel];
    CarCell *carCell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    carCell.backgroundColor=[UIColor whiteColor];
    NSString *docDir = [FileManager getDir];
    if (shouldBeginEditing) {
        NSString *docFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,[[copylist valueForKey:@"FotosInfo"] objectAtIndex:indexPath.row]];
        NSMutableArray *fotosInfoArray =[NSMutableArray arrayWithContentsOfFile:docFilePath];
        if (carCell.imgset) {
            [self BuildCarCell:fotosInfoArray targetCell:carCell byCar:[copylist objectAtIndex:indexPath.row]];
        }
        else
        {
            [carCell setItems];
            [self BuildCarCell:fotosInfoArray targetCell:carCell byCar:[copylist objectAtIndex:indexPath.row]];
        }
    } else {
        NSString *docFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,[[appDelegate.alleVoertuigenArray valueForKey:@"FotosInfo"] objectAtIndex:indexPath.row]];
        NSMutableArray *fotosInfoArray =[NSMutableArray arrayWithContentsOfFile:docFilePath];
        if (carCell.imgset) {
            [self BuildCarCell:fotosInfoArray targetCell:carCell byCar:[appDelegate.alleVoertuigenArray objectAtIndex:indexPath.row]];
        }
        else
        {
            [carCell setItems];
            [self BuildCarCell:fotosInfoArray targetCell:carCell byCar:[appDelegate.alleVoertuigenArray objectAtIndex:indexPath.row]];
        }
    }
    return carCell;
}


-(CarCell*) BuildCarCell:(NSMutableArray*)content targetCell:(CarCell*)cell byCar:(NSMutableDictionary*)car

{
    if ([content count]==0) {
        [cell.imgset setImage:[UIImage imageNamed:@"caricon.png"]];
    } else {
        NSString *docDir = [FileManager getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@",docDir,[[content valueForKey:@"Orgnaam"] firstObject]];
        UIImage *sender =[UIImage imageWithContentsOfFile:itemFilePath];
        if (sender) {
            float resizeImage = cell.frame.size.width/sender.size.width;
            [cell.imgset setImage:[UIImage imageWithContentsOfFile:itemFilePath]];
            [cell.imgset setFrame:CGRectMake(0,0, sender.size.width*resizeImage, sender.size.height*resizeImage)];
        }
        else
        {
            [cell.imgset setImage:[UIImage imageNamed:@"caricon.png"]];
        }
    }
    [cell.kenteken setText:[car valueForKey:@"KentekenOpgemaakt"]];
    [cell.label setText:[NSString stringWithFormat:@"Merk: %@\nModel:%@\nID: %@",[[[FileManager getMerk:[car valueForKey:@"MerkId"]] firstObject] valueForKey:@"Naam"], [[[[[FileManager getModel:[car valueForKey:@"ModelId"]] firstObject] valueForKey:@"Namen"] valueForKey:@"InternetNaam"] componentsJoinedByString:@","], [car valueForKey:@"VoertuigId"]]];
    [cell.label setNumberOfLines:3];
    [cell.layer setBorderWidth:2];
    [cell.layer  setBorderColor:[UIColor lightGrayColor].CGColor];
    [cell.layer setMasksToBounds:YES];

    if ([[car objectForKey:@"KentekenBuitenlands"] boolValue]){

        [cell.kenteken setBackgroundColor:[UIColor whiteColor]];
        [cell.kenteken setFrame:CGRectMake(cell.kenteken.frame.origin.x, cell.kenteken.frame.origin.y, cell.kenteken.frame.size.width+6, cell.kenteken.frame.size.height+6)];
        [cell.logos setAlpha:0];
        [cell.kenteken.layer setBorderWidth:1];

    } else {
        [cell.kenteken setBackgroundColor:[UIColor clearColor]];
        [cell.logos setAlpha:1];
        [cell.kenteken.layer setBorderWidth:0];

    }
       [cell.kenteken setTextAlignment:NSTextAlignmentCenter];
    [cell.kenteken sizeToFit];
    [cell.kenteken setCenter:cell.logos.center];

    return cell;
}
- (UIImage *)generatePhotoThumbnail:(UIImage *)image withSide:(CGFloat)ratio
{
        // Create a thumbnail version of the image for the event object.
    CGSize size = image.size;
    CGSize croppedSize;
    CGFloat offsetX = 0.0;
    CGFloat offsetY = 0.0;
        // check the size of the image, we want to make it
        // a square with sides the size of the smallest dimension.
        // So clip the extra portion from x or y coordinate
    if (size.width > size.height) {
        offsetX = (size.height - size.width) / 2;
        croppedSize = CGSizeMake(size.height, size.height);
    } else {
        offsetY = (size.width - size.height) / 2;
        croppedSize = CGSizeMake(size.width, size.width);
    }
        // Crop the image before resize
    CGRect clippedRect = CGRectMake(offsetX * -1, offsetY * -1, croppedSize.width, croppedSize.height);
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], clippedRect);
        // Done cropping
        // Resize the image
    CGRect rect = CGRectMake(0.0, 0.0, ratio, ratio);
    UIGraphicsBeginImageContext(rect.size);
    [[UIImage imageWithCGImage:imageRef] drawInRect:rect];
    UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
        // Done Resizing
    return thumbnail;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *appDelegate = [FileManager getDel];
    appDelegate.currentCarDictionary =[appDelegate.alleVoertuigenArray objectAtIndex:indexPath.row];
    appDelegate.categorieenStandaardArray =[[FileManager getStandaardCategorieen:@""] mutableCopy];
    [appDelegate.viewcontroller.collectionOnderdelenView.catogorie.tableResult reloadData];
    [self setAlpha:0];
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
    } else {
        [appDelegate.viewcontroller.barview.kenteken setText:[[appDelegate.alleVoertuigenArray objectAtIndex:indexPath.row] valueForKey:@"KentekenOpgemaakt"]];
        [appDelegate.viewcontroller.barview.kenteken setBackgroundColor:[UIColor clearColor]];
        [appDelegate.viewcontroller.barview.ovelaylabel setAlpha:0];
        [appDelegate.viewcontroller.barview.kenteken setAlpha:1];
        [appDelegate.viewcontroller.barview.logos setAlpha:1];
        [appDelegate.viewcontroller.barview.autolabel setText:[NSString stringWithFormat:@"%@ %@ ID: %@",[[[FileManager getMerk:[[appDelegate.alleVoertuigenArray objectAtIndex:indexPath.row] valueForKey:@"MerkId"]] firstObject] valueForKey:@"Naam"], [[[[[FileManager getModel:[[appDelegate.alleVoertuigenArray objectAtIndex:indexPath.row] valueForKey:@"ModelId"]] firstObject] valueForKey:@"Namen"] valueForKey:@"InternetNaam"] componentsJoinedByString:@","], [[appDelegate.alleVoertuigenArray objectAtIndex:indexPath.row] valueForKey:@"VoertuigId"]]];

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

    }
    [appDelegate.viewcontroller.menu move:(LineButton*)appDelegate.viewcontroller.menu.info];
        //[appDelegate.viewcontroller.barview.kenteken setText:[appDelegate.currentCar valueForKey:@"Kenteken"]];
}

@end
