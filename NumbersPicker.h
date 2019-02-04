//
//  NumberPicker.h
//  BellyBuddy
//
//  Created by Livecast on 21-01-14.
//  Copyright (c) 2014 Livecast. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "KMViewController.h"
//#import "ExtraView.h"
@interface NumbersPicker : UIPickerView <UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, strong) NSMutableArray *ageArray;
@property (nonatomic, strong) NSMutableArray *content;
@property (nonatomic, strong) UITextView *numberlabel;
@property (nonatomic, strong) UITextView *numberlabel2;
@property (nonatomic, strong) KMViewController *copyview;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) UIViewController *parant;
@property (nonatomic, strong) NSMutableAttributedString *one;
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
-(void)scrolTo:(NSInteger)component row:(NSInteger)row;
@end
