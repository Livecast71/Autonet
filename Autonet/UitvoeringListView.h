//
//  LineButton.h
//  Autonet
//
//  Created by Livecast02 on 10-12-16.
//  Copyright © 2016 Autonet. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ImageButton.h"
#import "FieldLabelView.h"
@interface UitvoeringListView: UIView <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign)  NSInteger VeldId;
@property (nonatomic, strong)  UIColor *baseColor;
@property (nonatomic, strong)  UIColor *contraColor;
@property (nonatomic, strong)  NSMutableDictionary *Veld;
@property (nonatomic, strong)  NSMutableArray *AlleVoertuigen;
@property (nonatomic, strong)  NSMutableArray *AllLines;
@property (nonatomic, strong)  NSMutableArray *AllVelden;
@property (nonatomic, strong)  NSMutableArray *AllVelden_voertuig;
@property (nonatomic, strong)  UITableView *tableResult;
@property (nonatomic, strong)  ImageButton *search;
@property (nonatomic, strong)  UIView *Parentview;
@property (nonatomic, strong)  FieldLabelView *Parentlabel;
@property (nonatomic, assign)  float asY;
-(void)setItem:(NSArray*)velden;
@end
