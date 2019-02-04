    //
    //  FileManger.m
    //  Autonet
    //
    //  Created by Livecast02 on 15-12-16.
    //  Copyright © 2016 Autonet. All rights reserved.
    //
#import "FileManager.h"
#import "JSONKit.h"
#import "SBJson.h"
#import "FileManager.h"
#import "AppDelegate.h"
#import "RSDownloadManager.h"
@implementation FileManager
#pragma mark - insert method
+(NSString*)getDir
{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}
+(AppDelegate*)getDel
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

+(NSMutableArray *)insertDelen:(NSMutableArray*)array
{


        ////////NSLog(@"insertDelen");
    
    AppDelegate *appDelegate = [FileManager getDel];
    NSPredicate *predicatecat = [NSPredicate predicateWithFormat:[[[[[NSString stringWithFormat:@"*%@#", [array componentsJoinedByString:@","]] stringByReplacingOccurrencesOfString:@"," withString:@") or (DeelId ="] stringByReplacingOccurrencesOfString:@"*" withString:@"(DeelId ="] stringByReplacingOccurrencesOfString:@"#" withString:@")"] stringByReplacingOccurrencesOfString:@"(DeelId =)" withString:@""]];



    NSString *docDirnew = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDirnew,@"Onderdelen"];
    NSMutableArray* savelist = [[NSMutableArray alloc] init];
    NSMutableArray* plist = [[[NSMutableArray arrayWithContentsOfFile:itemFilePath] filteredArrayUsingPredicate:predicatecat] mutableCopy];
    NSString *itemFilePath2 = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDirnew,@"Onderdelen", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
    NSMutableArray* total = [NSMutableArray arrayWithContentsOfFile:itemFilePath2];

    if (total == NULL) {

        total = [[NSMutableArray alloc] init];
    }

    NSMutableArray *titans =[[NSMutableArray alloc] init];
    for (int k =0; k < [plist count]; k++) {
        NSMutableDictionary *coursCell =[[[FileManager getEmptyPart] firstObject] mutableCopy];
        NSArray *velden =[FileManager getOnderdelen:[[[plist objectAtIndex:k] valueForKey:@"DeelId"] integerValue]];


        [coursCell setObject:[[plist objectAtIndex:k] valueForKey:@"DeelId"] forKey:@"DeelId"];
        [coursCell setObject:[appDelegate newUUID] forKey:@"AannamelijstOnderdeelId"];
        [titans removeAllObjects];
        for (int p =0; p < [velden count]; p++) {
            NSMutableDictionary *copywaarde =[[NSMutableDictionary alloc] init];
            [copywaarde setObject:[[velden objectAtIndex:p] valueForKey:@"VeldId"] forKeyedSubscript:@"VeldId"];
            [copywaarde setObject:@"-" forKeyedSubscript:@"Waarde"];
            [titans addObject:copywaarde];
        }
        [coursCell setObject:titans forKey:@"Velden"];
        if ([[total valueForKey:@"DeelId"] containsObject:[coursCell valueForKey:@"DeelId"]]) {
            NSString *  queryit = [NSString stringWithFormat:@"DeelId = %@", [coursCell valueForKey:@"DeelId"]];

            NSPredicate *predicateits = [NSPredicate predicateWithFormat:queryit];
            NSMutableArray* copyplist = [[total filteredArrayUsingPredicate:predicateits] mutableCopy];
            if ([[[copyplist firstObject] valueForKey:@"OnderdeelId"] integerValue] > 0) {
                coursCell = [copyplist firstObject];
                [coursCell setObject:@"0" forKey:@"OnderdeelId"];
                [coursCell setObject:[appDelegate newUUID] forKey:@"AannamelijstOnderdeelId"];
                [savelist addObject:coursCell];
            }
        }
        else
        {
            [savelist addObject:coursCell];
        }

    }
    return savelist;
}
+(NSArray*)insertOnderdelenid:(NSMutableDictionary*)dictonary setid:(NSString*)idit
{
    AppDelegate *appDelegate = [FileManager getDel];
    NSString *docDir = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/Velden_%@.plist",docDir,[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
    appDelegate.onderdelenVoertuigArray = [[NSMutableArray arrayWithContentsOfFile:itemFilePath] mutableCopy];

    if (appDelegate.onderdelenVoertuigArray)
    {
    } else {

        appDelegate.onderdelenVoertuigArray =[[NSMutableArray alloc] init];
    }
    NSString *queryit = [NSString stringWithFormat:@"VeldId = %@",idit];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[appDelegate.onderdelenVoertuigArray  filteredArrayUsingPredicate:predicateit] mutableCopy];
    if ([items count]>0) {
        [appDelegate.onderdelenVoertuigArray replaceObjectAtIndex:[appDelegate.onderdelenVoertuigArray indexOfObject:[items firstObject]] withObject:dictonary];
        [appDelegate.onderdelenVoertuigArray writeToFile:itemFilePath atomically: YES];
    } else {
        if (appDelegate.onderdelenVoertuigArray) {
            [appDelegate.onderdelenVoertuigArray addObject:dictonary];
            [appDelegate.onderdelenVoertuigArray writeToFile:itemFilePath atomically: YES];
        }
        else
        {
            appDelegate.onderdelenVoertuigArray =[[NSMutableArray alloc] init];
            [ appDelegate.onderdelenVoertuigArray addObject:dictonary];
            [ appDelegate.onderdelenVoertuigArray writeToFile:itemFilePath atomically: YES];
        }
    }

    return  appDelegate.onderdelenVoertuigArray;
}
+(void)insertVoertuig:(NSMutableDictionary*)sender
{
    AppDelegate *appDelegate = [FileManager getDel];
    NSString *docDir = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/Voertuigen.plist",docDir];
    NSMutableArray* copyplist = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    NSString *queryit = [NSString stringWithFormat:@"VoertuigId = %@", [sender valueForKey:@"VoertuigId"]];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[copyplist  filteredArrayUsingPredicate:predicateit] mutableCopy];
    [copyplist replaceObjectAtIndex:[copyplist indexOfObject:[items firstObject]] withObject:sender];
    [copyplist writeToFile:itemFilePath atomically: YES];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"UploadDatum" ascending:TRUE];
    [copyplist sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    appDelegate.alleVoertuigenArray =copyplist;
}
+(NSMutableArray*)insertSchades_voertuig:(NSMutableDictionary*)sender
{
    AppDelegate *appDelegate = [FileManager getDel];
    NSString *docDir = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/Schades_%@.plist",docDir,[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
    NSMutableArray* copyplist = [[NSMutableArray arrayWithContentsOfFile:itemFilePath] mutableCopy];
    NSString *queryit = [NSString stringWithFormat:@"Id = %@", [sender valueForKey:@"Id"]];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[copyplist  filteredArrayUsingPredicate:predicateit] mutableCopy];
    [copyplist replaceObjectAtIndex:[copyplist indexOfObject:[items firstObject]] withObject:sender];
    [copyplist writeToFile:itemFilePath atomically: YES];
    return copyplist;
}
+(NSMutableArray*)insertOpties_voertuig:(NSMutableDictionary*)sender
{
    AppDelegate *appDelegate = [FileManager getDel];
    NSString *docDir = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/Opties_%@.plist",docDir,[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
    NSMutableArray* copyplist = [[NSMutableArray arrayWithContentsOfFile:itemFilePath] mutableCopy];
    NSString *queryit = [NSString stringWithFormat:@"Id = %@", [sender valueForKey:@"Id"]];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[copyplist  filteredArrayUsingPredicate:predicateit] mutableCopy];
    [copyplist replaceObjectAtIndex:[copyplist indexOfObject:[items firstObject]] withObject:sender];
    [copyplist writeToFile:itemFilePath atomically: YES];
    return copyplist;
}
+(NSMutableArray*)insertgordels_voertuig:(NSMutableDictionary*)sender;
{
    AppDelegate *appDelegate = [FileManager getDel];
    NSString *docDir = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/Gorderspanners_%@.plist",docDir,[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
    NSMutableArray* copyplist = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    NSString *queryit = [NSString stringWithFormat:@"Id = %@", [sender valueForKey:@"Id"]];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[copyplist  filteredArrayUsingPredicate:predicateit] mutableCopy];
    [copyplist replaceObjectAtIndex:[copyplist indexOfObject:[items firstObject]] withObject:sender];
    [copyplist writeToFile:itemFilePath atomically: YES];
    return copyplist;
}
+(NSMutableArray*)insertAirbags_voertuig:(NSMutableDictionary*)sender
{
    AppDelegate *appDelegate = [FileManager getDel];
    NSString *docDir = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/Airbags_%@.plist",docDir,[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
    NSMutableArray* copyplist = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    NSString *queryit = [NSString stringWithFormat:@"Id = %@", [sender valueForKey:@"Id"]];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[copyplist  filteredArrayUsingPredicate:predicateit] mutableCopy];
    [copyplist replaceObjectAtIndex:[copyplist indexOfObject:[items firstObject]] withObject:sender];
    [copyplist writeToFile:itemFilePath atomically: YES];
    return copyplist;
}

+(void)WriteImagesThumbs:(NSMutableArray*)b;
{
    AppDelegate *appDelegate = [FileManager getDel];


    NSMutableDictionary* items = [self getUser];

    NSArray *copy = [[b valueForKey:@"Orgnaam"] copy];
    NSInteger index = [copy count] - 1;
    for (id object in [copy reverseObjectEnumerator]) {
        if ([[b valueForKey:@"Orgnaam"]  indexOfObject:object inRange:NSMakeRange(0, index)] != NSNotFound) {
            [b removeObjectAtIndex:index];
        }
        index--;
    };

        //NSLog(@"%lu", (unsigned long)[[b valueForKey:@"Orgnaam"] count]);

    NSURLSession *session = [NSURLSession sharedSession];
    for (int r =0; r < [b count]; r++) {

        NSArray *pathsCachescopy = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *docDir = [pathsCachescopy objectAtIndex:0]; // Get documents folder
        NSString *dataPath = [NSString stringWithFormat:@"%@/Caches/thumb_%@",docDir,[[b objectAtIndex:r] valueForKey:@"Orgnaam"]];

        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
        {
            NSString *url = [NSString stringWithFormat: @"http://%@:8089/api/v1/app/Foto/%@/%@/%@",[items valueForKey:@"Server"],[appDelegate updateUI],[items valueForKey:@"Id"],[[b objectAtIndex:r] valueForKey:@"FotoThumpId"]];
            NSURL *urlw = [NSURL URLWithString:url];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlw];
            NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                              {
                                                  if (error != nil) {
                                                  } else {
                                                      NSString *extra = [NSString stringWithFormat: @"http://%@:8089/api/v1/app/Foto/%@/%@/%@",[items valueForKey:@"Server"],[appDelegate updateUI],[items valueForKey:@"Id"],[[b objectAtIndex:r] valueForKey:@"FotoThumpId"]];
                                                      if ([data length] == response.expectedContentLength && [data length] != 0) {
                                                          NSString *myJsonString = [NSString stringWithContentsOfURL:[NSURL URLWithString:extra] encoding: NSUTF8StringEncoding error:&error];
                                                          if ([myJsonString length]>10) {
                                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                                  AppDelegate *appDelegate = [FileManager getDel];
                                                                  [appDelegate.viewcontroller.overlay setAlpha:0.5];
                                                                  [appDelegate.viewcontroller.overlay progressChange:[myJsonString length]/10000];


                                                                  double delayInSeconds = 0.3;
                                                                  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                                                                  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                                                                      AppDelegate *appDelegate = [FileManager getDel];
                                                                      appDelegate.alleVoertuigenArray =[[NSMutableArray alloc] initWithArray:[FileManager getArray:@"Voertuigen"]];
                                                                      [appDelegate.viewcontroller.navigaionView.collectionViewNav reloadData];
                                                                      [appDelegate.viewcontroller.menu.ListVoertuigen.tableResult reloadData];
                                                                  });
                                                              });

                                                              dispatch_async(dispatch_get_main_queue(), ^{


                                                                  NSString *query = [NSString stringWithFormat:@"FotoThumpId contains [cd]'%@'", [response.URL lastPathComponent]];
                                                                  NSPredicate *predicate = [NSPredicate predicateWithFormat:query];
                                                                  NSArray *arrayextra =  [[b filteredArrayUsingPredicate:predicate] mutableCopy];


                                                                  UIImage *image2 = [self decodeBase64ToImage:myJsonString];
                                                                  NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/thumb_%@",docDir,[[arrayextra firstObject] valueForKey:@"Orgnaam"]];
                                                                  NSData *data2 = [NSData dataWithData:UIImagePNGRepresentation(image2)];


                                                                  [data2 writeToFile:itemFilePath atomically:YES];

                                                                  NSString *documentsDirectorybureau =  [NSString stringWithFormat:@"/Users/jeffreysnijder02/Desktop/Demo/thumb_%@", [[b objectAtIndex:r] valueForKey:@"Orgnaam"]];
                                                                  [data2 writeToFile:documentsDirectorybureau atomically:YES];

                                                              });


                                                          }
                                                          else
                                                          {

                                                          }
                                                      }
                                                  }
                                              }];
            [dataTask resume];
        }
        else
        {


                //NSLog(@"%@", [[b objectAtIndex:r] valueForKey:@"Orgnaam"]);


        }

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

