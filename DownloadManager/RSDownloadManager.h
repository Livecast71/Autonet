//
//  RSDownloadManager.h
//  RSNetworkKit
//
//  Created by Rushi Sangani on 15/01/16.
//  Copyright © 2016 Rushi Sangani. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
static NSString *bgDownloadSessionIdentifier = @"com.RSNetworkKit.bgDownloadSessionIdentifier";
@interface RSDownloadManager : NSObject
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, copy) void (^backgroundSessionCompletionHandler)(void);
+(instancetype)sharedManager;
-(NSURLSessionDownloadTask *)downloadInBackgroundWithURL:(NSString *)urlString downloadProgress:(void (^)(NSNumber *progress))progressBlock success:(void (^)(NSURLResponse *response, NSURL *filePath))completionBlock andFailure:(void (^)(NSError *error))failureBlock;
@end
