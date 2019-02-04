    //
    //  ViewController.m
    //  Autonet
    //
    //  Created by Livecast02 on 28-11-16.
    //  Copyright © 2016 Autonet. All rights reserved.
    //
#import "ViewController.h"
#import "MaakOnderdeel.h"
#import "EditTextView.h"
#import "AppDelegate.h"
#import "ImageViewBlock.h"
#import "UICollectionOnderdelen.h"
#import "UICollectionSearch.h"
#import "JSONKit.h"
#import "SBJson.h"
#import "LineButton.h"
#import "MenuView.h"
#import "LineView.h"
#import "ImageButton.h"
#import "LabelButton.h"
#import "TableView.h"
#import "CarView.h"
#import "FileManager.h"
#import "OnderdeelView.h"
#import "KernoOnderdelenView.h"
#import "CameraButton.h"
#import "ScrollView.h"
#import "UITableListOnderdelen.h"
#import "PrijsViewController.h"
#import "MemoViewController.h"
#import "KMViewController.h"
#import "Loadingview.h"
#import "MaakArtikel.h"
#import "SelectionView.h"
#import "RemoveView.h"
#import "StatistiekView.h"
#import "imagePickerView.h"
#import "alertViewController.h"
@interface ViewController ()
@end
@implementation ViewController

@synthesize menu;
@synthesize Uploaden;
@synthesize carView;
@synthesize textcopy;
@synthesize listOnderdelenView;
@synthesize info;
@synthesize fotos;
@synthesize inkoop;
@synthesize verkoop;
@synthesize aannamelijst;
@synthesize internet;
@synthesize search;
@synthesize barview;
@synthesize Collectionsearch;
@synthesize collectionOnderdelenView;
@synthesize scroll;
@synthesize orientatie;
@synthesize Loading;
@synthesize activateCameraRoll;
@synthesize navigaionView;
@synthesize Loadingend;
@synthesize maakOnderdeel;
@synthesize maakartikel;
@synthesize selectionView;
@synthesize overlay;
@synthesize removeView;
@synthesize statistiekView;
@synthesize fotoPickerView;
@synthesize imageviewblock;
@synthesize pickercontroller;
- (void)viewDidLoad {

    AppDelegate *appDelegate = [FileManager getDel];


    float frameHeight = self.view.frame.size.height;
    float frameWidth = self.view.frame.size.width;

    [self keyborNotifications];

    [self.view setBackgroundColor:[UIColor colorWithRed:0.973 green:0.945 blue:0.882 alpha:1.000]];

    Collectionsearch= [[UICollectionSearch alloc] initWithFrame:CGRectMake(46, 58, frameWidth-50, frameHeight-60)];
    [self.view addSubview:Collectionsearch];

    listOnderdelenView = [[UITableListOnderdelen alloc] initWithFrame:CGRectMake(46, 60, frameWidth-50, frameHeight-64)];
    [self.view addSubview:listOnderdelenView];

    collectionOnderdelenView = [[UICollectionOnderdelen alloc] initWithFrame:CGRectMake(46, 60, frameWidth-50, frameHeight-64)];
    [self.view addSubview:collectionOnderdelenView];

    barview = [[BarView alloc]initWithFrame:CGRectMake(4, 4, frameWidth-8, 48)];
    [self.view addSubview:barview];

    carView = [[CarView alloc]initWithFrame:CGRectMake(46, 58, frameWidth-50, frameHeight-60)];
    [self.view addSubview:carView];

    menu = [[MenuView alloc]initWithFrame:CGRectMake(4, 54, 310, frameHeight-60)];
    [self.view addSubview:menu];

    scroll = [[ScrollView alloc]initWithFrame:CGRectMake(0, 0, frameWidth, frameHeight)];
    [self.view addSubview:scroll];

    navigaionView= [[NavigationView alloc] initWithFrame:CGRectMake(0, 0, frameWidth, frameHeight)];
    [self.view addSubview:navigaionView];

    selectionView= [[SelectionView alloc] initWithFrame:CGRectMake(0, 0, frameWidth, frameHeight)];
    [self.view addSubview:selectionView];

    maakOnderdeel= [[MaakOnderdeel alloc] initWithFrame:CGRectMake(0, 0, frameWidth, frameHeight)];
    [self.view addSubview:maakOnderdeel];

    statistiekView= [[StatistiekView alloc] initWithFrame:CGRectMake(0, 0, frameWidth, frameHeight)];
    [self.view addSubview:statistiekView];

    maakartikel = [[MaakArtikel alloc] initWithFrame:CGRectMake(0, 0, frameWidth/2.5, frameHeight/2.5)];
    [self.view addSubview:maakartikel];

    fotoPickerView= [[imagePickerView alloc] initWithFrame:CGRectMake(50, 50, frameWidth-100, frameHeight-100)];
    [self.view addSubview:fotoPickerView];

    Loading= [[Loadingview alloc] initWithFrame:CGRectMake(0, 0, frameWidth, frameHeight)];
    [self.view addSubview:Loading];

    Loadingend= [[LoadingEnd alloc] initWithFrame:CGRectMake(50, 40, frameWidth-100, frameHeight-100)];
    [self.view addSubview:Loadingend];

    removeView = [[RemoveView alloc] initWithFrame:CGRectMake(0, frameHeight-60,frameWidth, 60)];
    [self.view addSubview:removeView];

    textcopy = [[TekstCopyView alloc] initWithFrame:CGRectMake(0, 0,frameWidth, frameHeight)];
    [self.view addSubview:textcopy];

    imageviewblock = [[ImageViewBlock alloc]initWithFrame:CGRectMake(0,0, frameWidth, frameHeight)];
    [self.view addSubview:imageviewblock];

    overlay = [[LoadingOverlayView alloc]initWithFrame:CGRectMake(0,0, frameWidth, frameHeight)];
    [self.view addSubview:overlay];

    if ([appDelegate.alleVoertuigenArray count]>0) {
        [Loading setAlpha:0];
    } else {
        [Loading setAlpha:1];
    }


    [super viewDidLoad];
        // Do any additional setup after loading the view, typically from a nib.
}

