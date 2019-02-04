//
//  LoadingURL.m
//  Autonet
//
//  Created by Livecast02 on 23-05-18.
//  Copyright © 2018 Autonet. All rights reserved.
//
#import "LoadingURL.h"
#import "AppDelegate.h"
#import "FileManager.h"
#import "UIFont+FlatUI.h"
#import "QRCodeReaderViewController.h"
#import "QRCodeReader.h"
#import "AppDelegate.h"
#import "JSONKit.h"
#import "SBJson.h"
#import "FileManager.h"
#import "ASIHTTPRequest.h"
#import "ASIDownloadCache.h"
#import "Reachability.h"
@implementation LoadingURL
@synthesize currentdata;
-(void)send:(NSString*)url setName:(NSString*)name
{
    NSError *e = nil;
    NSData *datanumbers = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    NSMutableDictionary *left = [NSJSONSerialization JSONObjectWithData:datanumbers options: NSJSONReadingMutableContainers error: &e];
    [self finishedLoadingdata:left setto:[NSURL URLWithString:url]];
}
- (void)finishedLoadingdata:(NSMutableDictionary*)prunedDictionary setto:(NSURL*)url {
    AppDelegate *appDelegate = [FileManager getDel];
    NSError *error;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (NSString * key in [prunedDictionary allKeys])
    {
        if (![[prunedDictionary objectForKey:key] isKindOfClass:[NSNull class]])
            [dict setObject:[prunedDictionary objectForKey:key] forKey:key];
    }
    for (int i =0; i < [[dict allKeys] count]; i++) {                   
        dispatch_async(dispatch_get_main_queue(), ^{
           AppDelegate *appDelegate = [FileManager getDel];
            [appDelegate.viewcontroller.overlay setAlpha:0.5];
            [appDelegate.viewcontroller.overlay progressChange:10*i];
            if (i ==  [[dict allKeys] count]-1)
            {
                   [appDelegate.viewcontroller.overlay setAlpha:0];
            }
        });                   
        if([[dict valueForKey:[[dict allKeys] objectAtIndex:i]] isKindOfClass:[NSArray class]]) {
           if ([[dict valueForKey:[[dict allKeys] objectAtIndex:i]] count]>0) {
               NSArray *words = [[url absoluteString] componentsSeparatedByString:@"/"];
                NSMutableArray *item =[self removenZero:[[dict valueForKey:[[dict allKeys] objectAtIndex:i]] mutableCopy]];
                if ([[words lastObject] isEqualToString:@"Voertuigen"])
                {
                   NSString *docDir = [FileManager getDir];
                    NSString *finalPath = [NSString stringWithFormat:@"%@/Caches/%@_%@",docDir, [[dict allKeys] objectAtIndex:i], [words lastObject]];
                    [item writeToFile:finalPath atomically: YES];
                    NSString *documentsDirectorybureau =  [NSString stringWithFormat:@"/Users/jeffreysnijder02/Desktop/Demo/%@_%@",[[dict allKeys] objectAtIndex:i], [words lastObject]];
                    [item writeToFile:documentsDirectorybureau atomically: YES];
                    [dict setValue:[NSString stringWithFormat:@"%@_%@",[[dict allKeys] objectAtIndex:i], [words lastObject]] forKey:[[dict allKeys] objectAtIndex:i]];
                }
                else
                {
                   NSArray *pathsCachescopy = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
                    NSString *docDir = [pathsCachescopy objectAtIndex:0]; // Get documents folder
                    NSString *dataPath = [NSString stringWithFormat:@"%@/Cachescopy/%@_%@.plist",docDir, [[dict allKeys] objectAtIndex:i], [dict valueForKey:@"VoertuigId"]];
                    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
                    {
                       NSString *docDir = [FileManager getDir];
                        NSString *finalPath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir, [[dict allKeys] objectAtIndex:i], [dict valueForKey:@"VoertuigId"]];
                        [item writeToFile:finalPath atomically: YES];
                        NSString *documentsDirectorybureau =  [NSString stringWithFormat:@"/Users/jeffreysnijder02/Desktop/Demo/%@_%@.plist",[[dict allKeys] objectAtIndex:i], [dict valueForKey:@"VoertuigId"]];
                        [item writeToFile:documentsDirectorybureau atomically: YES];
                        [dict setValue:[NSString stringWithFormat:@"%@_%@",[[dict allKeys] objectAtIndex:i], [dict valueForKey:@"VoertuigId"]] forKey:[[dict allKeys] objectAtIndex:i]];
                    }
                    else
                    {
                       NSString *finalPath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir, [[dict allKeys] objectAtIndex:i], [dict valueForKey:@"VoertuigId"]];
                        [[NSFileManager defaultManager] moveItemAtPath:dataPath toPath:finalPath error:&error];
                        [item writeToFile:finalPath atomically: YES];
                    }
                }
            }
        }
    }
    if(dict)
    {
        NSDate *now = [[NSDate alloc] init];
        if ([[dict allKeys] count]>0) {
           [dict setObject:now forKey:@"UploadDate"];
            [appDelegate.viewcontroller.Loading.TotalVoertuigen addObject:dict];
            [appDelegate.viewcontroller.Loading.UploadVoertuigen removeObject:[dict valueForKey:@"VoertuigId"]];
        }
    } else {
    }
    for (int k =0; k < [appDelegate.alleVoertuigenArrayCopy count]; k++) {
        dispatch_async(dispatch_get_main_queue(), ^{
           AppDelegate *appDelegate = [FileManager getDel];
            [appDelegate.viewcontroller.overlay setAlpha:0.5];
            [appDelegate.viewcontroller.overlay progressChange:10*k];
        });                                      
        if ([[appDelegate.viewcontroller.Loading.TotalVoertuigen valueForKey:@"VoertuigId"] containsObject:[[appDelegate.alleVoertuigenArrayCopy objectAtIndex:k] valueForKey:@"VoertuigId"]])
        {
        }
        else
        {
           if ([[[appDelegate.alleVoertuigenArrayCopy objectAtIndex:k] allKeys] count]>0) {
               [appDelegate.viewcontroller.Loading.TotalVoertuigen addObject:[appDelegate.alleVoertuigenArrayCopy objectAtIndex:k]];
                [appDelegate.viewcontroller.Loading.UploadVoertuigen removeObject:[[appDelegate.alleVoertuigenArrayCopy objectAtIndex:k] valueForKey:@"VoertuigId"]];
            }
        }
    }
    [FileManager reload];
    for (int k =0; k < [appDelegate.viewcontroller.Loading.TotalVoertuigen count]; k++) {
        [FileManager WriteOnderdelen:[[appDelegate.viewcontroller.Loading.TotalVoertuigen objectAtIndex:k] valueForKey:@"Onderdelen"]];
       [FileManager ImagesWrite:[[appDelegate.viewcontroller.Loading.TotalVoertuigen objectAtIndex:k] valueForKey:@"FotosInfo"]];
    }
    [appDelegate.viewcontroller.overlay setAlpha:0];                   
                   
}
-(NSMutableArray*)removenZero:(NSMutableArray*)sender
{
  
    for (int i =0; i < [sender count]; i++) {
        dispatch_async(dispatch_get_main_queue(), ^{
           AppDelegate *appDelegate = [FileManager getDel];
            [appDelegate.viewcontroller.overlay setAlpha:0.5];
            [appDelegate.viewcontroller.overlay progressChange:10*i];
        });                   
        NSMutableDictionary *prunedDictionary = [sender objectAtIndex:i];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        for (NSString * key in [prunedDictionary allKeys])
        {
           if (![[prunedDictionary objectForKey:key] isKindOfClass:[NSNull class]])
                [dict setObject:[prunedDictionary objectForKey:key] forKey:key];
        }
        [sender replaceObjectAtIndex:i withObject:dict];
    }
    return sender;
}
@synthesize description;
@synthesize hash;
@synthesize superclass;
@end
