//
//  MaakArtikel.h
//  Autonet
//
//  Created by Livecast02 on 30-05-17.
//  Copyright © 2017 Autonet. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ImageButton.h"
@interface MaakArtikel : UIView <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>
@property (nonatomic, strong)  UITextView *search;
@property (nonatomic, strong)  UITableView *tableResult;
@property (nonatomic, strong)  NSMutableDictionary *selecteditem;
@property (nonatomic, strong)  NSMutableArray *AllVelden;
@property (nonatomic, strong)  UIButton *Bewaar;
@property (nonatomic, assign, getter=isShouldBeginEditing) BOOL shouldBeginEditing;
-(void) SetItems:(NSMutableArray*)sender;
-(void)buidItems;
-(void)gone;
-(void)select:(NSMutableDictionary*)copyitem;
@end
