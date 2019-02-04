//
//  TekstEditView.h
//  Autonet
//
//  Created by Livecast02 on 05-08-18.
//  Copyright © 2018 Autonet. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "EditTextView.h"
#import "EditTextField.h"
#import "OnderdeelView.h"
@interface TekstCopyView : UIView <UITextViewDelegate>
@property (nonatomic, strong)  UILabel *title;
@property (nonatomic, strong)  UITextView *inhoud;
@property (nonatomic, strong)  UIButton *note;
@property (nonatomic, assign) NSInteger VeldId;
@property (nonatomic, strong)  OnderdeelView *parantView;
@property (nonatomic, strong)  EditTextView *TextView;
@property (nonatomic, strong)  EditTextField *TextField;
@property (nonatomic, strong)  UIDatePicker *datePicker;
@property (nonatomic, strong)  UIDatePicker *dayMontheYearPicker;
@property (nonatomic, strong)  NSMutableArray* copyplist;
@property (nonatomic, strong)  NSMutableArray *Veldenit;
@property (nonatomic, strong)  UILabel *cover;
@property (nonatomic, strong)  UILabel *cover1;
@property (nonatomic, strong)  UILabel *cover2;
@property (nonatomic, strong)  NSString *pos;
-(void)builditems;
-(void)ScanClass:(NSObject*)clasless set:(OnderdeelView*)parant;
@end
