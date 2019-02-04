//
//  UICollectionProducts.h
//  zorgAtlas
//
//  Created by Livecast02 on 13-01-15.
//
//
#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import "CategorieenStandaardView.h"
#import "CategorieenView.h"
#import <CoreData/CoreData.h>
#import "KernoOnderdelenView.h"
#import "OnderdelenView.h"
#import "AannamelijstView.h"
@interface UICollectionOnderdelen : UIView <NSFetchedResultsControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate,UISearchBarDelegate>
@property (nonatomic, retain) UIButton *voegOnderdeelToe;
@property (nonatomic, retain) KernoOnderdelenView *kernoOnderdelenView;
@property (nonatomic, strong) CategorieenStandaardView *catogorieStandaard;
@property (nonatomic, strong) CategorieenView *catogorie;
@property (nonatomic, strong) OnderdelenView *onderdelen;
@property (nonatomic, assign) NSInteger veldID;
@property (nonatomic, strong) NSMutableArray *arrayItems;
@property (nonatomic, strong) NSMutableArray *veldenArray;
@property (nonatomic, strong) NSMutableArray *extraArrayItems;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong)  UISearchBar *searchBarTo;
@property (nonatomic, strong)  UICollectionView *collectionViewCopy;
@property (nonatomic, strong)  AannamelijstView *aannamelijstView;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsControllerCopy;
@property (nonatomic, assign, getter=isShouldBeginEditing) BOOL shouldBeginEditing;
@property(nonatomic, assign) BOOL automaticallyAdjustsScrollViewInsets;
- (void) selected:(NSString *)what;
- (void)keyboardWillShow:(NSNotification*)notification;
- (void)keyboardWillHide:(NSNotification*)notification;
-(void)setitems;
-(void)remove:(UIButton*)sender;
@end
