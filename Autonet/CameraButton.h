//
//  LineButton.h
//  Autonet
//
//  Created by Livecast02 on 10-12-16.
//  Copyright © 2016 Autonet. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "OnderdeelView.h"
@interface CameraButton : UIButton
@property (nonatomic, strong)  UIColor *baseColor;
@property (nonatomic, strong)  UIColor *contraColor;
@property (nonatomic, strong)  UIView *Colorview;
@property (nonatomic, strong)  NSMutableArray *AllLines;
@property (nonatomic, strong) UICollectionImage *currentCollection;
@property (nonatomic, strong)  OnderdeelView *currentOnderdeel;
-(void)setItem:(UIColor*)color setImage:(NSString*)imagestring;
-(void)setItembig:(UIColor*)color setImage:(NSString*)imagestrin;
-(void)Action:(CameraButton*)sender;
@end
