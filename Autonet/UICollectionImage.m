    //
    //  UICollectionProducts.m
    //  zorgAtlas
    //
    //  Created by Livecast02 on 13-01-15.
    //
    //
#import "UICollectionImage.h"
#import "AppDelegate.h"
#import "MenuView.h"
#import "FileManager.h"
#import "CameraButton.h"
#import "UICollectionImage.h"
#define MIN_CELL_HEIGHT 20
#define kOFFSET_FOR_KEYBOARD 80.0
@implementation UICollectionImage
@synthesize managedObjectContext;
@synthesize searchBarTo;
@synthesize collectionViewcopy;
@synthesize shouldBeginEditing;
@synthesize fetchedResultsControllerCopy;
@synthesize arrayItems;
@synthesize arrayInternet;
@synthesize extraArrayItems;
@synthesize header;
#pragma mark - Fetched Result Controller section                                      
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [arrayItems count];
}                   
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([header isEqualToString:@"head"]) {                   
        UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor grayColor];
        NSString *docDir = [FileManager getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/thumb_%@",docDir,[arrayItems objectAtIndex:indexPath.row]];
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:itemFilePath];
        if (fileExists) {


            UIImage *set =[UIImage imageWithContentsOfFile:itemFilePath];
            UIImageView *img = [[UIImageView alloc] initWithImage:[self generatePhotoThumbnail:set withSide:200]];
            [img setFrame:CGRectMake(0,0, 120*6, 90*6)];
            [cell addSubview:img];
                [img sizeToFit];

        }
        else

        {


            itemFilePath  = [NSString stringWithFormat:@"%@/Caches/%@",docDir,[arrayItems objectAtIndex:indexPath.row]];

        
        UIImage *set =[UIImage imageWithContentsOfFile:itemFilePath];
        UIImageView *img = [[UIImageView alloc] initWithImage:[self generatePhotoThumbnail:set withSide:200]];
        [img setFrame:CGRectMake(0,0, 120*6, 90*6)];
        [cell addSubview:img];
                [img sizeToFit];


        }
        UIView *backcell =[[UIView alloc]initWithFrame:CGRectMake((120*6)-140,4,120,50)];
        [backcell setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0]];
        [self addSubview:backcell];
        [backcell.layer setBorderWidth:2];
        [backcell.layer setCornerRadius:15];
        [cell setTag:1];
        return cell;
    } else {
        UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
        cell.backgroundColor=[UIColor grayColor];
        NSString *docDir = [FileManager getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/thumb_%@",docDir,[arrayItems objectAtIndex:indexPath.row]];
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:itemFilePath];
        if (fileExists) {


            UIImage *set =[UIImage imageWithContentsOfFile:itemFilePath];
            UIImageView *img = [[UIImageView alloc] initWithImage:[self generatePhotoThumbnail:set withSide:200]];
            [img setFrame:CGRectMake(0,0, 120*6, 90*6)];
            [cell addSubview:img];
                [img sizeToFit];

        }
        else
        {
            itemFilePath  = [NSString stringWithFormat:@"%@/Caches/%@",docDir,[arrayItems objectAtIndex:indexPath.row]];

            UIImage *set =[UIImage imageWithContentsOfFile:itemFilePath];
            UIImageView *img = [[UIImageView alloc] initWithImage:[self generatePhotoThumbnail:set withSide:120]];
            [img setFrame:CGRectMake(0,0, 120, 90)];
            [cell addSubview:img];
            [cell.layer setMasksToBounds:YES];
            [img sizeToFit];
        }

        UIImage *set =[UIImage imageWithContentsOfFile:itemFilePath];
        UIImageView *img = [[UIImageView alloc] initWithImage:[self generatePhotoThumbnail:set withSide:120]];
        [img setFrame:CGRectMake(0,0, 120, 90)];
        [cell addSubview:img];
        [cell.layer setMasksToBounds:YES];
        [img sizeToFit];                   
        if ([[arrayInternet objectAtIndex:indexPath.row] boolValue]) {                   
            UILabel *internetoverlay =[[UILabel alloc]initWithFrame:CGRectMake(0,90-16,120,16)];
            [internetoverlay setText:@" Op internet"];
            [internetoverlay setTextColor:[UIColor whiteColor]];
            [internetoverlay setFont:[UIFont systemFontOfSize:12]];
            [internetoverlay setBackgroundColor:[UIColor colorWithRed:0.439289 green:0.764236 blue:0.506794 alpha:1.000000]];
            [internetoverlay setTextAlignment:NSTextAlignmentLeft];
            [cell addSubview:internetoverlay];
        }
        else
        {
           UILabel *internetoverlay =[[UILabel alloc]initWithFrame:CGRectMake(0,90-16,120,16)];
            [internetoverlay setText:@" Niet op internet"];
            [internetoverlay setTextColor:[UIColor whiteColor]];
            [internetoverlay setFont:[UIFont systemFontOfSize:12]];
            [internetoverlay setBackgroundColor:[UIColor redColor]];
            [internetoverlay setTextAlignment:NSTextAlignmentLeft];
            [cell addSubview:internetoverlay];
        }
        return cell;
    }
}
-(void)moveOnintenet:(UISwitch*)sender
{
}
-(void)removebuttonAction:(UIButton*)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"2 Wilt u deze foto op internet gebruiken?" message:@"4 Maak een keuze!"
                                                   delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ja", @"Nee",  nil];
    [alert setTag:sender.tag];
    [alert show];                   
}
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [arrayItems removeObject:[arrayItems objectAtIndex:(alertView.tag -100)]];
    [self.collectionViewcopy reloadData];
}
- (void)activateDeletionMode:(UILongPressGestureRecognizer *)gr
{
}
- (UIImage *)generatePhotoThumbnail:(UIImage *)image withSide:(CGFloat)ratio
{
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
    appDelegate.currentCollection = self;
    if ([header isEqualToString:@"head"]) {                   
    } else {
        NSString *docDir = [FileManager getDir];
        [appDelegate.viewcontroller.imageviewblock.UISwitchOne setOn:[[arrayInternet objectAtIndex:indexPath.row] boolValue]];                   
        NSString *itemFileimagePath = [NSString stringWithFormat:@"%@/Caches/%@",docDir,[arrayItems objectAtIndex:indexPath.row]];

        NSLog(@"%@", itemFileimagePath);

        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:itemFileimagePath];
        if (fileExists) {

            appDelegate.viewcontroller.imageviewblock.currentimage = [arrayItems objectAtIndex:indexPath.row];
            [appDelegate.viewcontroller.imageviewblock sizeToFit];
            appDelegate.viewcontroller.imageviewblock.curentindex = indexPath;
            [appDelegate.viewcontroller.imageviewblock.imagecontent setImage:[UIImage imageWithContentsOfFile:itemFileimagePath]];
            [appDelegate.viewcontroller.imageviewblock.imagecontent sizeToFit];
            [appDelegate.viewcontroller.imageviewblock setAlpha:1];
            [appDelegate.viewcontroller.imageviewblock.imagecontent setCenter:appDelegate.viewcontroller.imageviewblock.center];
        }
        else{

            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@"Deze afbeelding is nog niet gedownload."
                                          message:@"Wilt u deze ophalen?"
                                          preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ophalen" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){

                [appDelegate.viewcontroller.overlay setAlpha:0.5];


                if ([[(OnderdeelView*)[[self superview] superview] basepart] valueForKey:@"FotosInfo"] == NULL) {

                    NSLog(@"%@", [appDelegate.currentCarDictionary valueForKey:@"FotosInfo"]);


                    NSString *docDir = [FileManager getDir];
                    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir, [appDelegate.currentCarDictionary valueForKey:@"FotosInfo"]];
                    NSMutableArray* copyplist = [NSMutableArray arrayWithContentsOfFile:itemFilePath];

                      [FileManager DownloadSingleImageForCar: [copyplist objectAtIndex:indexPath.row]];
                       [appDelegate.viewcontroller.overlay setAlpha:0];
                }
                else
                {


                NSLog(@"OnderdeelView %@", [[(OnderdeelView*)[[self superview] superview] basepart] valueForKey:@"FotosInfo"]);
                

                [FileManager DownloadSingleImageAfter: [[[(OnderdeelView*)[[self superview] superview] basepart] valueForKey:@"FotosInfo"] objectAtIndex:indexPath.row]];

                }

            }];
            [alert addAction:okAction];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                [appDelegate.viewcontroller.overlay setAlpha:0];


            }];
            [alert addAction:cancelAction];
            [appDelegate.viewcontroller presentViewController:alert animated:YES completion:nil];


        }
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([header isEqualToString:@"head"]) {
        return CGSizeMake(120*6, 90*6);
    } else {
        return CGSizeMake(120, 90);
    }
}
-(void)setitems
{                   
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    [layout setHeaderReferenceSize:CGSizeMake(2, 2)];
    [layout setFooterReferenceSize:CGSizeMake(2, 2)];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    collectionViewcopy=[[UICollectionView alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width-10, self.frame.size.height-10) collectionViewLayout:layout];
    [collectionViewcopy setDataSource:self];
    [collectionViewcopy setDelegate:self];
    [collectionViewcopy registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [collectionViewcopy setBackgroundColor:[UIColor whiteColor]];                   
    [self addSubview:collectionViewcopy];
}
-(void) resetimage:(NSMutableArray*)array gotoIndex:(NSIndexPath*)get
{
    AppDelegate *appDelegate = [FileManager getDel];
    arrayItems =[array mutableCopy];                   
    [UIView animateWithDuration:0
                     animations: ^{ [appDelegate.viewcontroller.scroll.imageView.collectionViewcopy reloadData]; }
                     completion:^(BOOL finished) {                   
                         NSIndexPath *iPath = [NSIndexPath indexPathForItem:get.row inSection:0];
                         [appDelegate.viewcontroller.scroll.imageView.collectionViewcopy scrollToItemAtIndexPath:iPath
                                                                                                atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                                                                                        animated:YES];
                     }];                   
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.2f];
    [appDelegate.viewcontroller.scroll setAlpha:1];
    [UIView commitAnimations];
    [appDelegate.viewcontroller overlayAction];
    [self.collectionViewcopy reloadData];                   
}                   
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}                   
                                      
@end
