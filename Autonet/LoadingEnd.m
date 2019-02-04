    //
    //  Loadingview.m
    //  Autonet
    //
    //  Created by Livecast02 on 15-12-16.
    //  Copyright © 2016 Autonet. All rights reserved.
    //
#import "LoadingEnd.h"
#import "UIFont+FlatUI.h"
#import "QRCodeReaderViewController.h"
#import "QRCodeReader.h"
#import "AppDelegate.h"
#import "JSONKit.h"
#import "SBJson.h"
#import "FileManager.h"
#import "NSData+Base64.h"
@implementation LoadingEnd
@synthesize TotalVoertuigen;
@synthesize responseData;
@synthesize theConnection;
@synthesize tableupload;
@synthesize overlay;
@synthesize indexit;
@synthesize RemovPlistArray;
@synthesize RemovPartFotosArray;
@synthesize RemovCarFotosArray;

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setAlpha:0];
        [self setLoadingItems];
        [self.layer setCornerRadius:6];
        self.layer.shadowOffset = CGSizeMake(0.5, 0);
        self.layer.shadowOpacity = 0.5;
        self.transform = CGAffineTransformMakeScale(0.5, 0.5);
        
        RemovPlistArray = [[NSMutableArray alloc] init];
        RemovPartFotosArray = [[NSMutableArray alloc] init];
        RemovCarFotosArray = [[NSMutableArray alloc] init];
        
    }
    return self;
}


