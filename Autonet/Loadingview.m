    //
    //  Loadingview.m
    //  Autonet
    //
    //  Created by Livecast02 on 15-12-16.
    //  Copyright © 2016 Autonet. All rights reserved.
    //
#import "Loadingview.h"
#import "LoadingURL.h"
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
@implementation Loadingview
ASIHTTPRequest *rqstForpdf;
@synthesize TotalVoertuigen;
@synthesize progressBar;
@synthesize currentProgress;
@synthesize UploadVoertuigen;
@synthesize theConnection;
@synthesize Skip;
@synthesize scan;
@synthesize clear;
@synthesize currentdata;
@synthesize TotalVoertuigenFotos;
@synthesize TotalOnderdelenFotos;
    //Imagepicker



- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setLoadingItems];

        TotalVoertuigenFotos = [[NSMutableArray alloc] init];
        TotalOnderdelenFotos = [[NSMutableArray alloc] init];

            //Imagepicker
    }
    return self;
}
-(void)setLoadingItems
{
    TotalVoertuigen =[[NSMutableArray alloc] init];
    UploadVoertuigen =[[NSMutableArray alloc] init];
    NSString *docDir = [FileManager getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Over"];
    NSMutableArray* copyplist = [NSMutableArray arrayWithContentsOfFile:itemFilePath];////////
    if ([copyplist count]>0) {
        [UploadVoertuigen addObjectsFromArray:copyplist];
    }
    [self setBackgroundColor:[UIColor whiteColor]];
    UIImageView *logos= [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-192)/2,(self.frame.size.height-50)/2,192,50)];
    [logos setImage:[UIImage imageNamed:@"logo.png"]];
    logos.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:logos];
    NSMutableDictionary* items = [FileManager getUser];
    if (items) {
        
        clear =[[UIButton alloc]initWithFrame:CGRectMake(((self.frame.size.width-145)/2), 430, 145, 40)];
        [clear setBackgroundColor:[UIColor orangeColor]];
        [clear setTitle:@"Start" forState:UIControlStateNormal];
        [clear addTarget:self action:@selector(clearPressed:) forControlEvents:UIControlEventTouchUpInside];
        [clear.layer setCornerRadius:6];
        [clear.titleLabel setFont:[UIFont regularFlatFontOfSize:20]];
        [clear.layer setMasksToBounds:YES];
        [self addSubview:clear];
    } else {
        scan =[[UIButton alloc]initWithFrame:CGRectMake(((self.frame.size.width-145)/2), 430, 145, 40)];
        [scan setBackgroundColor:[UIColor orangeColor]];
        [scan setTitle:@"Scan" forState:UIControlStateNormal];
#if TARGET_IPHONE_SIMULATOR
        NSString * const DeviceMode = @"Simulator";
#else
        NSString * const DeviceMode = @"Device";
#endif
        if ([DeviceMode isEqualToString:@"Simulator"]) {
            [scan addTarget:self action:@selector(clearPressed:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            [scan addTarget:self action:@selector(scanAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        [scan.layer setCornerRadius:6];
        [scan.titleLabel setFont:[UIFont regularFlatFontOfSize:20]];
        [scan.layer setMasksToBounds:YES];
        [self addSubview:scan];
        clear =[[UIButton alloc]initWithFrame:CGRectMake(((self.frame.size.width-145)/2), 430, 145, 40)];
        [clear setBackgroundColor:[UIColor orangeColor]];
        [clear setTitle:@"Start" forState:UIControlStateNormal];
        [clear addTarget:self action:@selector(clearPressed:) forControlEvents:UIControlEventTouchUpInside];
        [clear.layer setCornerRadius:6];
        [clear.titleLabel setFont:[UIFont regularFlatFontOfSize:20]];
        [clear.layer setMasksToBounds:YES];
        [self addSubview:clear];
        [clear setAlpha:0];
    }
}
- (IBAction)scanAction:(id)sender
{
    AppDelegate *appDelegate = [FileManager getDel];
    if ([QRCodeReader supportsMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]]) {
        static QRCodeReaderViewController *vc = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            QRCodeReader *reader = [QRCodeReader readerWithMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
            vc                   = [QRCodeReaderViewController readerWithCancelButtonTitle:@"Cancel" codeReader:reader startScanningAtLoad:YES showSwitchCameraButton:YES showTorchButton:YES];
            vc.modalPresentationStyle = UIModalPresentationFormSheet;
        });
        vc.delegate = self;
        [vc setCompletionWithBlock:^(NSString *resultAsString) {
        }];
        [appDelegate.viewcontroller presentViewController:vc animated:YES completion:NULL];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Reader not supported by the current device" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    [FileManager voertuigenPlist:TotalVoertuigen];
}
#pragma mark - QRCodeReader Delegate Methods
- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    AppDelegate *appDelegate = [FileManager getDel];
    [reader stopScanning];
    NSMutableDictionary *dict = [result mutableObjectFromJSONString];
    NSString *docDir = [FileManager getDir];
    NSString *locatioCat = [NSString stringWithFormat:@"%@/Caches/Login.plist",docDir];
    [dict writeToFile:locatioCat atomically: YES];
    [scan setAlpha:0];
    [clear setAlpha:1];
    [appDelegate.viewcontroller dismissViewControllerAnimated:YES completion:NULL];
}
- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    AppDelegate *appDelegate = [FileManager getDel];
    [appDelegate.viewcontroller dismissViewControllerAnimated:YES completion:NULL];
}
-(void)skip:(UIButton*)sender
{
    [FileManager reload];
    [self setAlpha:0];
}
-(void)clearSkip:(UIButton*)sender
{
    [self setAlpha:0];
}
-(void)clearPressed:(UIButton*)sender
{

    AppDelegate *appDelegate = [FileManager getDel];
    [appDelegate.alleVoertuigenArrayCopy  removeAllObjects];
    [TotalVoertuigen  removeAllObjects];
    [UploadVoertuigen removeAllObjects];


    [TotalVoertuigenFotos removeAllObjects];
     [TotalOnderdelenFotos removeAllObjects];

    NSString *docDir = [FileManager getDir];
    [self setAlpha:0];
    NSMutableDictionary* items = [FileManager getUser];
    NSString *locatioCarid = [NSString stringWithFormat:@"%@/Caches/Carids.plist",docDir];
    UploadVoertuigen = [NSMutableArray arrayWithContentsOfFile:locatioCarid];
    if (UploadVoertuigen ==NULL)
    {
        UploadVoertuigen =[[NSMutableArray alloc] init];
    } else {
        [UploadVoertuigen removeAllObjects];
        [self setAlpha:0];

    }
#if TARGET_IPHONE_SIMULATOR
    NSString * const DeviceMode = @"Simulator";
#else
    NSString * const DeviceMode = @"Device";
#endif
    if ([DeviceMode isEqualToString:@"Simulator"]) {
        items =[[NSMutableDictionary alloc] init];
        [items setObject:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"user_id"] forKey:@"Id"];
        [items setObject:@"Jeffrey Test" forKey:@"Naam"];
        [items setObject:@"77.251.255.106" forKey:@"Server"];;
        [items setObject:@"123456_3" forKey:@"Id"];;
    }
        //http://<server>/api/app/tabletvoertuigen/apitmp/<TabletId>
    NSString *url = [NSString stringWithFormat: @"http://%@:8089/api/v1/app/tabletvoertuigen/%@/%@",[items valueForKey:@"Server"], [appDelegate updateUI],[items valueForKey:@"Id"]];


    NSLog(@"%@", url);

    NSError *e = nil;
    NSData *datanumbers = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    if ([datanumbers length]>0)
    {
        NSArray *left = [NSJSONSerialization JSONObjectWithData:datanumbers options: NSJSONReadingMutableContainers error: &e];
        for (int k =0; k < [left count]; k++) {
            if ([UploadVoertuigen containsObject:[left objectAtIndex:k]])
            {
            }
            else
            {
                [UploadVoertuigen addObject:[left objectAtIndex:k]];
            }
        }
        [UploadVoertuigen writeToFile:locatioCarid atomically:YES];
        if ([UploadVoertuigen count]>0) {
            if ([UploadVoertuigen count]==1) {
                appDelegate.alleVoertuigenArrayCopy = [[NSMutableArray alloc] init];
                appDelegate.alleVoertuigenArrayCopy =[[FileManager getVoertuigen] mutableCopy];
                UIAlertController * alert=   [UIAlertController
                                              alertControllerWithTitle:@"Er staat een auto klaar."
                                              message:@"Wilt u deze ophalen?"
                                              preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ophalen" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
                    appDelegate.alleVoertuigenArrayCopy = [[NSMutableArray alloc] init];
                    appDelegate.alleVoertuigenArrayCopy =[[FileManager getVoertuigen] mutableCopy];
                    [appDelegate.viewcontroller.overlay setAlpha:0.5];
                    [appDelegate.viewcontroller.overlay progressChange:201];
                    [self ophalen:items];
                }];
                [alert addAction:okAction];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                    [appDelegate.viewcontroller.overlay setAlpha:0.5];
                    [appDelegate.viewcontroller.overlay progressChange:202];
                }];
                [alert addAction:cancelAction];
                [appDelegate.viewcontroller presentViewController:alert animated:YES completion:nil];
            }
            else
            {
                UIAlertController * alert=   [UIAlertController
                                              alertControllerWithTitle:@"Er staan auto's klaar."
                                              message:@"Wilt u deze ophalen?"
                                              preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ophalen" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
                    appDelegate.alleVoertuigenArrayCopy = [[NSMutableArray alloc] init];
                    appDelegate.alleVoertuigenArrayCopy =[[FileManager getVoertuigen] mutableCopy];
                    [appDelegate.viewcontroller.overlay setAlpha:0.5];
                    [appDelegate.viewcontroller.overlay progressChange:203];
                    [self ophalen:items];
                }];
                [alert addAction:okAction];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                }];
                [alert addAction:cancelAction];
                [appDelegate.viewcontroller presentViewController:alert animated:YES completion:nil];
            }
        }
        else
        {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@"Er staat niets klaar, log in op Automate en zet een auto klaar"
                                          message:@""
                                          preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Oké" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
                [appDelegate.viewcontroller.overlay setAlpha:0];
            }];
            [alert addAction:okAction];
            [appDelegate.viewcontroller presentViewController:alert animated:YES completion:nil];
        }
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Helaas" message:@"Geen data binnen, heeft u de server aan staan?"
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert setTag:406];
        [alert show];
        [appDelegate.viewcontroller.overlay setAlpha:0];
    }
}
-(void)ophalen:(NSMutableDictionary*)items
{
    AppDelegate *appDelegate = [FileManager getDel];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat: @"http://%@:8089/api/v1/app/Voertuig/%@/%@/%@",[items valueForKey:@"Server"],[appDelegate updateUI], [items valueForKey:@"Id"],[UploadVoertuigen firstObject]]];

    NSLog(@"%@", url);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];


        [appDelegate.viewcontroller.overlay setAlpha:0.5];

      NSURLSession *session = [NSURLSession sharedSession];

        NSLog(@"%f", appDelegate.generator.period);

    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          if (error != nil) {

                                          }
                                          else if (error != nil)
                                          {

                                              dispatch_async(dispatch_get_main_queue(), ^(void) {
                                                  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Helaas" message:@"Geen connectie, heeft u de server aan staan?"
                                                                                                 delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                                                  [alert setTag:435];
                                                  [alert show];
                                                  [appDelegate.viewcontroller.overlay setAlpha:0];
                                              });
                                          }

                                          else {

                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  AppDelegate *appDelegate = [FileManager getDel];
                                                  [appDelegate.viewcontroller.overlay setAlpha:0.5];
                                                  [appDelegate.viewcontroller.overlay progressChange:[data length]/1000];



                                              });


                                              dispatch_sync(dispatch_get_main_queue(), ^{

                                                  NSString* nsJson=  [[NSString alloc] initWithData:data
                                                                                           encoding:NSUTF8StringEncoding];
                                                  nsJson =[nsJson stringByReplacingOccurrencesOfString:@"<null>" withString:@""];

                                                      NSLog(@"%@", nsJson);

                                                  NSData *webData = [nsJson dataUsingEncoding:NSUTF8StringEncoding];
                                                  NSMutableDictionary *left = [NSJSONSerialization JSONObjectWithData:webData options: NSJSONReadingMutableContainers error:NULL];


                                                  [self.TotalVoertuigenFotos addObjectsFromArray:[left valueForKey:@"FotosInfo"]];
                                                  [self finishedLoadingData:left setTo:[NSURL URLWithString:[url absoluteString]]];

                                              });

                                          }
                                          
                                      }];
    [dataTask resume];




}                   
- (void)finishedLoadingData:(NSMutableDictionary*)prunedDictionary setTo:(NSURL*)url {

    NSError *error = nil;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];

    //NSLog(@"%@", url);

    for (NSString * key in [prunedDictionary allKeys])
    {
        if (![[prunedDictionary objectForKey:key] isKindOfClass:[NSNull class]])
            [dict setObject:[prunedDictionary objectForKey:key] forKey:key];
    }
    for (int i =0; i < [[dict allKeys] count]; i++) {

        if([[dict valueForKey:[[dict allKeys] objectAtIndex:i]] isKindOfClass:[NSArray class]]) {

            
            if ([[dict valueForKey:[[dict allKeys] objectAtIndex:i]] count]>0) {

                if ([[[dict valueForKey:[[dict allKeys] objectAtIndex:i]] firstObject] isKindOfClass:[NSDictionary class]]) {

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

                       //////////NSLog(@"1");

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
                           //////////NSLog(@"3");

                            NSString *finalPath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir, [[dict allKeys] objectAtIndex:i], [dict valueForKey:@"VoertuigId"]];
                            [[NSFileManager defaultManager] moveItemAtPath:dataPath toPath:finalPath error:&error];
                            [item writeToFile:finalPath atomically: YES];
                        }
                    }

                }
                else

                {


                }
            }

            //NSLog(@"%@", [prunedDictionary valueForKey:@"FotosInfo"]);

            dispatch_async(dispatch_get_main_queue(), ^{
                AppDelegate *appDelegate = [FileManager getDel];
                [appDelegate.viewcontroller.overlay setAlpha:0.5];
                [appDelegate.viewcontroller.overlay progressChange:10*i];


            });
        }
    }

    if(dict)
    {
        NSDate *now = [[NSDate alloc] init];
        if ([[dict allKeys] count]>0) {
            [dict setObject:now forKey:@"UploadDate"];
            [TotalVoertuigen addObject:dict];
            [FileManager WriteOnderdelen:[NSString stringWithFormat:@"Onderdelen_%@", [dict valueForKey:@"VoertuigId"]]];
            [UploadVoertuigen removeObject:[dict valueForKey:@"VoertuigId"]];
        }
    } else {
    }

    sleep(4);

       [self lastMove];

}