+(void)WriteImages:(NSMutableArray*)b;
{
    AppDelegate *appDelegate = [FileManager getDel];



    NSArray *copy = [[b valueForKey:@"Orgnaam"] copy];
    NSInteger index = [copy count] - 1;
    for (id object in [copy reverseObjectEnumerator]) {
        if ([[b valueForKey:@"Orgnaam"]  indexOfObject:object inRange:NSMakeRange(0, index)] != NSNotFound) {
            [b removeObjectAtIndex:index];
        }
        index--;
    };



    for (int r =0; r < [b count]; r++) {


        [self performSelector:@selector(WriteImage:) withObject:[b objectAtIndex:r] afterDelay:0.3*r];


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

+(bool)WriteImage:(NSMutableDictionary*)b;
{

    AppDelegate *appDelegate = [FileManager getDel];
    [appDelegate.viewcontroller.overlay setAlpha:0.5];
    NSMutableDictionary* items = [self getUser];

    NSURLSession *session = [NSURLSession sharedSession];

    NSArray *pathsCachescopy = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *docDir = [pathsCachescopy objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [NSString stringWithFormat:@"%@/Caches/%@",docDir,[b valueForKey:@"Orgnaam"]];

    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
    {
        NSString *url = [NSString stringWithFormat: @"http://%@:8089/api/v1/app/Foto/%@/%@/%@",[items valueForKey:@"Server"],[appDelegate updateUI],[items valueForKey:@"Id"],[b valueForKey:@"FotoGrootId"]];
        NSURL *urlw = [NSURL URLWithString:url];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlw];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                          {
                                              if (error != nil) {
                                              } else {


                                                  dispatch_async(dispatch_get_main_queue(), ^{

                                                      NSError *error;

                                                      NSString *myJsonString = [NSString stringWithContentsOfURL:urlw encoding: NSUTF8StringEncoding error:&error];

                                                      UIImage *image = [self decodeBase64ToImage:myJsonString];
                                                      NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@",docDir,[b valueForKey:@"Orgnaam"]];
                                                      NSData *data2 = [NSData dataWithData:UIImagePNGRepresentation(image)];
                                                      [data2 writeToFile:itemFilePath atomically:YES];
                                                      NSString *documentsDirectorybureau =  [NSString stringWithFormat:@"/Users/jeffreysnijder02/Desktop/Demo/%@", [b valueForKey:@"Orgnaam"]];
                                                      [data2 writeToFile:documentsDirectorybureau atomically:YES];

                                                      if ((unsigned long)[[appDelegate.viewcontroller.Loading.TotalVoertuigenFotos valueForKey:@"Orgnaam"]  indexOfObject:[b valueForKey:@"Orgnaam"]] == 1) {

                                                          NSLog(@"%lu", (unsigned long)[[appDelegate.viewcontroller.Loading.TotalVoertuigenFotos valueForKey:@"Orgnaam"]  indexOfObject:[b valueForKey:@"Orgnaam"]]);

                                                          appDelegate.alleVoertuigenArray =[[NSMutableArray alloc] initWithArray:[FileManager getArray:@"Voertuigen"]];
                                                          [appDelegate.viewcontroller.navigaionView.collectionViewNav reloadData];
                                                          [appDelegate.viewcontroller.menu.ListVoertuigen.tableResult reloadData];

                                                      }


                                                      if ((unsigned long)[[appDelegate.viewcontroller.Loading.TotalVoertuigenFotos valueForKey:@"Orgnaam"]  indexOfObject:[b valueForKey:@"Orgnaam"]] < [appDelegate.viewcontroller.Loading.TotalVoertuigenFotos count]) {


                                                          NSLog(@"%lu", (unsigned long)[[appDelegate.viewcontroller.Loading.TotalVoertuigenFotos valueForKey:@"Orgnaam"]  indexOfObject:[b valueForKey:@"Orgnaam"]]);

                                                              //0.002f

                                                          [appDelegate.viewcontroller.overlay setAlpha:0.5];

                                                          [appDelegate.viewcontroller.overlay progressChange:[myJsonString length]/1000];

                                                      }


                                                  });


                                              }
                                          }];
        [dataTask resume];
    } else {



    }


    return NO;

}


+(void)WriteOnderdelen:(NSString*)onderdelen
{

    AppDelegate *appDelegate = [FileManager getDel];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    NSString *plistPath2 = [documentsDirectory
                            stringByAppendingPathComponent:[NSString stringWithFormat:@"/Caches/%@.plist", onderdelen]];
    NSMutableArray* b = [NSMutableArray arrayWithContentsOfFile:plistPath2];

    if ([[[b firstObject] allKeys] containsObject:@"FotosInfo"]) {

    } else {
            //dispatch_group_t group = dispatch_group_create();

        NSURLSession *session = [NSURLSession sharedSession];
        NSMutableDictionary* items = [self getUser];
        NSMutableArray *delenarray =[[NSMutableArray alloc] init];
        for (int r =0; r < [b count]; r++) {

            NSString *url = [NSString stringWithFormat: @"http://%@:8089/api/v1/app/Onderdeel/%@/%@/%@",[items valueForKey:@"Server"],[appDelegate updateUI],[items valueForKey:@"Id"],[[b objectAtIndex:r] valueForKey:@"OnderdeelId"]];

            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
            [request setHTTPMethod:@"GET"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                              {


                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      AppDelegate *appDelegate = [FileManager getDel];
                                                      [appDelegate.viewcontroller.overlay setAlpha:0.5];
                                                      [appDelegate.viewcontroller.overlay progressChange:10*r];

                                                      NSString* nsJson=  [[NSString alloc] initWithData:data
                                                                                               encoding:NSUTF8StringEncoding];


                                                      nsJson =[nsJson stringByReplacingOccurrencesOfString:@"null" withString:@"\"\""];
                                                      NSData *webData = [nsJson dataUsingEncoding:NSUTF8StringEncoding];
                                                      NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:webData options: NSJSONReadingMutableContainers error:NULL];

                                                      if (dict) {
                                                          [dict setObject:[[b objectAtIndex:r] valueForKey:@"AannamelijstOnderdeelId"] forKey:@"AannamelijstOnderdeelId"];
                                                          [appDelegate.viewcontroller.Loading.TotalVoertuigenFotos addObjectsFromArray:[dict valueForKey:@"FotosInfo"]];
                                                          [delenarray addObject:dict];
                                                          [delenarray writeToFile:plistPath2 atomically:YES];
                                                          NSString *documentsDirectorybureau =  [NSString stringWithFormat:@"/Users/jeffreysnijder02/Desktop/Demo/%@.plist",onderdelen];
                                                          [delenarray writeToFile:documentsDirectorybureau atomically:YES];


                                                      }
                                                      else
                                                      {
                                                      }

                                                  });



                                              }];

            [dataTask resume];
        }


    }

    NSString *docDir = [FileManager getDir];

    NSString *itemFilePathvoer = [NSString stringWithFormat:@"%@/Caches/Voertuigen.plist",docDir];
    [appDelegate.alleVoertuigenArray writeToFile:itemFilePathvoer atomically: YES];
    [appDelegate.viewcontroller.navigaionView.collectionViewNav reloadData];
    [appDelegate.viewcontroller.menu.ListVoertuigen.tableResult reloadData];
}

+(void)DownloadSingleImage:(NSMutableDictionary*)imageDict;
{
    AppDelegate *appDelegate = [FileManager getDel];
    NSMutableDictionary* items = [self getUser];

    NSArray *pathsCachescopy = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *docDir = [pathsCachescopy objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [NSString stringWithFormat:@"%@/Caches/%@",docDir,[imageDict valueForKey:@"Orgnaam"]];

        ////////////NSLog(@"%@", imageDict);
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
    {
        NSString *url = [NSString stringWithFormat: @"http://%@:8089/api/v1/app/Foto/%@/%@/%@",[items valueForKey:@"Server"],[appDelegate updateUI],[items valueForKey:@"Id"],[imageDict valueForKey:@"FotoGrootId"]];
        NSURL *urlw = [NSURL URLWithString:url];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlw];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                          {
                                              if (error != nil) {

                                              } else {

                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      [appDelegate.viewcontroller.overlay setAlpha:0.5];
                                                      [appDelegate.viewcontroller.overlay progressChange:100];
                                                  });
                                                  NSString *extra = [NSString stringWithFormat: @"http://%@:8089/api/v1/app/Foto/%@/%@/%@",[items valueForKey:@"Server"],[appDelegate updateUI],[items valueForKey:@"Id"],[imageDict valueForKey:@"FotoGrootId"]];

                                                  if ([data length] == response.expectedContentLength && [data length] != 0) {

                                                      NSString *myJsonString = [NSString stringWithContentsOfURL:[NSURL URLWithString:extra] encoding: NSUTF8StringEncoding error:&error];
                                                      if ([myJsonString length]>10) {

                                                          UIImage *image2 = [self decodeBase64ToImage:myJsonString];
                                                          NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@",docDir,[imageDict valueForKey:@"Orgnaam"]];
                                                          NSData *data2 = [NSData dataWithData:UIImagePNGRepresentation(image2)];
                                                          [data2 writeToFile:itemFilePath atomically:YES];
                                                          NSString *documentsDirectorybureau =  [NSString stringWithFormat:@"/Users/jeffreysnijder02/Desktop/Demo/%@", [imageDict valueForKey:@"Orgnaam"]];
                                                          [data2 writeToFile:documentsDirectorybureau atomically:YES];

                                                          double delayInSeconds = 0.4;
                                                          dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                                                          dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                                                              [appDelegate.viewcontroller.overlay setAlpha:0];

                                                          });


                                                      }
                                                      else
                                                      {
                                                      }
                                                  }
                                              }
                                          }];
        [dataTask resume];
    }

}

+(void)DownloadSingleImageAfter:(NSMutableDictionary*)imageDict;
{
    AppDelegate *appDelegate = [FileManager getDel];
    NSMutableDictionary* items = [self getUser];

    NSLog(@"%@", imageDict);

    NSArray *pathsCachescopy = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *docDir = [pathsCachescopy objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [NSString stringWithFormat:@"%@/Caches/%@",docDir,[imageDict valueForKey:@"Orgnaam"]];


    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
    {
        NSString *url = [NSString stringWithFormat: @"http://%@:8089/api/v1/app/Foto/%@/%@/%@",[items valueForKey:@"Server"],[appDelegate updateUI],[items valueForKey:@"Id"],[imageDict valueForKey:@"FotoGrootId"]];

        [self SetUrl:url];
        NSURL *urlw = [NSURL URLWithString:url];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlw];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                          {
                                              if (error != nil) {

                                              } else {



                                                  if ([data length] == response.expectedContentLength && [data length] != 0) {

                                                      NSString* myJsonString=  [[NSString alloc] initWithData:data
                                                                                                     encoding:NSUTF8StringEncoding];
                                                      if ([myJsonString length]>10) {

                                                          dispatch_async(dispatch_get_main_queue(), ^{
                                                              [appDelegate.viewcontroller.overlay setAlpha:0.5];
                                                              [appDelegate.viewcontroller.overlay progressChange:100];
                                                          });

                                                          dispatch_sync(dispatch_get_main_queue(), ^{
                                                              UIImage *image2 = [self decodeBase64ToImage:myJsonString];
                                                              NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@",docDir,[imageDict valueForKey:@"Orgnaam"]];
                                                              NSData *data2 = [NSData dataWithData:UIImagePNGRepresentation(image2)];
                                                              [data2 writeToFile:itemFilePath atomically:YES];
                                                              NSString *documentsDirectorybureau =  [NSString stringWithFormat:@"/Users/jeffreysnijder02/Desktop/Demo/%@", [imageDict valueForKey:@"Orgnaam"]];
                                                              [data2 writeToFile:documentsDirectorybureau atomically:YES];

                                                              double delayInSeconds = 0.4;
                                                              dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                                                              dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                                                                  [appDelegate.viewcontroller.overlay setAlpha:0];

                                                                  AppDelegate *appDelegate = [FileManager getDel];
                                                                  appDelegate.alleVoertuigenArray =[[NSMutableArray alloc] initWithArray:[FileManager getArray:@"Voertuigen"]];
                                                                  [appDelegate.viewcontroller.navigaionView.collectionViewNav reloadData];
                                                                  [appDelegate.viewcontroller.menu.ListVoertuigen.tableResult reloadData];
                                                                  [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];

                                                                  NSString *itemFileimagePath = [NSString stringWithFormat:@"%@/Caches/%@",docDir,[imageDict valueForKey:@"Orgnaam"]];

                                                                  appDelegate.viewcontroller.imageviewblock.currentimage = [imageDict valueForKey:@"Orgnaam"];
                                                                  [appDelegate.viewcontroller.imageviewblock sizeToFit];
                                                                  [appDelegate.viewcontroller.imageviewblock.imagecontent setImage:[UIImage imageWithContentsOfFile:itemFileimagePath]];
                                                                  [appDelegate.viewcontroller.imageviewblock.imagecontent sizeToFit];
                                                                  [appDelegate.viewcontroller.imageviewblock setAlpha:1];
                                                                  [appDelegate.viewcontroller.imageviewblock.imagecontent setCenter:appDelegate.viewcontroller.imageviewblock.center];

                                                              });

                                                          });


                                                      }
                                                      else
                                                      {
                                                      }
                                                  }
                                              }
                                          }];
        [dataTask resume];
    }

}

