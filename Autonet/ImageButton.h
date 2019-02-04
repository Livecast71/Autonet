//
//  LineButton.h
//  Autonet
//
//  Created by Livecast02 on 10-12-16.
//  Copyright © 2016 Autonet. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "OnderdeelView.h"
@interface ImageButton : UIButton
@property (nonatomic, strong)  UIColor *baseColor;
@property (nonatomic, strong)  OnderdeelView *onderdeel;
@property (nonatomic, strong)  UIColor *contraColor;
@property (nonatomic, strong)  UIView *Colorview;
@property (nonatomic, strong)  UILabel *titleView;
@property (nonatomic, strong)  UIImageView *upDownView;
@property (nonatomic, strong)  NSMutableArray *AllLines;
-(void)setItem:(UIColor*)color setImage:(NSString*)imagestring;
-(void)setItembig:(UIColor*)color setImage:(NSString*)imagestrin;
-(void)setItemtop:(UIColor*)color setImage:(NSString*)imagestring;
-(void)Action:(ImageButton*)sender;
-(void)setlabel;
@end
