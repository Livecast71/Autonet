//
//  LineButton.h
//  Autonet
//
//  Created by Livecast02 on 10-12-16.
//  Copyright © 2016 Autonet. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ImageButton.h"
@interface OnderdelenViewSelect: UIView <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>
@property (nonatomic, strong)  UIView *parant;
@property (nonatomic, strong)  UIColor *baseColor;
@property (nonatomic, strong)  UIColor *contraColor;
@property (nonatomic, strong)  NSMutableArray *Deelnamen;
@property (nonatomic, strong)  NSMutableArray *Delen;
@property (nonatomic, strong)  NSMutableArray *AllLines;
@property (nonatomic, strong)  UITableView *tableResult;
@property (nonatomic, strong)  UITextView *search;
@property (nonatomic, strong)  NSMutableDictionary *searchDict;
-(void)setItem:(UIColor*)color;
- (void)reset;
@end