+(void)DownloadSingleImageForCar:(NSMutableDictionary*)imageDict;
{
    AppDelegate *appDelegate = [FileManager getDel];
    NSMutableDictionary* items = [self getUser];

    NSLog(@"%@", imageDict);

    NSArray *pathsCachescopy = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *docDir = [pathsCachescopy objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [NSString stringWithFormat:@"%@/Caches/%@",docDir,[imageDict valueForKey:@"Orgnaam"]];


    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
    {
        NSString *url = [NSString stringWithFormat: @"http://%@:8089/api/v1/app/Foto/%@/%@/%@",[items valueForKey:@"Server"],[appDelegate updateUI],[items valueForKey:@"Id"],[imageDict valueForKey:@"FotoGrootId"]];

        [self SetUrl:url];
        NSURL *urlw = [NSURL URLWithString:url];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlw];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                          {
                                              if (error != nil) {

                                              } else {



                                                  if ([data length] == response.expectedContentLength && [data length] != 0) {

                                                      NSString* myJsonString=  [[NSString alloc] initWithData:data
                                                                                                     encoding:NSUTF8StringEncoding];
                                                      if ([myJsonString length]>10) {

                                                          dispatch_async(dispatch_get_main_queue(), ^{
                                                              [appDelegate.viewcontroller.overlay setAlpha:0.5];
                                                              [appDelegate.viewcontroller.overlay progressChange:100];
                                                          });

                                                          dispatch_sync(dispatch_get_main_queue(), ^{
                                                              UIImage *image2 = [self decodeBase64ToImage:myJsonString];
                                                              NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@",docDir,[imageDict valueForKey:@"Orgnaam"]];
                                                              NSData *data2 = [NSData dataWithData:UIImagePNGRepresentation(image2)];
                                                              [data2 writeToFile:itemFilePath atomically:YES];
                                                              NSString *documentsDirectorybureau =  [NSString stringWithFormat:@"/Users/jeffreysnijder02/Desktop/Demo/%@", [imageDict valueForKey:@"Orgnaam"]];
                                                              [data2 writeToFile:documentsDirectorybureau atomically:YES];

                                                              double delayInSeconds = 0.4;
                                                              dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                                                              dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                                                                  [appDelegate.viewcontroller.overlay setAlpha:0];

                                                                  AppDelegate *appDelegate = [FileManager getDel];
                                                                  appDelegate.alleVoertuigenArray =[[NSMutableArray alloc] initWithArray:[FileManager getArray:@"Voertuigen"]];
                                                                  [appDelegate.viewcontroller.navigaionView.collectionViewNav reloadData];
                                                                  [appDelegate.viewcontroller.menu.ListVoertuigen.tableResult reloadData];
                                                                  [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];

                                                                  NSLog(@"%@",(ImageScrollView*)[[[[appDelegate.viewcontroller.carView.ScrollResult subviews] objectAtIndex:3] subviews] objectAtIndex:4]);

                                                                  ImageScrollView *copy=(ImageScrollView*)[[[[appDelegate.viewcontroller.carView.ScrollResult subviews] objectAtIndex:3] subviews] objectAtIndex:4];

                                                                  [copy.imageView.collectionViewcopy reloadData];

                                                                  NSString *itemFileimagePath = [NSString stringWithFormat:@"%@/Caches/%@",docDir,[imageDict valueForKey:@"Orgnaam"]];

                                                                  appDelegate.viewcontroller.imageviewblock.currentimage = [imageDict valueForKey:@"Orgnaam"];
                                                                  [appDelegate.viewcontroller.imageviewblock sizeToFit];
                                                                  [appDelegate.viewcontroller.imageviewblock.imagecontent setImage:[UIImage imageWithContentsOfFile:itemFileimagePath]];
                                                                  [appDelegate.viewcontroller.imageviewblock.imagecontent sizeToFit];
                                                                  [appDelegate.viewcontroller.imageviewblock setAlpha:1];
                                                                  [appDelegate.viewcontroller.imageviewblock.imagecontent setCenter:appDelegate.viewcontroller.imageviewblock.center];

                                                              });

                                                          });


                                                      }
                                                      else
                                                      {
                                                      }
                                                  }
                                              }
                                          }];
        [dataTask resume];
    }

}

+(void)DownloadSingleThumbImage:(NSMutableDictionary*)imageDict
{
    AppDelegate *appDelegate = [FileManager getDel];
    NSMutableDictionary* items = [self getUser];

    NSArray *pathsCachescopy = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *docDir = [pathsCachescopy objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [NSString stringWithFormat:@"%@/Caches/%@",docDir,[imageDict valueForKey:@"Orgnaam"]];


    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
    {
        NSString *url = [NSString stringWithFormat: @"http://%@:8089/api/v1/app/Foto/%@/%@/%@",[items valueForKey:@"Server"],[appDelegate updateUI],[items valueForKey:@"Id"],[imageDict valueForKey:@"FotoThumpId"]];
            // [self SetUrl:url];
        NSURL *urlw = [NSURL URLWithString:url];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlw];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                          {
                                              if (error != nil) {

                                              } else {



                                                  if ([data length] == response.expectedContentLength && [data length] != 0) {

                                                      NSString* myJsonString=  [[NSString alloc] initWithData:data
                                                                                                     encoding:NSUTF8StringEncoding];
                                                      if ([myJsonString length]>10) {

                                                          UIImage *image2 = [self decodeBase64ToImage:myJsonString];
                                                          NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/thumb_%@",docDir,[imageDict valueForKey:@"Orgnaam"]];
                                                          NSData *data2 = [NSData dataWithData:UIImagePNGRepresentation(image2)];
                                                          [data2 writeToFile:itemFilePath atomically:YES];
                                                          NSString *documentsDirectorybureau =  [NSString stringWithFormat:@"/Users/jeffreysnijder02/Desktop/Demo/thumb_%@", [imageDict valueForKey:@"Orgnaam"]];
                                                          [data2 writeToFile:documentsDirectorybureau atomically:YES];


                                                      }
                                                      else
                                                      {
                                                      }
                                                  }
                                              }
                                          }];
        [dataTask resume];
    }

}



+(FileManager*)OnderdelenImagesWriteToArray:(NSMutableArray*)images onderdeelID:(NSString*)onderdeel voertuigID:(NSString*)voertuig
{

    static FileManager *shared = nil;
    static dispatch_once_t pred = 0;

    dispatch_once(&pred, ^{
            ////////////NSLog(@"getPlaatsen");
        shared = [[FileManager alloc] init];
        shared.imagesArray = [[NSMutableArray alloc] init];
    });

    for (int r =0; r < [images count]; r++) {

        if ([[shared.imagesArray valueForKey:@"Orgnaam"] containsObject:[[images objectAtIndex:r] valueForKey:@"Orgnaam"]])
        {
        }
        else
        {

            NSMutableDictionary *Copydict = [images objectAtIndex:r];

            [Copydict setObject:voertuig forKey:@"voetuigID"];
            [Copydict setObject:onderdeel forKey:@"onderdeelID"];
            [FileManager DownloadSingleThumbImage:Copydict];
            [shared.imagesArray addObject:Copydict];

            dispatch_async(dispatch_get_main_queue(), ^{
                AppDelegate *appDelegate = [FileManager getDel];
                [appDelegate.viewcontroller.overlay setAlpha:0.5];
                [appDelegate.viewcontroller.overlay progressChange:10*r];
            });

        }

    }


    return shared;


}


+(NSArray*)insertnew:(NSMutableDictionary*)sender
{

        //////NSLog(@"insertnew %@", sender);

    AppDelegate *appDelegate = [FileManager getDel];
    NSString *docDirnew = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDirnew,@"Onderdelen", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
    NSMutableArray* copyplist = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    
    if ([copyplist count]>0) {
    } else {
        copyplist =[[NSMutableArray alloc] init];


        copyplist =[[NSMutableArray alloc] init];
        [copyplist writeToFile:itemFilePath atomically: YES];

        NSInteger index = [appDelegate.alleVoertuigenArray indexOfObject:appDelegate.currentCarDictionary];
        [appDelegate.currentCarDictionary setValue:[NSString stringWithFormat:@"%@_%@",@"Onderdelen", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]] forKey:@"Onderdelen"];
        [appDelegate.alleVoertuigenArray replaceObjectAtIndex:index withObject:appDelegate.currentCarDictionary];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/Voertuigen.plist",docDirnew];
        [appDelegate.alleVoertuigenArray writeToFile:itemFilePath atomically: YES];

    }
    if ([[copyplist valueForKey:@"DeelId"] containsObject:[sender valueForKey:@"DeelId"]]) {
        NSString *queryit = [NSString stringWithFormat:@"DeelId = %@", [sender valueForKey:@"DeelId"]];
        NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
        NSMutableDictionary *items =  [[[copyplist  filteredArrayUsingPredicate:predicateit] mutableCopy] firstObject];
        NSInteger index =[copyplist indexOfObject:items];
        [copyplist replaceObjectAtIndex:index withObject:sender];
        [copyplist writeToFile:itemFilePath atomically: YES];
        return copyplist;
    } else {
        [copyplist addObject:sender];
        [copyplist writeToFile:itemFilePath atomically: YES];
        return copyplist;
    }
}
+(void)insertFotos:(NSMutableArray*)sender
{
    AppDelegate *appDelegate = [FileManager getDel];
    NSString *docDir = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/FotosInfo_%@.plist",docDir,[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
    NSInteger index = [appDelegate.alleVoertuigenArray indexOfObject:appDelegate.currentCarDictionary];
    [appDelegate.currentCarDictionary setObject: [NSString stringWithFormat:@"FotosInfo_%@",[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]] forKey:@"FotosInfo"];
    [appDelegate.alleVoertuigenArray replaceObjectAtIndex:index withObject:appDelegate.currentCarDictionary];
    NSString *itemFilePathvoer = [NSString stringWithFormat:@"%@/Caches/Voertuigen.plist",docDir];
    [appDelegate.alleVoertuigenArray writeToFile:itemFilePathvoer atomically: YES];
    [appDelegate.viewcontroller.navigaionView.collectionViewNav reloadData];
    [appDelegate.viewcontroller.menu.ListVoertuigen.tableResult reloadData];
    [sender writeToFile:itemFilePath atomically: YES];
}
+(NSArray*)insertFotosIn_voertuig:(NSMutableDictionary*)sender
{
    AppDelegate *appDelegate = [FileManager getDel];
    NSString *docDir = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/FotosInfo_%@.plist",docDir,[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:itemFilePath];
    if (fileExists) {
        NSMutableArray *copyplist = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
        [copyplist addObject:sender];
        [copyplist writeToFile:itemFilePath atomically: YES];
        return copyplist;
    } else {
        NSMutableArray* copyplist = [[NSMutableArray alloc] init];
        [copyplist addObject:sender];
        [copyplist writeToFile:itemFilePath atomically: YES];
        return copyplist;
    }
}
+(NSMutableArray*)getFotos_onderdelen:(NSString*)DeelId
{

        ////////NSLog(@"getFotos_onderdelen");

    AppDelegate *appDelegate = [FileManager getDel];
    NSString *docDirnew = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDirnew,@"Onderdelen", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
    NSMutableArray* copyplist = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    NSString *queryit = [NSString stringWithFormat:@"DeelId = %@", DeelId];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[copyplist  filteredArrayUsingPredicate:predicateit] mutableCopy];
    if ([items count]>0) {
        return items;
    } else {
        return [[NSMutableArray alloc] init];
    }
}
+(NSArray*)insertFotos_onderdelenid:(NSMutableArray*)sender setid:(NSString*)DeelId
{

        ////NSLog(@"sender %@ %@", sender, DeelId);


    AppDelegate *appDelegate = [FileManager getDel];
    NSString *docDirnew = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDirnew,@"Onderdelen", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
    NSMutableArray* copyplist = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    NSString *queryit = [NSString stringWithFormat:@"DeelId = %@", DeelId];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];


    if ([[copyplist filteredArrayUsingPredicate:predicateit]  count]>0) {
        NSMutableDictionary *items =  [[[copyplist filteredArrayUsingPredicate:predicateit] mutableCopy] firstObject];
        NSInteger index =[copyplist indexOfObject:items];
        [items setValue:sender forKey:@"FotosInfo"];
        [copyplist replaceObjectAtIndex:index withObject:items];
        [copyplist writeToFile:itemFilePath atomically: YES];
        NSString *documentsDirectorybureau =  [NSString stringWithFormat:@"/Users/jeffreysnijder02/Desktop/Demo/%@_%@.plist",@"Onderdelen", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
        [copyplist writeToFile:documentsDirectorybureau atomically: YES];
        return copyplist;
    } else {
        return NULL;
    }
}

