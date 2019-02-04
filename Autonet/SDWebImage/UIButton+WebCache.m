/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
#import "UIButton+WebCache.h"
#import "objc/runtime.h"
static char operationKey;
@implementation UIButton (WebCache)
- (void)setImageWithURL:(NSURL *)url forState:(UIControlState)state
{
    [self setImageWithURL:url forState:state placeholderImage:nil options:0 completed:nil];
}
- (void)setImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder
{
    [self setImageWithURL:url forState:state placeholderImage:placeholder options:0 completed:nil];
}
- (void)setImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options
{
    [self setImageWithURL:url forState:state placeholderImage:placeholder options:options completed:nil];
}
- (void)setImageWithURL:(NSURL *)url forState:(UIControlState)state completed:(SDWebImageCompletedBlock)completedBlock
{
    [self setImageWithURL:url forState:state placeholderImage:nil options:0 completed:completedBlock];
}
- (void)setImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletedBlock)completedBlock
{
    [self setImageWithURL:url forState:state placeholderImage:placeholder options:0 completed:completedBlock];
}
- (void)setImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletedBlock)completedBlock
{
    [self cancelCurrentImageLoad];
    [self setImage:placeholder forState:state];
    if (url)
    {
        __weak UIButton *wself = self;
        id<SDWebImageOperation> operation = [SDWebImageManager.sharedManager downloadWithURL:url options:options progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished)
        {
           if (!wself) return;
            dispatch_main_sync_safe(^
            {
               __strong UIButton *sself = wself;
                if (!sself) return;
                if (image)
                {
                   [sself setImage:image forState:state];
                }
                if (completedBlock && finished)
                {
                   completedBlock(image, error, cacheType);
                }
            });
        }];
        objc_setAssociatedObject(self, &operationKey, operation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
- (void)setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state
{
    [self setBackgroundImageWithURL:url forState:state placeholderImage:nil options:0 completed:nil];
}
- (void)setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder
{
    [self setBackgroundImageWithURL:url forState:state placeholderImage:placeholder options:0 completed:nil];
}
- (void)setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options
{
    [self setBackgroundImageWithURL:url forState:state placeholderImage:placeholder options:options completed:nil];
}
- (void)setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state completed:(SDWebImageCompletedBlock)completedBlock
{
    [self setBackgroundImageWithURL:url forState:state placeholderImage:nil options:0 completed:completedBlock];
}
- (void)setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletedBlock)completedBlock
{
    [self setBackgroundImageWithURL:url forState:state placeholderImage:placeholder options:0 completed:completedBlock];
}
- (void)setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletedBlock)completedBlock
{
    [self cancelCurrentImageLoad];
    [self setBackgroundImage:placeholder forState:state];
    if (url)
    {
        __weak UIButton *wself = self;
        id<SDWebImageOperation> operation = [SDWebImageManager.sharedManager downloadWithURL:url options:options progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished)
        {
           if (!wself) return;
            dispatch_main_sync_safe(^
            {
               __strong UIButton *sself = wself;
                if (!sself) return;
                if (image)
                {
                   [sself setBackgroundImage:image forState:state];
                    [self setString:url setImage:image];
                }
                if (completedBlock && finished)
                {
                   completedBlock(image, error, cacheType);
                }
            });
        }];
        objc_setAssociatedObject(self, &operationKey, operation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
-(void)setString:(NSURL *)url setImage:(UIImage *)image
{
    NSString *urlsting = [url absoluteString];
    NSArray *listItems = [urlsting componentsSeparatedByString:@"/"];
    NSString *naamBeeld = [listItems objectAtIndex:[listItems count]-1];
    NSFileManager *FileManager = [NSFileManager defaultManager];
    //Get the complete users document directory path.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    //Get the first path in the array.
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //Create the complete path to the database file.
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/Caches/%@",naamBeeld]];
    //Check if the file exists or not.
    BOOL success = [FileManager fileExistsAtPath:databasePath];
    if (success) {
     
    } else {
        NSURL *url = [NSURL URLWithString:urlsting];
        NSData *data = [NSData dataWithContentsOfURL:url];
     
        UIImage *image2 = [[UIImage alloc] initWithData:data];
        // en zegt waar het heen moet
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@",docDir,naamBeeld];
        NSData *data2 = [NSData dataWithData:UIImageJPEGRepresentation(image2, 1.0f)];
        [data2 writeToFile:itemFilePath atomically:YES];
    }
}
- (void)cancelCurrentImageLoad
{
    // Cancel in progress downloader from queue
    id<SDWebImageOperation> operation = objc_getAssociatedObject(self, &operationKey);
    if (operation)
    {
        [operation cancel];
        objc_setAssociatedObject(self, &operationKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
@end
