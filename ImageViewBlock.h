//
//  ImageViewBlock.h
//  Autonet
//
//  Created by Livecast02 on 17-10-17.
//  Copyright © 2017 Autonet. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface ImageViewBlock : UIView
@property (nonatomic, strong) UIImageView *imagecontent;
@property (nonatomic, strong) NSIndexPath *curentindex;
@property (nonatomic, strong) NSString *currentimage;
@property (nonatomic, strong) UISwitch *UISwitchOne;
-(void)setimtems;
@end
