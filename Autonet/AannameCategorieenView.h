//
//  LineButton.h
//  Autonet
//
//  Created by Livecast02 on 10-12-16.
//  Copyright © 2016 Autonet. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ImageButton.h"
@interface AannameCategorieenView: UIView <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)  UIColor *baseColor;
@property (nonatomic, strong)  UIColor *contraColor;
@property (nonatomic, strong)  NSMutableArray *AlleVoertuigen;
@property (nonatomic, strong)  NSMutableArray *AllLines;
@property (nonatomic, strong)  UITableView *tableResult;
@property (nonatomic, strong)  ImageButton *search;
-(void)setItem:(UIColor*)color;
@end
