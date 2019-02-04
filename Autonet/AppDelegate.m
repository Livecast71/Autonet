    //
    //  AppDelegate.m
    //  Autonet
    //
    //  Created by Livecast02 on 28-11-16.
    //  Copyright © 2016 Autonet. All rights reserved.
    //
#import "AppDelegate.h"
#import "ViewController.h"
#import "FileManager.h"
#import "TOTPGenerator.h"
#import "MF_Base32Additions.h"
@interface AppDelegate ()
@end
@implementation AppDelegate
@synthesize viewcontroller;
@synthesize window;
@synthesize currentCarDictionary;
@synthesize onderdelenVoertuigArray;
@synthesize categorieenStandaardArray;
@synthesize categorieenArray;
@synthesize onderdelenArray;
@synthesize searchCatagorie;
@synthesize currentimages;
@synthesize currentimage;
@synthesize alleVoertuigenArray;
@synthesize indexand;
@synthesize makenewOnderdeel;
@synthesize removall;
@synthesize viewNumber;
@synthesize uneditable;
@synthesize currentCollection;
@synthesize currentOnderdeel;
@synthesize currentItemDictonary;
@synthesize currentItemListView;
@synthesize aanname;
@synthesize alleVoertuigenArrayCopy;
@synthesize moviesize;
@synthesize navigation;
@synthesize generator;
@synthesize Soort;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
        // Override point for customization after application launch.
    [self updateUI];                   
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];                   
    viewcontroller =[[ViewController alloc] init];
    navigation=[[UINavigationController alloc] initWithRootViewController:viewcontroller];
    [navigation.navigationBar setHidden:YES];
    [self.window setRootViewController: navigation];
    searchCatagorie =0;

    removall = [[NSMutableArray alloc] init];
    currentCarDictionary = [[NSMutableDictionary alloc] init];
    alleVoertuigenArrayCopy = [[NSMutableArray alloc] init];
    onderdelenVoertuigArray= [[NSMutableArray alloc] init];
    alleVoertuigenArray = [[NSMutableArray alloc] init];
    categorieenStandaardArray= [[NSMutableArray alloc] init];
    categorieenArray= [[NSMutableArray alloc] init];
    onderdelenArray= [[NSMutableArray alloc] init];
    currentItemDictonary= [[NSMutableDictionary alloc] init];


    NSString* path3 = [[NSBundle mainBundle] pathForResource:@"CarItemsfold" ofType:@"plist"];
    NSMutableArray* items = [NSMutableArray arrayWithContentsOfFile:path3];


      NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);


    NSLog(@"%@", paths);
    
    uneditable = [[NSMutableArray alloc] init];
    [uneditable addObject:@"Tellerstand"];
    for (int k =0; k < [items count]; k++) {
        
        [uneditable addObjectsFromArray: [[[items objectAtIndex:k] valueForKey:@"List"] valueForKey:@"item"]];
        
    }
    NSString *docDir = [FileManager getDir];
    NSString *locatioCat = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"CarItemsfold"];
    [items writeToFile:locatioCat atomically: YES];
    NSString *documentsDirectorybureau =  [NSString stringWithFormat:@"/Users/jeffreysnijder02/Desktop/Demo/%@",[NSString stringWithFormat:@"%@.plist",@"CarItemsfold"]];
    [items writeToFile:documentsDirectorybureau atomically: YES];
    if (![self connected]) {
    } else {
    }
    [self removeCarfiles:@"5401"];

    
    return YES;
}
-(void) removeCarfiles:(NSString*)Carid
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *directory = [documentsDirectory stringByAppendingPathComponent:@"Caches/"];
    NSError *error = nil;
    for (NSString *file in [fm contentsOfDirectoryAtPath:directory error:&error]) {
        if ([file rangeOfString:Carid].location == NSNotFound) {
        } else {
            NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@",documentsDirectory,file];
            NSFileManager *fileManager = [NSFileManager defaultManager];
            [fileManager removeItemAtPath:itemFilePath error:NULL];
        }
    }
}
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{                   
    if ([window.rootViewController.presentedViewController isKindOfClass:[imagePickerViewController class]]) {                   

         return UIInterfaceOrientationMaskAll;
    } else {                   
                
    return UIInterfaceOrientationMaskLandscape;                   
    }
}
- (NSString*)updateKenteken:(NSString*)kenteken

{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < [kenteken length]; i++) {
        NSString *ch = [kenteken substringWithRange:NSMakeRange(i, 1)];
        [array addObject:ch];
    }

    if ([array count]==6) {

        

        return [NSString stringWithFormat:@"\t%@%@-%@%@-%@%@", [array objectAtIndex:0],[array objectAtIndex:1],[array objectAtIndex:2],[array objectAtIndex:3],[array objectAtIndex:4],[array objectAtIndex:5]];
    } else {

          return kenteken;
    }



}
- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}
- (void)applicationWillResignActive:(UIApplication *)application {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}
-(void)createDatabaseIfNeeded {
        //Voertuig_15383.json
        //Voertuig_15393.json
        //Voertuig_15394.json
    NSArray *two =[[NSArray alloc] initWithObjects:@"Voertuig_201.json", nil];
    BOOL success;
    NSError *error;
        //FileManager - Object allows easy access to the File System.
    NSFileManager *FileManager = [NSFileManager defaultManager];
        //Get the complete users document directory path.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    for (int k =0; k < [two count]; k++) {
           //Create the complete path to the database file.
        NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/Caches/Aanname/%@", [two objectAtIndex:k]]];
            //Check if the file exists or not.
        success = [FileManager fileExistsAtPath:databasePath];
            //If the database is present then quit.
        if(success) return;
            //the database does not exists, so we will copy it to the users document directory]
        NSString *dbPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"Data/%@", [two objectAtIndex:k]]];
            //Copy the database file to the users document directory.
        success = [FileManager copyItemAtPath:dbPath toPath:databasePath error:&error];
        if(!success)
            NSAssert1(0, @"Failed to copy the database. Error: %@.", [error localizedDescription]);
    }
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}
- (void)applicationWillTerminate:(UIApplication *)application {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}
#pragma mark - Core Data stack
@synthesize persistentContainer = _persistentContainer;
- (NSPersistentContainer *)persistentContainer {
        // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
           _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Autonet"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
               if (error != nil) {
                       // Replace this implementation with code to handle the error appropriately.
                        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                        ////////////NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    return _persistentContainer;
}
#pragma mark - Core Data Saving support
- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
           // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            ////////////NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}
- (NSString*)updateUI
{
    long timestamp = (long)[[NSDate date] timeIntervalSince1970];
    if(timestamp % 30 != 0){
        timestamp -= timestamp % 30;
    }
    NSString *secret = @"IF2XI33OMV2DSVLKLYTDMOCB";
    NSData *secretData =  [NSData dataWithBase32String:secret];
    NSInteger digits = 6;
    NSInteger period = 30;
    generator = [[TOTPGenerator alloc] initWithSecret:secretData algorithm:kOTPGeneratorSHA1Algorithm digits:digits period:period];
    NSString *pin = [generator generateOTPForDate:[NSDate dateWithTimeIntervalSince1970:timestamp]];

    NSLog(@"%f", self.generator.period);

    return pin;
}
- (NSString *)newUUID
{
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef uuidStr = CFUUIDCreateString(NULL, uuid);
    NSString *result = [[NSString alloc] initWithFormat:@"%@", [(NSString *)CFBridgingRelease(uuidStr) lowercaseString]];
    return result;
}
@end
