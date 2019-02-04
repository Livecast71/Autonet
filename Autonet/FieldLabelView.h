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
#import "EditTextField.h"
@interface FieldLabelView : UIView <UITextFieldDelegate, UITextViewDelegate>
@property (readonly, assign, nonatomic) float insert;
@property (nonatomic, assign, nonatomic) NSInteger limit;
@property (nonatomic, strong)  ItemFold *foldscreen;
@property (nonatomic, assign) NSInteger veldID;
@property (nonatomic, assign) float scrollingSize;
@property (nonatomic, strong)  OnderdeelView *parantView;
@property (nonatomic, strong) IBOutlet UILabel *cilinderinhoud;
@property (nonatomic, strong) IBOutlet UILabel *vermogen;
@property (nonatomic, strong) IBOutlet UILabel *colorLabel;
@property (nonatomic, strong) UILabel *title;
-(void)setItemVeld:(NSMutableDictionary*)items;
-(void)setItemVeldCar:(NSMutableDictionary*)items;
-(void)setPrijs:(NSString*)items;
-(void)setAirbags:(NSMutableDictionary*)items;
-(void)setOpties:(NSMutableDictionary*)items;
-(void)setGordels:(NSMutableDictionary*)items;
-(void)setSchades:(NSMutableDictionary*)items;
-(NSString*)caclulateCillinder:(NSString*)string;
-(NSString*)caclalateVermogen:(NSString*)string;
@end
