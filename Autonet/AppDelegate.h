//
//  AppDelegate.h
//  Autonet
//
//  Created by Livecast02 on 28-11-16.
//  Copyright © 2016 Autonet. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ViewController.h"
#import "Reachability.h"
#import "ExtraLabelView.h"
#import "ItemListView.h"
#import "TOTPGenerator.h"
#import "MF_Base32Additions.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,UIAlertViewDelegate, UIDocumentInteractionControllerDelegate, NSStreamDelegate>
@property (nonatomic, assign)  NSUInteger viewNumber;
@property (nonatomic, strong)  NSIndexPath *indexand;
@property (strong, nonatomic) NSMutableDictionary *currentCarDictionary;
@property (nonatomic, strong) UIImage *currentimage;
@property (nonatomic, strong) NSMutableArray *removall;
@property (nonatomic, strong) OnderdeelView *currentOnderdeel;
@property (nonatomic, strong) UICollectionImage *currentCollection;
@property (nonatomic, strong) NSMutableArray *currentimages;
@property (strong, nonatomic) NSMutableArray *onderdelenVoertuigArray;
@property (nonatomic, assign) NSInteger searchCatagorie;
@property (strong, nonatomic) NSMutableArray *categorieenStandaardArray;
@property (strong, nonatomic) NSMutableArray *categorieenArray;

@property (strong, nonatomic) NSMutableArray *onderdelenArray;

@property (strong, nonatomic)  NSMutableArray* uneditable;
@property (strong, nonatomic) NSMutableArray *alleVoertuigenArray;
@property (strong, nonatomic) NSMutableArray *alleVoertuigenArrayCopy;
@property (strong, nonatomic) NSMutableArray *Voertuigsoorten;
@property (strong, nonatomic) NSMutableDictionary *makenewOnderdeel;
@property (strong, nonatomic) NSString *Soort;
@property (nonatomic, assign) NSInteger moviesize;
@property (nonatomic, strong) ItemListView *currentItemListView;
@property (nonatomic, assign, getter = isAanname) BOOL aanname;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) IBOutlet NSMutableDictionary *currentItemDictonary;
@property (readonly, strong, nonatomic)  ViewController *viewcontroller;
@property (readonly, strong, nonatomic)  UINavigationController *navigation;
@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (readonly, strong)  TOTPGenerator *generator;
-(void)createDatabaseIfNeeded;
- (void)saveContext;
- (NSString *)newUUID;
- (BOOL)connected;
- (NSString*)updateUI;
- (NSString*)updateKenteken:(NSString*)kenteken;
@end