+(void)insertVeldentotaal:(NSString*)carid
{

    static FileManager *shared = nil;
    if (shared.Veldentotaal) {

    } else {
        shared.Veldentotaal =[[NSMutableArray alloc] init];
    }

    AppDelegate *appDelegate = [FileManager getDel];
    NSMutableDictionary *copy  = [[NSMutableDictionary alloc] init];
    [copy setObject:appDelegate.onderdelenVoertuigArray forKey:carid];
    [shared.Veldentotaal addObject:copy];



}

#pragma mark - actions method                                      
+(void)RemoveNewOnId:(NSString*)IDit
{
        ////////NSLog(@"RemoveNewOnId");

    AppDelegate *appDelegate = [FileManager getDel];
    NSString *docDirnew = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDirnew,@"Onderdelen", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
    NSMutableArray* copyplist = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    if ([[copyplist valueForKey:@"DeelId"] containsObject:IDit]) {
        NSString *queryit = [NSString stringWithFormat:@"DeelId = %@", IDit];
        NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
        NSMutableDictionary *items =  [[[copyplist  filteredArrayUsingPredicate:predicateit] mutableCopy] firstObject];
        NSInteger index =[copyplist indexOfObject:items];
        [copyplist removeObjectAtIndex:index];
        [copyplist writeToFile:itemFilePath atomically: YES];
    }
}
+(void)RemoveNew:(NSMutableDictionary*)sender
{
        ////////NSLog(@"RemoveNew");

    AppDelegate *appDelegate = [FileManager getDel];
    NSString *docDirnew = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDirnew,@"Onderdelen", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
    NSMutableArray* copyplist = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    if ([[copyplist valueForKey:@"DeelId"] containsObject:[sender valueForKey:@"DeelId"]]) {
        NSString *queryit = [NSString stringWithFormat:@"DeelId = %@", [sender valueForKey:@"DeelId"]];
        NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
        NSMutableDictionary *items =  [[[copyplist  filteredArrayUsingPredicate:predicateit] mutableCopy] firstObject];
        NSInteger index =[copyplist indexOfObject:items];
        [copyplist removeObjectAtIndex:index];
        [copyplist writeToFile:itemFilePath atomically: YES];
    }
}
+(NSArray*)getVoertuigen
{
    NSString *docDir = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/Voertuigen.plist",docDir];
    NSMutableArray* copyplist = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"UploadDate" ascending:FALSE];
    [copyplist sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    return copyplist;
}
+(NSMutableDictionary*)getUser
{
    NSString *documentsDirectory = [self getDir];
    NSString *locatioCat = [NSString stringWithFormat:@"%@/Caches/Login.plist",documentsDirectory];
    NSMutableDictionary* items = [NSMutableDictionary dictionaryWithContentsOfFile:locatioCat];
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
    return items;
}
+(NSArray*)getOpties_voertuig:(NSString*)sender
{
    NSString *docDir = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/Opties_%@.plist",docDir,sender];
    NSMutableArray* copyplist = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    return copyplist;
}
+(NSArray*)getGordelspanners_voertuig:(NSString*)sender;
{
    NSString *docDir = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/Gorderspanners_%@.plist",docDir,sender];
    NSMutableArray* copyplist = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    return copyplist;
}
+(NSArray*)getAirbags_voertuig:(NSString*)sender;
{
    NSString *docDir = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/Airbags_%@.plist",docDir,sender];
    NSMutableArray* copyplist = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    return copyplist;
}
+(NSArray*)getFotos_voertuig:(NSString*)sender
{
    AppDelegate *appDelegate = [FileManager getDel];
    NSString *docDir = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/FotosInfo_%@.plist",docDir,[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
    NSMutableArray* copyplist = [[NSMutableArray arrayWithContentsOfFile:itemFilePath] mutableCopy];
    if ([[copyplist firstObject] allKeys]>0) {
        return copyplist;
    } else {
        return [[NSMutableArray alloc] init];
    }
}                                      
+(NSArray*)getOnderdelen_voertuig:(NSString*)sender
{
        ////////NSLog(@"getOnderdelen_voertuig");

    AppDelegate *appDelegate = [FileManager getDel];
    NSString *docDir = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"Onderdelen", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];


    NSMutableArray* beforearray = [NSMutableArray arrayWithContentsOfFile:itemFilePath];


    NSString *queryit;
    if (appDelegate.aanname) {
        queryit = [NSString stringWithFormat:@"(OnderdeelId > 0)"];
    } else {
        queryit = [NSString stringWithFormat:@"(OnderdeelId == 0)"];
    }
    NSPredicate *predicateits = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray* copyplist = [[beforearray filteredArrayUsingPredicate:predicateits] mutableCopy];

        ////////////NSLog(@"%@", itemFilePath);

    if ([copyplist count]>0) {
        NSMutableArray* onderdelen =[[FileManager getOnderdelen] mutableCopy];
        NSString *queryit = [NSString stringWithFormat:@"(DeelId =%@)", [[copyplist valueForKey:@"DeelId"] componentsJoinedByString:@") or (DeelId ="]];
        NSPredicate *predicateit = [NSPredicate predicateWithFormat:[queryit stringByReplacingOccurrencesOfString:@"(DeelId =)" withString:@""]];
        NSMutableArray *items =  [[onderdelen  filteredArrayUsingPredicate:predicateit] mutableCopy];
        for (int i = 0; i < [items count]; i++) {
            NSMutableDictionary *set =[items objectAtIndex:i];
            [set setValue:[[set valueForKey:@"Categorieen"] componentsJoinedByString:@","] forKey:@"Categorieen"];
            [items replaceObjectAtIndex:i withObject:set];
            [set setObject:@"NO" forKey:@"Verplicht"];
        }
        NSString *locatioCat = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Categorieen"];
        NSMutableArray* copyCat= [NSMutableArray arrayWithContentsOfFile:locatioCat];
        NSMutableArray *uniquearray = [[[NSSet setWithArray:[items valueForKey:@"Categorieen"]] allObjects] mutableCopy];
        NSString *querycat = [NSString stringWithFormat:@"(CategorieId =%@)", [uniquearray componentsJoinedByString:@") or (CategorieId ="]];
        querycat = [querycat stringByReplacingOccurrencesOfString:@"(CategorieId =<null>) or" withString:@""];
        NSPredicate *predicatecat = [NSPredicate predicateWithFormat:[[querycat stringByReplacingOccurrencesOfString:@"or (CategorieId =)" withString:@""]stringByReplacingOccurrencesOfString:@"(CategorieId =) or" withString:@""]];
        appDelegate.categorieenStandaardArray =[[copyCat  filteredArrayUsingPredicate:predicatecat] mutableCopy];
        appDelegate.onderdelenVoertuigArray = items;
        NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey: @"@firstObject" ascending: YES];
        NSArray *sorted = [[[appDelegate.onderdelenVoertuigArray valueForKey:@"DeelNamen"] valueForKey:@"Naam"] sortedArrayUsingDescriptors: @[sd]];
        for (int k =0; k < [sorted count]; k++) {
            NSInteger count = [[[appDelegate.onderdelenVoertuigArray valueForKey:@"DeelNamen"] valueForKey:@"Naam"] indexOfObject:[sorted objectAtIndex:k]];
            NSMutableDictionary *copyitem = [appDelegate.onderdelenVoertuigArray objectAtIndex:count];
            [appDelegate.onderdelenVoertuigArray removeObjectAtIndex:count];
            [appDelegate.onderdelenVoertuigArray addObject:copyitem];
        }
        [appDelegate.viewcontroller.collectionOnderdelenView.catogorieStandaard.tableResult reloadData];
        [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
        return items;
    } else {
        return [[NSMutableArray alloc] init];
    }
}                   
+(NSArray*)getOnderdelen_Categorie:(NSMutableArray*)onderdelen whatid:(NSString*)deelid
{                   
    NSString *queryit = [NSString stringWithFormat:@"(ANY Categorieen = %@)", deelid];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:[queryit stringByReplacingOccurrencesOfString:@"(DeelId =)" withString:@""]];
    NSMutableArray *items =  [[onderdelen  filteredArrayUsingPredicate:predicateit] mutableCopy];


    return items;
}                   
+(NSArray*)getOnderdelen_voertuig_kern:(NSString*)sender
{
        ////////NSLog(@"getOnderdelen_voertuig_kern");

    NSString *docDir = [self getDir];
    NSString *locatioCat = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Velden"];
    NSMutableArray* copyCat= [NSMutableArray arrayWithContentsOfFile:locatioCat];
    NSString *queryit = [NSString stringWithFormat:@"((InternetOmschrijving LIKE [cd]'Motortype') and !(CategorieId ='-')) And ((InternetOmschrijving LIKE [cd]'Cilinderinhoud') and !(CategorieId ='-')) or ((InternetOmschrijving LIKE [cd]'Carrosserie') and !(CategorieId ='-')) or ((InternetOmschrijving LIKE [cd]'Versnellingsbak type') and !(CategorieId ='-')) or ((InternetOmschrijving LIKE [cd]'Versnellingsbak') and !(CategorieId ='-')) or ((InternetOmschrijving LIKE [cd]'Motorcode') and !(CategorieId ='-')) or ((InternetOmschrijving LIKE [cd]'Deuren') and !(CategorieId ='-')) or ((InternetOmschrijving LIKE [cd]'Tellerstand') and !(CategorieId ='-'))"];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[copyCat  filteredArrayUsingPredicate:predicateit] mutableCopy];
    return items;
}

+(NSArray*)getSchades_voertuig:(NSString*)sender
{
    NSString *docDir = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/Schades_%@.plist",docDir,sender];
    NSMutableArray* copyplist = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    return copyplist;
}
+(NSArray*)getVelden_voertuig:(NSString*)sender
{
    AppDelegate *appDelegate = [FileManager getDel];
    NSString *docDir = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/Velden_%@.plist",docDir, [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
    NSMutableArray* copyplist = [NSMutableArray arrayWithContentsOfFile:itemFilePath];

    if (copyplist)
    {
    } else {

        copyplist =[[NSMutableArray alloc] init];
    }


    return copyplist;
}

+(NSArray*)getVelden_voertuigMulti:(NSString*)sender add:(NSMutableArray*)items
{
        //////NSLog(@"%@", items);

    AppDelegate *appDelegate = [FileManager getDel];
    NSString *docDir = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/Velden_%@.plist",docDir, [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
    NSMutableArray* copyplist = [NSMutableArray arrayWithContentsOfFile:itemFilePath];

    if (copyplist)
    {
    } else {

        copyplist =[[NSMutableArray alloc] init];
    }
        ////////////NSLog(@"copyplist %@", copyplist);

    NSString *queryit = [NSString stringWithFormat:@"VeldId = %@", [items.firstObject valueForKey:@"VeldId"]];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];

    NSMutableArray* romoveObjectsarray = [[copyplist filteredArrayUsingPredicate:predicateit] mutableCopy];

    if ([romoveObjectsarray count]>0) {


        for (NSMutableDictionary *item in romoveObjectsarray) {

            [copyplist removeObject:item];

        }


    }

    else {


    }

    for (NSMutableDictionary *item in items) {



        [copyplist addObject:item];

    }

    [copyplist writeToFile:itemFilePath atomically: YES];

        //////NSLog(@"%@", copyplist);
    return copyplist;


}
+(NSArray*)getVelden_voertuig:(NSString*)sender add:(NSMutableDictionary*)item
{
    AppDelegate *appDelegate = [FileManager getDel];
    NSString *docDir = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/Velden_%@.plist",docDir, [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
    NSMutableArray* copyplist = [NSMutableArray arrayWithContentsOfFile:itemFilePath];

    if (copyplist)
    {
    } else {

        copyplist =[[NSMutableArray alloc] init];
    }

    if ([[copyplist valueForKey:@"VeldId"] containsObject:[item valueForKey:@"VeldId"]]) {
        [copyplist replaceObjectAtIndex:[[copyplist valueForKey:@"VeldId"] indexOfObject:[item valueForKey:@"VeldId"]] withObject:item];
    } else {
        if ([copyplist count]>0)
        {
            [copyplist addObject:item];
        }
        else
        {
            copyplist = [[NSMutableArray alloc] init];
            [copyplist addObject:item];
        }
    }


    [copyplist writeToFile:itemFilePath atomically: YES];
    return copyplist;
}
+(void)insertKilometerStand:(NSNumber*)sender
{
    AppDelegate *appDelegate = [FileManager getDel];
    NSString *docDir = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/Voertuigen.plist",docDir];
    NSMutableArray* copyplist = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    NSString *queryit = [NSString stringWithFormat:@"VoertuigId = %@", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[copyplist  filteredArrayUsingPredicate:predicateit] mutableCopy];
    if ([items count]>0) {
        NSInteger index = [copyplist indexOfObject:[items firstObject]];
        [copyplist replaceObjectAtIndex:index withObject:appDelegate.currentCarDictionary];
        [copyplist writeToFile:itemFilePath atomically: YES];
    }
}                   
+(NSArray*)getVoertuigsoortenopid:(NSString*)sender
{
    static FileManager *shared = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        shared = [[FileManager alloc] init];
        NSString *docDir = [self getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Voertuigsoorten"];
        shared.Voertuigsoorten = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    });
    NSString *queryit = [NSString stringWithFormat:@"VoertuigSoortId = %@", sender];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[shared.Voertuigsoorten  filteredArrayUsingPredicate:predicateit] mutableCopy];
    return items;
}
+(NSMutableDictionary*)getAannamelijstenCategorieen
{
    AppDelegate *appDelegate = [FileManager getDel];
    NSString *docDir = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"AannameLijst", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
    NSMutableDictionary* copyplist = [[NSMutableDictionary dictionaryWithContentsOfFile:itemFilePath] mutableCopy];
    return copyplist;
}

