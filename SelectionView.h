//
//  SelectionView.h
//  Autonet
//
//  Created by Livecast02 on 08-06-17.
//  Copyright © 2017 Autonet. All rights reserved.
//
#import "TableViewCatagorie.h"
#import "TableViewOnderdelen.h"
#import "TableViewSelectie.h"
#import <UIKit/UIKit.h>
@interface SelectionView : UIView
@property (nonatomic, strong) TableViewCatagorie *CatogieView;
@property (nonatomic, strong) TableViewOnderdelen *OnderdelenTable;
@property (nonatomic, strong) TableViewSelectie *SelectieView;
-(void)setItems;
-(void)reset:(NSString*)DeelId;
@end
