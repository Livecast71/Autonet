//
//  UIImagePickerView.h
//  Autonet
//
//  Created by Livecast02 on 08-08-17.
//  Copyright © 2017 Autonet. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ItemFold.h"
@interface imagePickerView : UIView<NSFetchedResultsControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate,UISearchBarDelegate, UIAlertViewDelegate>
@property (nonatomic, strong) NSString *header;
@property (nonatomic, strong) NSString *ItemID;
@property (nonatomic, strong) NSMutableArray *arrayItems;
@property (nonatomic, strong) NSMutableArray *localArray;
@property (nonatomic, strong) ItemFold *currentFold;
@property (nonatomic, strong) NSMutableDictionary *localDictonary;
@property (nonatomic, strong) NSMutableArray *extraArrayItems;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong)  UISearchBar *searchBarTo;
@property (nonatomic, strong)  UICollectionView *collectionViewImages;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsControllerCopy;
@property (nonatomic, assign, getter=isShouldBeginEditing) BOOL shouldBeginEditing;
-(void)setitems;
-(void) resetimage:(NSMutableArray*)array gotoIndex:(NSIndexPath*)get;
-(void)setLoadingItems;
-(void)select;
@end