+(NSArray*)getTeststatussen
{

    static FileManager *shared = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
            ////////////NSLog(@"een getallVeldenValues");
        shared = [[FileManager alloc] init];
        NSString *docDir = [self getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Teststatussen"];
        NSArray* cases = [NSArray arrayWithContentsOfFile:itemFilePath];

        NSMutableArray* copy = [[NSMutableArray alloc] init];

        for (int k=0 ; k<[cases count]; k++) {

            NSMutableDictionary* copydict = [[NSMutableDictionary alloc] init];
            [copydict setObject:[[cases objectAtIndex:k] valueForKey:@"TestStatusId"] forKey:@"Order"];
            [copydict setObject:[[cases objectAtIndex:k] valueForKey:@"Omschrijving"] forKey:@"Waarde"];
            [copydict setObject:[[cases objectAtIndex:k] valueForKey:@"Omschrijving"] forKey:@"WaardeLang"];
            [copy addObject:copydict];
        }
        shared.Teststatussen = [[copy mutableCopy] mutableCopy];
    });


        ////////////NSLog(@"%@", shared.Teststatussen);
    
    return shared.Teststatussen;
}

+(NSArray*)getTeststatussenOnID:(NSInteger)sender
{

    NSString *queryit = [NSString stringWithFormat:@"Order = %li", (long)sender];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[[self getTeststatussen]  filteredArrayUsingPredicate:predicateit] mutableCopy];
    if ([items count]>0) {
        return items;
    } else {
        return NULL;
    }
}

+(NSArray*)getCategorieen:(NSString*)sender
{
    AppDelegate *appDelegate = [FileManager getDel];
    NSString *docDir = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"AannameLijst", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
    NSMutableDictionary* copyplist = [NSMutableDictionary dictionaryWithContentsOfFile:itemFilePath];
    return [copyplist valueForKey:@"Groepen"];
}
+(NSArray*)getVoertuigVeldenOpID
{
    
    AppDelegate *appDelegate = [FileManager getDel];
    NSString *docDir = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"Velden", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
    NSMutableArray* copyplist = [[NSMutableArray arrayWithContentsOfFile:itemFilePath] mutableCopy];

    if (copyplist == NULL)
    {
        copyplist =[[NSMutableArray alloc] init];
        [copyplist writeToFile:itemFilePath atomically: YES];

        NSInteger index = [appDelegate.alleVoertuigenArray indexOfObject:appDelegate.currentCarDictionary];
        [appDelegate.currentCarDictionary setValue:[NSString stringWithFormat:@"%@_%@",@"Velden", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]] forKey:@"Velden"];
        [appDelegate.alleVoertuigenArray replaceObjectAtIndex:index withObject:appDelegate.currentCarDictionary];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/Voertuigen.plist",docDir];
        [appDelegate.alleVoertuigenArray writeToFile:itemFilePath atomically: YES];


            //FotosInfo_4325
    }



        ////////NSLog(@"getVoertuigVeldenOpID %@", copyplist);
    return copyplist;
}
+(NSArray*)getVeldmaskers:(NSString*)sender and:(NSString*)carID
{
    static FileManager *shared = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
            ////////////NSLog(@"een getallVeldenValues");
        shared = [[FileManager alloc] init];
        NSString *docDir = [self getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Veldmaskers"];
        shared.Veldmaskers = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    });
    NSString *queryit = [NSString stringWithFormat:@"VeldMaskId = %@", sender];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[ shared.Veldmaskers  filteredArrayUsingPredicate:predicateit] mutableCopy];
    return items;
}                   
+(NSArray*)getVeldenOnOnderdeel:(NSString*)sender and:(NSString*)onderdeelID
{
    AppDelegate *appDelegate = [FileManager getDel];

    NSString *docDir = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/Velden_%@.plist",docDir,[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
    NSMutableArray* copyplist = [[NSMutableArray arrayWithContentsOfFile:itemFilePath] mutableCopy];

    if (copyplist)
    {
    } else {

        copyplist =[[NSMutableArray alloc] init];
    }

    NSString *queryit = [NSString stringWithFormat:@"VeldId = %@", sender];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[copyplist  filteredArrayUsingPredicate:predicateit] mutableCopy];

    if ([items count]>0) {
        return items;
    } else {

        NSString *docDir = [self getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/Onderdelen_%@.plist",docDir,[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
        NSMutableArray* copyplist = [[NSMutableArray arrayWithContentsOfFile:itemFilePath] mutableCopy];


            ////////////NSLog(@"%@", copyplist);


        NSString *queryit = [NSString stringWithFormat:@"DeelId = %@", onderdeelID];
        NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
        NSMutableArray *item =  [[copyplist filteredArrayUsingPredicate:predicateit] mutableCopy];


        if ([item count]>0) {



            NSString *query = [NSString stringWithFormat:@"VeldId = %@", sender];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:query];
            NSMutableArray *items =  [[[[item firstObject] valueForKey:@"Velden"]  filteredArrayUsingPredicate:predicate] mutableCopy];




            return items;
        }
        else
        {
            return NULL;
        }

    }

}
+(NSArray*)getVelden:(NSString*)sender and:(NSString*)carID
{
    
    NSString *docDir = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/Velden_%@.plist",docDir,carID];
    NSMutableArray* copyplist = [[NSMutableArray arrayWithContentsOfFile:itemFilePath] mutableCopy];

    if (copyplist)
    {
    } else {

        copyplist =[[NSMutableArray alloc] init];
    }



    NSString *queryit = [NSString stringWithFormat:@"VeldId = %@", sender];


    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[copyplist  filteredArrayUsingPredicate:predicateit] mutableCopy];


    if ([items count]>0) {
        return items;
    } else {
        return NULL;
    }
}
+(NSArray*)getVeldenOnlist:(NSArray*)sender
{
        ////////NSLog(@"getVeldenOnlist");

    if ([sender count]>0) {
        static FileManager *shared = nil;
        static dispatch_once_t pred = 0;

        dispatch_once(&pred, ^{
                ////////////NSLog(@"een getallVeldenValues");
            shared = [[FileManager alloc] init];
            NSString *docDir = [self getDir];
            NSString *locatioCat = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Velden"];
            shared.velden = [NSMutableArray arrayWithContentsOfFile:locatioCat];
        });

        if ([shared.velden count]==0) {
            NSString *docDir = [self getDir];
            NSString *locatioCat = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Velden"];
            shared.velden = [NSMutableArray arrayWithContentsOfFile:locatioCat];
        }
        if ([sender count]>1) {
            NSString *queryit = [NSString stringWithFormat:@"(VeldId =%@)", [sender componentsJoinedByString:@") or (VeldId ="]];
            NSPredicate *predicateit = [NSPredicate predicateWithFormat:[queryit stringByReplacingOccurrencesOfString:@"(VeldId =)" withString:@""]];
            NSMutableArray *items =  [[shared.velden  filteredArrayUsingPredicate:predicateit] mutableCopy];
            return items;
        }
        else
        {
            NSString *queryit = [NSString stringWithFormat:@"VeldId =%@", [sender firstObject]];
            NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
            NSMutableArray *items =  [[shared.velden  filteredArrayUsingPredicate:predicateit] mutableCopy];
            return items;
        }
    } else {
        return [[NSArray alloc] init];
    }
}                   
+(NSArray*)getStatistiekenOnID:(NSString*)sender
{
    AppDelegate *appDelegate = [FileManager getDel];
    NSString *docDir = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"Statistieken", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
    NSMutableArray* copyplist = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    NSString *queryit = [NSString stringWithFormat:@"DeelId = %@", sender];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[copyplist  filteredArrayUsingPredicate:predicateit] mutableCopy];
    if ([items count]>0) {
        return items;
    } else {
        return NULL;
    }
}
+(NSArray*)getOnderdeelOnID:(NSString*)sender
{
    AppDelegate *appDelegate = [FileManager getDel];
    NSString *docDirnew = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDirnew,@"Onderdelen", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
    NSMutableArray* copyplist = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    NSString *queryit = [NSString stringWithFormat:@"DeelId = %@", sender];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[copyplist  filteredArrayUsingPredicate:predicateit] mutableCopy];
    if ([items count]>0) {
        return items;
    } else {
        return NULL;
    }
}                   
static FileManager *sharedOnderdelen = nil;
static dispatch_once_t predOnderdelen = 0;                   