-(void)setLoadingItems
{
    UIButton *note =[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-50,10, 40, 40)];
    [note setImage:[UIImage imageNamed:@"gone.png"] forState:UIControlStateNormal];
    [note addTarget:self action:@selector(select) forControlEvents:UIControlEventTouchUpInside];
    [note.layer setCornerRadius:4];
    [self addSubview:note];
    
    TotalVoertuigen =[[FileManager getVoertuigen] mutableCopy];
    tableupload =[[UITableView alloc] initWithFrame:CGRectMake((self.frame.size.width-600)/2, 40, 600,self.frame.size.height-40)];
    [tableupload setRowHeight:40];
    [tableupload setAlwaysBounceHorizontal:NO];
    [tableupload setDelegate:self];
    [tableupload setDataSource:self];
    [self addSubview:tableupload];
    
    overlay =[[UIView alloc]initWithFrame:CGRectMake(0,0, self.frame.size.width, self.frame.size.height)];
    [overlay setBackgroundColor:[UIColor grayColor]];
    [overlay setAlpha:0];
    [self addSubview:overlay];
    
    UIActivityIndicatorView *indictor =[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0,0, 60, 60)];
    [indictor setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [overlay addSubview:indictor];
    [indictor setCenter:overlay.center];
    [indictor startAnimating];
}
-(void)select
{
    AppDelegate *appDelegate = [FileManager getDel];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.4f];
    appDelegate.viewcontroller.Loadingend.transform = CGAffineTransformMakeScale(0.5, 0.5);
    [appDelegate.viewcontroller.Loadingend setAlpha:0];
    [appDelegate.viewcontroller overlayAction];
    [UIView commitAnimations];
}
-(void)upload:(UIButton*)sender
{
    [sender setBackgroundColor:[UIColor grayColor]];
    NSMutableDictionary *dictuploadid =[TotalVoertuigen objectAtIndex:sender.tag-1008];
    
    
    [RemovPlistArray removeAllObjects];
    [RemovCarFotosArray removeAllObjects];
    [RemovPartFotosArray removeAllObjects];
    
    indexit = [[TotalVoertuigen firstObject] valueForKey:@"VoertuigId"];
    
    NSArray *plistItems =[NSArray arrayWithObjects:@"FotosInfo",@"Onderdelen",@"Schades", @"Velden",@"Opties", @"Gorderspanners", @"Airbags", @"Data", @"Locatie", nil];
    for (int i =0; i < [plistItems count]; i++) {
        NSString *docDir = [FileManager getDir];
        
        if ([[plistItems objectAtIndex:i] isEqualToString:@"Onderdelen"]) {
            
            NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir, [plistItems objectAtIndex:i], [dictuploadid valueForKey:@"VoertuigId"]];
            BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:itemFilePath];
            if (fileExists) {
                NSMutableArray* copyplist = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
                [dictuploadid setObject:copyplist forKey:[plistItems objectAtIndex:i]];
            }
            else
            {
            }
            
        }
        else
        {
            NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir, [plistItems objectAtIndex:i], [dictuploadid valueForKey:@"VoertuigId"]];
            [self.RemovPlistArray addObject:itemFilePath];
            BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:itemFilePath];
            if (fileExists) {
                NSMutableArray* copyplist = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
                [dictuploadid setObject:copyplist forKey:[plistItems objectAtIndex:i]];
            }
            else
            {
            }
            
        }
        
    }
    
    if ([dictuploadid valueForKey:@"InkoopDatumTijd"]) {
        [dictuploadid setObject:[NSString stringWithFormat:@"%@", [dictuploadid valueForKey:@"InkoopDatumTijd"]] forKey:@"InkoopDatumTijd"];
    } else {
        [dictuploadid setObject:@"" forKey:@"InkoopDatumTijd"];
    }
    if ([dictuploadid valueForKey:@"ARNTag"]) {
        [dictuploadid setObject:[NSString stringWithFormat:@"%@", [dictuploadid valueForKey:@"ARNTag"]] forKey:@"ARNTag"];
    } else {
        [dictuploadid setObject:@"" forKey:@"ARNTag"];
    }
    if ([dictuploadid valueForKey:@"UploadDate"]) {
        [dictuploadid setObject:[NSString stringWithFormat:@"%@", [dictuploadid valueForKey:@"UploadDate"]] forKey:@"UploadDate"];
    } else {
        [dictuploadid setObject:@"" forKey:@"UploadDate"];
    }
    
    NSArray *onoLennon =[NSArray arrayWithObjects:@"OnderdeelId", @"DeelId", @"AannamelijstOnderdeelId", @"Aanwezig", @"Demonteren", @"internetOol", @"Aanauto", @"isVerkocht", @"isVermist", @"isOrder",@"isPrullenbak",  @"isAanAuto", @"isInVoorraad", nil];
    NSArray *check =[NSArray arrayWithObjects:@"nummer", @"nummer", @"string", @"bool", @"bool", @"bool",@"bool", @"bool", @"bool", @"bool", @"bool", @"bool", @"bool", @"bool", nil];
    NSMutableArray *OnderdelenArray = [[NSMutableArray alloc] init];
    
    if ([[dictuploadid valueForKey:@"Onderdelen"] isKindOfClass:[NSArray class]]) {
        
    } else {
        [dictuploadid setObject:[[NSMutableArray alloc] init] forKey:@"Onderdelen"];
    }
    
    NSMutableArray *FotosInfoCar = [dictuploadid  valueForKey:@"FotosInfo"];
    
    NSString *docDir = [FileManager getDir];
    
    
    for (int t =0; t < [FotosInfoCar count]; t++) {
        
        
        if ([[[FotosInfoCar objectAtIndex:t] allKeys] containsObject:@"InAutomate"])
        {
            
        }
        else
        {
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSString *FotosInfo = [[FotosInfoCar objectAtIndex:t] valueForKey:@"Orgnaam"];
            NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@",docDir,FotosInfo];
            NSString *itemFilePaththumb = [NSString stringWithFormat:@"%@/Caches/thumb_%@",docDir,FotosInfo];
            [fileManager removeItemAtPath:itemFilePaththumb error:NULL];
            [fileManager removeItemAtPath:itemFilePath error:NULL];
            
        }
        
    }
    
    
    NSString *queryit = [NSString stringWithFormat:@"(isInVoorraad == %@) OR (isVerkocht == %@) OR (isPrullenbak == %@) OR (isVermist == %@)", [NSNumber numberWithBool:YES], [NSNumber numberWithBool:YES], [NSNumber numberWithBool:YES], [NSNumber numberWithBool:YES]];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *letit = [[[dictuploadid valueForKey:@"Onderdelen"] filteredArrayUsingPredicate:predicateit] mutableCopy];
    
    
    for (int k =0; k < [letit count]; k++) {
        
        
        NSMutableDictionary *onderdeel = [letit objectAtIndex:k];
        
        for (int t =0; t < [[onderdeel  valueForKey:@"FotosInfo"] count]; t++) {
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSString *FotosInfo = [[[onderdeel  valueForKey:@"FotosInfo"] objectAtIndex:t] valueForKey:@"Orgnaam"];
            NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@",docDir,FotosInfo];
            NSString *itemFilePaththumb = [NSString stringWithFormat:@"%@/Caches/thumb_%@",docDir,FotosInfo];
            [fileManager removeItemAtPath:itemFilePaththumb error:NULL];
            [fileManager removeItemAtPath:itemFilePath error:NULL];
        }
        
    }
    
    
    for (int k =0; k < [[dictuploadid valueForKey:@"Onderdelen"] count]; k++) {
        
        NSMutableDictionary *inserChange =[[NSMutableDictionary alloc] init];
        for (int i =0; i < [onoLennon count]; i++) {
            
            if ([[[[dictuploadid valueForKey:@"Onderdelen"] objectAtIndex:k] allKeys] containsObject:[onoLennon objectAtIndex:i]]) {
                if ([[check objectAtIndex:i] isEqualToString:@"nummer"]) {
                    
                    
                    [inserChange setObject:[NSNumber numberWithInt:[[[[dictuploadid valueForKey:@"Onderdelen"] objectAtIndex:k]  valueForKey:[onoLennon objectAtIndex:i]] intValue]] forKey:[onoLennon objectAtIndex:i]];
                }
                else if ([[check objectAtIndex:i] isEqualToString:@"string"]) {
                    [inserChange setObject:[[[dictuploadid valueForKey:@"Onderdelen"] objectAtIndex:k]  valueForKey:[onoLennon objectAtIndex:i]] forKey:[[onoLennon objectAtIndex:i] stringByReplacingOccurrencesOfString:@"internetOol" withString:@"Internet"]];
                }
                else if ([[check objectAtIndex:i] isEqualToString:@"bool"]) {
                    [inserChange setObject:[NSNumber numberWithBool:[[[[dictuploadid valueForKey:@"Onderdelen"] objectAtIndex:k]  valueForKey:[onoLennon objectAtIndex:i]] intValue]] forKey:[onoLennon objectAtIndex:i]];
                }
                else
                {
                    [inserChange setObject:[NSNumber numberWithInt:[[[[dictuploadid valueForKey:@"Onderdelen"] objectAtIndex:k]  valueForKey:[onoLennon objectAtIndex:i]] intValue]] forKey:[onoLennon objectAtIndex:i]];
                }
            }
            else
            {
                if ([[check objectAtIndex:i] isEqualToString:@"nummer"]) {
                    [inserChange setObject:@"" forKey:[onoLennon objectAtIndex:i]];
                }
                else if ([[check objectAtIndex:i] isEqualToString:@"string"]) {
                    if ([[onoLennon objectAtIndex:i] isEqualToString:@"AannamelijstOnderdeelId"]) {
                        
                        [inserChange setObject:[[NSUUID UUID] UUIDString] forKey:[onoLennon objectAtIndex:i]];
                    }
                    else{
                        [inserChange setObject:@"" forKey:[onoLennon objectAtIndex:i]];
                    }
                    
                }
                else if ([[check objectAtIndex:i] isEqualToString:@"bool"]) {
                    [inserChange setObject:[NSNumber numberWithBool:NO] forKey:[onoLennon objectAtIndex:i]];
                }
            }
        }
        
        
        
        [OnderdelenArray addObject:inserChange];
        
    }
    
    
    
    [dictuploadid setObject:OnderdelenArray forKey:@"Onderdelen"];
    
    
    
    [self uploadVoertuig:dictuploadid];
    [self performSelector:@selector(changeButton:) withObject:sender afterDelay:0.3];
    
    
}

