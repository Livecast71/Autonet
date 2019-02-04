//
//  LineButton.h
//  Autonet
//
//  Created by Livecast02 on 10-12-16.
//  Copyright © 2016 Autonet. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "TableViewSelectie.h"
@interface TableViewOnderdelen: UIView <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)  NSMutableArray *AllLines;
@property (nonatomic, strong)  NSMutableArray *AllCatagories;
@property (nonatomic, strong) UITableView *tableResult;
@property (nonatomic, strong) TableViewSelectie *tableViewSelectie;
-(void)setItem;
@end