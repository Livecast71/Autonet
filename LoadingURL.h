//
//  LoadingURL.h
//  Autonet
//
//  Created by Livecast02 on 23-05-18.
//  Copyright © 2018 Autonet. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LoadingURL : UIView <NSURLSessionDelegate>
@property (nonatomic, strong) NSMutableData *currentdata;
-(void)send:(NSString*)url setName:(NSString*)name;
@end