-(void)uploadVoertuig:(NSMutableDictionary*)dictuploadid
{
    
    AppDelegate *appDelegate = [FileManager getDel];
    NSMutableDictionary* items = [FileManager getUser];
    
    
    
    NSDateFormatter *formattertoString2 = [[NSDateFormatter alloc] init];
    [formattertoString2 setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"nl_NL"]];
    [formattertoString2 setDateFormat:@"dd-MM-yyyy"];
    
    NSDateFormatter *formattertoString = [[NSDateFormatter alloc] init];
    [formattertoString setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"nl_NL"]];
    [formattertoString setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    
    
    
    if ([[dictuploadid valueForKey:@"Verzekerd"] rangeOfString:@"T"].location == NSNotFound) {
        
        
        NSDate *copy = [formattertoString2 dateFromString:[dictuploadid valueForKey:@"Verzekerd"]];
        [dictuploadid setValue:[formattertoString stringFromDate:copy] forKey:@"Verzekerd"];
        
    } else {
        
        
        [dictuploadid setValue:[dictuploadid valueForKey:@"Verzekerd"]  forKey:@"Verzekerd"];
    }
    
    
    
    if ([[dictuploadid valueForKey:@"APKTotDatum"] rangeOfString:@"T"].location == NSNotFound) {
        
        
        NSDate *copy = [formattertoString2 dateFromString:[dictuploadid valueForKey:@"APKTotDatum"]];
        [dictuploadid setValue:[formattertoString stringFromDate:copy] forKey:@"APKTotDatum"];
        
    } else {
        
        
        [dictuploadid setValue:[dictuploadid valueForKey:@"APKTotDatum"]  forKey:@"APKTotDatum"];
    }
    
    NSLog(@"APKTotDatum %@", [dictuploadid  valueForKey:@"Verzekerd"]);
    
    NSLog(@"APKTotDatum %@", [dictuploadid  valueForKey:@"APKTotDatum"]);
    
    
    
    for (int k =0; k < [[dictuploadid allKeys] count]; k++) {
        
        
        if ([[[dictuploadid allKeys] objectAtIndex:k] isEqualToString:@"VraagPrijs"]||[[[dictuploadid allKeys] objectAtIndex:k] isEqualToString:@"InternetPrijs"]||[[[dictuploadid allKeys] objectAtIndex:k] isEqualToString:@"InternetPrijsExport"]|[[[dictuploadid allKeys] objectAtIndex:k] isEqualToString:@"BPMBasis"]) {
            
            
            if ([[dictuploadid valueForKey:[[dictuploadid allKeys] objectAtIndex:k]] integerValue]>0) {
                
                
                NSLog(@"%@", [dictuploadid valueForKey:[[dictuploadid allKeys] objectAtIndex:k]]);
                
                [dictuploadid setObject:[dictuploadid valueForKey:[[dictuploadid allKeys] objectAtIndex:k]] forKey:[[dictuploadid allKeys] objectAtIndex:k]];
                
            }
            
        }
        
        
    }
    
    
    
    NSData *datacar = [NSJSONSerialization dataWithJSONObject:dictuploadid
                                                      options:NSJSONWritingPrettyPrinted error:NULL];
    NSString *urlstring = [NSString stringWithFormat: @"http://%@:8089/api/v1/app/Voertuig/%@/%@/%@",[items valueForKey:@"Server"],[appDelegate updateUI], [items valueForKey:@"Id"],[dictuploadid  valueForKey:@"VoertuigId"]];
    NSURL *url = [NSURL URLWithString:urlstring];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[datacar length]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:datacar];
    [overlay setAlpha:0.5];
    
    NSLog(@"%@", dictuploadid);
    
    
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         
         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
         NSLog(@"%ld", (long)[httpResponse statusCode]);
         
         if ([[NSString stringWithFormat:@"%ld", (long)[httpResponse statusCode]] isEqualToString:@"500"]||[[NSString stringWithFormat:@"%ld", (long)[httpResponse statusCode]] isEqualToString:@"400"]) {
             
             NSLog(@"response %@", httpResponse);
             
             NSLog(@"response %@", response);
             
             dispatch_async(dispatch_get_main_queue(), ^(void) {
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Helaas" message:[NSString stringWithFormat:@"Error %ld", (long)[httpResponse statusCode]]
                                                                delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                 [alert setTag:435];
                 [alert show];
                 [appDelegate.viewcontroller.overlay setAlpha:0];
             });
             
         }
         else
         {
             
             if ([data length] > 0){
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     if ([[dictuploadid valueForKey:@"FotosInfo"] isKindOfClass:[NSString class]]) {
                     }
                     else{
                         [self sendFotosAuto:[dictuploadid valueForKey:@"FotosInfo"] withID:[dictuploadid  valueForKey:@"VoertuigId"]];
                         
                         
                         
                         NSString *docDir = [FileManager getDir];
                         NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"Onderdelen", [dictuploadid valueForKey:@"VoertuigId"]];
                         NSMutableArray* copyplist = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
                         
                         NSString *queryit = [NSString stringWithFormat:@"(isInVoorraad == %@) and (isVerkocht == %@) and (isPrullenbak == %@) and (isVermist == %@)", [NSNumber numberWithBool:NO], [NSNumber numberWithBool:NO], [NSNumber numberWithBool:NO], [NSNumber numberWithBool:NO]];
                         NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
                         NSMutableArray *letit = [[copyplist filteredArrayUsingPredicate:predicateit] mutableCopy];
                         
                         for (int i =0; i < [letit count]; i++) {
                             
                             [self send:[letit objectAtIndex:i] withID:[dictuploadid  valueForKey:@"VoertuigId"] Onderdelen:copyplist];
                         };
                         
                     }
                     
                     
                     
                     NSString *docDir = [FileManager getDir];
                     NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/Voertuigen.plist",docDir];
                     NSString *queryit = [NSString stringWithFormat:@"VoertuigId = %@", [dictuploadid  valueForKey:@"VoertuigId"]];
                     NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
                     NSMutableArray *remove = [[appDelegate.alleVoertuigenArray filteredArrayUsingPredicate:predicateit] mutableCopy];
                     
                     if ([appDelegate.alleVoertuigenArray count]>0) {
                             ////NSLog(@"remove %@", [[remove firstObject] valueForKey:@"VoertuigId"]);
                         NSInteger index = [appDelegate.alleVoertuigenArray indexOfObject:[remove firstObject]];
                         [appDelegate.alleVoertuigenArray removeObjectAtIndex:index];
                         [appDelegate.alleVoertuigenArray writeToFile:itemFilePath atomically: YES];
                     }
                     
                     for (int i =0; i < [self.RemovPlistArray count]; i++) {
                         
                         NSFileManager *fileManager = [NSFileManager defaultManager];
                         [fileManager removeItemAtPath:[self.RemovPlistArray objectAtIndex:i] error:NULL];
                         
                     }
                     
                     NSString *itemFilePath2 = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"Onderdelen", [dictuploadid valueForKey:@"VoertuigId"]];
                     NSFileManager *fileManager = [NSFileManager defaultManager];
                     [fileManager removeItemAtPath:itemFilePath2 error:NULL];
                     
                     
                     NSMutableArray *remove2 = [[self.TotalVoertuigen filteredArrayUsingPredicate:predicateit] mutableCopy];
                     
                     if ([self.TotalVoertuigen count]>0) {
                             ////NSLog(@"remove %@", [[remove2 firstObject] valueForKey:@"VoertuigId"]);
                         NSInteger index = [self.TotalVoertuigen indexOfObject:[remove2 firstObject]];
                         [self.TotalVoertuigen removeObjectAtIndex:index];
                     }
                     
                         ////NSLog(@"TotalVoertuigen %@", [self.TotalVoertuigen valueForKey:@"VoertuigId"]);
                     
                     
                     
                     [self.tableupload reloadData];
                     AppDelegate *appDelegate = [FileManager getDel];
                     [appDelegate.viewcontroller.navigaionView.collectionViewNav reloadData];
                     [appDelegate.viewcontroller.menu.ListVoertuigen.tableResult reloadData];
                     
                     if ([appDelegate.alleVoertuigenArray count]) {
                         [appDelegate.viewcontroller.navigaionView setAlpha:1];
                             //[appDelegate.viewcontroller.Loadingend setAlpha:0];
                         [appDelegate.viewcontroller.Loadingend.tableupload reloadData];
                         
                     }
                     else
                     {
                         [appDelegate.viewcontroller.navigaionView setAlpha:1];
                         [appDelegate.viewcontroller.Loading setAlpha:1];
                         [appDelegate.viewcontroller.Loadingend setAlpha:0];
                         [appDelegate.viewcontroller.Loadingend.tableupload reloadData];
                     }
                     [appDelegate.viewcontroller.overlay setAlpha:0];
                     [appDelegate.viewcontroller overlayAction];
                     [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
                     [self.overlay setAlpha:0];
                     
                     
                 });
                 
             }
             else if ([data length] == 0 && error == nil){
                 
                 dispatch_async(dispatch_get_main_queue(), ^(void) {
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Helaas" message:@"Er is iets mis gegaan!"
                                                                    delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                     [alert setTag:435];
                     [alert show];
                     [appDelegate.viewcontroller.overlay setAlpha:0];
                 });
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
             
         }
         
     }];
    
}
-(void)changeButton:(UIButton*)sender
{
    [sender setBackgroundColor:[UIColor orangeColor]];
    [overlay setAlpha:0];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag ==435) {
    } else {
        if (buttonIndex ==0) {
            [self setAlpha:0];
        }
        else
        {
            
        }
    }
}
-(void)FotoRequest:(NSString*)name
{
    /*
     NSString *docDir = [FileManager docDir];
     NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,name];
     NSMutableArray* list = [[NSMutableArray arrayWithContentsOfFile:itemFilePath] mutableCopy];
     */// [self sendFotos:list];
}
-(void)sendFotosAuto:(NSMutableArray*)list withID:(NSString*)autoid
{
        ////NSLog(@"sendFotosAuto %@", list);
    
    if (list)
    {
        AppDelegate *appDelegate = [FileManager getDel];
        NSMutableDictionary* items = [FileManager getUser];
        NSString *docDir = [FileManager getDir];
        for (int i =0; i < [list count]; i++) {
            if ([[[list objectAtIndex:i] allKeys] containsObject:@"InAutomate"])
            {
                NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@",docDir,[[list valueForKey:@"Orgnaam"] objectAtIndex:i]];
                    //NSString *itemFilePaththumb = [NSString stringWithFormat:@"%@/Caches/thumb_%@",docDir,[[list valueForKey:@"Orgnaam"] objectAtIndex:i]];
                UIImage *currentimage =[UIImage imageWithContentsOfFile:itemFilePath];
                NSString *fotoString = [self imageToNSString:currentimage];
                NSData* data = [fotoString dataUsingEncoding:NSUTF8StringEncoding];
                
                NSString *urlstring = @"";
                
                if ([[[list objectAtIndex:i] valueForKey:@"Internet"] boolValue]) {
                    
                    urlstring = [NSString stringWithFormat: @"http://%@:8089/api/v1/app/Foto/%@/%@/%@/V%@/1",[items valueForKey:@"Server"],[appDelegate updateUI],[items valueForKey:@"Id"],[[list objectAtIndex:i] valueForKey:@"Orgnaam"],autoid];
                    
                }
                else
                {
                    
                    urlstring = [NSString stringWithFormat: @"http://%@:8089/api/v1/app/Foto/%@/%@/%@/V%@/0",[items valueForKey:@"Server"],[appDelegate updateUI],[items valueForKey:@"Id"],[[list objectAtIndex:i] valueForKey:@"Orgnaam"],autoid];
                    
                }
                NSURL *url = [NSURL URLWithString:urlstring];
                NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[data length]];
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
                [request setHTTPMethod:@"POST"];
                [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
                [request setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
                [request setHTTPBody:data];
                [overlay setAlpha:0.5];
                NSOperationQueue *queue = [[NSOperationQueue alloc] init];
                [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
                 {
                     
                     
                     if ([data length] > 0 && error == nil){
                         
                     }
                     else if ([data length] == 0 && error == nil){
                     }
                     else if (error != nil)
                     {
                     }
                     
                     dispatch_async(dispatch_get_main_queue(), ^{
                         
                         
                         
                         NSArray *myArray = [[response.URL absoluteString] componentsSeparatedByString:@"/"];
                         
                             ////NSLog(@"%@", myArray);
                             ////NSLog(@"%@", [myArray objectAtIndex:9]);
                         
                         [self.tableupload reloadData];
                         [self.overlay setAlpha:0];
                         
                         NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@",docDir,[myArray objectAtIndex:9]];
                         NSString *itemFilePaththumb = [NSString stringWithFormat:@"%@/Caches/thumb_%@",docDir,[myArray objectAtIndex:9]];
                         
                         NSFileManager *fileManager = [NSFileManager defaultManager];
                         [fileManager removeItemAtPath:itemFilePaththumb error:NULL];
                         [fileManager removeItemAtPath:itemFilePath error:NULL];
                         
                             ////NSLog(@"remove %@", itemFilePaththumb);
                             ////NSLog(@"remove %@", itemFilePath);
                         
                     });
                     
                     
                 }];
            }
            else
            {
                
                
                
            }
        }
    }
}
-(void)sendFotosOnderdelen:(NSMutableArray*)list withID:(NSString*)onderdeelID
{
    
    
    NSLog(@"sendFotosOnderdelen %@", list);
    
    if (list)
    {
        AppDelegate *appDelegate = [FileManager getDel];
        NSMutableDictionary* items = [FileManager getUser];
        NSString *docDir = [FileManager getDir];
        for (int i =0; i < [list count]; i++) {
            if ([[[list objectAtIndex:i] allKeys] containsObject:@"InAutomate"])
            {
                NSString *Path = [NSString stringWithFormat:@"%@/Caches/%@",docDir,[[list valueForKey:@"Orgnaam"] objectAtIndex:i]];
                UIImage *currentimage =[UIImage imageWithContentsOfFile:Path];
                NSString *fotoString = [self imageToNSString:currentimage];
                
                NSData* data = [fotoString dataUsingEncoding:NSUTF8StringEncoding];
                NSString *urlstring = @"";
                
                if ([[[list objectAtIndex:i] valueForKey:@"Internet"] boolValue]) {
                    
                    urlstring = [NSString stringWithFormat: @"http://%@:8089/api/v1/app/Foto/%@/%@/%@/%@/1",[items valueForKey:@"Server"],[appDelegate updateUI],[items valueForKey:@"Id"],[[list objectAtIndex:i] valueForKey:@"Orgnaam"],onderdeelID];
                }
                else
                {
                    urlstring = [NSString stringWithFormat: @"http://%@:8089/api/v1/app/Foto/%@/%@/%@/%@/0",[items valueForKey:@"Server"],[appDelegate updateUI],[items valueForKey:@"Id"],[[list objectAtIndex:i] valueForKey:@"Orgnaam"],onderdeelID];
                    
                }
                NSURL *url = [NSURL URLWithString:urlstring];
                NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[data length]];
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
                [request setHTTPMethod:@"POST"];
                [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
                [request setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
                [request setHTTPBody:data];
                [overlay setAlpha:0.5];
                NSOperationQueue *queue = [[NSOperationQueue alloc] init];
                [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
                 {
                     if ([data length] > 0 && error == nil){
                         
                     }
                     else if ([data length] == 0 && error == nil){
                     }
                     else if (error != nil)
                     {
                     }
                     
                     
                     dispatch_async(dispatch_get_main_queue(), ^{
                         
                         
                         NSArray *myArray = [[response.URL absoluteString] componentsSeparatedByString:@"/"];
                         
                         
                         [self.tableupload reloadData];
                         [self.overlay setAlpha:0];
                         
                         NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@",docDir,[myArray objectAtIndex:9]];
                         NSString *itemFilePaththumb = [NSString stringWithFormat:@"%@/Caches/thumb_%@",docDir,[myArray objectAtIndex:9]];
                         
                         NSFileManager *fileManager = [NSFileManager defaultManager];
                         [fileManager removeItemAtPath:itemFilePaththumb error:NULL];
                         [fileManager removeItemAtPath:itemFilePath error:NULL];
                         
                         
                         
                         
                     });
                     
                     
                 }];
            }
            else
            {
                
            }
        }
    }
}
- (NSString *)imageToNSString:(UIImage *)image
{
    NSData *data = UIImagePNGRepresentation(image);
    return [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}
-(void) removeCarfiles:(NSString*)Carid
{
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *directory = [documentsDirectory stringByAppendingPathComponent:@"Caches/"];
    NSError *error = nil;
    for (NSString *file in [fm contentsOfDirectoryAtPath:directory error:&error]) {
        if ([file rangeOfString:[NSString stringWithFormat:@"%@", Carid]].location == NSNotFound) {
        }
        else
        {
            NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@",documentsDirectory,file];
            [self.RemovPlistArray addObject:itemFilePath];
        }
    }
}

-(void)send:(NSMutableDictionary*)datasend withID:(NSString*)carid Onderdelen:(NSMutableArray*)ids
{
    
    
    
    NSString *queryit = [NSString stringWithFormat:@"AannamelijstOnderdeelId LIKE [cd]'%@'", [datasend valueForKey:@"AannamelijstOnderdeelId"]];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *letit = [[ids filteredArrayUsingPredicate:predicateit] mutableCopy];
    
    [datasend setObject:[[letit firstObject] valueForKey:@"AannamelijstOnderdeelId"] forKey:@"AannamelijstOnderdeelId"];
    [datasend setObject:carid forKey:@"VoertuigId"];
    
    
    
    
    NSData *dataonderdelen = [NSJSONSerialization dataWithJSONObject:datasend
                                                             options:NSJSONWritingPrettyPrinted error:NULL];
    AppDelegate *appDelegate = [FileManager getDel];
    NSMutableDictionary* items = [FileManager getUser];
    NSString *urlstring = [NSString stringWithFormat: @"http://%@:8089/api/v1/app/Onderdeel/%@/%@/%@",[items valueForKey:@"Server"],[appDelegate updateUI], [items valueForKey:@"Id"],[datasend valueForKey:@"AannamelijstOnderdeelId"]];
    NSURL *url = [NSURL URLWithString:urlstring];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[dataonderdelen length]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:dataonderdelen];
    [overlay setAlpha:0.5];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if ([data length] > 0 && error == nil){
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self.tableupload reloadData];
                 [self.overlay setAlpha:0];
                 
                     //[self.RemoveURLArray removeAllObjects];
                 
                 
             });
         }
         else if ([data length] == 0 && error == nil){
             
             
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
     }];
    if ([[datasend valueForKey:@"FotosInfo"] isKindOfClass:[NSString class]]) {
    } else{
        [self sendFotosOnderdelen:[datasend valueForKey:@"FotosInfo"] withID:[datasend valueForKey:@"AannamelijstOnderdeelId"]];
    }
    
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    AppDelegate *appDelegate = [FileManager getDel];
    appDelegate.moviesize =response.expectedContentLength;
    [responseData setLength:0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}
