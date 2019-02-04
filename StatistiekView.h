//
//  StatistiekView.h
//  Autonet
//
//  Created by Livecast02 on 11-07-17.
//  Copyright © 2017 Autonet. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface StatistiekView : UIView <UIScrollViewDelegate>
@property (nonatomic, strong)  UILabel *titleView;
@property (nonatomic, strong)  UIView *content;
@property (nonatomic, strong)  UIScrollView *ScrollResult;
-(void)insertDeelID:(NSMutableDictionary*)set;
-(void)setItems;
@end
