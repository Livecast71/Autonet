//
//  EditTextField.h
//  Autonet
//
//  Created by Livecast02 on 08-03-17.
//  Copyright © 2017 Autonet. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface EditTextView : UITextView
@property (nonatomic, assign)  BOOL character;
@property (nonatomic, assign)  NSInteger limit;
@property (nonatomic, assign)  NSString* pos;
@property (nonatomic, assign)  NSNumber* LengteMax;
@property (nonatomic, assign)  NSNumber* RangeMax;
@property (nonatomic, strong)  NSString *format;
@property (nonatomic, strong)  NSString *edittitle;
@property (nonatomic, strong)  NSString *edittext;
@property (nonatomic, strong)  NSIndexPath *indexand;
@property (nonatomic, strong)  NSMutableDictionary *contentdict;
-(void)builditems;


@end
