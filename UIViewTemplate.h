//
//  UIViewTemplate.h
//  Autonet
//
//  Created by Livecast02 on 27-07-17.
//  Copyright © 2017 Autonet. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface UIViewTemplate : UIView
{
    NSMutableArray *getlist;
    NSString *Moment;
    NSString *Interval;
    NSNumber *startnumber;
}
@property (nonatomic, strong) NSNumber *startnumber;
@property (nonatomic, strong) NSString *Moment;
@property (nonatomic, strong) NSMutableArray *getlist;
@property (nonatomic, strong) NSString *Interval;
@end
