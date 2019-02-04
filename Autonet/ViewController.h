//
//  ViewController.h
//  Autonet
//
//  Created by Livecast02 on 28-11-16.
//  Copyright © 2016 Autonet. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "LineView.h"
#import "removeView.h"
#import "CameraButton.h"
#import "LineButton.h"
#import "MenuView.h"
#import "CarView.h"
#import "ImageButton.h"
#import "TekstCopyView.h"
#import "BarView.h"
#import "UICollectionSearch.h"
#import "UICollectionOnderdelen.h"
#import "KernoOnderdelenView.h"
#import "ScrollView.h"
#import "UITableListOnderdelen.h"
#import "Loadingview.h"
#import "NavigationView.h"
#import "LoadingEnd.h"
#import "MaakOnderdeel.h"
#import "MaakArtikel.h"
#import "SelectionView.h"
#import "RemoveView.h"
#import "StatistiekView.h"
#import "imagePickerView.h"
#import "ImageViewBlock.h"
#import "LoadingOverlayView.h"
@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, retain) imagePickerView *fotoPickerView;
@property (nonatomic, retain) UICollectionSearch *Collectionsearch;
@property (nonatomic, retain) UICollectionOnderdelen *collectionOnderdelenView;
@property (nonatomic, retain) UITableListOnderdelen *listOnderdelenView;
@property (nonatomic, strong)  BarView *barview;
@property (nonatomic, strong)  NSNumber *orientatie;
@property (nonatomic, strong)  MenuView *menu;
@property (nonatomic, strong)  MaakArtikel * maakartikel;
@property (nonatomic, strong)  MaakOnderdeel *maakOnderdeel;
@property (nonatomic, strong)  SelectionView *selectionView;
@property (nonatomic, strong)  StatistiekView *statistiekView;
@property (nonatomic, strong)  TekstCopyView *textcopy;
@property (nonatomic, strong)  CarView *carView;
@property (nonatomic, strong)  LineButton *Uploaden;
@property (nonatomic, strong)  Loadingview *Loading;
@property (nonatomic, strong)  LoadingEnd *Loadingend;
@property (nonatomic, strong)  NavigationView *navigaionView;
@property (nonatomic, strong)  ImageButton *fotos;
@property (nonatomic, strong)  ImageButton *info;
@property (nonatomic, strong)  ImageButton *inkoop;
@property (nonatomic, strong)  ImageButton *verkoop;
@property (nonatomic, strong)  ImageButton *aannamelijst;
@property (nonatomic, strong)  ImageButton *internet;
@property (nonatomic, strong)  ImageButton *search;
@property (nonatomic, strong)  ScrollView *scroll;
@property (nonatomic, strong)  ImageViewBlock *imageviewblock;
@property (nonatomic, strong) LoadingOverlayView *overlay;
@property (nonatomic, strong)  RemoveView *removeView;
@property (nonatomic, strong)  ImageButton *activateCameraRoll;
@property (nonatomic, strong) UIPopoverController *cameraRoll;
@property (nonatomic, strong) imagePickerViewController *pickercontroller;
- (IBAction)CameraAction406:(CameraButton *)sender;
- (IBAction)CameraAction407:(CameraButton *)sender;
- (IBAction)MemoAction:(ImageButton *)sender;
- (IBAction)PrijsAction:(ImageButton *)sender;
- (IBAction)EditPricesAction:(EditTextField *)sender;

-(void)overlayAction;
-(void)move:(LineButton*)sender;
@end
