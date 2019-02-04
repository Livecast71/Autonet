//
//  ItemSwitch.h
//  Autonet
//
//  Created by Livecast02 on 21-06-17.
//  Copyright © 2017 Autonet. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface ItemSwitch : UIView
@property (nonatomic, strong)  UILabel *internet;
@property (nonatomic, strong)  UISwitch *Switcher;
-(void)selectRemove:(UISwitch*)zender;
-(void)setitems:(NSString*)text;
@end