-(BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return YES;
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
        //[COMMON showErrorAlert:@"Internet Connection Error!"];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
}
- (void)viewDidLoad
{
    [self searchForStuff:@"iPhone"];
}
-(void)searchForStuff:(NSString *)text
{
        // responseData = [[NSMutableData data] retain];
        // NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.whatever.com/json"]];
        // [[NSURLConnection alloc] initWithRequest:request delegate:self];
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
    [appDelegate.viewcontroller dismissViewControllerAnimated:YES completion:NULL];
}
- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    AppDelegate *appDelegate = [FileManager getDel];
    [appDelegate.viewcontroller dismissViewControllerAnimated:YES completion:NULL];
}
-(void)end
{
    [self setAlpha:0];
}
#pragma mark - tabelDelegate method
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *content =[[UIView alloc] initWithFrame:CGRectMake(0,0,self.frame.size.width,80)];
    return content;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [TotalVoertuigen count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cellupload"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellupload"];
        [cell setBackgroundColor:[UIColor whiteColor]];
        [cell.contentView setBackgroundColor:[UIColor whiteColor]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    UILabel *existlabel = (UILabel *)[cell viewWithTag:105];
    if (existlabel) {
        UILabel *existbutton = (UILabel *)[cell viewWithTag:1008+indexPath.row];
        [existbutton setBackgroundColor:[UIColor orangeColor]];
        [existlabel setFrame:CGRectMake(10,0,600,40)];
        [existlabel setText:[NSString stringWithFormat:@"%@ %@", [[TotalVoertuigen objectAtIndex:indexPath.row] valueForKey:@"Kenteken"], [[TotalVoertuigen objectAtIndex:indexPath.row] valueForKey:@"AldocModel"]]];
    } else {
        UIButton *scan =[[UIButton alloc]initWithFrame:CGRectMake(600-150, 4, 145, 30)];
        [scan setBackgroundColor:[UIColor orangeColor]];
        [scan setTitle:@"Uploaden" forState:UIControlStateNormal];
        [scan addTarget:self action:@selector(upload:) forControlEvents:UIControlEventTouchUpInside];
        [scan.layer setCornerRadius:6];
        [scan setTag:1008+indexPath.row];
        [scan.titleLabel setFont:[UIFont regularFlatFontOfSize:15]];
        [scan.layer setMasksToBounds:YES];
        [cell addSubview:scan];
        UILabel *kenteken =[[UILabel alloc] initWithFrame:CGRectMake(10,0,600-150,40)];
        [kenteken setBackgroundColor:[UIColor clearColor]];
        [kenteken setText:[NSString stringWithFormat:@"%@ %@", [[TotalVoertuigen objectAtIndex:indexPath.row] valueForKey:@"Kenteken"], [[TotalVoertuigen objectAtIndex:indexPath.row] valueForKey:@"AldocModel"]]];
        [kenteken setFont:[UIFont systemFontOfSize:12]];
        [kenteken setTextAlignment:NSTextAlignmentLeft];
        [kenteken setTag:105];
        [cell addSubview:kenteken];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
@end