-(void)lastMove
{

    NSLog(@"lastMove");

    AppDelegate *appDelegate = [FileManager getDel];

    if ([UploadVoertuigen count] == 0)
    {

        double delayInSeconds = 0.6;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){




            if ([self.TotalVoertuigenFotos count]>0) {


                UIAlertController * alert=   [UIAlertController
                                              alertControllerWithTitle:@"Er zijn afbeeldingen voor beschikbaar."
                                              message:@"Wilt u deze ophalen?"
                                              preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ophalen" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){

                    [appDelegate.viewcontroller.overlay setAlpha:0.5];




                    [FileManager WriteImages:self.TotalVoertuigenFotos];


                }];
                [alert addAction:okAction];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                    [appDelegate.viewcontroller.overlay setAlpha:0];


                    [FileManager WriteImagesThumbs:self.TotalVoertuigenFotos];


                }];
                [alert addAction:cancelAction];
                [appDelegate.viewcontroller presentViewController:alert animated:YES completion:nil];

            }
            else
            {

                [appDelegate.viewcontroller.overlay setAlpha:0];

            }

        });

    }

    for (int k =0; k < [appDelegate.alleVoertuigenArrayCopy count]; k++) {

        if ([[TotalVoertuigen valueForKey:@"VoertuigId"] containsObject:[[appDelegate.alleVoertuigenArrayCopy objectAtIndex:k] valueForKey:@"VoertuigId"]])
        {
        }
        else
        {
            if ([[[appDelegate.alleVoertuigenArrayCopy objectAtIndex:k] allKeys] count]>0) {
                [TotalVoertuigen addObject:[appDelegate.alleVoertuigenArrayCopy objectAtIndex:k]];
                [UploadVoertuigen removeObject:[[appDelegate.alleVoertuigenArrayCopy objectAtIndex:k] valueForKey:@"VoertuigId"]];
            }
        }
    }
    NSString *docDir = [FileManager getDir];
    if ([TotalVoertuigen count]>0) {
        NSString *plistPath = [docDir
                               stringByAppendingPathComponent:[NSString stringWithFormat:@"/Caches/%@.plist", @"Voertuigen"]];
        [TotalVoertuigen writeToFile:plistPath atomically: YES];
        NSString *documentsDirectorybureau =  [NSString stringWithFormat:@"/Users/jeffreysnijder02/Desktop/Demo/Voertuigen.plist"];
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"UploadDate" ascending:FALSE];
        [TotalVoertuigen sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        [TotalVoertuigen writeToFile:documentsDirectorybureau atomically: YES];
    }
    [FileManager reload];
    [self setAlpha:0];


    if ([UploadVoertuigen count]>0) {
        NSString *docDir = [FileManager getDir];
        [self setAlpha:0];
        NSString *locatioCarid = [NSString stringWithFormat:@"%@/Caches/Carids.plist",docDir];
        [UploadVoertuigen writeToFile:locatioCarid atomically: YES];
        NSMutableDictionary* items = [FileManager getUser];
        [self ophalen:items];
    } else {
        NSString *docDir = [FileManager getDir];
        [self setAlpha:0];
        NSString *locatioCarid = [NSString stringWithFormat:@"%@/Caches/Carids.plist",docDir];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:locatioCarid error:NULL];
            //[UploadVoertuigen writeToFile:locatioCarid atomically: YES];
    }

    double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        AppDelegate *appDelegate = [FileManager getDel];
        appDelegate.alleVoertuigenArray =[[NSMutableArray alloc] initWithArray:[FileManager getArray:@"Voertuigen"]];
        [appDelegate.viewcontroller.navigaionView.collectionViewNav reloadData];
        [appDelegate.viewcontroller.menu.ListVoertuigen.tableResult reloadData];
    });
    

}
-(NSMutableArray*)removenZero:(NSMutableArray*)sender
{
        //////////NSLog(@"%@", sender);
    for (int i =0; i < [sender count]; i++) {
        dispatch_async(dispatch_get_main_queue(), ^{
            AppDelegate *appDelegate = [FileManager getDel];
            [appDelegate.viewcontroller.overlay setAlpha:0.5];
            [appDelegate.viewcontroller.overlay progressChange:10*i];


            double delayInSeconds = 10*i;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){

                [appDelegate.viewcontroller.overlay setAlpha:0];

            });

            if (i ==  [sender count]-1)
            {

                     [appDelegate.viewcontroller.overlay setAlpha:0];

            }
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
@end