+(NSArray*)getVeldafhankelijkinlcude:(NSString*)sender include:(NSInteger)tag;
{
    NSString *docDir = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Veldafhankelijk"];
    NSMutableArray* copyplist = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    NSString *queryit = [NSString stringWithFormat:@"Waarde_Afhankelijk like [cd]'%@'", sender];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[copyplist  filteredArrayUsingPredicate:predicateit] mutableCopy];
    if ([items count] >0) {
        return items;
    } else {
        NSString *docDir = [self getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Veldafhankelijk"];
        NSMutableArray* copyplist = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
        NSString *queryit = [NSString stringWithFormat:@"VeldId_Afhankelijk == %li", (long)tag];
        NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
        NSMutableArray *itemcopy =  [[copyplist  filteredArrayUsingPredicate:predicateit] mutableCopy];
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithDictionary:[itemcopy firstObject]];
        [tempDictionary setObject:@"" forKey:@"Waarde"];
        [itemcopy removeAllObjects];
        [itemcopy addObject:tempDictionary];
        return itemcopy;
    }
}
+(NSArray*)getLandID:(NSNumber*)sender
{

    
    NSString* path3 = [[NSBundle mainBundle] pathForResource:@"Landen" ofType:@"plist"];
    NSMutableArray* copyplist = [NSMutableArray arrayWithContentsOfFile:path3];
    NSString *queryit = [NSString stringWithFormat:@"LandId == %@", sender];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[copyplist  filteredArrayUsingPredicate:predicateit] mutableCopy];

    return items;

}
+(NSArray*)getAfstandOnID:(NSString*)sender
{

    
    NSString* path3 = [[NSBundle mainBundle] pathForResource:@"Afstand" ofType:@"plist"];
    NSMutableArray* copyplist = [NSMutableArray arrayWithContentsOfFile:path3];
    NSString *queryit = [NSString stringWithFormat:@"Waarde contains [cd]'%@'", sender];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[copyplist  filteredArrayUsingPredicate:predicateit] mutableCopy];
    return items;
}                   
+(NSArray*)getBTWOnID:(NSString*)sender
{
    NSString* path3 = [[NSBundle mainBundle] pathForResource:@"BTW" ofType:@"plist"];
    NSMutableArray* copyplist = [NSMutableArray arrayWithContentsOfFile:path3];
    NSString *queryit = [NSString stringWithFormat:@"Waarde contains [cd]'%@'", sender];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[copyplist  filteredArrayUsingPredicate:predicateit] mutableCopy];
    return items;
}                                      
+(void)UserAannamelijst:(NSMutableDictionary*)sender
{
    AppDelegate *appDelegate = [FileManager getDel];
    NSString *docDir = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"AannameLijst", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
    NSString *documentsDirectorybureau =  [NSString stringWithFormat:@"/Users/jeffreysnijder02/Desktop/Demo/%@_%@.plist",@"AannameLijst", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
    NSMutableDictionary* copyplist = [NSMutableDictionary dictionaryWithContentsOfFile:itemFilePath];
    if ([[copyplist valueForKey:@"Groepen"] count] >0) {
        NSMutableArray* test =[[NSMutableArray alloc] init];
        for (int k=0 ; k<[[sender valueForKey:@"Groepen"] count]; k++) {
            if ([test containsObject:[[sender valueForKey:@"Groepen"] objectAtIndex:k]]) {
            }
            else
            {
                [test addObject:[[sender valueForKey:@"Groepen"] objectAtIndex:k]];
            }
        }
        for (int k=0 ; k<[[copyplist valueForKey:@"Groepen"] count]; k++) {
            if ([test containsObject:[[copyplist valueForKey:@"Groepen"] objectAtIndex:k]]) {
            }
            else
            {
                [test addObject:[[copyplist valueForKey:@"Groepen"] objectAtIndex:k]];
            }
        }
        [sender setObject:test forKey:@"Groepen"];
        [sender writeToFile:itemFilePath atomically: YES];
        [sender writeToFile:documentsDirectorybureau atomically: YES];
    } else {
        [sender writeToFile:itemFilePath atomically: YES];
        [sender writeToFile:documentsDirectorybureau atomically: YES];
    }
}
+(NSArray*)getAannamelijst:(NSString*)sender
{
    NSString *docDir = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Aannamelijsten"];

    
    NSMutableArray* copyplist = [NSMutableArray arrayWithContentsOfFile:itemFilePath];


    



    return copyplist;
}                   
+(NSArray*)getOnderdelenfullOnID
{
    AppDelegate *appDelegate = [FileManager getDel];
    NSString *docDirnew = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDirnew,@"Onderdelen", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
    NSMutableArray* copyplist = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    if ([copyplist count]>0) {
        return copyplist;
    } else {
        return [FileManager getEmptyPart];
    }
}
+(NSArray*)getOnderdelenAndWrite:(NSMutableDictionary*)sender
{
    AppDelegate *appDelegate = [FileManager getDel];
        ////////////NSLog(@"getOnderdelenAndWrite");
        ////////////NSLog(@"getOnderdelenAndWrite");
    NSString *docDir = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"Onderdelen", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
    NSMutableArray* copyplist = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    NSString *queryit = [NSString stringWithFormat:@"DeelId = %@", [sender valueForKey:@"DeelId"]];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableDictionary *items =  [[[copyplist  filteredArrayUsingPredicate:predicateit] firstObject] mutableCopy];
    [copyplist replaceObjectAtIndex:[copyplist indexOfObject:items] withObject:sender];
    [copyplist writeToFile:itemFilePath atomically: YES];
        ////////////NSLog(@"sender %@", sender);
    return copyplist;
}
+(NSMutableDictionary*)getUser:(NSString*)sender
{
    NSString *documentsDirectory = [self getDir];
    NSString *userlogin = [NSString stringWithFormat:@"%@/Caches/Login.plist",documentsDirectory];
    NSMutableDictionary* person = [NSMutableDictionary dictionaryWithContentsOfFile:userlogin];
    return person;
}
+(void)checkit
{
    AppDelegate *appDelegate = [FileManager getDel];
    NSMutableDictionary* items = [self getUser];
    NSString *url = [NSString stringWithFormat: @"http://%@:8089/api/v1/app/tabelwijzigingen/%@/%@",[items valueForKey:@"Server"], [appDelegate updateUI],[items valueForKey:@"Id"]];
        // [self SetUrl:url];
    NSFileManager *fileManager = [NSFileManager defaultManager];
        //Get the complete users document directory path.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        //Get the first path in the array.
    NSString *documentsDirectory = [paths firstObject];
    NSString *locatioCat2 = [NSString stringWithFormat:@"%@/Caches/",documentsDirectory];
    NSArray *contents = [fileManager contentsOfDirectoryAtURL:[NSURL URLWithString:locatioCat2]
                                   includingPropertiesForKeys:@[]
                                                      options:NSDirectoryEnumerationSkipsHiddenFiles
                                                        error:nil];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pathExtension ENDSWITH 'plist'"];
    for (NSURL *path in [contents filteredArrayUsingPredicate:predicate]) {
        NSString *docDir = [self getDir];
        NSArray *extra = [[path absoluteString] componentsSeparatedByString:@"/"];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@",docDir,[extra lastObject]];
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:itemFilePath];
        if (fileExists) {
        }
        else
        {
        }
    }
}
+(void)insert
{
}
+(void)fileDoc:(NSString*)myJsonString
{
    /*
     
     myJsonString =[myJsonString stringByReplacingOccurrencesOfString:@"NULL" withString:@"\"-\""];
     myJsonString =[myJsonString stringByReplacingOccurrencesOfString:@"null" withString:@"\"-\""];
     //myJsonString =[myJsonString stringByReplacingOccurrencesOfString:@"\"\"" withString:@"\"-\""];
     
     NSData *jsonData = [myJsonString dataUsingEncoding:NSUTF8StringEncoding];
     
     NSString *returnString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
     
     
     NSMutableArray *dict = [returnString mutableObjectFromJSONString];
     
     
     
     
     
     
     NSString *documentsDirectory = [self docDir];
     
     
     
     NSString *finalPath = [NSString stringWithFormat:@"%@/Caches/%@.plist",documentsDirectory,[items objectAtIndex:k]];
     
     
     
     NSString *docDir = [self docDir];
     
     
     
     
     NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,[items objectAtIndex:k]];
     
     [dict writeToFile:itemFilePath atomically: YES];
     
     
     [dict writeToFile:finalPath atomically: YES];
     
     NSString *documentsDirectorybureau =  [NSString stringWithFormat:@"/Users/jeffreysnijder02/Desktop/Demo/%@", [NSString stringWithFormat:@"%@.plist", [items objectAtIndex:k]]];
     
     
     [dict writeToFile:documentsDirectorybureau atomically: YES];
     
     */
}
+(void)reload
{
    AppDelegate *appDelegate = [FileManager getDel];
    NSString* pathDownloadItems = [[NSBundle mainBundle] pathForResource:@"Download" ofType:@"plist"];
    NSMutableArray* items = [NSMutableArray arrayWithContentsOfFile:pathDownloadItems];
    NSString *documentsDirectory = [self getDir];
    NSString *userlogin = [NSString stringWithFormat:@"%@/Caches/Login.plist",documentsDirectory];
    NSMutableDictionary* person = [NSMutableDictionary dictionaryWithContentsOfFile:userlogin];
#if TARGET_IPHONE_SIMULATOR
    NSString * const DeviceMode = @"Simulator";
#else
    NSString * const DeviceMode = @"Device";
#endif
    if ([DeviceMode isEqualToString:@"Simulator"]) {
        person =[[NSMutableDictionary alloc] init];
        [person setObject:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"user_id"] forKey:@"Id"];
        [person setObject:@"Jeffrey Test" forKey:@"Naam"];
        [person setObject:@"77.251.255.106" forKey:@"Server"];;
        [person setObject:@"123456_3" forKey:@"Id"];;
    }
    NSString *url = [NSString stringWithFormat: @"http://%@:8089/api/v1/app/tabelwijzigingen/%@/%@",[person valueForKey:@"Server"], [appDelegate updateUI], [person valueForKey:@"Id"]];


        //[self SetUrl:url];
    NSURL *myURL = [NSURL URLWithString:url];
    NSError *error = nil;
    NSString *myJsonString = [NSString stringWithContentsOfURL:myURL encoding: NSUTF8StringEncoding error:&error];
    myJsonString =[myJsonString stringByReplacingOccurrencesOfString:@"NULL" withString:@"\"-\""];
    myJsonString =[myJsonString stringByReplacingOccurrencesOfString:@"null" withString:@"\"-\""];
    NSMutableDictionary *dict = [myJsonString mutableObjectFromJSONString];
    NSString *Downloadliststring = [NSString stringWithFormat:@"%@/Caches/tabelwijzigingen.plist",documentsDirectory];
    [dict writeToFile:Downloadliststring atomically: YES];
    NSString *dictextra =  [NSString stringWithFormat:@"/Users/jeffreysnijder02/Desktop/Demo/tabelwijzigingen.plist"];
    [dict writeToFile:dictextra atomically: YES];
    NSMutableArray *Downloadlist =[[NSMutableArray alloc] init];
    NSString *Downloadlistpath = [NSString stringWithFormat:@"%@/Caches/Downloadlist.plist",documentsDirectory];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:Downloadlistpath];
    if (fileExists) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"update == %@", [NSNumber numberWithBool:YES]];
        NSArray *arrayextra =  [[items
                                 filteredArrayUsingPredicate:predicate] mutableCopy];
        float counter = 0;
        for (NSMutableDictionary *insert in arrayextra) {
            counter = counter+1.0;
            NSDate *now = [[NSDate alloc] init];
            [insert setObject:now forKey:@"date"];
            NSString *url =@"";
            BOOL Set =[[insert valueForKey:@"taal"] floatValue];
            if (Set) {
                url = [NSString stringWithFormat: @"http://%@:8089/api/v1/v1/app/%@/%@/%@",[person valueForKey:@"Server"], [insert valueForKey:@"URL"], [appDelegate updateUI],[person valueForKey:@"Id"]];
                    // [self SetUrl:url];
            }
            else
            {
                url = [NSString stringWithFormat: @"http://%@:8089/api/v1/app/%@/%@/%@",[person valueForKey:@"Server"], [insert valueForKey:@"URL"], [appDelegate updateUI],[person valueForKey:@"Id"]];
                    // [self SetUrl:url];
            }
            NSURL *myURL = [NSURL URLWithString:url];
            NSError *error = nil;
            NSString *myJsonString = [NSString stringWithContentsOfURL:myURL encoding: NSUTF8StringEncoding error:&error];
            myJsonString =[myJsonString stringByReplacingOccurrencesOfString:@"NULL" withString:@"\"-\""];
            myJsonString =[myJsonString stringByReplacingOccurrencesOfString:@"null" withString:@"\"-\""];
            NSData *jsonData = [myJsonString dataUsingEncoding:NSUTF8StringEncoding];
            NSString *returnString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSMutableArray *dict = [returnString mutableObjectFromJSONString];
            NSString *documentsDirectory = [self getDir];
            NSString *finalPath = [NSString stringWithFormat:@"%@/Caches/%@.plist",documentsDirectory,[[insert valueForKey:@"URL"] capitalizedString]];
            [insert setObject:[insert valueForKey:@"URL"] forKey:@"item"];
            NSString *docDir = [self getDir];
            NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,[[insert valueForKey:@"URL"] capitalizedString]];
            [dict writeToFile:itemFilePath atomically: YES];
            [dict writeToFile:finalPath atomically: YES];
            NSString *documentsDirectorybureau =  [NSString stringWithFormat:@"/Users/jeffreysnijder02/Desktop/Demo/%@", [NSString stringWithFormat:@"%@.plist", [[insert valueForKey:@"URL"] capitalizedString]]];
            [dict writeToFile:documentsDirectorybureau atomically: YES];
            [Downloadlist addObject:insert];

        }
        NSString *documentsDownloadlist =  [NSString stringWithFormat:@"/Users/jeffreysnijder02/Desktop/Demo/%@", [NSString stringWithFormat:@"Downloadlist.plist"]];
        [Downloadlist writeToFile:documentsDownloadlist atomically: YES];
        [Downloadlist writeToFile:Downloadlistpath atomically: YES];
    } else {
        float counter = 0;
        for (NSMutableDictionary *insert in items) {
            counter = counter+1.0;
            NSDate *now = [[NSDate alloc] init];
            [insert setObject:now forKey:@"date"];
            NSString *url =@"";
            BOOL Set =[[insert valueForKey:@"taal"] floatValue];
            if (Set) {

                url = [NSString stringWithFormat: @"http://%@:8089/api/v1/app/%@/%@/%@",[person valueForKey:@"Server"], [insert valueForKey:@"URL"],[appDelegate updateUI], [person valueForKey:@"Id"]];
                    //[self SetUrl:url];
            }
            else
            {
                url = [NSString stringWithFormat: @"http://%@:8089/api/v1/app/%@/%@/%@",[person valueForKey:@"Server"], [insert valueForKey:@"URL"],[appDelegate updateUI], [person valueForKey:@"Id"]];
                    //[self SetUrl:url];
            }
            NSURL *myURL = [NSURL URLWithString:url];
            NSError *error = nil;
            NSString *myJsonString = [NSString stringWithContentsOfURL:myURL encoding: NSUTF8StringEncoding error:&error];
            myJsonString =[myJsonString stringByReplacingOccurrencesOfString:@"NULL" withString:@"\"-\""];
            myJsonString =[myJsonString stringByReplacingOccurrencesOfString:@"null" withString:@"\"-\""];
            NSData *jsonData = [myJsonString dataUsingEncoding:NSUTF8StringEncoding];
            NSString *returnString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSMutableArray *dict = [returnString mutableObjectFromJSONString];
            NSString *documentsDirectory = [self getDir];
            NSString *finalPath = [NSString stringWithFormat:@"%@/Caches/%@.plist",documentsDirectory,[[insert valueForKey:@"URL"] capitalizedString]];
            [insert setObject:[insert valueForKey:@"URL"] forKey:@"item"];
            NSString *docDir = [self getDir];
            NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,[[insert valueForKey:@"URL"] capitalizedString]];
            [dict writeToFile:itemFilePath atomically: YES];
            [dict writeToFile:finalPath atomically: YES];
            NSString *documentsDirectorybureau =  [NSString stringWithFormat:@"/Users/jeffreysnijder02/Desktop/Demo/%@", [NSString stringWithFormat:@"%@.plist", [[insert valueForKey:@"URL"] capitalizedString]]];
            [dict writeToFile:documentsDirectorybureau atomically: YES];
            [Downloadlist addObject:insert];
        }
        NSString *documentsDownloadlist =  [NSString stringWithFormat:@"/Users/jeffreysnijder02/Desktop/Demo/%@", [NSString stringWithFormat:@"Downloadlist.plist"]];
        [Downloadlist writeToFile:documentsDownloadlist atomically: YES];
        [Downloadlist writeToFile:Downloadlistpath atomically: YES];
    }
    NSArray *pathsCachescopy = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryCachescopy = [pathsCachescopy objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [documentsDirectoryCachescopy stringByAppendingPathComponent:@"/Cachescopy"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:dataPath])
    {

    }
}
+(void) SetUrl:(NSString*)dateURL
{

        //NSLog(@"%@", dateURL);
    [RSDownloadManager sharedManager].backgroundSessionCompletionHandler = ^{
        dispatch_async(dispatch_get_main_queue(), ^{

            AppDelegate *appDelegate = [FileManager getDel];
            [appDelegate.viewcontroller.overlay setAlpha:0];
        });
    };
    [[RSDownloadManager sharedManager] downloadInBackgroundWithURL:dateURL downloadProgress:^(NSNumber *progress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            AppDelegate *appDelegate = [FileManager getDel];
            [appDelegate.viewcontroller.overlay setAlpha:0.5];
            [appDelegate.viewcontroller.overlay progressChange:[progress floatValue]];

        });

    } success:^(NSURLResponse *response, NSURL *filePath) {
    } andFailure:^(NSError *error) {
    }];
}




