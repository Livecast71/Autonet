//
//  Loadingview.h
//  Autonet
//
//  Created by Livecast02 on 15-12-16.
//  Copyright © 2016 Autonet. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "QRCodeReaderDelegate.h"
#import "ASIHTTPRequest.h"
#import "ASIDownloadCache.h"
@interface Loadingview : UIView <QRCodeReaderDelegate,NSXMLParserDelegate, NSStreamDelegate, UIApplicationDelegate,UIAlertViewDelegate, UIDocumentInteractionControllerDelegate, NSStreamDelegate, NSURLSessionDataDelegate, NSURLSessionDelegate, NSURLSessionTaskDelegate>
@property (nonatomic, strong) NSMutableArray *TotalVoertuigenFotos;
@property (nonatomic, strong) NSMutableArray *TotalOnderdelenFotos;
@property (nonatomic, strong) NSMutableArray *TotalVoertuigen;
@property (nonatomic, strong) NSMutableArray *UploadVoertuigen;
@property (nonatomic, strong)  NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *theConnection;
@property (nonatomic, strong) UIProgressView *progressBar;
@property (nonatomic, strong) NSMutableData *currentdata;
@property (nonatomic, strong) NSMutableData *currentdata2;
@property (nonatomic, strong) ASIHTTPRequest *rqstForpdf;
@property (nonatomic, assign) float currentProgress;
@property (nonatomic, strong) UIButton *Skip;
@property (nonatomic, strong) UIButton *clear;
@property (nonatomic, strong) UIButton *scan;
@property (nonatomic, retain) NSMutableData *dataToDownload;
@property (nonatomic) float downloadSize;
@property (nonatomic, retain) NSURLSession *defaultSession;
-(void)clearPressed:(UIButton*)sender;
-(void)setLoadingItems;
-(void)lastMove;
- (IBAction)scanAction:(id)sender;
-(NSMutableArray*)removenZero:(NSMutableArray*)sender;
@end
