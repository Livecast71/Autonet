//
//  UICollectionProducts.h
//  zorgAtlas
//
//  Created by Livecast02 on 13-01-15.
//
//
#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@interface UICollectionImage : UIView <NSFetchedResultsControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate,UISearchBarDelegate>
@property (nonatomic, strong) NSString *header;
@property (nonatomic, strong) NSMutableArray *arrayItems;
@property (nonatomic, strong) NSMutableArray *arrayInternet;
@property (nonatomic, strong) NSMutableArray *extraArrayItems;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong)  UISearchBar *searchBarTo;
@property (nonatomic, strong)  UICollectionView *collectionViewcopy;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsControllerCopy;
@property (nonatomic, assign, getter=isShouldBeginEditing) BOOL shouldBeginEditing;
-(void)setitems;
-(void) resetimage:(NSMutableArray*)array gotoIndex:(NSIndexPath*)get;
@end
