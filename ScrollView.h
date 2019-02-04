//
//  ScrollView.h
//  Autonet
//
//  Created by Livecast02 on 06-02-17.
//  Copyright © 2017 Autonet. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "UICollectionImage.h"
@interface ScrollView : UIView <UIScrollViewDelegate>
@property (nonatomic, retain) UICollectionImage *imageView;
-(void)setImages:(NSArray*)sender;
@end
