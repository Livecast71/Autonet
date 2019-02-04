//
//  ItemFold.h
//  Autonet
//
//  Created by Livecast02 on 01-03-17.
//  Copyright © 2017 Autonet. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ImageButton.h"
#import "ImageScrollView.h"
#import "imagePickerViewController.h"
@interface ItemFold : UIView <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
-(void)ItemFold:(NSMutableDictionary*)item;
@property (nonatomic, strong)  UILabel *titleView;
@property (nonatomic, strong)  UIImageView *upDownView;
@property (nonatomic, strong) imagePickerViewController *pickercontroller;
@property (nonatomic, assign)  float sizeit;                   
@property (nonatomic, strong) NSMutableArray *veldenArray;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong)  NSIndexPath *indexand;
@property (nonatomic, strong)  NSMutableDictionary *contentdict;
@property (nonatomic, strong)  NSMutableDictionary *basepart;
@property (nonatomic, strong)  ImageButton *activateCameraRoll;
@property (nonatomic, strong) UIPopoverController *cameraRoll;
@property (nonatomic, strong) ImageScrollView *imageScrollView;
@property (nonatomic, strong)  NSArray *extraArray;
@property (nonatomic, strong) UIView *backview;
-(void)select:(UIButton*)set;
-(void)selectfold:(UIButton*)set;
@end
