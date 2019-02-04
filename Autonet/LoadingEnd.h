//
//  Loadingview.h
//  Autonet
//
//  Created by Livecast02 on 15-12-16.
//  Copyright © 2016 Autonet. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "QRCodeReaderDelegate.h"
@interface LoadingEnd : UIView <QRCodeReaderDelegate,NSXMLParserDelegate, NSStreamDelegate, UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *RemovPlistArray;

@property (nonatomic, strong) NSMutableArray *RemovPartFotosArray;

@property (nonatomic, strong) NSMutableArray *RemovCarFotosArray;

@property (nonatomic, strong) NSMutableArray *TotalVoertuigen;
@property (nonatomic, strong)  NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *theConnection;
@property (nonatomic, strong) UITableView *tableupload;
@property (nonatomic, strong) NSString *indexit;
@property (nonatomic, strong) UIView *overlay;
-(void)setLoadingItems;
@end
