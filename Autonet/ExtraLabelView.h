//
//  LabelView.h
//  Autonet
//
//  Created by Livecast02 on 02-02-17.
//  Copyright © 2017 Autonet. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ItemFold.h"
#import "OnderdeelView.h"
#import "EditTextView.h"
@interface ExtraLabelView : UIView <UITextFieldDelegate, UITextViewDelegate>
@property (readonly, assign, nonatomic) float insert;
@property (nonatomic, assign, nonatomic) NSInteger limit;
@property (nonatomic, strong)  ItemFold *foldscreen;
@property (nonatomic, assign) NSInteger veldID;
@property (nonatomic, strong)  OnderdeelView *parantView;
@property (nonatomic, strong)  EditTextView *inhoudextra;
@property (nonatomic, strong) IBOutlet UILabel *cilinderinhoud;
@property (nonatomic, strong) IBOutlet UILabel *Vermogen;
@property (nonatomic, assign) float scrollingSize;
-(void)setItemExtras:(NSString*)titleExtra;
@end
