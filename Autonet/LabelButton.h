//
//  LineButton.h
//  Autonet
//
//  Created by Livecast02 on 10-12-16.
//  Copyright © 2016 Autonet. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface LabelButton : UILabel
@property (nonatomic, strong)  UIColor *baseColor;
@property (nonatomic, strong)  UIColor *contraColor;
@property (nonatomic, strong)  NSMutableArray *AllLines;
-(void)setItem:(UIColor*)color;
-(void)Action:(LabelButton*)sender;
@end
