//
//  RSDownloadManager.m
//  RSNetworkKit
//
//  Created by Rushi Sangani on 15/01/16.
//  Copyright © 2016 Rushi Sangani. All rights reserved.
//
#import "RSDownloadManager.h"
#import "AppDelegate.h"
@interface RSDownloadManager ()
@end
@implementation RSDownloadManager
#pragma mark - Singleton instance
+(instancetype)sharedManager
{
    static RSDownloadManager *_downloadManager = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        if (!_downloadManager) {
           _downloadManager = [[self alloc] init];
        }
    });
    return _downloadManager;
}
#pragma mark - Init with Session Configuration
-(void)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration {
    self.manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
}
#pragma mark- download in background request Method
-(NSURLSessionDownloadTask *)downloadInBackgroundWithURL:(NSString *)urlString downloadProgress:(void (^)(NSNumber *))progressBlock success:(void (^)(NSURLResponse *, NSURL *))completionBlock andFailure:(void (^)(NSError *))failureBlock {
    /* initialise session manager with background configuration */
    if(!self.manager){
        [self initWithSessionConfiguration:[NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:bgDownloadSessionIdentifier]];
    }
    [self configureBackgroundSessionCompletion];
   
    /* Create a request from the url */
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSURLSessionDownloadTask *downloadTask = [self.manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        if(progressBlock) {
           progressBlock ([NSNumber numberWithDouble:downloadProgress.fractionCompleted]);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if(error) {
           if(failureBlock) {
               failureBlock (error);
            }
        }
        else {
           if(completionBlock) {
               completionBlock (response, filePath);
            }
        }
    }];
    [downloadTask resume];
    return downloadTask;
}
#pragma mark- Handle background session completion
- (void)configureBackgroundSessionCompletion {
    typeof(self) __weak weakSelf = self;
    [self.manager setDidFinishEventsForBackgroundURLSessionBlock:^(NSURLSession *session) {
        if (weakSelf.backgroundSessionCompletionHandler) {
           weakSelf.backgroundSessionCompletionHandler();
            weakSelf.backgroundSessionCompletionHandler = nil;
        }
    }];
}
@end
