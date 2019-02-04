//
//  OnderdeelView.h
//  Autonet
//
//  Created by Livecast02 on 19-12-16.
//  Copyright © 2016 Autonet. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "DeelView.h"
#import "ImageScrollView.h"
#import "ItemSwitch.h"
@interface OnderdeelView : UIScrollView <UIScrollViewDelegate, UIImagePickerControllerDelegate, UIAlertViewDelegate>
@property (nonatomic, strong) DeelView *itemview;
@property (nonatomic, strong) NSMutableArray *veldenArray;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong)  NSIndexPath *indexand;
@property (nonatomic, strong)  NSMutableArray *contentdict;
@property (nonatomic, strong)  NSMutableDictionary *basepart;
@property (nonatomic, strong) UILabel *titletopview;
@property (nonatomic, strong) UICollectionViewCell *parentcell;
@property (nonatomic, assign)  float sizeit;
@property (nonatomic, strong) UIImageView *upDownView;
@property (nonatomic, strong)  ImageScrollView *imageView;
@property (nonatomic, strong) ItemSwitch *itemSwitch;
-(void)setItemcoursCell:(NSMutableDictionary*)coursCell;
-(void)setVelden:(NSArray*)velden;
-(void)setVeldenEmpty:(NSArray*)velden;
-(void)handleDoubleCaredata:(UIGestureRecognizer *)gestureRecognizer;
@end
