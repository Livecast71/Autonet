//
//  MemoViewController.h
//  Autonet
//
//  Created by Livecast02 on 09-03-17.
//  Copyright © 2017 Autonet. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ImageButton.h"
@interface MemoViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>
{
}
@property (nonatomic, strong)  UIPopoverController *popoverparant;
@property (nonatomic, strong)  NSMutableDictionary *basepart;
@property (nonatomic, strong)   UITextView *Memotext;
@property (nonatomic, strong)  UITextView *search;
@property (nonatomic, strong)  OnderdeelView *onderdeel;
@property (nonatomic, strong)  UITableView *tableResult;
@property (nonatomic, strong)   UIButton *Bewaar;
@property (nonatomic, strong)  NSMutableDictionary *selecteditem;
@property (nonatomic, strong)  NSMutableArray *AllVelden;
@property (nonatomic, assign, getter=isShouldBeginEditing) BOOL shouldBeginEditing;
-(void) SetItems:(NSMutableArray*)sender;
-(void)gone;
-(void)select:(NSMutableDictionary*)copyitem;
@end
