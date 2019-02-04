//
//  Deel.h
//  Autonet
//
//  Created by Livecast02 on 21-12-16.
//  Copyright © 2016 Autonet. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface DeelView : UIView
@property (nonatomic, strong)  UILabel *titleView;
@property (nonatomic, strong)  UIImageView *upDownView;
@property (nonatomic, assign)  float sizeit;
-(void)setDeel:(NSMutableDictionary*)velden;

@end
