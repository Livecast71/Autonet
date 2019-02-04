//
//  Loadingview.h
//  Autonet
//
//  Created by Livecast02 on 15-12-16.
//  Copyright © 2016 Autonet. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "QRCodeReaderDelegate.h"
@interface NavigationView : UIView <UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate, QRCodeReaderDelegate>
{
}
@property (nonatomic, strong) UIProgressView *progressBar;
@property (nonatomic, strong)  UICollectionView *collectionViewNav;
@property (nonatomic, strong)  NSMutableArray *copylist;
@property (nonatomic, assign) BOOL shouldBeginEditing;
-(void)setLoadingItems;
@end
