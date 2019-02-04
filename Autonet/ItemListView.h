//
//  LineButton.h
//  Autonet
//
//  Created by Livecast02 on 10-12-16.
//  Copyright © 2016 Autonet. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ImageButton.h"
#import "FieldLabelView.h"
#import "OnderdeelView.h"
@interface ItemListView: UIView <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign)  NSInteger VeldId;
@property (nonatomic, assign)  NSString *Veldname;
@property (nonatomic, strong)  UIColor *baseColor;
@property (nonatomic, strong)  UIColor *contraColor;
@property (nonatomic, strong)  NSMutableDictionary *currentDictonary;
@property (nonatomic, strong)  NSMutableDictionary *Veld;
@property (nonatomic, strong)  NSMutableDictionary *Airbag;
@property (nonatomic, strong)  NSMutableDictionary *Gordels;
@property (nonatomic, strong)  NSMutableDictionary *Schades;
@property (nonatomic, strong)  NSMutableDictionary *Opties;
@property (nonatomic, strong)  NSMutableArray *AlleVoertuigen;
@property (nonatomic, strong)  NSMutableArray *AllLines;
@property (nonatomic, strong)  NSMutableArray *AllVelden;
@property (nonatomic, strong)  NSMutableArray *AllVeldenActive;
@property (nonatomic, strong)  NSMutableArray *AllVelden_voertuig;
@property (nonatomic, strong)  UITableView *tableResult;
@property (nonatomic, strong)  ImageButton *search;
@property (nonatomic, strong)  UIView *Parentview;
@property (nonatomic, strong)  FieldLabelView *Parentlabel;
@property (nonatomic, strong)  OnderdeelView *onderdeelview;
@property (nonatomic, assign)  float asY;
-(void)setItemListAuto:(NSArray*)velden;
-(void)setItemgo:(NSDictionary*)velden;
-(void)setItemCountry:(NSArray*)velden;
-(void)setItemVelden:(NSArray*)velden;
-(void)setItemExtraVelden:(NSArray*)velden;
-(void)setItemYESNOGordels:(NSArray*)velden aanwezig:(NSMutableDictionary*)value;
-(void)setItemYESNOOpties:(NSArray*)velden aanwezig:(NSMutableDictionary*)value;
-(void)setItemYESNOAirbag:(NSArray*)velden aanwezig:(NSMutableDictionary*)value;
-(void)setItemYESNOSchades:(NSArray*)velden aanwezig:(NSMutableDictionary*)value;
-(void)RefreshTableview:(NSMutableArray*)sender;
-(void)RefreshTableviewEmpty:(NSMutableArray*)sender;
-(void)setItemSoorten:(NSArray*)velden;
-(void)return;
@end
