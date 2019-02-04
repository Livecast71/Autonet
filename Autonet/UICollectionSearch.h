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
@interface UICollectionSearch : UIView <NSFetchedResultsControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate,UISearchBarDelegate>
@property (nonatomic, strong) NSMutableArray *arrayItems;
@property (nonatomic, strong) NSMutableArray *extraArrayItems;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong)  UISearchBar *searchBarTo;
@property (nonatomic, strong)  UICollectionView *collectionViewcopy;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsControllerCopy;
@property (nonatomic, assign, getter=isShouldBeginEditing) BOOL shouldBeginEditing;
- (void) selected:(NSString *)what;
-(void)setitems;
@end