+(void)ImagesWrite:(NSObject*)images;
{
    AppDelegate *appDelegate = [FileManager getDel];


    if ([images isKindOfClass:[NSArray class]]) {


        double delayInSeconds = 0.6;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            appDelegate.alleVoertuigenArray =[[NSMutableArray alloc] initWithArray:[FileManager getArray:@"Voertuigen"]];
            [appDelegate.viewcontroller.navigaionView.collectionViewNav reloadData];
            [appDelegate.viewcontroller.menu.ListVoertuigen.tableResult reloadData];
        });
    }

    else {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths firstObject];
        NSString *plistPath2 = [documentsDirectory
                                stringByAppendingPathComponent:[NSString stringWithFormat:@"/Caches/%@.plist",images]];
        NSMutableArray* b = [NSMutableArray arrayWithContentsOfFile:plistPath2];

        NSMutableDictionary* items = [self getUser];
        for (int r =0; r < [b count]; r++) {

            NSArray *pathsCachescopy = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
            NSString *docDir = [pathsCachescopy objectAtIndex:0]; // Get documents folder
            NSString *dataPath = [NSString stringWithFormat:@"%@/Caches/%@",docDir,[[b objectAtIndex:r] valueForKey:@"Orgnaam"]];

            if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
            {
                NSString *url = [NSString stringWithFormat: @"http://%@:8089/api/v1/app/Foto/%@/%@/%@",[items valueForKey:@"Server"],[appDelegate updateUI],[items valueForKey:@"Id"],[[b objectAtIndex:r] valueForKey:@"FotoGrootId"]];
                NSURL *urlw = [NSURL URLWithString:url];
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlw];
                NSURLSession *session = [NSURLSession sharedSession];
                NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                                  {
                                                      if (error != nil) {
                                                      } else {
                                                          NSString *extra = [NSString stringWithFormat: @"http://%@:8089/api/v1/app/Foto/%@/%@/%@",[items valueForKey:@"Server"],[appDelegate updateUI],[items valueForKey:@"Id"],[[b objectAtIndex:r] valueForKey:@"FotoGrootId"]];
                                                          if ([data length] == response.expectedContentLength && [data length] != 0) {
                                                              NSString *myJsonString = [NSString stringWithContentsOfURL:[NSURL URLWithString:extra] encoding: NSUTF8StringEncoding error:&error];
                                                              if ([myJsonString length]>10) {
                                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                                      AppDelegate *appDelegate = [FileManager getDel];
                                                                      [appDelegate.viewcontroller.overlay setAlpha:0.5];
                                                                      [appDelegate.viewcontroller.overlay progressChange:[myJsonString length]/1000];
                                                                  });


                                                                  dispatch_sync(dispatch_get_main_queue(), ^{

                                                                      UIImage *image2 = [self decodeBase64ToImage:myJsonString];
                                                                      NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@",docDir,[[b objectAtIndex:r] valueForKey:@"Orgnaam"]];
                                                                      NSData *data2 = [NSData dataWithData:UIImagePNGRepresentation(image2)];
                                                                      [data2 writeToFile:itemFilePath atomically:YES];

                                                                      NSString *documentsDirectorybureau =  [NSString stringWithFormat:@"/Users/jeffreysnijder02/Desktop/Demo/%@", [[b objectAtIndex:r] valueForKey:@"Orgnaam"]];
                                                                      [data2 writeToFile:documentsDirectorybureau atomically:YES];

                                                                      AppDelegate *appDelegate = [FileManager getDel];
                                                                      appDelegate.alleVoertuigenArray =[[NSMutableArray alloc] initWithArray:[FileManager getArray:@"Voertuigen"]];
                                                                      [appDelegate.viewcontroller.navigaionView.collectionViewNav reloadData];
                                                                      [appDelegate.viewcontroller.menu.ListVoertuigen.tableResult reloadData];
                                                                  });
                                                              }
                                                              else
                                                              {

                                                              }
                                                          }
                                                      }
                                                  }];
                [dataTask resume];
            }
            else
            {



            }

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
}
+(NSArray*)removeFotos_onderdelenid:(NSString*)idit
{
    AppDelegate *appDelegate = [FileManager getDel];
    NSString *docDir = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"FotosInfo", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
    NSMutableArray* copyplist = [[NSMutableArray arrayWithContentsOfFile:itemFilePath] mutableCopy];
    NSString *queryit = [NSString stringWithFormat:@"Orgnaam LIKE [cd]'%@'", idit];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[copyplist  filteredArrayUsingPredicate:predicateit] mutableCopy];
    [copyplist removeObject:[items firstObject]];
    [copyplist writeToFile:itemFilePath atomically: YES];
    return copyplist;
}
+(void)voertuigenPlist:(NSMutableArray*)total
{
    NSString *docDir = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Voertuigen"];
    [total writeToFile:itemFilePath atomically: YES];
    NSString *documentsDirectorybureau =  [NSString stringWithFormat:@"/Users/jeffreysnijder02/Desktop/Demo/%@", [NSString stringWithFormat:@"%@.plist", @"Voertuigen"]];
    [total writeToFile:documentsDirectorybureau atomically: YES];
}
+(void)setPlist:(NSString*)source
{                   
    NSString *strBundle = [[NSBundle mainBundle] pathForResource:source ofType:@"csv"];
    NSString *fileObj = [NSString stringWithContentsOfFile:strBundle
                                                  encoding:NSUTF8StringEncoding
                                                     error:nil];
    fileObj =[fileObj stringByReplacingOccurrencesOfString:@"NULL" withString:@"-"];
    fileObj =[fileObj stringByReplacingOccurrencesOfString:@"null" withString:@"\"-\""];
    fileObj =[fileObj stringByReplacingOccurrencesOfString:@"\"\"" withString:@"\"-\""];
    NSArray *objectArray = [fileObj componentsSeparatedByString:@"\n"];
    NSArray *values = [[objectArray firstObject] componentsSeparatedByString:@";"];
    NSMutableArray *Total = [[NSMutableArray alloc] init];
    for (int i = 1; i < [objectArray count]-1; i++) {
        NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] init];
        NSArray *content = [[objectArray objectAtIndex:i] componentsSeparatedByString:@";"];
        if ([content count]>=[values count])
        {
            for (int k = 0; k < [values count]; k++) {

                [dataDictionary setValue:[content objectAtIndex:k] forKey:[values objectAtIndex:k]];
            }
        }
        else
        {
        }
        [Total addObject:dataDictionary];
    }
    NSString *documentsArrybureau =  [NSString stringWithFormat:@"/Users/jeffreysnijder02/Desktop/Demo/%@", [NSString stringWithFormat:@"CSV_%@.plist", source]];
    [Total writeToFile:documentsArrybureau atomically: YES];
}
+(NSArray*)getArray:(NSString*)sender
{
    NSString *docDir = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,sender];
    NSMutableArray* a = [NSMutableArray arrayWithContentsOfFile:itemFilePath];

    if ([a count]>1) {

        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"UploadDate" ascending:FALSE];
        [a sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        return a;
    } else {
        return a;

    }
}
+(UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}
+(BOOL)writeToPlistFile:(NSString*)filename{
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:self];
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths firstObject];
    NSString * path = [documentsDirectory stringByAppendingPathComponent:filename];
    BOOL didWriteSuccessfull = [data writeToFile:path atomically:YES];
    return didWriteSuccessfull;
}
+(NSArray*)readFromPlistFile:(NSString*)filename{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths firstObject];
    NSString * path = [documentsDirectory stringByAppendingPathComponent:filename];
    NSData * data = [NSData dataWithContentsOfFile:path];
    return  [NSKeyedUnarchiver unarchiveObjectWithData:data];
}
#pragma mark - new method                   
+(void)refresh {                   
    sharedOnderdelen = nil;
    predOnderdelen = 0;
}                   
+(NSArray*)getOnderdelenVoertuigId:(NSString*)sender
{                   
    AppDelegate *appDelegate = [FileManager getDel];
    
    NSString *docDir = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"Onderdelen", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
    NSMutableArray* copyplist = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    NSString *queryit = [NSString stringWithFormat:@"DeelId = %@", sender];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[copyplist  filteredArrayUsingPredicate:predicateit] mutableCopy];
    if ([items count]>0) {
        return items;
    } else {
        return NULL;
    }
}