-(void)keyborNotifications

{

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification object:nil];
}
- (void)keyboardDidShow:(NSNotification *)notification
{

        // ////////////NSLog(@"keyboardDidShow");
}
-(void)keyboardDidHide:(NSNotification *)notification
{
    AppDelegate *appDelegate = [FileManager getDel];
    [appDelegate.viewcontroller.textcopy setAlpha:0];
        // ////////////NSLog(@"keyboardDidHide");
}
-(void)overlayAction
{
    [overlay setAlpha:0.5];

    double delayInSeconds = 1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.overlay setAlpha:0];

    });
}
-(void)move:(LineButton*)sender
{

    if (menu.frame.origin.x <0)
    {
        if ([sender isEqual:Uploaden]) {
            [search setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
            [info setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
            [fotos setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
            [internet setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
            [inkoop setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
            [aannamelijst setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
            [verkoop setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationDuration:0.2f];
            [menu setFrame:CGRectMake(4, 4, 260, self.view.frame.size.height-8)];
            [Uploaden setFrame:CGRectMake(254, 4, 50, 100)];
            [search setFrame:CGRectMake(254, search.frame.origin.y, 50, 50)];
            [info setFrame:CGRectMake(254, info.frame.origin.y, 50, 50)];
            [fotos setFrame:CGRectMake(254, fotos.frame.origin.y, 50, 50)];
            [internet setFrame:CGRectMake(254, internet.frame.origin.y, 50, 50)];
            [inkoop setFrame:CGRectMake(254, inkoop.frame.origin.y, 50, 50)];
            [verkoop setFrame:CGRectMake(254, verkoop.frame.origin.y, 50, 50)];
            [aannamelijst setFrame:CGRectMake(254, aannamelijst.frame.origin.y, 50, 50)];
            [UIView commitAnimations];
            double delayInSeconds = 0.3;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [sender setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
                [self.menu setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
                    // [self setTitleColor:baseColor forState:normal];
            });
        }
        else
        {
            [search setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
            [info setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
            [fotos setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
            [internet setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
            [inkoop setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
            [aannamelijst setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
            [verkoop setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
        }
    } else {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.2f];
        [menu setFrame:CGRectMake(-260, 4, 260, self.view.frame.size.height-8)];
        [Uploaden setFrame:CGRectMake(-6, 4, 50, 100)];
        [search setFrame:CGRectMake(-6, search.frame.origin.y, 50, 50)];
        [search setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
        [info setFrame:CGRectMake(-6, info.frame.origin.y, 50, 50)];
        [info setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
        [fotos setFrame:CGRectMake(-6, fotos.frame.origin.y, 50, 50)];
        [fotos setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
        [internet setFrame:CGRectMake(-6, internet.frame.origin.y, 50, 50)];
        [internet setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
        [inkoop setFrame:CGRectMake(-6, inkoop.frame.origin.y, 50, 50)];
        [inkoop setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
        [aannamelijst setFrame:CGRectMake(-6, aannamelijst.frame.origin.y, 50, 50)];
        [aannamelijst setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
        [verkoop setFrame:CGRectMake(-6, verkoop.frame.origin.y, 50, 50)];
        [verkoop setBackgroundColor:[UIColor colorWithRed:0.082 green:0.667 blue:0.804 alpha:1.000]];
        [UIView commitAnimations];
    }
    [sender setBackgroundColor:[UIColor colorWithRed:0.414 green:0.806 blue:0.849 alpha:1.0]];
    [menu setBackgroundColor:[UIColor colorWithRed:0.414 green:0.806 blue:0.849 alpha:1.0]];
        //[self setTitleColor:contraColor forState:normal];
}
- (IBAction)CameraAction407:(CameraButton *)sender {
    AppDelegate *appDelegate = [FileManager getDel];
    appDelegate.currentCollection = sender.currentCollection;
    appDelegate.currentOnderdeel=sender.currentOnderdeel;
    if ([sender.currentOnderdeel.basepart valueForKey:@"FotosInfo"] ==NULL) {
        NSMutableArray *emptyArray = [[NSMutableArray alloc] init];
        [appDelegate.viewcontroller.fotoPickerView setLocalArray:emptyArray];
        [appDelegate.viewcontroller.fotoPickerView setItemID:[sender.currentOnderdeel.basepart valueForKey:@"DeelId"]];
    } else {
        [appDelegate.viewcontroller.fotoPickerView setLocalArray:[sender.currentOnderdeel.basepart valueForKey:@"FotosInfo"]];
        [appDelegate.viewcontroller.fotoPickerView setItemID:[sender.currentOnderdeel.basepart valueForKey:@"DeelId"]];
    }
    alertViewController * alert=   [alertViewController
                                    alertControllerWithTitle:@"Maak een keuze!"
                                    message:@""
                                    preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *neeAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        self.pickercontroller = [[imagePickerViewController alloc] init];
        self.pickercontroller.delegate = self;
        self.pickercontroller.allowsEditing = YES;
#if (TARGET_IPHONE_SIMULATOR)
        self.pickercontroller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
#else
        self.pickercontroller.sourceType =  UIImagePickerControllerSourceTypeCamera;
#endif
        [self presentViewController: self.pickercontroller animated:YES completion:NULL];
    }];
    [alert addAction:neeAction];
    UIAlertAction *FotoAction = [UIAlertAction actionWithTitle:@"Fotobibliotheek" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [appDelegate.viewcontroller.fotoPickerView select];
    }];
    [alert addAction:FotoAction];
    UIAlertAction *playAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
    }];
    [alert addAction:playAction];
    [self presentViewController:alert animated:YES completion:nil];

}
- (IBAction)clearPressed:(id)sender
{
}
- (IBAction)MemoAction:(ImageButton *)sender {
    OnderdeelView *copy = (OnderdeelView*) [sender superview];
    MemoViewController *picker = [[MemoViewController alloc] init];
    activateCameraRoll =sender;
    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:picker];
    popover.popoverContentSize = CGSizeMake(325, 600);
    CGRect rect=CGRectMake(activateCameraRoll.bounds.origin.x, activateCameraRoll.bounds.origin.y+10, 50, 30);
    [popover presentPopoverFromRect:rect inView:activateCameraRoll permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        //assign a reference to the strongly declared UIPopoverController
    self.cameraRoll = popover;
    picker.popoverparant =popover;
    picker.basepart =copy.basepart;
    picker.onderdeel = copy;
    [picker.Memotext setText:[copy.basepart valueForKey:@"Bijzonderheid"]];
}
- (IBAction)KMAction:(ImageButton *)sender {
    KMViewController *picker = [[KMViewController alloc] init];
    activateCameraRoll =sender;
    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:picker];
    popover.popoverContentSize = CGSizeMake(325, 600);
    CGRect rect=CGRectMake(activateCameraRoll.bounds.origin.x, activateCameraRoll.bounds.origin.y+10, 50, 30);
    [popover presentPopoverFromRect:rect inView:activateCameraRoll permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    self.cameraRoll = popover;
    picker.popoverparant =popover;
}

- (IBAction)EditPricesAction:(EditTextField *)sender
{

    PrijsViewController *picker = [[PrijsViewController alloc] init];
    picker.basefield = sender;
   // OnderdeelView *copy = (OnderdeelView*) [sender superview];
    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:picker];
    popover.popoverContentSize = CGSizeMake(325, 600);
    CGRect rect=CGRectMake(sender.bounds.origin.x, sender.bounds.origin.y+10, 50, 30);
    [popover presentPopoverFromRect:rect inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    self.cameraRoll = popover;
    picker.popoverparant =popover;

    if ([sender.text length]>0) {

          [picker.mainLabel setText:sender.text];
    }
    else
    {
    [picker.mainLabel setText:@"0"];


    }
    //picker.basepart =copy.basepart;

}
- (IBAction)PrijsAction:(ImageButton *)sender {
    PrijsViewController *picker = [[PrijsViewController alloc] init];
    activateCameraRoll =sender;
    OnderdeelView *copy = (OnderdeelView*) [sender superview];
    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:picker];
    popover.popoverContentSize = CGSizeMake(325, 600);
    CGRect rect=CGRectMake(activateCameraRoll.bounds.origin.x, activateCameraRoll.bounds.origin.y+10, 50, 30);
    [popover presentPopoverFromRect:rect inView:activateCameraRoll permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    self.cameraRoll = popover;
    picker.popoverparant =popover;
    picker.basepart =copy.basepart;

    if ([[picker.basepart valueForKey:@"Prijs"] length]>0) {

        [picker.mainLabel setText:[picker.basepart valueForKey:@"Prijs"]];
    }
    else
    {
        [picker.mainLabel setText:@"0"];


    }

    

}
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)index{
    AppDelegate *appDelegate = [FileManager getDel];
    if (alertView.tag ==407) {

        if (index==0) {


            NSString *idit = [appDelegate newUUID];

            NSString *docDir = [FileManager getDir];
            NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@",docDir,[NSString stringWithFormat:@"%@.jpg", idit]];
            NSData *data2 = [NSData dataWithData:UIImageJPEGRepresentation( appDelegate.currentimage, 1.0f)];
            [data2 writeToFile:itemFilePath atomically:YES];
            if (appDelegate.currentCollection.arrayInternet) {
            }
            else
            {
                appDelegate.currentCollection.arrayInternet = [[NSMutableArray alloc] init];
            }
            if (appDelegate.currentCollection.arrayItems){
            }
            else
            {
                appDelegate.currentCollection.arrayItems = [[NSMutableArray alloc] init];
            }

            [appDelegate.currentCollection.arrayInternet addObject:[NSNumber numberWithBool:NO]];
            [appDelegate.currentCollection.arrayItems addObject:[NSString stringWithFormat:@"%@.jpg", idit]];
            NSMutableArray *copyfoto = [[NSMutableArray alloc] init];
            [copyfoto setArray:(NSArray*) [appDelegate.currentOnderdeel.basepart valueForKey:@"FotosInfo"]];
            NSMutableDictionary *localDictonary = [[NSMutableDictionary alloc] init];
            [localDictonary setValue:idit forKey:@"FotoGrootId"];
            NSNumber *number = [NSNumber numberWithInteger:[appDelegate.currentCollection.arrayItems count]+1];
            [localDictonary setValue:number forKey:@"FotoId"];
            [localDictonary setValue:[NSNumber numberWithBool:YES] forKey:@"Internet"];
            [localDictonary setValue:[NSString stringWithFormat:@"%@.jpg", idit] forKey:@"Orgnaam"];
            [localDictonary setValue:number forKey:@"Positie"];
            NSNumber *number2 = [NSNumber numberWithBool:NO];
            [localDictonary setValue:number2 forKey:@"InAutomate"];
            [copyfoto addObject:localDictonary];
            [appDelegate.currentOnderdeel.basepart setObject:copyfoto forKey:@"FotosInfo"];
            [FileManager insertnew:appDelegate.currentOnderdeel.basepart];
            [appDelegate.currentCollection.collectionViewcopy reloadData];
            [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];

        }
        else  if (index==1) {
            AppDelegate *appDelegate = [FileManager getDel];
            NSString *idit = [appDelegate newUUID];
            NSString *docDir = [FileManager getDir];
            NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@",docDir,[NSString stringWithFormat:@"%@.jpg", idit]];
            NSData *data2 = [NSData dataWithData:UIImageJPEGRepresentation( appDelegate.currentimage, 1.0f)];
            [data2 writeToFile:itemFilePath atomically:YES];
            if (appDelegate.currentCollection.arrayInternet) {
            }
            else
            {
                appDelegate.currentCollection.arrayInternet = [[NSMutableArray alloc] init];
            }
            if ( appDelegate.currentCollection.arrayItems){
            }
            else
            {
                appDelegate.currentCollection.arrayItems = [[NSMutableArray alloc] init];
            }

            [appDelegate.currentCollection.arrayInternet addObject:[NSNumber numberWithBool:NO]];
            [appDelegate.currentCollection.arrayItems addObject:[NSString stringWithFormat:@"%@.jpg", idit]];
            NSMutableArray *copyfoto = [[NSMutableArray alloc] init];
            [copyfoto setArray:(NSArray*) [appDelegate.currentOnderdeel.basepart valueForKey:@"FotosInfo"]];

            NSMutableDictionary *localDictonary = [[NSMutableDictionary alloc] init];
            [localDictonary setValue:idit forKey:@"FotoGrootId"];
            NSNumber *number = [NSNumber numberWithInteger:[appDelegate.currentCollection.arrayItems count]+1];
            [localDictonary setValue:number forKey:@"FotoId"];
            [localDictonary setValue:[NSNumber numberWithBool:NO] forKey:@"Internet"];
            [localDictonary setValue:[NSString stringWithFormat:@"%@.jpg", idit] forKey:@"Orgnaam"];
            [localDictonary setValue:number forKey:@"Positie"];
            NSNumber *number2 = [NSNumber numberWithBool:NO];
            [localDictonary setValue:number2 forKey:@"InAutomate"];
            [copyfoto addObject:localDictonary];
            [appDelegate.currentOnderdeel.basepart setObject:copyfoto forKey:@"FotosInfo"];
            [FileManager insertnew:appDelegate.currentOnderdeel.basepart];

            [appDelegate.currentCollection.collectionViewcopy reloadData];
            [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];

        }

    } else {

        if (index==1) {
            AppDelegate *appDelegate = [FileManager getDel];

            [appDelegate.viewcontroller.fotoPickerView select];
        }
        else if (index==2)
        {
            pickercontroller = [[imagePickerViewController alloc] init];
            pickercontroller.delegate = self;
            pickercontroller.allowsEditing = YES;
#if (TARGET_IPHONE_SIMULATOR)
            pickercontroller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
#else
            pickercontroller.sourceType =  UIImagePickerControllerSourceTypeCamera;
#endif
            [self presentViewController: pickercontroller animated:YES completion:NULL];

        }
        else
        {
        }
    }
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}                   
- (void)imagePickerController:(imagePickerViewController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info;
{
    AppDelegate *appDelegate = [FileManager getDel];
    appDelegate.currentimage =(UIImage*)[info valueForKey:@"UIImagePickerControllerEditedImage"];
    alertViewController * alert=   [alertViewController
                                    alertControllerWithTitle:@"Vraag:"
                                    message:@"Wilt u deze foto op internet gebruiken?"
                                    preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *jaAction = [UIAlertAction actionWithTitle:@"Ja" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSString *idit = [appDelegate newUUID];
        NSString *docDir = [FileManager getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@",docDir,[NSString stringWithFormat:@"%@.jpg", idit]];
        NSData *data2 = [NSData dataWithData:UIImageJPEGRepresentation( appDelegate.currentimage, 1.0f)];
        [data2 writeToFile:itemFilePath atomically:YES];
        if (appDelegate.currentCollection.arrayInternet) {
        }
        else
        {
            appDelegate.currentCollection.arrayInternet = [[NSMutableArray alloc] init];
        }
        if (appDelegate.currentCollection.arrayItems){
        }
        else
        {
            appDelegate.currentCollection.arrayItems = [[NSMutableArray alloc] init];
        }
        [appDelegate.currentCollection.arrayInternet addObject:[NSNumber numberWithBool:NO]];
        [appDelegate.currentCollection.arrayItems addObject:[NSString stringWithFormat:@"%@.jpg", idit]];
        NSMutableArray *copyfoto = [[NSMutableArray alloc] init];
        [copyfoto setArray:(NSArray*) [appDelegate.currentOnderdeel.basepart valueForKey:@"FotosInfo"]];
        NSMutableDictionary *localDictonary = [[NSMutableDictionary alloc] init];
        [localDictonary setValue:idit forKey:@"FotoGrootId"];
        NSNumber *number = [NSNumber numberWithInteger:[appDelegate.currentCollection.arrayItems count]+1];
        [localDictonary setValue:number forKey:@"FotoId"];
        [localDictonary setValue:[NSNumber numberWithBool:YES] forKey:@"Internet"];
        [localDictonary setValue:[NSString stringWithFormat:@"%@.jpg", idit] forKey:@"Orgnaam"];
        [localDictonary setValue:number forKey:@"Positie"];
        NSNumber *number2 = [NSNumber numberWithBool:NO];
        [localDictonary setValue:number2 forKey:@"InAutomate"];
        [copyfoto addObject:localDictonary];
        [appDelegate.currentOnderdeel.basepart setObject:copyfoto forKey:@"FotosInfo"];
        [FileManager insertnew:appDelegate.currentOnderdeel.basepart];
        [appDelegate.currentCollection.collectionViewcopy reloadData];
        [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
        [self dismissViewControllerAnimated:YES completion:NULL];
    }];
    [alert addAction:jaAction];

    UIAlertAction *neeAction = [UIAlertAction actionWithTitle:@"Nee" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSString *idit = [appDelegate newUUID];
        NSString *docDir = [FileManager getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@",docDir,[NSString stringWithFormat:@"%@.jpg", idit]];
        NSData *data2 = [NSData dataWithData:UIImageJPEGRepresentation( appDelegate.currentimage, 1.0f)];
        [data2 writeToFile:itemFilePath atomically:YES];
        if (appDelegate.currentCollection.arrayInternet) {
        }
        else
        {
            appDelegate.currentCollection.arrayInternet = [[NSMutableArray alloc] init];
        }
        if (appDelegate.currentCollection.arrayItems){
        }
        else
        {
            appDelegate.currentCollection.arrayItems = [[NSMutableArray alloc] init];
        }
        [appDelegate.currentCollection.arrayInternet addObject:[NSNumber numberWithBool:NO]];
        [appDelegate.currentCollection.arrayItems addObject:[NSString stringWithFormat:@"%@.jpg", idit]];
        NSMutableArray *copyfoto = [[NSMutableArray alloc] init];
        [copyfoto setArray:(NSArray*) [appDelegate.currentOnderdeel.basepart valueForKey:@"FotosInfo"]];
        NSMutableDictionary *localDictonary = [[NSMutableDictionary alloc] init];
        [localDictonary setValue:idit forKey:@"FotoGrootId"];
        NSNumber *number = [NSNumber numberWithInteger:[appDelegate.currentCollection.arrayItems count]+1];
        [localDictonary setValue:number forKey:@"FotoId"];
        [localDictonary setValue:[NSNumber numberWithBool:NO] forKey:@"Internet"];
        [localDictonary setValue:[NSString stringWithFormat:@"%@.jpg", idit] forKey:@"Orgnaam"];
        [localDictonary setValue:number forKey:@"Positie"];
        NSNumber *number2 = [NSNumber numberWithBool:NO];
        [localDictonary setValue:number2 forKey:@"InAutomate"];
        [copyfoto addObject:localDictonary];
        [appDelegate.currentOnderdeel.basepart setObject:copyfoto forKey:@"FotosInfo"];
        [FileManager insertnew:appDelegate.currentOnderdeel.basepart];
        [appDelegate.currentCollection.collectionViewcopy reloadData];
        [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
        [self dismissViewControllerAnimated:YES completion:NULL];
    }];
    [alert addAction:neeAction];

    UIAlertAction *playAction = [UIAlertAction actionWithTitle:@"Nog een foto maken." style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSString *idit = [appDelegate newUUID];
        NSString *docDir = [FileManager getDir];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@",docDir,[NSString stringWithFormat:@"%@.jpg", idit]];
        NSData *data2 = [NSData dataWithData:UIImageJPEGRepresentation( appDelegate.currentimage, 1.0f)];
        [data2 writeToFile:itemFilePath atomically:YES];
        if (appDelegate.currentCollection.arrayInternet) {
        }
        else
        {
            appDelegate.currentCollection.arrayInternet = [[NSMutableArray alloc] init];
        }
        if (appDelegate.currentCollection.arrayItems){
        }
        else
        {
            appDelegate.currentCollection.arrayItems = [[NSMutableArray alloc] init];
        }
        [appDelegate.currentCollection.arrayInternet addObject:[NSNumber numberWithBool:NO]];
        [appDelegate.currentCollection.arrayItems addObject:[NSString stringWithFormat:@"%@.jpg", idit]];
        NSMutableArray *copyfoto = [[NSMutableArray alloc] init];
        [copyfoto setArray:(NSArray*) [appDelegate.currentOnderdeel.basepart valueForKey:@"FotosInfo"]];
        NSMutableDictionary *localDictonary = [[NSMutableDictionary alloc] init];
        [localDictonary setValue:idit forKey:@"FotoGrootId"];
        NSNumber *number = [NSNumber numberWithInteger:[appDelegate.currentCollection.arrayItems count]+1];
        [localDictonary setValue:number forKey:@"FotoId"];
        [localDictonary setValue:[NSNumber numberWithBool:YES] forKey:@"Internet"];
        [localDictonary setValue:[NSString stringWithFormat:@"%@.jpg", idit] forKey:@"Orgnaam"];
        [localDictonary setValue:number forKey:@"Positie"];
        NSNumber *number2 = [NSNumber numberWithBool:NO];
        [localDictonary setValue:number2 forKey:@"InAutomate"];
        [copyfoto addObject:localDictonary];
        [appDelegate.currentOnderdeel.basepart setObject:copyfoto forKey:@"FotosInfo"];
        [FileManager insertnew:appDelegate.currentOnderdeel.basepart];
        [appDelegate.currentCollection.collectionViewcopy reloadData];
        [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];

        [self dismissViewControllerAnimated:NO completion:NULL];


        self.pickercontroller = [[imagePickerViewController alloc] init];
        self.pickercontroller.delegate = self;
        self.pickercontroller.allowsEditing = YES;
#if (TARGET_IPHONE_SIMULATOR)
        self.pickercontroller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
#else
        self.pickercontroller.sourceType =  UIImagePickerControllerSourceTypeCamera;
#endif
        [appDelegate.viewcontroller presentViewController: self.pickercontroller animated:NO completion:NULL];

    }];
    [alert addAction:playAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:NULL];
    }];
    [alert addAction:cancelAction];
    [appDelegate.window.rootViewController.presentedViewController presentViewController:alert animated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}
@end
