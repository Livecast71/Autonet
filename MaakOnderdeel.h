//
//  MaakOnderdeel.h
//  Autonet
//
//  Created by Livecast02 on 17-05-17.
//  Copyright © 2017 Autonet. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "OnderdelenViewSelect.h"
@interface MaakOnderdeel : UIView
@property (nonatomic, strong)  OnderdelenViewSelect *onderdelen;
-(void)reset:(NSString*)DeelId;
-(void)setItems;
@end
