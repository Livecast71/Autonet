//
//  UITableListOnderdelen.h
//  Autonet
//
//  Created by Livecast02 on 07-02-17.
//  Copyright © 2017 Autonet. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface UITableListOnderdelen : UIView <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) NSInteger VeldId;
@property (nonatomic, strong) NSMutableArray *AlleOnderdelen;
@property (nonatomic, strong) NSMutableArray *extraArrayItems;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong)  UISearchBar *searchBarTo;
@property (nonatomic, strong)  UITableView *tableResult;
@property (nonatomic, assign, getter=isShouldBeginEditing) BOOL shouldBeginEditing;
-(void)buildItems;
@end
