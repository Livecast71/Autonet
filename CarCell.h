//
//  CarCell.h
//  Autonet
//
//  Created by Livecast02 on 13-04-17.
//  Copyright © 2017 Autonet. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface CarCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imgset;
@property (nonatomic, strong) UIImageView *logos;
@property (nonatomic, strong) UILabel *kenteken;
@property (nonatomic, strong) UIView *onderdelenView;
@property (nonatomic, strong) UILabel *label;
-(void)setItems;
@end
