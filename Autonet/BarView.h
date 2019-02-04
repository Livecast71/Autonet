//
//  LineButton.h
//  Autonet
//
//  Created by Livecast02 on 10-12-16.
//  Copyright © 2016 Autonet. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "LineButton.h"
@interface BarView: UIView <UIScrollViewDelegate>
@property (readonly, assign, nonatomic) float currentheight;
@property (nonatomic, strong)  UIColor *baseColor;
@property (nonatomic, strong)  UIColor *contraColor;
@property (nonatomic, strong)  UILabel *kenteken;
@property (nonatomic, strong)   UIView *content;
@property (nonatomic, strong)  LineButton *Uploaden;
@property (nonatomic, strong) UILabel *ovelaylabel;
@property (nonatomic, strong) UIImageView *logos;
@property (nonatomic, strong) IBOutlet UILabel *ipadname;
@property (nonatomic, strong) IBOutlet UILabel *autolabel;
@property (nonatomic, strong)  NSMutableArray *AllLines;
-(void)setItem:(UIColor*)color;
@end
