//
//  LineButton.h
//  Autonet
//
//  Created by Livecast02 on 10-12-16.
//  Copyright © 2016 Autonet. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ImageButton.h"
#import "LineButton.h"
#import "LineView.h"
#import "TableView.h"
@interface MenuView: UIView
@property (nonatomic, strong)  UIColor *baseColor;
@property (nonatomic, strong)  UIColor *contraColor;
@property (nonatomic, strong)  ImageButton *fotos;
@property (nonatomic, strong)  ImageButton *info;
@property (nonatomic, strong)  ImageButton *onderdelen;
@property (nonatomic, strong)  ImageButton *inkoop;
@property (nonatomic, strong)  ImageButton *verkoop;
@property (nonatomic, strong)  ImageButton *aannamelijst;
@property (nonatomic, strong)  ImageButton *internet;
@property (nonatomic, strong)  ImageButton *search;
@property (nonatomic, strong)  ImageButton *Uploaden;
@property (nonatomic, strong)  LineView *content;
@property (nonatomic, strong)  TableView *ListVoertuigen;
@property (nonatomic, strong)  NSMutableArray *AllLines;
-(void)setItem:(UIColor*)color;
-(void)move:(LineButton*)sender;
@end
