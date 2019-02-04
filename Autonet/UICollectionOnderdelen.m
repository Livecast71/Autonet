    //
    //  UICollectionProducts.m
    //  zorgAtlas
    //
    //  Created by Livecast02 on 13-01-15.
    //
    //
#import "UICollectionOnderdelen.h"
#import "AppDelegate.h"
#import "MenuView.h"
#import "CategorieenStandaardView.h"
#import "CategorieenView.h"
#import "FileManager.h"
#import "OnderdeelView.h"
#import "OnderdelenView.h"
#import "FileManager.h"
#import "AannamelijstView.h"
#define MIN_CELL_HEIGHT 20
#define kOFFSET_FOR_KEYBOARD 80.0
@implementation UICollectionOnderdelen
@synthesize managedObjectContext;
@synthesize searchBarTo;
@synthesize collectionViewCopy;
@synthesize shouldBeginEditing;
@synthesize fetchedResultsControllerCopy;
@synthesize arrayItems;
@synthesize extraArrayItems;
@synthesize veldID;
@synthesize catogorie;
@synthesize catogorieStandaard;
@synthesize kernoOnderdelenView;
@synthesize onderdelen;
@synthesize aannamelijstView;
@synthesize voegOnderdeelToe;
#pragma mark - Fetched Result Controller section

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setitems];
        [self setAlpha:0];
        [self setAlpha:1];
    }
    return self;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    AppDelegate *appDelegate = [FileManager getDel];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"DeelId = %@", [appDelegate.viewcontroller.collectionOnderdelenView.onderdelen.searchDict valueForKey:@"DeelId"]];
        //@"DeelId like [cd] %@"
    NSMutableArray *test =  [[appDelegate.onderdelenVoertuigArray filteredArrayUsingPredicate:predicate] mutableCopy];
    
    
    if ([test count]>0) {
        
        return 1;                   
    } else {                   
            //
        if (appDelegate.searchCatagorie >0) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Categorieen like [cd] %@",[NSString stringWithFormat:@"%ld", (long)appDelegate.searchCatagorie]];
            NSMutableArray *items =  [[appDelegate.onderdelenVoertuigArray filteredArrayUsingPredicate:predicate] mutableCopy];
            return [items count];
        }
        else{
            return [appDelegate.onderdelenVoertuigArray count];
        }
    }
}
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *appDelegate = [FileManager getDel];                   
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"DeelId = %@", [appDelegate.viewcontroller.collectionOnderdelenView.onderdelen.searchDict valueForKey:@"DeelId"]];
        //@"DeelId like [cd] %@"
    NSMutableArray *test =  [[appDelegate.onderdelenVoertuigArray filteredArrayUsingPredicate:predicate] mutableCopy];
    if ([test count]>0) {                   
        if (appDelegate.searchCatagorie >0) {
            NSMutableDictionary *coursCell =[test objectAtIndex:indexPath.row];
            OnderdeelView *existlabel = (OnderdeelView *)[cell viewWithTag:27];
            [existlabel removeFromSuperview];
            float Number;
            if ([[[test objectAtIndex:indexPath.row] valueForKey:@"DeelVelden"] count] % 2)
            {
                Number =(([[[test objectAtIndex:indexPath.row] valueForKey:@"DeelVelden"] count]+1)*55)/2;
            }
            else
            {
                Number =((([[[test objectAtIndex:indexPath.row] valueForKey:@"DeelVelden"] count])*55)/2);
                
            }
            if ([[[test objectAtIndex:indexPath.row] valueForKey:@"Verplicht"] boolValue]) {
                NSArray *velden =[FileManager getOnderdelen:[[coursCell valueForKey:@"DeelId"] integerValue]];
                NSIndexPath *iPath = [NSIndexPath indexPathForItem:[test indexOfObject:coursCell] inSection:0];                   
                OnderdeelView *onderdeel =[[OnderdeelView alloc]initWithFrame:CGRectMake(5, 5, self.frame.size.width-20, 760+ Number)];
                [onderdeel setTag:27];
                [cell addSubview:onderdeel];                   
                [onderdeel setBackgroundColor:[UIColor clearColor]];
                onderdeel.layer.shadowOffset = CGSizeMake(0, 0);
                onderdeel.layer.shadowOpacity = 0;
                onderdeel.contentdict =[test objectAtIndex:indexPath.row];
                onderdeel.basepart =  [[FileManager getOnderdelenVoertuigId:[coursCell valueForKey:@"DeelId"]] firstObject];
                onderdeel.indexand =iPath;
                [onderdeel setVelden:velden];
                onderdeel.parentcell =cell;
                onderdeel.sizeit =150+Number;
                
                if ([[coursCell valueForKey:@"DeelNamen"] count]>0) {                   
                    [onderdeel.titletopview setText:[NSString stringWithFormat:@"%@", [[[coursCell valueForKey:@"DeelNamen"] firstObject] valueForKey:@"Naam"]]];                   
                    if ([appDelegate.viewcontroller.removeView.SelectedItems containsObject:[NSNumber numberWithInteger:[[coursCell valueForKey:@"DeelId"] intValue]]]) {                   
                        [onderdeel.itemSwitch.Switcher setOn:YES];
                        [onderdeel.itemSwitch.internet setText:@"Afwezig"];                   
                    }
                    else
                    {
                        [onderdeel.itemSwitch.Switcher setOn:NO];
                        [onderdeel.itemSwitch.internet setText:@"Aanwezig"];
                        
                    }
                    
                    [onderdeel.itemSwitch.Switcher setTag:[[coursCell valueForKey:@"DeelId"] intValue]];                                      
                }                   
            }
            else
                
            {
                
                NSIndexPath *iPath = [NSIndexPath indexPathForItem:[test indexOfObject:coursCell] inSection:0];
                OnderdeelView *onderdeel =[[OnderdeelView alloc]initWithFrame:CGRectMake(5, 5, self.frame.size.width-20, 55)];
                [onderdeel setTag:27];
                [cell addSubview:onderdeel];
                onderdeel.indexand =iPath;
                onderdeel.basepart =  [[FileManager getOnderdelenVoertuigId:[coursCell valueForKey:@"DeelId"]] firstObject];
                [onderdeel setItemcoursCell:coursCell];
                [onderdeel setBackgroundColor:[UIColor clearColor]];
                onderdeel.layer.shadowOffset = CGSizeMake(0, 0);
                onderdeel.layer.shadowOpacity = 0;
                onderdeel.parentcell =cell;
                
                onderdeel.sizeit =150+Number;
                
                if ([[coursCell valueForKey:@"DeelNamen"] count]>0) {                   
                    [onderdeel.titletopview setText:[NSString stringWithFormat:@"%@", [[[coursCell valueForKey:@"DeelNamen"] firstObject] valueForKey:@"Naam"]]];
                    [onderdeel.itemSwitch.Switcher setTag:[[coursCell valueForKey:@"DeelId"] intValue]];                                      
                }
                if ([appDelegate.viewcontroller.removeView.SelectedItems containsObject:[NSNumber numberWithInteger:[[coursCell valueForKey:@"DeelId"] intValue]]]) {                   
                    [onderdeel.itemSwitch.Switcher setOn:YES];
                    [onderdeel.itemSwitch.internet setText:@"Afwezig"];                   
                }                   
                else
                {                   
                    [onderdeel.itemSwitch.Switcher setOn:NO];
                    [onderdeel.itemSwitch.internet setText:@"Aanwezig"];                   
                }
                onderdeel.contentdict =[test objectAtIndex:indexPath.row];
                
            }
        }
        else
        {                   
            NSMutableDictionary *coursCell =[test objectAtIndex:indexPath.row];
            OnderdeelView *existlabel = (OnderdeelView *)[cell viewWithTag:27];
            [existlabel removeFromSuperview];
            float Number;
            if ([[[test objectAtIndex:indexPath.row] valueForKey:@"DeelVelden"] count] % 2)
            {
                Number =(([[[test objectAtIndex:indexPath.row] valueForKey:@"DeelVelden"] count]+1)*55)/2;
            }
            else
            {
                Number =((([[[test objectAtIndex:indexPath.row] valueForKey:@"DeelVelden"] count])*55)/2);
                
            }
            if ([[[test objectAtIndex:indexPath.row] valueForKey:@"Verplicht"] boolValue]) {
                NSArray *velden =[FileManager getOnderdelen:[[coursCell valueForKey:@"DeelId"] integerValue]];
                OnderdeelView *onderdeel =[[OnderdeelView alloc]initWithFrame:CGRectMake(5, 5, self.frame.size.width-20, 760+ Number)];
                [onderdeel setTag:27];
                [cell addSubview:onderdeel];
                onderdeel.indexand =indexPath;
                
                [onderdeel setBackgroundColor:[UIColor clearColor]];
                onderdeel.layer.shadowOffset = CGSizeMake(0, 0);
                onderdeel.layer.shadowOpacity = 0;
                
                onderdeel.contentdict =[test objectAtIndex:indexPath.row];
                onderdeel.basepart =  [[FileManager getOnderdelenVoertuigId:[coursCell valueForKey:@"DeelId"]] firstObject];
                [onderdeel setVelden:velden];
                onderdeel.parentcell =cell;
                onderdeel.sizeit =150+Number;
                
                if ([[coursCell valueForKey:@"DeelNamen"] count]>0) {                   
                    [onderdeel.titletopview setText:[NSString stringWithFormat:@"%@", [[[coursCell valueForKey:@"DeelNamen"] firstObject] valueForKey:@"Naam"]]];                   
                    if ([appDelegate.viewcontroller.removeView.SelectedItems containsObject:[NSNumber numberWithInteger:[[coursCell valueForKey:@"DeelId"] intValue]]]) {                   
                        [onderdeel.itemSwitch.Switcher setOn:YES];
                        [onderdeel.itemSwitch.internet setText:@"Afwezig"];                   
                    }
                    
                    else
                    {
                        
                        [onderdeel.itemSwitch.Switcher setOn:NO];
                        [onderdeel.itemSwitch.internet setText:@"Aanwezig"];
                        
                    }                   
                    [onderdeel.itemSwitch.Switcher setTag:[[coursCell valueForKey:@"DeelId"] intValue]];                                      
                }                   
            }
            else
                
            {                   
                OnderdeelView *onderdeel =[[OnderdeelView alloc]initWithFrame:CGRectMake(5, 5, self.frame.size.width-20, 55)];
                [onderdeel setTag:27];
                [cell addSubview:onderdeel];
                onderdeel.indexand =indexPath;
                
                onderdeel.basepart =  [[FileManager getOnderdelenVoertuigId:[coursCell valueForKey:@"DeelId"]] firstObject];
                [onderdeel setItemcoursCell:coursCell];
                [onderdeel setBackgroundColor:[UIColor clearColor]];
                onderdeel.layer.shadowOffset = CGSizeMake(0, 0);
                onderdeel.layer.shadowOpacity = 0;
                onderdeel.parentcell =cell;
                
                onderdeel.sizeit =150+Number;
                
                if ([[coursCell valueForKey:@"DeelNamen"] count]>0) {                   
                    [onderdeel.titletopview setText:[NSString stringWithFormat:@"%@", [[[coursCell valueForKey:@"DeelNamen"] firstObject] valueForKey:@"Naam"]]];                   
                    if ([appDelegate.viewcontroller.removeView.SelectedItems containsObject:[NSNumber numberWithInteger:[[coursCell valueForKey:@"DeelId"] intValue]]]) {
                        
                        
                        [onderdeel.itemSwitch.Switcher setOn:YES];
                        [onderdeel.itemSwitch.internet setText:@"Afwezig"];                   
                    }
                    
                    else
                    {
                        
                        [onderdeel.itemSwitch.Switcher setOn:NO];
                        [onderdeel.itemSwitch.internet setText:@"Aanwezig"];
                        
                    }
                    
                    [onderdeel.itemSwitch.Switcher setTag:[[coursCell valueForKey:@"DeelId"] intValue]];                                      
                }
                onderdeel.contentdict =[test objectAtIndex:indexPath.row];
                
            }
        }                   
        
    } else {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Categorieen like [cd] %@",[NSString stringWithFormat:@"%ld", (long)appDelegate.searchCatagorie]];
        
        NSMutableArray *items =  [[appDelegate.onderdelenVoertuigArray filteredArrayUsingPredicate:predicate] mutableCopy];                   
        
        if (appDelegate.searchCatagorie >0) {
            NSMutableDictionary *coursCell =[items objectAtIndex:indexPath.row];
            OnderdeelView *existlabel = (OnderdeelView *)[cell viewWithTag:27];
            [existlabel removeFromSuperview];
            float Number;
            if ([[[items objectAtIndex:indexPath.row] valueForKey:@"DeelVelden"] count] % 2)
            {
                Number =(([[[items objectAtIndex:indexPath.row] valueForKey:@"DeelVelden"] count]+1)*55)/2;
            }
            else
            {
                Number =((([[[items objectAtIndex:indexPath.row] valueForKey:@"DeelVelden"] count])*55)/2);
                
            }
                ////////////NSLog(@"%@", [items objectAtIndex:indexPath.row]);
            if ([[[items objectAtIndex:indexPath.row] valueForKey:@"Verplicht"] boolValue]) {
                NSArray *velden =[FileManager getOnderdelen:[[coursCell valueForKey:@"DeelId"] integerValue]];
                NSIndexPath *iPath = [NSIndexPath indexPathForItem:[appDelegate.onderdelenVoertuigArray indexOfObject:coursCell] inSection:0];
                
                
                OnderdeelView *onderdeel =[[OnderdeelView alloc]initWithFrame:CGRectMake(5, 5, self.frame.size.width-20, 760+ Number)];
                [onderdeel setTag:27];
                [cell addSubview:onderdeel];                   
                [onderdeel setBackgroundColor:[UIColor clearColor]];
                onderdeel.layer.shadowOffset = CGSizeMake(0, 0);
                onderdeel.layer.shadowOpacity = 0;
                
                onderdeel.contentdict =[items objectAtIndex:indexPath.row];                   
                onderdeel.basepart =  [[FileManager getOnderdelenVoertuigId:[coursCell valueForKey:@"DeelId"]] firstObject];
                onderdeel.indexand =iPath;
                [onderdeel setVelden:velden];
                onderdeel.parentcell =cell;
                onderdeel.sizeit =150+Number;
                
                if ([[coursCell valueForKey:@"DeelNamen"] count]>0) {                   
                    [onderdeel.titletopview setText:[NSString stringWithFormat:@"%@", [[[coursCell valueForKey:@"DeelNamen"] firstObject] valueForKey:@"Naam"]]];
                    
                    if ([appDelegate.viewcontroller.removeView.SelectedItems containsObject:[NSNumber numberWithInteger:[[coursCell valueForKey:@"DeelId"] intValue]]]) {
                        
                        
                        [onderdeel.itemSwitch.Switcher setOn:YES];
                        [onderdeel.itemSwitch.internet setText:@"Afwezig"];                   
                    }
                    
                    else
                    {
                        
                        [onderdeel.itemSwitch.Switcher setOn:NO];
                        [onderdeel.itemSwitch.internet setText:@"Aanwezig"];
                        
                    }                   
                    [onderdeel.itemSwitch.Switcher setTag:[[coursCell valueForKey:@"DeelId"] intValue]];                                      
                }                   
            }
            else
                
            {
                
                NSIndexPath *iPath = [NSIndexPath indexPathForItem:[appDelegate.onderdelenVoertuigArray indexOfObject:coursCell] inSection:0];
                
                OnderdeelView *onderdeel =[[OnderdeelView alloc]initWithFrame:CGRectMake(5, 5, self.frame.size.width-20, 55)];
                [onderdeel setTag:27];
                [cell addSubview:onderdeel];
                onderdeel.indexand =iPath;
                
                onderdeel.basepart =  [[FileManager getOnderdelenVoertuigId:[coursCell valueForKey:@"DeelId"]] firstObject];
                [onderdeel setItemcoursCell:coursCell];
                [onderdeel setBackgroundColor:[UIColor clearColor]];
                onderdeel.layer.shadowOffset = CGSizeMake(0, 0);
                onderdeel.layer.shadowOpacity = 0;
                onderdeel.parentcell =cell;
                
                onderdeel.sizeit =150+Number;
                
                if ([[coursCell valueForKey:@"DeelNamen"] count]>0) {                   
                    [onderdeel.titletopview setText:[NSString stringWithFormat:@"%@", [[[coursCell valueForKey:@"DeelNamen"] firstObject] valueForKey:@"Naam"]]];                   
                    if ([appDelegate.viewcontroller.removeView.SelectedItems containsObject:[NSNumber numberWithInteger:[[coursCell valueForKey:@"DeelId"] intValue]]]) {
                        
                        
                        [onderdeel.itemSwitch.Switcher setOn:YES];
                        [onderdeel.itemSwitch.internet setText:@"Afwezig"];                   
                    }
                    
                    else
                    {
                        
                        [onderdeel.itemSwitch.Switcher setOn:NO];
                        [onderdeel.itemSwitch.internet setText:@"Aanwezig"];
                        
                    }
                    
                    [onderdeel.itemSwitch.Switcher setTag:[[coursCell valueForKey:@"DeelId"] intValue]];                                      
                }
                onderdeel.contentdict =[items objectAtIndex:indexPath.row];
                
            }
        }
        else
        {
            NSMutableDictionary *coursCell =[appDelegate.onderdelenVoertuigArray objectAtIndex:indexPath.row];
            OnderdeelView *existlabel = (OnderdeelView *)[cell viewWithTag:27];
            [existlabel removeFromSuperview];
            float Number;
            if ([[[appDelegate.onderdelenVoertuigArray objectAtIndex:indexPath.row] valueForKey:@"DeelVelden"] count] % 2)
            {
                Number =(([[[appDelegate.onderdelenVoertuigArray objectAtIndex:indexPath.row] valueForKey:@"DeelVelden"] count]+1)*55)/2;
            }
            else
            {
                Number =((([[[appDelegate.onderdelenVoertuigArray objectAtIndex:indexPath.row] valueForKey:@"DeelVelden"] count])*55)/2);
                
            }
            if ([[[appDelegate.onderdelenVoertuigArray objectAtIndex:indexPath.row] valueForKey:@"Verplicht"] boolValue]) {
                NSArray *velden =[FileManager getOnderdelen:[[coursCell valueForKey:@"DeelId"] integerValue]];                   
                OnderdeelView *onderdeel =[[OnderdeelView alloc]initWithFrame:CGRectMake(5, 5, self.frame.size.width-20, 760+ Number)];
                [onderdeel setTag:27];
                [cell addSubview:onderdeel];
                onderdeel.indexand =indexPath;
                
                [onderdeel setBackgroundColor:[UIColor clearColor]];
                onderdeel.layer.shadowOffset = CGSizeMake(0, 0);
                onderdeel.layer.shadowOpacity = 0;
                
                onderdeel.contentdict =[appDelegate.onderdelenVoertuigArray objectAtIndex:indexPath.row];
                
                onderdeel.basepart =  [[FileManager getOnderdelenVoertuigId:[coursCell valueForKey:@"DeelId"]] firstObject];
                [onderdeel setVelden:velden];
                
                onderdeel.parentcell =cell;
                
                onderdeel.sizeit =150+Number;
                
                if ([[coursCell valueForKey:@"DeelNamen"] count]>0) {                   
                    [onderdeel.titletopview setText:[NSString stringWithFormat:@"%@", [[[coursCell valueForKey:@"DeelNamen"] firstObject] valueForKey:@"Naam"]]];
                    
                    if ([appDelegate.viewcontroller.removeView.SelectedItems containsObject:[NSNumber numberWithInteger:[[coursCell valueForKey:@"DeelId"] intValue]]]) {
                        
                        
                        [onderdeel.itemSwitch.Switcher setOn:YES];
                        [onderdeel.itemSwitch.internet setText:@"Afwezig"];                   
                    }
                    
                    else
                    {
                        
                        [onderdeel.itemSwitch.Switcher setOn:NO];
                        [onderdeel.itemSwitch.internet setText:@"Aanwezig"];
                        
                    }
                    
                    [onderdeel.itemSwitch.Switcher setTag:[[coursCell valueForKey:@"DeelId"] intValue]];                                      
                }                   
            }
            else
                
            {
                
                OnderdeelView *onderdeel =[[OnderdeelView alloc]initWithFrame:CGRectMake(5, 5, self.frame.size.width-20, 55)];
                [onderdeel setTag:27];
                [cell addSubview:onderdeel];
                onderdeel.indexand =indexPath;
                
                onderdeel.basepart =  [[FileManager getOnderdelenVoertuigId:[coursCell valueForKey:@"DeelId"]] firstObject];
                [onderdeel setItemcoursCell:coursCell];
                [onderdeel setBackgroundColor:[UIColor clearColor]];
                onderdeel.layer.shadowOffset = CGSizeMake(0, 0);
                onderdeel.layer.shadowOpacity = 0;
                onderdeel.parentcell =cell;
                
                onderdeel.sizeit =150+Number;
                
                if ([[coursCell valueForKey:@"DeelNamen"] count]>0) {                   
                    [onderdeel.titletopview setText:[NSString stringWithFormat:@"%@", [[[coursCell valueForKey:@"DeelNamen"] firstObject] valueForKey:@"Naam"]]];                   
                    if ([appDelegate.viewcontroller.removeView.SelectedItems containsObject:[NSNumber numberWithInteger:[[coursCell valueForKey:@"DeelId"] intValue]]]) {
                        
                        
                        [onderdeel.itemSwitch.Switcher setOn:YES];
                        [onderdeel.itemSwitch.internet setText:@"Afwezig"];                   
                    }
                    
                    else
                    {
                        
                        [onderdeel.itemSwitch.Switcher setOn:NO];
                        [onderdeel.itemSwitch.internet setText:@"Aanwezig"];
                        
                    }
                    
                    [onderdeel.itemSwitch.Switcher setTag:[[coursCell valueForKey:@"DeelId"] intValue]];                                      
                }
                onderdeel.contentdict =[appDelegate.onderdelenVoertuigArray objectAtIndex:indexPath.row];
            }
        }
    }
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
-(UIImage*) Download: (NSString*)urlsting
{
        //[self geturldate:urlsting];
    NSArray *listItems = [urlsting componentsSeparatedByString:@"/"];
    NSString *naamBeeld = [listItems objectAtIndex:[listItems count]-1];
    NSFileManager *FileManager = [NSFileManager defaultManager];
        //Get the complete users document directory path.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        //Get the first path in the array.
    NSString *documentsDirectory = [paths firstObject];
        //Create the complete path to the database file.
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/Caches/%@",naamBeeld]];
        //Check if the file exists or not.
    BOOL success = [FileManager fileExistsAtPath:databasePath];
    if (success) {                   
        NSString *documentsDirectory2 = [paths firstObject];
        NSString *filePath2 = [documentsDirectory2 stringByAppendingPathComponent:[NSString stringWithFormat:@"/Caches/%@",naamBeeld]];
        UIImage *image2 = [UIImage imageWithContentsOfFile:filePath2];
        
        return image2;
    } else {
        NSURL *url = [NSURL URLWithString:urlsting];
        NSData *data = [NSData dataWithContentsOfURL:url];                   
        UIImage *image2 = [[UIImage alloc] initWithData:data];
        if (image2) {
                // en zegt waar het heen moet
            NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
            NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@",docDir,naamBeeld];
            NSData *data2 = [NSData dataWithData:UIImageJPEGRepresentation(image2, 1.0f)];
            [data2 writeToFile:itemFilePath atomically:YES];
        }                   
        return image2;
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *appDelegate = [FileManager getDel];
    if (appDelegate.searchCatagorie >0) {
        NSMutableArray *set =[[NSMutableArray alloc] init];
        [set addObject:[NSNumber numberWithInteger:appDelegate.searchCatagorie]];                                      
        
    } else {                   
    }
}
- (CGFloat)calculateTextHeighTitle:(NSString*)text width:(CGFloat)nWidth
{
    CGSize constraint = CGSizeMake(nWidth, 20000.0f);
    CGRect textRect = [text boundingRectWithSize:constraint
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Max-Bold" size:10]}
                                         context:nil];
    CGSize size = textRect.size;
    CGFloat height = MAX(size.height, MIN_CELL_HEIGHT);
    return height+10;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *appDelegate = [FileManager getDel];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"DeelId = %@", [appDelegate.viewcontroller.collectionOnderdelenView.onderdelen.searchDict valueForKey:@"DeelId"]];
        ////////////NSLog(@"%@", appDelegate.Onderdelen_voertuig);
    NSMutableArray *test =  [[appDelegate.onderdelenVoertuigArray filteredArrayUsingPredicate:predicate] mutableCopy];
    if ([test count]>0) {                   
        if (appDelegate.searchCatagorie >0) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Categorieen like [cd] %@",[NSString stringWithFormat:@"%ld", (long)appDelegate.searchCatagorie]];
                ////////////NSLog(@"%@", [appDelegate.Onderdelen_voertuig valueForKey:@"Categorieen"]);
            NSMutableArray *items =  [[test  filteredArrayUsingPredicate:predicate] mutableCopy];
            if ([[[items objectAtIndex:indexPath.row] valueForKey:@"Verplicht"] boolValue]) {
                float Number;
                
                if ([[[items objectAtIndex:indexPath.row] valueForKey:@"DeelVelden"] count] % 2)
                {                   
                    Number =(([[[items objectAtIndex:indexPath.row] valueForKey:@"DeelVelden"] count]+1)*55)/2;                   
                }
                
                else
                {                   
                    Number =((([[[items objectAtIndex:indexPath.row] valueForKey:@"DeelVelden"] count])*55)/2);
                    
                }
                if ([[[items objectAtIndex:indexPath.row] valueForKey:@"DeelVelden"] count] % 2)
                {                   
                    return CGSizeMake( self.frame.size.width-10, 760+ Number);
                    
                }
                else
                {
                    
                    return CGSizeMake( self.frame.size.width-10, 760+Number);
                    
                }
            }
            else
            {
                
                return CGSizeMake( self.frame.size.width-10, 55);
            }
        }
        else
        {
            if ([[[test objectAtIndex:indexPath.row] valueForKey:@"Verplicht"] boolValue]) {
                float Number;
                
                if ([[[test objectAtIndex:indexPath.row] valueForKey:@"DeelVelden"] count] % 2)
                {                   
                    Number =(([[[test objectAtIndex:indexPath.row] valueForKey:@"DeelVelden"] count]+1)*55)/2;                   
                }
                
                else
                {                   
                    Number =((([[[test objectAtIndex:indexPath.row] valueForKey:@"DeelVelden"] count])*55)/2);
                    
                }
                if ([[[test objectAtIndex:indexPath.row] valueForKey:@"DeelVelden"] count] % 2)
                {                   
                    return CGSizeMake( self.frame.size.width-10, 760+ Number);
                    
                }
                else
                {
                    
                    return CGSizeMake( self.frame.size.width-10, 760+Number);
                    
                }
            }
            else
            {
                
                return CGSizeMake( self.frame.size.width-10, 55);
            }
        }                   
    } else {
        if (appDelegate.searchCatagorie >0) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"Categorieen like [cd] %@",[NSString stringWithFormat:@"%ld", (long)appDelegate.searchCatagorie]];
                ////////////NSLog(@"%@", [appDelegate.Onderdelen_voertuig valueForKey:@"Categorieen"]);
            NSMutableArray *items =  [[appDelegate.onderdelenVoertuigArray  filteredArrayUsingPredicate:predicate] mutableCopy];
            if ([[[items objectAtIndex:indexPath.row] valueForKey:@"Verplicht"] boolValue]) {
                float Number;
                
                if ([[[items objectAtIndex:indexPath.row] valueForKey:@"DeelVelden"] count] % 2)
                {                   
                    Number =(([[[items objectAtIndex:indexPath.row] valueForKey:@"DeelVelden"] count]+1)*55)/2;                   
                }
                
                else
                {                   
                    Number =((([[[items objectAtIndex:indexPath.row] valueForKey:@"DeelVelden"] count])*55)/2);
                    
                }
                if ([[[items objectAtIndex:indexPath.row] valueForKey:@"DeelVelden"] count] % 2)
                {                   
                    return CGSizeMake( self.frame.size.width-10, 760+ Number);
                    
                }
                else
                {
                    
                    return CGSizeMake( self.frame.size.width-10, 760+Number);
                    
                }
            }
            else
            {
                
                return CGSizeMake( self.frame.size.width-10, 55);
            }
        }
        else
        {
            if ([[[appDelegate.onderdelenVoertuigArray objectAtIndex:indexPath.row] valueForKey:@"Verplicht"] boolValue]) {
                float Number;
                
                if ([[[appDelegate.onderdelenVoertuigArray objectAtIndex:indexPath.row] valueForKey:@"DeelVelden"] count] % 2)
                {                   
                    Number =(([[[appDelegate.onderdelenVoertuigArray objectAtIndex:indexPath.row] valueForKey:@"DeelVelden"] count]+1)*55)/2;                   
                }
                
                else
                {                   
                    Number =((([[[appDelegate.onderdelenVoertuigArray objectAtIndex:indexPath.row] valueForKey:@"DeelVelden"] count])*55)/2);
                    
                }
                if ([[[appDelegate.onderdelenVoertuigArray objectAtIndex:indexPath.row] valueForKey:@"DeelVelden"] count] % 2)
                {                                      
                    return CGSizeMake( self.frame.size.width-10, 760+ Number);
                    
                }
                else
                {
                    
                    return CGSizeMake( self.frame.size.width-10, 760+Number);
                    
                }
            }
            else
            {
                
                return CGSizeMake( self.frame.size.width-10, 55);
            }
        }
    }
}
-(void)setitems
{
        //AppDelegate *appDelegate = [FileManager getDel];
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    [layout setHeaderReferenceSize:CGSizeMake(10, 10)];
    [layout setFooterReferenceSize:CGSizeMake(10, 10)];
    
    
    collectionViewCopy=[[UICollectionView alloc] initWithFrame:CGRectMake(4, 48, self.frame.size.width-8, self.frame.size.height-68) collectionViewLayout:layout];
        ////////////NSLog(@"%f", self.frame.size.height-68);
    [collectionViewCopy setDataSource:self];
    [collectionViewCopy setDelegate:self];
    [collectionViewCopy registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [collectionViewCopy setBackgroundColor:[UIColor clearColor]];
    [self addSubview:collectionViewCopy];
    
    
    aannamelijstView =[[AannamelijstView alloc]initWithFrame:CGRectMake(4, 4, 206, 40)];
    [aannamelijstView setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
    [aannamelijstView.layer setBorderColor:[UIColor colorWithRed:0.525 green:0.706 blue:0.871 alpha:1.000].CGColor];
    aannamelijstView.layer.borderWidth = 2;
    [aannamelijstView.layer setCornerRadius:4];
    [aannamelijstView setItem:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
    [aannamelijstView.layer setMasksToBounds:YES];
    [aannamelijstView setAlpha:0];
    [self addSubview:aannamelijstView];
    
    catogorie =[[CategorieenView alloc]initWithFrame:CGRectMake(216, 4, 280, 40)];
    [catogorie setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
    [catogorie.layer setBorderColor:[UIColor colorWithRed:0.525 green:0.706 blue:0.871 alpha:1.000].CGColor];
    catogorie.layer.borderWidth = 2;
    [catogorie.layer setCornerRadius:4];
    [catogorie setItem:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
    [self addSubview:catogorie];
    
    onderdelen =[[OnderdelenView alloc]initWithFrame:CGRectMake(506, 4, 280, 40)];
    [onderdelen setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
    [onderdelen.layer setBorderColor:[UIColor colorWithRed:0.525 green:0.706 blue:0.871 alpha:1.000].CGColor];
    onderdelen.layer.borderWidth = 2;
    [onderdelen.layer setCornerRadius:4];
    [onderdelen setItemOnderdelen:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
    [self addSubview:onderdelen];
    
    
    voegOnderdeelToe =[[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-180, 4, 170, 40)];
    [voegOnderdeelToe setBackgroundColor:[UIColor whiteColor]];
    [voegOnderdeelToe setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [voegOnderdeelToe.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [voegOnderdeelToe setTitle:@"Onderdeel aanmaken" forState:UIControlStateNormal];
    [voegOnderdeelToe addTarget:self action:@selector(makeNewOnderdeel:) forControlEvents:UIControlEventTouchUpInside];
    [voegOnderdeelToe.layer setBorderColor:[UIColor colorWithRed:0.525 green:0.706 blue:0.871 alpha:1.000].CGColor];
    voegOnderdeelToe.layer.borderWidth = 2;
    [voegOnderdeelToe.layer setCornerRadius:4];
    [self addSubview:voegOnderdeelToe];
    
    
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];                   
}
-(void)makeNewOnderdeel:(UIButton*)sender
{
    AppDelegate *appDelegate = [FileManager getDel];
    appDelegate.viewcontroller.selectionView.CatogieView.AllCatagories = [[FileManager getStandaardCategorieen:@""] mutableCopy];
    appDelegate.categorieenStandaardArray =[[FileManager getStandaardCategorieen:@""] mutableCopy];
    appDelegate.viewcontroller.selectionView.OnderdelenTable.AllCatagories = [[FileManager getOnderdelen] mutableCopy];
    [appDelegate.viewcontroller.selectionView.OnderdelenTable.tableResult reloadData];
    [appDelegate.viewcontroller.selectionView.SelectieView.tableResult reloadData];
    [appDelegate.viewcontroller.selectionView.CatogieView.tableResult reloadData];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.2f];
    [appDelegate.viewcontroller.selectionView setAlpha:1];
    [UIView commitAnimations];
    [appDelegate.viewcontroller overlayAction];
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];


    [appDelegate.viewcontroller.collectionOnderdelenView.aannamelijstView reset];
    [appDelegate.viewcontroller.collectionOnderdelenView.catogorie reset];
    [appDelegate.viewcontroller.collectionOnderdelenView.onderdelen reset];

    
    
}
- (void)viewWillLayoutSubviews {
    [collectionViewCopy.collectionViewLayout invalidateLayout];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];                   
}
- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
}
- (void) searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
        // TODO - dynamically update the search results here, if we choose to do that.
        ////////////NSLog(@"3 %@", searchText);
    if ([searchText length] > 0) {
            // The user clicked the [X] button while the keyboard was hidden
            ////////////NSLog(@"x");
        [collectionViewCopy reloadData];                   
        shouldBeginEditing = NO;
    } else  {
            // The user clicked the [X] button or otherwise cleared the text.
            ////////////NSLog(@"x");
        arrayItems = extraArrayItems;
        [collectionViewCopy reloadData];                   
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)bar {
        // reset the shouldBeginEditing BOOL ivar to YES, but first take its value and use it to return it from the method call
    BOOL boolToReturn = shouldBeginEditing;
    shouldBeginEditing = YES;
    return boolToReturn;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}
-(void)textFieldDidChange:(UITextField *)textField
{
}
- (void)keyboardWillShow:(NSNotification*)notification {
        //TekstCopyView
        ////////////NSLog(@"2 keyboardWillShow");
}
- (void)keyboardWillHide:(NSNotification*)notification {
    AppDelegate *appDelegate = [FileManager getDel];
    [appDelegate.viewcontroller.textcopy setAlpha:0];
        ////////////NSLog(@"2 keyboardWillHide");
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.0;
}
-(void)remove:(UIButton*)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Onderdelen verwijderen?"
                                                   delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"verwijderen", nil];
    [alert setTag:406];
    [alert show];
}
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)index{
    AppDelegate *appDelegate = [FileManager getDel];                   
    if (index ==0) {
    } else {                   
        for (int k =0; k < [appDelegate.viewcontroller.removeView.SelectedItems count]; k++) {
            [FileManager RemoveNewOnId:[appDelegate.viewcontroller.removeView.SelectedItems objectAtIndex:k]];                   
        }
        double delayInSeconds = 0.3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){                   
            appDelegate.onderdelenVoertuigArray = [[FileManager getOnderdelen_voertuig:[appDelegate.currentCarDictionary valueForKey:@"Onderdelen"]] mutableCopy];
            [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationDuration:0.2f];
            [appDelegate.viewcontroller.removeView setAlpha:0];
            [UIView commitAnimations];
            
            
        });                   
    }                                      
}
@end
