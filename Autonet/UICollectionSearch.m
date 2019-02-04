//
//  UICollectionProducts.m
//  zorgAtlas
//
//  Created by Livecast02 on 13-01-15.
//
//
#import "UICollectionSearch.h"
#import "AppDelegate.h"
#import "FileManager.h"
#import "MenuView.h"
#define MIN_CELL_HEIGHT 20
#define kOFFSET_FOR_KEYBOARD 80.0
@implementation UICollectionSearch
@synthesize managedObjectContext;
@synthesize searchBarTo;
@synthesize collectionViewcopy;
@synthesize shouldBeginEditing;
@synthesize fetchedResultsControllerCopy;
@synthesize arrayItems;
@synthesize extraArrayItems;
#pragma mark - Fetched Result Controller section

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setAlpha:1];
        [self setitems];
        [self setAlpha:0];
    }
    return self;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   
    return [arrayItems count];
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
        UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
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
    //appDelegate.searchCatagorie = [[[arrayItems  objectAtIndex:indexPath.row]  valueForKey:@"CategorieId"] integerValue];
    [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
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
    return CGSizeMake(130, 100);
}
-(void)setitems
{
    [self.layer setCornerRadius:6];
    UILabel *VoorlettersBack =[[UILabel alloc]initWithFrame:CGRectMake(4, 4, 280, 40)];
    [VoorlettersBack.layer setBorderColor:[UIColor colorWithRed:0.525 green:0.706 blue:0.871 alpha:1.000].CGColor];
    [VoorlettersBack.layer setBorderWidth:2];
    [VoorlettersBack.layer setCornerRadius:10];
    [self addSubview:VoorlettersBack];
   
    searchBarTo= [[UISearchBar alloc] initWithFrame:CGRectMake(4, 4, 280, 40)];
    [searchBarTo setTintColor:[UIColor whiteColor]];
    [searchBarTo setBarTintColor:[UIColor whiteColor]];
    [searchBarTo setKeyboardType:UIKeyboardTypeNumberPad];
    [searchBarTo setDelegate:self];
    searchBarTo.clipsToBounds = YES;
    [searchBarTo.layer setBorderColor:[UIColor colorWithRed:0.525 green:0.706 blue:0.871 alpha:1.000].CGColor];
    searchBarTo.layer.borderWidth = 2;
    [searchBarTo.layer setCornerRadius:4];
    [searchBarTo setText:@"Zoek foto..."];
    [self  addSubview:searchBarTo];

    UIButton *note =[[UIButton alloc]initWithFrame:CGRectMake(300,4, 200, 40)];
    [note setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [note setTitle:@"Delen kaarzetten voor upload" forState:UIControlStateNormal];
    [note setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
    [self addSubview:note];

    [note.layer setBorderWidth:2];
    [note.layer  setBorderColor:[UIColor whiteColor].CGColor];
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    [layout setHeaderReferenceSize:CGSizeMake(10, 10)];
    [layout setFooterReferenceSize:CGSizeMake(10, 10)];
    collectionViewcopy=[[UICollectionView alloc] initWithFrame:CGRectMake(4, 60, 670, 728) collectionViewLayout:layout];
    [collectionViewcopy setDataSource:self];
    [collectionViewcopy setDelegate:self];
    [collectionViewcopy registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [collectionViewcopy setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:collectionViewcopy];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];                   
}
- (void) selected:(NSString *)what {
    /*
   ////////////NSLog(@"%@", what);
    [searchBarTo setText:@""];
    if ([what length]>0) {
       
         
        if ([what isEqualToString:@"Alle inhalatoren"])
        {
  
        MultiSlideAppDelegate *appDelegate = (MultiSlideAppDelegate *)[[UIApplication sharedApplication] delegate];
              NSError *error = nil;
       
      
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        [fetchRequest setEntity:[NSEntityDescription entityForName:@"Parts"
                                            inManagedObjectContext:[appDelegate managedObjectContext]]];
       
         
        NSString *query = [NSString stringWithFormat:@"(module like [cd]'%@') and !(items like [cd]'%@') and !(items like [cd]'Over inhalatoren') and !(info like [cd]'%@')", [appDelegate.Version stringByReplacingOccurrencesOfString:@"\n" withString:@" "], @"Alle inhalatoren",@"-"];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:query];
       
         [fetchRequest setPredicate:predicate];
        NSSortDescriptor *sortDescriptor = nil;
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name"
                                                     ascending:YES];
        NSArray *sortDescriptors = nil;
        sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
       
         [fetchRequest setSortDescriptors:sortDescriptors];
       
  
       arrayItems = [[[appDelegate managedObjectContext] executeFetchRequest:fetchRequest error:&error] mutableCopy];
            copyArrayItems = [[[appDelegate managedObjectContext] executeFetchRequest:fetchRequest error:&error] mutableCopy];
   
      
        [collectionViewcopy reloadData];
        }
        else
        {
           MultiSlideAppDelegate *appDelegate = (MultiSlideAppDelegate *)[[UIApplication sharedApplication] delegate];
            NSError *error = nil;
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            [fetchRequest setEntity:[NSEntityDescription entityForName:@"Parts"
                                                inManagedObjectContext:[appDelegate managedObjectContext]]];
            NSString *query = [NSString stringWithFormat:@"(items like [cd]'%@') and !(info like [cd]'-')", what];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:query];
            [fetchRequest setPredicate:predicate];
            NSSortDescriptor *sortDescriptor = nil;
            sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name"
                                                         ascending:YES];
            NSArray *sortDescriptors = nil;
            sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
            [fetchRequest setSortDescriptors:sortDescriptors];
            arrayItems = [[[appDelegate managedObjectContext] executeFetchRequest:fetchRequest error:&error] mutableCopy];
            copyArrayItems = [[[appDelegate managedObjectContext] executeFetchRequest:fetchRequest error:&error] mutableCopy];
            [collectionViewcopy reloadData];
        }
        
     }
    else {
       
     }
     
     */
}
- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
   
    /*
    if ([searchBar.text length]>0) {
    MultiSlideAppDelegate *appDelegate = (MultiSlideAppDelegate *)[[UIApplication sharedApplication] delegate];
         NSError *error = nil;
   
    [searchBar resignFirstResponder];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Parts"
                                        inManagedObjectContext:[appDelegate managedObjectContext]]];
    NSString *query = [NSString stringWithFormat:@"(name CONTAINS [cd]'%@') and (module like [cd]'%@') and !(items like [cd]'%@') and !(items like [cd]'Over inhalatoren') and !(info like [cd]'%@')", searchBar.text, [appDelegate.Version stringByReplacingOccurrencesOfString:@"\n" withString:@" "], @"Alle inhalatoren",@"-"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:query];
    [fetchRequest setPredicate:predicate];
    NSSortDescriptor *sortDescriptor = nil;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name"
                                                 ascending:YES];
    NSArray *sortDescriptors = nil;
    sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
 
    [fetchRequest setSortDescriptors:sortDescriptors];
 
        arrayItems = [[[appDelegate managedObjectContext] executeFetchRequest:fetchRequest error:&error] mutableCopy];
       
   
    [collectionViewcopy reloadData];
    } else {
        arrayItems = copyArrayItems;
       
        [collectionViewcopy reloadData];
       
     }
    */
}
- (void) searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
    // TODO - dynamically update the search results here, if we choose to do that.
       ////////////NSLog(@"2 %@", searchText);
    if ([searchText length] > 0) {
        // The user clicked the [X] button while the keyboard was hidden
        ////////////NSLog(@"x");
      
        [collectionViewcopy reloadData];
       
         shouldBeginEditing = NO;
    } else  {
        // The user clicked the [X] button or otherwise cleared the text.
        ////////////NSLog(@"x");
     arrayItems = extraArrayItems;
        [collectionViewcopy reloadData];
       
         
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
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.0;
}
     
     
     
     
@end