+(NSArray*)getOnderdelen
{

    NSString *docDir = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Onderdelen"];
    NSMutableArray *Onderdelen = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    return Onderdelen;
}
+(NSArray*)getVoertuigvelden
{
        ////////NSLog(@"getVoertuigvelden");

    static FileManager *shared = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
            ////////////NSLog(@"een getallVeldenValues");
        shared = [[FileManager alloc] init];
        NSString *docDir = [self getDir];
        NSString *locatioCat = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Velden"];
        NSMutableArray* copyCat= [NSMutableArray arrayWithContentsOfFile:locatioCat];
        NSString *queryit = [NSString stringWithFormat:@"VoertuigVeld == 1"];
        NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
        shared.Voertuigvelden =  [[copyCat  filteredArrayUsingPredicate:predicateit] mutableCopy];

        if ([ shared.Voertuigvelden count]==0) {

            shared.Voertuigvelden = [[NSMutableArray alloc] init];
        }

            ////////NSLog(@"Voertuigvelden %@", shared.Voertuigvelden);

    });
    return  shared.Voertuigvelden;
}
+(NSArray*)getStandaardCategorieen:(NSString*)sender
{
    static FileManager *shared = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
            ////////////NSLog(@"een getallVeldenValues");
        shared = [[FileManager alloc] init];
        NSString *docDir = [self getDir];
        NSString *locatioCat = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Categorieen"];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(Naam != %@) and (Naam != %@)", @"Autos / Groepen", @"Overige diensten"];

        NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey: @"Naam" ascending: YES];
        shared.Categorieen =   [[[NSMutableArray arrayWithContentsOfFile:locatioCat] filteredArrayUsingPredicate:predicate] sortedArrayUsingDescriptors:@[sd]];




    });
    return shared.Categorieen;
}                   
+(NSArray*)getVeldenId:(NSString*)sender
{

        ////////NSLog(@"getVeldenId");

    static FileManager *shared = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        shared = [[FileManager alloc] init];
        NSString *docDir = [self getDir];
        NSString *locatioCat = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Velden"];
        shared.velden = [NSMutableArray arrayWithContentsOfFile:locatioCat];
    });
    if ([shared.velden count]==0) {
        NSString *docDir = [self getDir];
        NSString *locatioCat = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Velden"];
        shared.velden = [NSMutableArray arrayWithContentsOfFile:locatioCat];
    }
    NSString *queryit = [NSString stringWithFormat:@"VeldId = %@", sender];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[shared.velden  filteredArrayUsingPredicate:predicateit] mutableCopy];
    if ([items count]>0) {

        return items;
    } else {
        return NULL;
    }
}                   
+(NSMutableDictionary*)getOnderdelenWaardes:(NSString*)sender
{                   
    NSString *docDir = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Onderdelen"];
    NSMutableArray *Onderdelen = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    NSString *queryit = [NSString stringWithFormat:@"DeelId = %@", sender];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableDictionary *items =  [[[Onderdelen  filteredArrayUsingPredicate:predicateit] firstObject] mutableCopy];
    return items;
}                   
+(NSMutableDictionary*)getMAskVeld:(NSString*)sender
{                                      
    static FileManager *shared = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        shared = [[FileManager alloc] init];
        NSString *docDir = [self getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Veldmaskers"];
        shared.Veldmaskers = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    });
    NSString *queryit = [NSString stringWithFormat:@"VeldMaskId = %@", sender];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableDictionary *items =  [[[shared.Veldmaskers  filteredArrayUsingPredicate:predicateit] mutableCopy] firstObject];
    if ([items allKeys]>0) {
        return items;
    } else {
        NSMutableDictionary *iteem = [[NSMutableDictionary alloc] init];
        [iteem setObject:@"MCT" forKey:@"Mask"];
        [iteem setObject:[NSNumber numberWithInt:1] forKey:@"VeldMaskId"];
        return iteem;
    }
}                   
+(NSArray*)getEmptyPart
{
    
    static FileManager *shared = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        shared = [[FileManager alloc] init];
        NSString* path3 = [[NSBundle mainBundle] pathForResource:@"EmptyPart" ofType:@"plist"];
        shared.Empty = [NSArray arrayWithContentsOfFile:path3];
    });
    return shared.Empty;
}                   
+(NSArray*)getAfstand
{
    static FileManager *shared = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        shared = [[FileManager alloc] init];
        NSString* path3 = [[NSBundle mainBundle] pathForResource:@"Afstand" ofType:@"plist"];
        shared.Afstand = [NSArray arrayWithContentsOfFile:path3];
    });
    return shared.Afstand;
}                                      
+(NSArray*)getBTW
{
    static FileManager *shared = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        shared = [[FileManager alloc] init];
        NSString* path3 = [[NSBundle mainBundle] pathForResource:@"BTW" ofType:@"plist"];
        shared.BTW = [NSArray arrayWithContentsOfFile:path3];
    });

    return  shared.BTW;
}
+(NSArray*)getLand
{                   
    static FileManager *shared = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        shared = [[FileManager alloc] init];
        NSString *docDir = [self getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Landen"];
        shared.landen = [NSArray arrayWithContentsOfFile:itemFilePath];
    });
    return  shared.landen;
}                                      
+(NSArray*)getVeldmaskers:(NSString*)sender
{
    static FileManager *shared = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        shared = [[FileManager alloc] init];
        NSString *docDir = [self getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Veldmaskers"];
        shared.Veldmaskers = [NSArray arrayWithContentsOfFile:itemFilePath];
    });
    NSString *queryit = [NSString stringWithFormat:@"VeldMaskId = %@", sender];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[shared.Veldmaskers  filteredArrayUsingPredicate:predicateit] mutableCopy];
    return items;
}
+(NSDictionary*)getInternetSoorten
{
    static FileManager *shared = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
            ////////////NSLog(@"een getInternetSoorten");
        shared = [[FileManager alloc] init];
        NSString *docDir = [self getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Internetsoorten"];
        shared.internetsoorten = [NSDictionary dictionaryWithContentsOfFile:itemFilePath];
    });
    return shared.internetsoorten;
}                   
+(NSArray*)getallVeldenValues
{

    static FileManager *shared = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
            ////////////NSLog(@"een getallVeldenValues");
        shared = [[FileManager alloc] init];
        NSString *docDir = [self getDir];
        NSString *locatioCat = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Velden"];
        shared.velden = [NSMutableArray arrayWithContentsOfFile:locatioCat];
    });
    if ([shared.velden count]==0) {
        NSString *docDir = [self getDir];
        NSString *locatioCat = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Velden"];
        shared.velden = [NSMutableArray arrayWithContentsOfFile:locatioCat];
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"VeldWaarden.@count>0"];
    NSMutableArray* items= [[shared.velden filteredArrayUsingPredicate:predicate] mutableCopy];
    NSMutableArray *copyitems =[[NSMutableArray alloc] init];
    for (int k=0 ; k<[items count]; k++) {
        [copyitems addObject:[[items objectAtIndex:k] valueForKey:@"InternetOmschrijving"]];
    }

    return copyitems;
}                   
+(NSArray*)getMerk:(NSString*)sender
{
    AppDelegate *appDelegate = [FileManager getDel];
    static FileManager *shared = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
            ////////////NSLog(@"getMerk");
        shared = [[FileManager alloc] init];
        NSString *docDir = [self getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Merken"];
        shared.merken = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    });
    NSString *queryit = [NSString stringWithFormat:@"MerkId = %@", sender];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[shared.merken  filteredArrayUsingPredicate:predicateit] mutableCopy];
    [appDelegate.currentCarDictionary setValue:[[items firstObject] valueForKey:@"Naam"] forKey:@"Naam"];
    return items;
}

+(NSArray*)getMerkOnNaam:(NSString*)sender
{

    AppDelegate *appDelegate = [FileManager getDel];

    static FileManager *shared = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
            ////////////NSLog(@"getMerk");
        shared = [[FileManager alloc] init];
        NSString *docDir = [self getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Merken"];
        shared.merkenNamen = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    });
    NSString *queryit = [NSString stringWithFormat:@"Naam contains [cd]'%@'", sender];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[shared.merkenNamen  filteredArrayUsingPredicate:predicateit] mutableCopy];

    if ([items count]>0)

    {



        NSString *query = [NSString stringWithFormat:@"MerkId = %@", [[items valueForKey:@"MerkId"] componentsJoinedByString:@" || MerkId = "]];

        NSPredicate *predicate = [NSPredicate predicateWithFormat:query];

        return [[appDelegate.alleVoertuigenArray  filteredArrayUsingPredicate:predicate] mutableCopy];;

    } else {

        return appDelegate.alleVoertuigenArray;
    }


}
+(NSArray*)getModellen:(NSString*)sender
{
    static FileManager *shared = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
            ////////////NSLog(@"getModellen");
        shared = [[FileManager alloc] init];
        NSString *docDir = [self getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Modellen"];
        shared.modellen = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    });
    NSString *queryit = [NSString stringWithFormat:@"MerkId = %@", sender];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[shared.modellen  filteredArrayUsingPredicate:predicateit] mutableCopy];
    return items;
}
+(NSArray*)getModel:(NSString*)sender
{
    AppDelegate *appDelegate = [FileManager getDel];
    static FileManager *shared = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        shared = [[FileManager alloc] init];

        NSString *docDir = [self getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Modellen"];
        shared.modellen = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    });
    NSString *queryit = [NSString stringWithFormat:@"ModelId = %@", sender];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[shared.modellen  filteredArrayUsingPredicate:predicateit] mutableCopy];
    NSString * result = [[[[items firstObject] valueForKey:@"Namen"] valueForKey:@"InternetNaam"] componentsJoinedByString:@", "];
    [appDelegate.currentCarDictionary setValue:result forKey:@"Namen"];
    return items;
}

+(NSArray*)getModeOnName:(NSString*)sender
{
    NSString *docDir = [self getDir];
    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Modellen"];
    NSMutableArray *modellen = [NSMutableArray arrayWithContentsOfFile:itemFilePath];



    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ANY SELF CONTAINS %@", sender];
    NSArray *array = [[[modellen valueForKey:@"Namen"] valueForKey:@"InternetNaam"] filteredArrayUsingPredicate: predicate];


    return array;
}



+(NSString*)getVeld:(NSString*)sender
{
    static FileManager *shared = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
            ////////////NSLog(@"getVeld");
        shared = [[FileManager alloc] init];
        NSString *docDir = [self getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"VeldAfhankelijk"];
        shared.Veldafhankelijk = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    });
    NSString *queryit = [NSString stringWithFormat:@"Waarde_Afhankelijk contains [cd]'%@'", sender];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[shared.Veldafhankelijk  filteredArrayUsingPredicate:predicateit] mutableCopy];
    return [items firstObject];
}
+(NSArray*)getLand:(NSString*)sender
{
    static FileManager *shared = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
            ////////////NSLog(@"getLand");
        shared = [[FileManager alloc] init];
        NSString *docDir = [self getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Landen"];
        shared.landen = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    });
    NSString *queryit = [NSString stringWithFormat:@"LandId = %@", sender];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[shared.landen  filteredArrayUsingPredicate:predicateit] mutableCopy];
    return items;
}
+(NSArray*)getPlaatsen:(NSString*)sender
{
    static FileManager *shared = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
            ////////////NSLog(@"getPlaatsen");
        shared = [[FileManager alloc] init];
        NSString *docDir = [self getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Plaatsen"];
        shared.plaatsen = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    });
    NSString *queryit = [NSString stringWithFormat:@"DeelPlaatsId = %@", sender];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[shared.plaatsen  filteredArrayUsingPredicate:predicateit] mutableCopy];
    return items;
}
+(NSArray*)getOnderdelen:(NSInteger)sender
{


    static FileManager *shared = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
            ////////////NSLog(@"getAfhangkelijkheden");
        shared = [[FileManager alloc] init];
        NSString *docDir = [self getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Onderdelen"];
        NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey: @"Naam" ascending: YES];
        shared.Onderdelen =   [[NSMutableArray arrayWithContentsOfFile:itemFilePath] sortedArrayUsingDescriptors:@[sd]];


    });

    NSNumberFormatter *formatter = [NSNumberFormatter new];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.usesGroupingSeparator = YES;

    NSString *queryit = [NSString stringWithFormat:@"DeelId = %li", (long)sender];

    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableDictionary *items =  [[[shared.Onderdelen  filteredArrayUsingPredicate:predicateit] firstObject] mutableCopy];
    NSArray *velden = [FileManager getVeldenOnlist:[[items valueForKey:@"DeelVelden"] valueForKey:@"VeldId"]];


    return velden;
}
+(NSArray*)getAfhangkelijkheden:(NSString*)sender
{
    static FileManager *shared = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
            ////////////NSLog(@"getAfhangkelijkheden");
        shared = [[FileManager alloc] init];
        NSString *docDir = [self getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Veldafhangkelijk"];
        shared.Veldafhankelijk = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    });
    NSString *queryit = [NSString stringWithFormat:@"SuggestieId = %@", sender];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[shared.Veldafhankelijk  filteredArrayUsingPredicate:predicateit] mutableCopy];
    return items;
}
+(NSArray*)getVeldafhankelijk:(NSString*)sender
{
    static FileManager *shared = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
            ////////////NSLog(@"getVeldafhankelijk");
        shared = [[FileManager alloc] init];
        NSString *docDir = [self getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Veldafhangkelijk"];
        shared.Veldafhankelijk = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    });
    NSString *queryit = [NSString stringWithFormat:@"Waarde_Afhankelijk like [cd]'%@'", sender];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[shared.Veldafhankelijk  filteredArrayUsingPredicate:predicateit] mutableCopy];
    if ([items count] >0) {
        return items;
    } else {
        NSMutableArray *itemcopy = [[NSMutableArray alloc] init];
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]initWithDictionary:[shared.Veldafhankelijk firstObject]];
        [tempDictionary setObject:@"" forKey:@"Waarde"];
        [itemcopy addObject:tempDictionary];
        return itemcopy;
    }
}                   
+(NSArray*)getSuggesties:(NSString*)sender
{
    static FileManager *shared = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
            ////////////NSLog(@"getSuggesties");
        shared = [[FileManager alloc] init];
        NSString *docDir = [self getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Suggesties"];
        shared.Suggesties = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    });
    NSString *queryit = [NSString stringWithFormat:@"SuggestieId = %@", sender];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *items =  [[shared.Suggesties  filteredArrayUsingPredicate:predicateit] mutableCopy];
    return items;
}
+(NSArray*)getVoertuigsoorten
{
    static FileManager *shared = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
            ////////////NSLog(@"getVoertuigsoorten");
        shared = [[FileManager alloc] init];
        NSString *docDir = [self getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Voertuigsoorten"];
        shared.Voertuigsoorten = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    });
    return  shared.Voertuigsoorten;
}
+(NSArray*)getAannamelijsten:(NSString*)sender
{
    static FileManager *shared = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
            ////////////NSLog(@"getAannamelijsten");
        shared = [[FileManager alloc] init];
        NSString *docDir = [self getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"Categorieen"];
        shared.Categorieen = [NSMutableArray arrayWithContentsOfFile:itemFilePath];
    });
    return  shared.Categorieen;
}
@end
