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
@interface BigLabelView : UIView <UITextFieldDelegate, UITextViewDelegate>
@property (readonly, assign, nonatomic) float insert;
@property (nonatomic, strong)  ItemFold *foldscreen;
@property (nonatomic, assign) NSInteger VeldId;
@property (nonatomic, strong)  OnderdeelView *parantView;
@property (nonatomic, strong)  EditTextView *inhoud;
@property (nonatomic, strong) IBOutlet UILabel *cilinderinhoud;
@property (nonatomic, strong) IBOutlet UILabel *Vermogen;
@property (nonatomic, strong) IBOutlet UILabel *colorlabel;
@property (nonatomic, assign) float scrollingSize;
-(void)setItemset:(NSMutableDictionary*)items;
-(void)setItem:(NSMutableDictionary*)items;
-(void)setPrijs:(NSString*)items;
-(void)setAirbags:(NSMutableDictionary*)items;
-(void)setOpties:(NSMutableDictionary*)items;
-(void)setGordels:(NSMutableDictionary*)items;
-(void)setSchades:(NSMutableDictionary*)items;
-(NSString*)caclulateCillinder:(NSString*)string;
-(NSString*)caclalateVermogen:(NSString*)string;
@end
