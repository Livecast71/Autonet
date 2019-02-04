    //
    //  LabelView.m
    //  Autonet
    //
    //  Created by Livecast02 on 02-02-17.
    //  Copyright © 2017 Autonet. All rights reserved.
    //
#import "BigLabelView.h"
#import "UIFont+FlatUI.h"
#import "FileManager.h"
#import "AppDelegate.h"
#import "ItemListView.h"
#import "OnderdeelView.h"
#import "EditTextView.h"
@implementation BigLabelView
@synthesize insert;
@synthesize foldscreen;
@synthesize parantView;
@synthesize VeldId;
@synthesize inhoud;
@synthesize cilinderinhoud;
@synthesize Vermogen;
@synthesize colorlabel;
@synthesize scrollingSize;



-(UILabel*)createTitleLabel

{
    UILabel *title =[[UILabel alloc] initWithFrame:CGRectMake(0, 5, self.frame.size.width, 30)];
    [title setFont:[UIFont regularFlatFontOfSize:16]];
    [title setTextColor:[UIColor blackColor]];
    [title setTextAlignment:NSTextAlignmentLeft];
    
    
    return title;
    
}

-(ItemListView*)createItemListView

{
    ItemListView *catogorie =[[ItemListView alloc]initWithFrame:CGRectMake(insert, 5, 250, 40)];
    [catogorie setTag:VeldId];
    [catogorie setBackgroundColor:[UIColor whiteColor]];
    catogorie.asY =5;
    [catogorie.layer setBorderWidth:2];
    [catogorie.layer  setBorderColor:[UIColor lightGrayColor].CGColor];
    [catogorie.layer setCornerRadius:6];
    
    return catogorie;
    
}
-(void)setAirbags:(NSMutableDictionary*)items
{
    AppDelegate *appDelegate = [FileManager getDel];
    
    UILabel *title =[self createTitleLabel];
    [title setText:[items valueForKey:@"Naam"]];
    [self addSubview:title];
    insert =180;
    
    
    ItemListView *catogorie = [self createItemListView];
    [self addSubview:catogorie];
    
    NSArray *set =[[NSArray alloc] initWithObjects:@"Afwezig",@"Aanwezig", nil];
    [catogorie setParentview:appDelegate.viewcontroller.carView.content];
        // [catogorie setParentlabel:self];
    [catogorie setItemYESNOAirbag:set aanwezig:items];
}
-(void)setOpties:(NSMutableDictionary*)items
{
    AppDelegate *appDelegate = [FileManager getDel];
    
    UILabel *title =[self createTitleLabel];
    [title setText:[items valueForKey:@"Naam"]];
    [self addSubview:title];
    
    insert =180;
    
    ItemListView *catogorie = [self createItemListView];
    [self addSubview:catogorie];
    
    NSArray *set =[[NSArray alloc] initWithObjects:@"Afwezig",@"Aanwezig", nil];
    [catogorie setParentview:appDelegate.viewcontroller.carView.content];
        // [catogorie setParentlabel:self];
    [catogorie setItemYESNOOpties:set aanwezig:items];
}
-(void)setSchades:(NSMutableDictionary*)items
{
    AppDelegate *appDelegate = [FileManager getDel];
    
    UILabel *title =[self createTitleLabel];
    [title setText:[items valueForKey:@"Naam"]];
    [self addSubview:title];
    
    insert =180;
    
    ItemListView *catogorie = [self createItemListView];
    [self addSubview:catogorie];
    
    NSArray *set =[[NSArray alloc] initWithObjects:@"Nee",@"Ja", nil];
    [catogorie setParentview:appDelegate.viewcontroller.carView.content];
        //[catogorie setParentlabel:self];
    [catogorie setItemYESNOSchades:set aanwezig:items];
}
-(void)setGordels:(NSMutableDictionary*)items
{
    
    AppDelegate *appDelegate = [FileManager getDel];
    
    UILabel *title =[self createTitleLabel];
    [title setText:[items valueForKey:@"Naam"]];
    [self addSubview:title];
    
    insert =180;
    
    ItemListView *catogorie = [self createItemListView];
    [self addSubview:catogorie];
    
    NSArray *set =[[NSArray alloc] initWithObjects:@"Afwezig",@"Aanwezig", nil];
    [catogorie setParentview:appDelegate.viewcontroller.carView.content];
        // [catogorie setParentlabel:self];
    [catogorie setItemYESNOGordels:set aanwezig:items];
    
}
-(void)setItemset:(NSMutableDictionary*)items
{
    AppDelegate *appDelegate = [FileManager getDel];
    colorlabel =[[UILabel alloc]initWithFrame:CGRectMake(190,10,10,30)];
    [colorlabel setBackgroundColor:[UIColor colorWithRed:0.719543 green:0.000000 blue:1.000000 alpha:0.000000]];
    [self addSubview:colorlabel];
    [colorlabel setTag:1];
    
        ////////////NSLog(@"big %@ %@", items, [items valueForKey:@"LengteMax"]);
    
    if ([appDelegate.uneditable containsObject:[items valueForKey:@"InternetOmschrijving"]]) {
        
        
        [self setUserInteractionEnabled:NO];
        [colorlabel setBackgroundColor:[UIColor colorWithRed:0.545809 green:0.763733 blue:0.834598 alpha:1.000000]];
    } else {
        [self setUserInteractionEnabled:YES];
        [colorlabel setBackgroundColor:[UIColor colorWithRed:0.439289 green:0.764236 blue:0.506794 alpha:1.000000]];
    }
    NSArray *arraydelen = [FileManager getVelden:[items valueForKey:@"VeldId"] and:[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
    NSString *format;
    if ([[items valueForKey:@"VeldMaskId"] isKindOfClass:[NSNumber class]]) {
        
        
        format  = [[FileManager getMAskVeld:[items valueForKey:@"VeldMaskId"]] valueForKey:@"Mask"];
    }
    UILabel *title =[[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width, 30)];
    [title setText:[items valueForKey:@"InternetOmschrijving"]];
    [title setFont:[UIFont regularFlatFontOfSize:16]];
    [title setTextColor:[UIColor blackColor]];
    [title setTextAlignment:NSTextAlignmentLeft];
    [self addSubview:title];
    insert =200;
    if ([[items valueForKey:@"VeldWaarden"] count]>0) {
        
        
        ItemListView *catogorie =[[ItemListView alloc]initWithFrame:CGRectMake(insert, 5, 250, 40)];
        [catogorie setTag:VeldId];
        [catogorie setBackgroundColor:[UIColor whiteColor]];
        catogorie.asY =5;
        [catogorie.layer setBorderWidth:2];
        [catogorie.layer  setBorderColor:[UIColor lightGrayColor].CGColor];
        [catogorie.layer setCornerRadius:6];
        [catogorie.layer setCornerRadius:4];
        catogorie.VeldId = [[items valueForKey:@"VeldId"] integerValue];
        [catogorie setOnderdeelview:parantView];
        [catogorie setParentlabel:(FieldLabelView*)self];
        [catogorie setItemVelden:[items valueForKey:@"VeldWaarden"]];
        [self addSubview:catogorie];
        
        
        
        
        if ([[[arraydelen firstObject] valueForKey:@"Waarde"] isKindOfClass:[NSNumber class]]) {
            [catogorie.search.titleView setText:[NSString stringWithFormat:@"%i", [[[arraydelen firstObject] valueForKey:@"Waarde"] intValue]]];
        }
        else
        {
            NSString *queryit = [NSString stringWithFormat:@"Waarde LIKE [cd]'%@'", [[arraydelen  firstObject] valueForKey:@"Waarde"]];
            NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
            NSMutableArray *VeldWaarden =  [[[items valueForKey:@"VeldWaarden"]  filteredArrayUsingPredicate:predicateit] mutableCopy];
            if ([VeldWaarden count]>0)
                
            {
                [catogorie.search.titleView setText:[[VeldWaarden firstObject] valueForKey:@"WaardeLang"]];
            }
            else
                
            {
                
                [catogorie.search.titleView setText:[[arraydelen  firstObject] valueForKey:@"Waarde"]];
            }
        }
        
    } else {
        
        if ([[appDelegate.currentCarDictionary allKeys] containsObject:[items valueForKey:@"InternetOmschrijving"]]) {
            UIView *content =[[UIView alloc] initWithFrame:CGRectMake(insert, 5, 250, 40)];
            [content setBackgroundColor:[UIColor whiteColor]];
            [content.layer setBorderWidth:2];
            [content.layer  setBorderColor:[UIColor lightGrayColor].CGColor];
            [content.layer setCornerRadius:6];
            [self addSubview:content];
            EditTextView *inhoud =[[EditTextView alloc] initWithFrame:CGRectMake(10, 4, 250, 30)];
            inhoud.limit = 500;
            inhoud.format = [[FileManager getMAskVeld:[items valueForKey:@"VeldMaskId"]] valueForKey:@"Mask"];
            if ([[appDelegate.currentCarDictionary valueForKey:[items valueForKey:@"InternetOmschrijving"]] isKindOfClass:[NSNumber class]]) {
                
                [inhoud setText: [NSString stringWithFormat:@"%i", [[appDelegate.currentCarDictionary valueForKey:[items valueForKey:@"InternetOmschrijving"]] intValue]]];
                
            }
            else
            {
                [inhoud setText: [appDelegate.currentCarDictionary valueForKey:[items valueForKey:@"InternetOmschrijving"]]];
                
            }
            [inhoud setDelegate:self];
            [inhoud setFont:[UIFont regularFlatFontOfSize:16]];
            [inhoud setTextColor:[UIColor blackColor]];
            [inhoud setTextAlignment:NSTextAlignmentLeft];
            [self setFormat:format text:inhoud];
            [inhoud setReturnKeyType:UIReturnKeyDone];
            [content addSubview:inhoud];
            OnderdeelView *deel= (OnderdeelView*) [self superview];
            [inhoud setContentdict:items];
            [inhoud setIndexand:deel.indexand];
            [inhoud setEdittext:[items valueForKey:@"InternetOmschrijving"]];
        }
        else
        {
            NSArray *two =[[NSArray alloc] initWithObjects:@"Chassisnr",@"Kenteken",@"Inhoud",@"Kleppen",@"Vermogen",@"BPMBasis",@"Kleur",@"Kleur2",@"Kleur3",@"APKTotDatum",@"LamineerCodes", @"InternetPrijs",@"InternetPrijsExport",@"InternetPrijsSoort",@"InternetSoortId", @"Verzekerd",@"Gewicht",@"Bouwjaar",@"Bouwmaand",@"Bouwdag",@"Kilometerstand",@"ARNTag",@"Duplicaatnr", @"ControleLetter",@"Meldcode", @"KentekenKaartCode1",@"KentekenKaartCode2",@"KentekenKaartDocumentnummer", @"AldocModel", @"AldocType", @"Motorcode", @"Cilinderinhoud", @"Motornummer", @"Interieurcode", @"Versnellingsbakcode", @"Laknummer voertuig",@"Laknummer voertuig 2",@"Laknummer voertuig 3",@"Wielbouten",@"Locatie", @"AanmaakMedewerker", @"Afstandbediening", @"AfstandbedieningOrigineel",@"SecurityCode", @"SleutelNummer", @"Sleutels", @"RadioCode", nil];
            for (int k =0; k < [two count]; k++) {                                      
                UIView *content =[[UIView alloc] initWithFrame:CGRectMake(insert, 5, 250, 40)];
                [content setBackgroundColor:[UIColor whiteColor]];
                [content.layer setBorderWidth:2];
                [content.layer  setBorderColor:[UIColor lightGrayColor].CGColor];
                [content.layer setCornerRadius:6];
                [self addSubview:content];
                
                
                if ([ [items valueForKey:@"InternetOmschrijving"] isEqualToString:@"Tellerstand"]) {
                    
                    
                    
                    EditTextView *inhoud =[[EditTextView alloc] initWithFrame:CGRectMake(10, 4, 250, 30)];
                    inhoud.limit = 500;
                    
                    inhoud.format = [[FileManager getMAskVeld:[items valueForKey:@"VeldMaskId"]] valueForKey:@"Mask"];
                    
                    if ([[appDelegate.currentCarDictionary valueForKey:@"Kilometerstand"] isKindOfClass:[NSNumber class]]) {
                        
                        
                        
                        [inhoud setText: [NSString stringWithFormat:@"%i", [[appDelegate.currentCarDictionary valueForKey:@"Kilometerstand"] intValue]]];
                        
                    }
                    
                    else
                    {
                        [inhoud setText: [appDelegate.currentCarDictionary valueForKey:@"Kilometerstand"]];
                        
                    }
                    [inhoud setDelegate:self];
                    [inhoud setFont:[UIFont regularFlatFontOfSize:16]];
                    [inhoud setTextColor:[UIColor blackColor]];
                    [inhoud setTextAlignment:NSTextAlignmentLeft];
                    [self setFormat:format text:inhoud];
                    [inhoud setReturnKeyType:UIReturnKeyDone];
                    [content addSubview:inhoud];
                    
                    
                    OnderdeelView *deel = (OnderdeelView*) [self superview];
                    [inhoud setContentdict:items];
                    [inhoud setIndexand:deel.indexand];
                    [inhoud setEdittext:[items valueForKey:@"InternetOmschrijving"]];
                    
                }
                else if ([ [items valueForKey:@"InternetOmschrijving"] isEqualToString:@"Motorcode"]) {                   
                    EditTextView *inhoud =[[EditTextView alloc] initWithFrame:CGRectMake(10, 4, 250, 30)];
                    inhoud.limit = 500;
                    
                    inhoud.format = [[FileManager getMAskVeld:[items valueForKey:@"VeldMaskId"]] valueForKey:@"Mask"];
                    
                    if ([[appDelegate.currentCarDictionary valueForKey:@"MCode"] isKindOfClass:[NSNumber class]]) {
                        
                        
                        
                        [inhoud setText: [NSString stringWithFormat:@"%i", [[appDelegate.currentCarDictionary valueForKey:@"MCode"] intValue]]];
                        
                    }
                    
                    else
                    {
                        [inhoud setText: [appDelegate.currentCarDictionary valueForKey:@"MCode"]];
                        
                    }
                    [inhoud setDelegate:self];
                    [inhoud setFont:[UIFont regularFlatFontOfSize:16]];
                    [inhoud setTextColor:[UIColor blackColor]];
                    [inhoud setTextAlignment:NSTextAlignmentLeft];
                    [self setFormat:format text:inhoud];
                    [inhoud setReturnKeyType:UIReturnKeyDone];
                    [content addSubview:inhoud];
                    
                    OnderdeelView *deel = (OnderdeelView*) [self superview];
                    [inhoud setContentdict:items];
                    [inhoud setIndexand:deel.indexand];
                    [inhoud setEdittext:[items valueForKey:@"InternetOmschrijving"]];
                    
                }
                else if ([ [items valueForKey:@"InternetOmschrijving"] isEqualToString:@"InternetSoortId"]) {
                    
                    EditTextView *inhoud =[[EditTextView alloc] initWithFrame:CGRectMake(10, 4, 250, 30)];
                    inhoud.limit = 500;
                    inhoud.format = [[FileManager getMAskVeld:[items valueForKey:@"VeldMaskId"]] valueForKey:@"Mask"];
                    
                    if ([[appDelegate.currentCarDictionary valueForKey:@"MCode"] isKindOfClass:[NSNumber class]]) {
                        
                        
                        
                        [inhoud setText: [NSString stringWithFormat:@"%i", [[appDelegate.currentCarDictionary valueForKey:@"MCode"] intValue]]];
                        
                    }
                    
                    else
                    {
                        [inhoud setText: [appDelegate.currentCarDictionary valueForKey:@"MCode"]];
                        
                    }
                    [inhoud setDelegate:self];
                    [inhoud setFont:[UIFont regularFlatFontOfSize:16]];
                    [inhoud setTextColor:[UIColor blackColor]];
                    [inhoud setTextAlignment:NSTextAlignmentLeft];
                    [self setFormat:format text:inhoud];
                    [inhoud setReturnKeyType:UIReturnKeyDone];
                    [content addSubview:inhoud];
                    
                    OnderdeelView *deel = (OnderdeelView*) [self superview];
                    [inhoud setContentdict:items];
                    [inhoud setIndexand:deel.indexand];
                    [inhoud setEdittext:[items valueForKey:@"InternetOmschrijving"]];
                    
                }
                
                else if ([[items valueForKey:@"InternetOmschrijving"]  isEqualToString:@"Vermogen"]) 
                {
                    
                    
                    EditTextView *inhoud =[[EditTextView alloc] initWithFrame:CGRectMake(10, 4, 250, 30)];
                    inhoud.limit = 500;
                    
                    inhoud.format = [[FileManager getMAskVeld:[items valueForKey:@"VeldMaskId"]] valueForKey:@"Mask"];
                    
                    if ([[[arraydelen firstObject] valueForKey:@"Waarde"] isKindOfClass:[NSNumber class]]) {
                        
                        [inhoud setText: [NSString stringWithFormat:@"%i", [[[arraydelen  firstObject] valueForKey:@"Waarde"] intValue]]];
                        
                    }
                    
                    else
                    {
                        [inhoud setText: [[arraydelen  firstObject] valueForKey:@"Waarde"]];
                        
                    }
                    [inhoud setDelegate:self];
                    [inhoud setFont:[UIFont regularFlatFontOfSize:16]];
                    [inhoud setTextColor:[UIColor blackColor]];
                    [inhoud setTextAlignment:NSTextAlignmentLeft];
                    [self setFormat:format text:inhoud];
                    [inhoud setReturnKeyType:UIReturnKeyDone];
                    [content addSubview:inhoud];
                    
                    OnderdeelView *deel = (OnderdeelView*) [self superview];
                    [inhoud setContentdict:items];
                    [inhoud setIndexand:deel.indexand];
                    [inhoud setEdittext:[items valueForKey:@"InternetOmschrijving"]];
                    
                    Vermogen =[[UILabel alloc]initWithFrame:CGRectMake(250-62,0,60,40)];
                    [Vermogen setText:[self caclalateVermogen:inhoud.text]];
                    [Vermogen setTextColor:[UIColor blackColor]];
                    [Vermogen setFont:[UIFont systemFontOfSize:16]];
                    [Vermogen setTextAlignment:NSTextAlignmentLeft];
                    [content addSubview:Vermogen];
                    [Vermogen setTag:1];
                    
                }
                
                else if ([[items valueForKey:@"InternetOmschrijving"] isEqualToString:@"Cilinderinhoud"]) {                   
                    
                    EditTextView *inhoud =[[EditTextView alloc] initWithFrame:CGRectMake(10, 4, 250, 30)];
                    inhoud.limit = 500;
                    
                    inhoud.format = [[FileManager getMAskVeld:[items valueForKey:@"VeldMaskId"]] valueForKey:@"Mask"];
                    
                    if ([[[arraydelen firstObject] valueForKey:@"Waarde"] isKindOfClass:[NSNumber class]]) {
                        
                        [inhoud setText: [NSString stringWithFormat:@"%i", [[[arraydelen  firstObject] valueForKey:@"Waarde"] intValue]]];
                        
                    }
                    
                    else
                    {
                        [inhoud setText: [[arraydelen  firstObject] valueForKey:@"Waarde"]];
                        
                    }
                    [inhoud setDelegate:self];
                    [inhoud setFont:[UIFont regularFlatFontOfSize:16]];
                    [inhoud setTextColor:[UIColor blackColor]];
                    [inhoud setTextAlignment:NSTextAlignmentLeft];
                    [self setFormat:format text:inhoud];
                    [inhoud setReturnKeyType:UIReturnKeyDone];
                    [content addSubview:inhoud];
                    
                    OnderdeelView *deel = (OnderdeelView*) [self superview];
                    [inhoud setContentdict:items];
                    [inhoud setIndexand:deel.indexand];
                    [inhoud setEdittext:[items valueForKey:@"InternetOmschrijving"]];
                    
                    cilinderinhoud =[[UILabel alloc]initWithFrame:CGRectMake(250-62,0,60,40)];
                    [cilinderinhoud setText:[self caclulateCillinder:inhoud.text]];
                    [cilinderinhoud setTextColor:[UIColor blackColor]];
                    [cilinderinhoud setBackgroundColor:[UIColor yellowColor]];
                    [cilinderinhoud setFont:[UIFont systemFontOfSize:16]];
                    [cilinderinhoud setTextAlignment:NSTextAlignmentLeft];
                    [content addSubview:cilinderinhoud];
                    [cilinderinhoud setTag:1];
                    
                    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textUpdated:) name: UITextFieldTextDidChangeNotification object:inhoud];
                    
                }
                else
                    
                {
                    
                    EditTextView *inhoud =[[EditTextView alloc] initWithFrame:CGRectMake(10, 4, 250, 30)];
                    inhoud.limit = 500;
                    
                    inhoud.format = [[FileManager getMAskVeld:[items valueForKey:@"VeldMaskId"]] valueForKey:@"Mask"];
                    
                    if ([[[arraydelen firstObject] valueForKey:@"Waarde"] isKindOfClass:[NSNumber class]]) {
                        
                        [inhoud setText: [NSString stringWithFormat:@"%i", [[[arraydelen  firstObject] valueForKey:@"Waarde"] intValue]]];
                        
                    }
                    
                    else
                    {
                        [inhoud setText: [[arraydelen  firstObject] valueForKey:@"Waarde"]];
                        
                    }
                    [inhoud setDelegate:self];
                    [inhoud setFont:[UIFont regularFlatFontOfSize:16]];
                    [inhoud setTextColor:[UIColor blackColor]];
                    [inhoud setTextAlignment:NSTextAlignmentLeft];
                    [self setFormat:format text:inhoud];
                    [inhoud setReturnKeyType:UIReturnKeyDone];
                    [content addSubview:inhoud];
                    
                    OnderdeelView *deel = (OnderdeelView*) [self superview];
                    [inhoud setContentdict:items];
                    [inhoud setIndexand:deel.indexand];
                    [inhoud setEdittext:[items valueForKey:@"InternetOmschrijving"]];
                    
                }
                
            }
        }
        
    }
    
        ////NSLog(@"%@", parantView.basepart);
    
    
    [self setUserInteractionEnabled:YES];
    
    if ([[parantView.basepart valueForKey:@"isInVoorraad"] boolValue]) {
        
        [self setUserInteractionEnabled:NO];
        
    }
    if ([[parantView.basepart valueForKey:@"isVermist"] boolValue]) {
        
        [self setUserInteractionEnabled:NO];
    }
    if ([[parantView.basepart valueForKey:@"isPrullenbak"] boolValue]) {
        
        [self setUserInteractionEnabled:NO];
    }
    if ([[parantView.basepart valueForKey:@"isVerkocht"] boolValue]) {
        
        [self setUserInteractionEnabled:NO];
    }
    
}

-(void) setFormat:(NSString*)format text:(EditTextView*)inhoud
{
        //////////NSLog(@"%@", format);
    if ([format isEqualToString:@"MCT"] ) {
        [inhoud setFormat:format];
        [inhoud setKeyboardType:UIKeyboardTypeNamePhonePad];
        inhoud.character = NO;
    } else  if ([format isEqualToString:@"MCU"] ) {
        [inhoud setFormat:format];
        [inhoud setKeyboardType:UIKeyboardTypeAlphabet];
        inhoud.character = YES;
    } else  if ([format isEqualToString:@"MR"] ) {
        [inhoud setFormat:format];
        [inhoud setKeyboardType:UIKeyboardTypeNumberPad];
        inhoud.character = NO;
    } else  if ([format isEqualToString:@"MR1"] ) {
        [inhoud setFormat:format];
        [inhoud setKeyboardType:UIKeyboardTypeNumberPad];
        inhoud.character = NO;
    } else  if ([format isEqualToString:@"MR2"] ) {
        [inhoud setFormat:format];
        [inhoud setKeyboardType:UIKeyboardTypeNumberPad];
        inhoud.character = NO;
    }
}
-(void)textUpdated:(EditTextView*)textField
{                   
    if ([textField.edittext isEqualToString:@"Cilinderinhoud"])
    {                   
        [cilinderinhoud setText:[self caclulateCillinder:textField.text]];
    }
    if ([textField.edittext isEqualToString:@"Vermogen"])
    {
        [Vermogen setText:[self caclalateVermogen:textField.text]];
        
        
    }
}
-(void)textViewDidEndEditing:(EditTextView *)textField
{
    AppDelegate *appDelegate = [FileManager getDel];
    
    appDelegate.viewcontroller.textcopy.VeldId = VeldId;
    [appDelegate.viewcontroller.textcopy ScanClass:textField set:parantView];
    if ([textField.edittext isEqualToString:@"Prijs"]) {
    }
    else
    {
        if ([textField.text length]>0) {
            
            [appDelegate.currentCarDictionary setValue:textField.text forKey:textField.edittext];
            
        }
    }
}

-(void)textViewDidBeginEditing:(EditTextView *)textField
{
    AppDelegate *appDelegate = [FileManager getDel];
    
        ////NSLog(@"%@", parantView.basepart);
    
    
        ////NSLog(@"%@", parantView.basepart);
        ////////////NSLog(@"biglabelview textViewDidBeginEditing");
    [appDelegate.viewcontroller.textcopy ScanClass:textField set:parantView];
    if ([textField.text isEqualToString:@"-"]) {
        [textField setText:@""];
    }
    
    if ([[self superview] isKindOfClass:[ItemFold class]]) {
        
        ItemFold *copy = (ItemFold*)[self superview];
        UIScrollView *scroll = (UIScrollView*)[[self superview] superview];
        scrollingSize = (self.frame.origin.y+copy.frame.origin.y);
        [appDelegate.currentItemDictonary setObject:copy forKey:@"CurrentItem"];
        [appDelegate.currentItemDictonary setObject:scroll forKey:@"Superview"];
        [appDelegate.currentItemDictonary setObject:appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy forKey:@"Header"];
        [appDelegate.currentItemDictonary setObject:[NSNumber numberWithFloat:scrollingSize] forKey:@"scrollingSize"];
    }
    else
    {
        OnderdeelView *copy = (OnderdeelView*)[[self superview] superview];
        scrollingSize = (self.frame.origin.y+copy.frame.origin.y-240);
        
        
        [appDelegate.currentItemDictonary setObject:copy forKey:@"CurrentItem"];
        [appDelegate.currentItemDictonary setObject:[self superview] forKey:@"Superview"];
        [appDelegate.currentItemDictonary setObject:copy forKey:@"Header"];
        [appDelegate.currentItemDictonary setObject:[NSNumber numberWithFloat:scrollingSize] forKey:@"scrollingSize"];
        
        
    }
    OnderdeelView *copy = (OnderdeelView*)[[[textField superview] superview] superview];
    CGRect frame = CGRectMake(copy.frame.origin.x, scrollingSize, copy.frame.size.width, copy.frame.size.height);
    [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy scrollRectToVisible:frame animated:NO];
    if ([textField.edittext isEqualToString:@"Prijs"]) {
        
        
        [textField becomeFirstResponder];
    }
    else
    {
        
        if ([textField.text length]>0) {
            
            [appDelegate.currentCarDictionary setValue:textField.text forKey:textField.edittext];
            
        }
        
        [textField becomeFirstResponder];
    }
    double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if ([[appDelegate.currentItemDictonary valueForKey:@"CurrentItem"] isKindOfClass:[ItemFold class]]) {
            UIView *copy = [appDelegate.currentItemDictonary valueForKey:@"CurrentItem"];
            float scrollingSize =[[appDelegate.currentItemDictonary valueForKey:@"scrollingSize"] floatValue];
            CGRect frame = CGRectMake(copy.frame.origin.x, scrollingSize-100, copy.frame.size.width, copy.frame.size.height);
            [[appDelegate.currentItemDictonary valueForKey:@"Superview"] scrollRectToVisible:frame animated:NO];
        }
        else
        {
            UIView *copy = [appDelegate.currentItemDictonary valueForKey:@"CurrentItem"];
            float scrollingSize =[[appDelegate.currentItemDictonary valueForKey:@"scrollingSize"] floatValue];
            CGRect frame = CGRectMake(copy.frame.origin.x, scrollingSize-100, copy.frame.size.width, copy.frame.size.height);
            [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy scrollRectToVisible:frame animated:NO];
        }
    });
    
    
}
- (BOOL)textFieldShouldReturn:(EditTextView *)textField {
    
    if ([textField.edittext isEqualToString:@"Prijs"]) {
    } else {
        if ([textField.text length]>0) {
            
            [parantView.basepart setValue:textField.text forKey:textField.edittext];
            
        }
    }
    
    
    [textField resignFirstResponder];
    return NO;
}
-(void)setPrijs:(NSString*)items
{
        //AppDelegate *appDelegate = [FileManager getDel];
    colorlabel =[[UILabel alloc]initWithFrame:CGRectMake(190,10,10,30)];
    [colorlabel setBackgroundColor:[UIColor colorWithRed:0.719543 green:0.000000 blue:1.000000 alpha:0.000000]];
    [self addSubview:colorlabel];
    [colorlabel setTag:1];
    [colorlabel setBackgroundColor:[UIColor colorWithRed:0.545809 green:0.763733 blue:0.834598 alpha:1.000000]];
    insert =200;
    UILabel *titles =[[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width, 30)];
    [titles setText:@"Prijs"];
    [titles setFont:[UIFont regularFlatFontOfSize:16]];
    [titles setTextColor:[UIColor blackColor]];
    [titles setTextAlignment:NSTextAlignmentLeft];
    [self addSubview:titles];
    
    UIView *content =[[UIView alloc] initWithFrame:CGRectMake(insert, 5, self.frame.size.width, 40)];
    [content setBackgroundColor:[UIColor whiteColor]];
    [content.layer setBorderWidth:2];
    [content.layer  setBorderColor:[UIColor lightGrayColor].CGColor];
    [content.layer setCornerRadius:6];
    [self addSubview:content];
    
    UILabel *euro =[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 30, 30)];
    [euro setText:@"€"];
    [euro setFont:[UIFont regularFlatFontOfSize:16]];
    [euro setTextColor:[UIColor blackColor]];
    [euro setTextAlignment:NSTextAlignmentLeft];
    [content addSubview:euro];
        ////////////NSLog(@"%@",items);
    EditTextView *inhoud =[[EditTextView alloc] initWithFrame:CGRectMake(30, 6, self.frame.size.width-40, 30)];
    inhoud.limit = 500;
    inhoud.format = [[FileManager getMAskVeld:[items valueForKey:@"VeldId"]] valueForKey:@"Mask"];
    OnderdeelView *deel = (OnderdeelView*) [self superview];
    [inhoud setContentdict:parantView.basepart];
    [inhoud setIndexand:deel.indexand];
    [inhoud setEdittext:@"Prijs"];
    [inhoud setDelegate:self];
    [inhoud setFont:[UIFont regularFlatFontOfSize:16]];
    [inhoud setTextColor:[UIColor blackColor]];
    [inhoud setTextAlignment:NSTextAlignmentLeft];
    [inhoud setReturnKeyType:UIReturnKeyDone];
    [inhoud setUserInteractionEnabled:NO];
    if ([[parantView.basepart valueForKey:@"Prijs"] isKindOfClass:[NSNumber class]]) {
        [inhoud setText:[NSString stringWithFormat:@"%i", [[parantView.basepart valueForKey:@"Prijs"] intValue]]];
    } else {
        [inhoud setText:[parantView.basepart valueForKey:@"Prijs"]];
    }
        //[inhoud setText:[parantView.basepart valueForKey:@"Prijs"]];
    [content addSubview:inhoud];
}
- (BOOL)textFieldShouldClear:(EditTextView *)textField;   
{
    return YES;
}
-(BOOL)textField:(EditTextView *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    
    if (textField.character) {
        return YES;
    } else {
        if ([textField.format isEqualToString:@"MCT"]||[textField.format isEqualToString:@"MCU"]) {
            return YES;
        }
        else
        {
            NSUInteger lengthOfString = string.length;
            for (NSInteger index = 0; index < lengthOfString; index++) {
                unichar character = [string characterAtIndex:index];
                if ((character < 48) && (character != 46)) return NO;
                    // 48 unichar for 0, and 46 unichar for point
                if (character > 57) return NO;
                    // 57 unichar for 9
            }
                // Check for total length
            NSUInteger proposedNewLength = textField.text.length - range.length + string.length;
            if (proposedNewLength > 6)
                
                
                return YES;
            return YES;
        }
    }
    
}
-(void)textFieldDidEndEditing:(EditTextView *)textField reason:(UITextFieldDidEndEditingReason)reason
{
    AppDelegate *appDelegate = [FileManager getDel];
    
    
    if ([textField.edittext isEqualToString:@"Prijs"]) {
    } else {
        if ([textField.text length]>0) {
            
            [appDelegate.currentCarDictionary setValue:textField.text forKey:textField.edittext];
            
        }
    }
    
    
}
-(void)setItem:(NSMutableDictionary*)items
{
    AppDelegate *appDelegate = [FileManager getDel];
    
        ////////////NSLog(@"big %@ %@", items, [items valueForKey:@"LengteMax"]);
    
    
    ItemFold *copy = (ItemFold*)[self superview];
    scrollingSize = (self.frame.size.height+self.frame.origin.y)+(copy.frame.size.height+copy.frame.origin.y);
    
    VeldId = [[items valueForKey:@"VeldId"] integerValue];
    self.tag = [[items valueForKey:@"VeldId"] integerValue];
    BOOL editable =YES;
    if ([[items valueForKey:@"editable"] isEqualToString:@"YES"])
    {
        editable =YES;
    } else {
        editable =NO;
    }
    BOOL character=YES;
    if ([[items valueForKey:@"char"] isEqualToString:@"YES"])
    {
        character =YES;
    } else {
        character =NO;
    }
        ////////////NSLog(@"%@", [items valueForKey:@"char"]);
        ////////////NSLog(@"%hhd", character);
    NSArray *set = [FileManager getVelden:[items valueForKey:@"VeldId"] and:[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
    
    if ([[appDelegate.currentCarDictionary allKeys] count]>0) {
        insert =200;
        
        
        if ([[items valueForKey:@"title_active"] isEqualToString:@"YES"]) {
            UILabel *title =[[UILabel alloc] initWithFrame:CGRectMake(0, 5, self.frame.size.width, 30)];
            [title setText:[items valueForKey:@"title"]];
            [title setFont:[UIFont regularFlatFontOfSize:16]];
            [title setTextColor:[UIColor blackColor]];
            [title setTextAlignment:NSTextAlignmentLeft];
            [self addSubview:title];
        }
        else
        {
            insert =10;
        }
        
        if ([[items valueForKey:@"function"] integerValue] ==1) {
            
            
            UIView *content =[[UIView alloc] initWithFrame:CGRectMake(insert, 5, [[items valueForKey:@"width"] floatValue], 40)];
            [content setBackgroundColor:[UIColor whiteColor]];
            [content.layer setBorderWidth:2];
            [content.layer  setBorderColor:[UIColor lightGrayColor].CGColor];
            [content.layer setCornerRadius:6];
            [self addSubview:content];                   
            if ([[items valueForKey:@"item"] isEqualToString:@"Naam"]) {
                
                EditTextView *inhoud =[[EditTextView alloc] initWithFrame:CGRectMake(10, 4, [[items valueForKey:@"width"] floatValue], 30)];
                inhoud.limit = 500;
                inhoud.format = [[FileManager getMAskVeld:@"1"] valueForKey:@"Mask"];
                [inhoud setText: [[[FileManager getMerk:[appDelegate.currentCarDictionary valueForKey:@"MerkId"]] firstObject] valueForKey:@"Naam"]];
                [inhoud setFont:[UIFont regularFlatFontOfSize:16]];
                [inhoud setTextColor:[UIColor blackColor]];
                [inhoud setDelegate:self];
                [inhoud setTextAlignment:NSTextAlignmentLeft];
                [content addSubview:inhoud];
                
                [inhoud setEdittext:[items valueForKey:@"item"]];
                [inhoud setEdittitle:[items valueForKey:@"title"]];
                [inhoud setUserInteractionEnabled:editable];
                [inhoud setCharacter:character];
                if (inhoud.character) {
                    
                    [inhoud setKeyboardType:UIKeyboardTypeNumberPad];
                }
                else
                {
                    
                    [inhoud setKeyboardType:UIKeyboardTypeAlphabet];
                    
                }
                
            }
            else if ([[items valueForKey:@"item"] isEqualToString:@"ModelId"]) {
                
                
                UILabel *title =[[UILabel alloc] initWithFrame:CGRectMake(10, 4, [[items valueForKey:@"width"] floatValue], 30)];
                
                [title setText:[[[[[FileManager getModel:[appDelegate.currentCarDictionary valueForKey:@"ModelId"]] firstObject] valueForKey:@"Namen"] valueForKey:@"InternetNaam"] componentsJoinedByString:@","]];
                [title setFont:[UIFont regularFlatFontOfSize:16]];
                [title setTextColor:[UIColor blackColor]];
                [title setTextAlignment:NSTextAlignmentLeft];
                [content addSubview:title];
                
            }
            else if ([[items valueForKey:@"item"] isEqualToString:@"InternetSoortId"]) {
                
                ItemListView *catogorie =[[ItemListView alloc]initWithFrame:CGRectMake(insert, 5, [[items valueForKey:@"width"] floatValue], 40)];
                [catogorie setBackgroundColor:[UIColor whiteColor]];
                [catogorie setTag:VeldId];
                catogorie.asY =catogorie.frame.origin.y;
                [catogorie.layer setBorderWidth:2];
                [catogorie.layer  setBorderColor:[UIColor lightGrayColor].CGColor];
                [catogorie.layer setCornerRadius:6];
                [self addSubview:catogorie];
                [catogorie.layer setCornerRadius:4];
                catogorie.VeldId =[[items valueForKey:@"VeldId"] integerValue];
                [catogorie setItemgo:[FileManager getInternetSoorten]];
                [catogorie setParentview:appDelegate.viewcontroller.carView.content];
                [catogorie setParentlabel:(FieldLabelView*)self];
                
            }
            else if ([[items valueForKey:@"item"] isEqualToString:@"Productielan"]) {
                ItemListView *catogorie =[[ItemListView alloc]initWithFrame:CGRectMake(insert, 5, [[items valueForKey:@"width"] floatValue], 40)];
                [catogorie setTag:VeldId];
                [catogorie setBackgroundColor:[UIColor whiteColor]];
                catogorie.asY =catogorie.frame.origin.y;
                [catogorie.layer setBorderWidth:2];
                [catogorie.layer  setBorderColor:[UIColor lightGrayColor].CGColor];
                [catogorie.layer setCornerRadius:6];
                [self addSubview:catogorie];
                [catogorie.layer setCornerRadius:4];
                catogorie.VeldId =[[items valueForKey:@"VeldId"] integerValue];
                [catogorie setItemCountry:[FileManager getLand]];
                
                [catogorie setParentview:appDelegate.viewcontroller.carView.content];
                [catogorie setParentlabel:(FieldLabelView*)self];
                
            }
            
            else
            {
                
            }
            
            NSArray *one =[FileManager getallVeldenValues];
            
            NSString *query = [NSString stringWithFormat:@"self contains [cd]'%@'", [items valueForKey:@"item"]];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:query];
            NSArray *arrayextra =  [[one
                                     filteredArrayUsingPredicate:predicate] mutableCopy];
            
            if ([arrayextra count]>0) {
                
                if ([[items valueForKey:@"title_active"] isEqualToString:@"YES"]) {
                    
                    ItemListView *catogorie =[[ItemListView alloc]initWithFrame:CGRectMake(insert, 5, [[items valueForKey:@"width"] floatValue], 40)];
                    [catogorie setTag:VeldId];
                    [catogorie setBackgroundColor:[UIColor whiteColor]];
                        // [catogorie setVeldId:[[velden valueForKey:@"VeldId"] integerValue]];
                    catogorie.asY =catogorie.frame.origin.y;
                    [catogorie.layer setBorderWidth:2];
                    [catogorie.layer  setBorderColor:[UIColor lightGrayColor].CGColor];
                    [catogorie.layer setCornerRadius:6];
                    [self addSubview:catogorie];
                    [catogorie.layer setCornerRadius:4];
                    catogorie.VeldId =[[items valueForKey:@"VeldId"] integerValue];
                    [catogorie setItemListAuto:[[FileManager getVeldenId:[items valueForKey:@"VeldId"]] valueForKey:@"VeldWaarden"]];
                    
                    [catogorie setParentview:appDelegate.viewcontroller.carView.content];
                    [catogorie setParentlabel:(FieldLabelView*)self];
                    
                    
                }
                else
                {
                    
                    ItemListView *catogorie =[[ItemListView alloc]initWithFrame:CGRectMake(insert, 5, [[items valueForKey:@"width"] floatValue], 40)];
                    [catogorie setTag:VeldId];
                    [catogorie setBackgroundColor:[UIColor whiteColor]];
                        // [catogorie setVeldId:[[velden valueForKey:@"VeldId"] integerValue]];
                    catogorie.asY =catogorie.frame.origin.y;
                    [catogorie.layer setBorderWidth:2];
                    [catogorie.layer  setBorderColor:[UIColor lightGrayColor].CGColor];
                    [catogorie.layer setCornerRadius:6];
                    [self addSubview:catogorie];
                    [catogorie.layer setCornerRadius:4];
                    
                    catogorie.VeldId =[[items valueForKey:@"VeldId"] integerValue];
                    [catogorie setItemListAuto:[[FileManager getVeldenId:[items valueForKey:@"VeldId"]] valueForKey:@"VeldWaarden"]];
                    
                    [catogorie setParentview:appDelegate.viewcontroller.carView.content];
                    [catogorie setParentlabel:(FieldLabelView*)self];
                }
                
                
            }
            NSArray *two =[[NSArray alloc] initWithObjects:@"Chassisnr",@"Kenteken",@"Inhoud",@"Kleppen",@"Vermogen",@"BPMBasis",@"Kleur",@"Kleur2",@"Kleur3",@"APKTotDatum",@"LamineerCodes", @"InternetPrijs",@"InternetPrijsExport",@"InternetPrijsSoort",@"InternetSoortId" @"Verzekerd",@"Gewicht",@"Bouwjaar",@"Bouwmaand",@"Bouwdag",@"Kilometerstand",@"ARNTag",@"Duplicaatnr", @"ControleLetter",@"Meldcode", @"KentekenKaartCode1",@"KentekenKaartCode2",@"KentekenKaartDocumentnummer", @"AldocModel", @"AldocType", @"Motorcode", @"Cilinderinhoud", @"Motornummer", @"Interieurcode",  @"Versnellingsbakcode", @"Laknummer voertuig",@"Laknummer voertuig 2",@"Laknummer voertuig 3",@"Wielbouten",@"Locatie", @"AanmaakMedewerker",@"Afstandbediening", @"AfstandbedieningOrigineel",@"SecurityCode", @"SleutelNummer", @"Sleutels", @"RadioCode", @"Verzekerd",@"InternetOmschrijving", @"Bijzonderheid", nil];
            for (int k =0; k < [two count]; k++) {
                
                
                    //[FileManager getVoertuigvelden]
                    //[items valueForKey:@"InternetOmschrijving"]
                
                
                if ([[appDelegate.currentCarDictionary allKeys] containsObject:[two objectAtIndex:k]]) {
                    
                    if ([[items valueForKey:@"item"] isEqualToString:[two objectAtIndex:k]]) {                   
                        UIView *content =[[UIView alloc] initWithFrame:CGRectMake(insert, 5, [[items valueForKey:@"width"] floatValue], 150)];
                        [content setBackgroundColor:[UIColor whiteColor]];
                        [content.layer setBorderWidth:2];
                        [content.layer  setBorderColor:[UIColor lightGrayColor].CGColor];
                        [content.layer setCornerRadius:6];
                        [self addSubview:content];
                        
                        if ([ [items valueForKey:@"item"] isEqualToString:@"AldocType"]) {
                            
                                //////////NSLog(@"item %@", [items valueForKey:@"item"]);
                            
                            UITextView *inhoud =[[UITextView alloc] initWithFrame:CGRectMake(10, 4, [[items valueForKey:@"width"] floatValue]-10, 130)];
                            [inhoud setText: [[appDelegate.currentCarDictionary valueForKey:[two objectAtIndex:k]] stringByReplacingOccurrencesOfString:@"  " withString:@"\n"]];
                            [inhoud setFont:[UIFont regularFlatFontOfSize:16]];
                            [inhoud setTextColor:[UIColor blackColor]];
                            [inhoud setTextAlignment:NSTextAlignmentLeft];
                                //[inhoud setNumberOfLines:99];
                                //[inhoud setDelegate:self];
                            [content addSubview:inhoud];
                            
                                //[inhoud setText:[items valueForKey:@"title"]];
                            [inhoud setUserInteractionEnabled:NO];
                            
                            
                            [content setFrame:CGRectMake(insert, 5, [[items valueForKey:@"width"] floatValue], 140)];
                                //
                            
                        }
                        
                        else if ([ [items valueForKey:@"item"] isEqualToString:@"Bijzonderheid"]||[ [items valueForKey:@"item"] isEqualToString:@"InternetOmschrijving"]) {
                            
                            
                            EditTextView *inhoud =[[EditTextView alloc] initWithFrame:CGRectMake(10, 4, [[items valueForKey:@"width"] floatValue]-10, 290)];
                            inhoud.limit = 500;
                            [inhoud setText: [[appDelegate.currentCarDictionary valueForKey:[two objectAtIndex:k]] stringByReplacingOccurrencesOfString:@"  " withString:@"\n"]];
                            [inhoud setFont:[UIFont regularFlatFontOfSize:16]];
                            [inhoud setTextColor:[UIColor blackColor]];
                            [inhoud setTextAlignment:NSTextAlignmentLeft];
                            [inhoud setEdittext:[items valueForKey:@"item"]];
                            [inhoud setEdittitle:[items valueForKey:@"title"]];
                            [inhoud setPos:[items valueForKey:@"Pos"]];
                            [inhoud setUserInteractionEnabled:editable];
                            [inhoud setDelegate:self];
                            [content addSubview:inhoud];
                            
                            [content setFrame:CGRectMake(insert, 5, [[items valueForKey:@"width"] floatValue], 290)];
                            
                            
                            
                        }
                        
                        
                        else
                        {
                            
                            
                            EditTextView *inhoud =[[EditTextView alloc] initWithFrame:CGRectMake(10, 4, [[items valueForKey:@"width"] floatValue]-5, 30)];
                            inhoud.limit = 500;;
                            
                            
                            
                            
                            if ([[appDelegate.currentCarDictionary valueForKey:[two objectAtIndex:k]] isKindOfClass:[NSNumber class]]) {
                                
                                
                                
                                
                                
                                [inhoud setText: [NSString stringWithFormat:@"%i", [[appDelegate.currentCarDictionary valueForKey:[two objectAtIndex:k]] intValue]]];
                                
                            }
                            
                            else
                            {
                                [inhoud setText: [appDelegate.currentCarDictionary valueForKey:[two objectAtIndex:k]]];
                                
                            }
                            
                            [inhoud setFont:[UIFont regularFlatFontOfSize:16]];
                            [inhoud setTextColor:[UIColor blackColor]];
                            [inhoud setTextAlignment:NSTextAlignmentLeft];
                            [inhoud setDelegate:self];
                            [inhoud setPos:[items valueForKey:@"Pos"]];
                            [content addSubview:inhoud];
                            
                            [inhoud setEdittext:[items valueForKey:@"item"]];
                            [inhoud setEdittitle:[items valueForKey:@"title"]];
                            [inhoud setUserInteractionEnabled:editable];
                            [inhoud setCharacter:character];
                            
                            if (inhoud.character) {
                                
                                
                                [inhoud setKeyboardType:UIKeyboardTypeAlphabet];
                                
                            }
                            else
                            {
                                
                                [inhoud setKeyboardType:UIKeyboardTypeNumberPad];
                                
                                
                                
                                
                            }
                            
                            
                            
                        }
                        
                    }
                    
                }
                else
                {
                    
                    if ([[items valueForKey:@"item"] isEqualToString:[two objectAtIndex:k]]) {
                        
                        
                        
                        if ([ [items valueForKey:@"item"] isEqualToString:@"Cilinderinhoud"]) {
                            
                            EditTextView *inhoud =[[EditTextView alloc] initWithFrame:CGRectMake(10, 4, [[items valueForKey:@"width"] floatValue], 30)];
                            inhoud.limit = 500;
                            
                            
                            
                            if ([[[set firstObject] valueForKey:@"Waarde"] isKindOfClass:[NSNumber class]]) {
                                
                                [inhoud setText: [NSString stringWithFormat:@"%i", [[[set  firstObject] valueForKey:@"Waarde"] intValue]]];
                                
                            }
                            
                            else
                            {
                                [inhoud setText: [[set  firstObject] valueForKey:@"Waarde"]];
                                
                            }
                            
                            [inhoud setFont:[UIFont regularFlatFontOfSize:16]];
                            [inhoud setTextColor:[UIColor blackColor]];
                            [inhoud setTextAlignment:NSTextAlignmentLeft];
                            [content addSubview:inhoud];
                            [inhoud setPos:[items valueForKey:@"Pos"]];
                            [inhoud setEdittext:[items valueForKey:@"item"]];
                            [inhoud setEdittitle:[items valueForKey:@"title"]];
                            [inhoud setUserInteractionEnabled:editable];
                            [inhoud setDelegate:self];
                            [inhoud setCharacter:character];
                            
                            if (inhoud.character) {
                                
                                
                                [inhoud setKeyboardType:UIKeyboardTypeAlphabet];
                                
                            }
                            else
                            {
                                
                                [inhoud setKeyboardType:UIKeyboardTypeNumberPad];
                                
                                
                                
                                
                            }
                            
                            
                            cilinderinhoud =[[UILabel alloc]initWithFrame:CGRectMake([[items valueForKey:@"width"] floatValue]-62,0,60,40)];
                            [cilinderinhoud setText:[self caclulateCillinder:inhoud.text]];
                            [cilinderinhoud setTextColor:[UIColor blackColor]];
                            [cilinderinhoud setBackgroundColor:[UIColor yellowColor]];
                            [cilinderinhoud setFont:[UIFont systemFontOfSize:16]];
                            [cilinderinhoud setTextAlignment:NSTextAlignmentLeft];
                            [content addSubview:cilinderinhoud];
                            [cilinderinhoud setTag:1];
                            
                        }
                        
                        else if ([ [items valueForKey:@"item"] isEqualToString:@"Vermogen"]) 
                        {                   
                            
                            EditTextView *inhoud =[[EditTextView alloc] initWithFrame:CGRectMake(10, 4, [[items valueForKey:@"width"] floatValue], 30)];
                            inhoud.limit = 500;
                            
                            
                            if ([[[set firstObject] valueForKey:@"Waarde"] isKindOfClass:[NSNumber class]]) {
                                
                                [inhoud setText: [NSString stringWithFormat:@"%i", [[[set  firstObject] valueForKey:@"Waarde"] intValue]]];
                                
                            }
                            
                            else
                            {
                                [inhoud setText: [[set  firstObject] valueForKey:@"Waarde"]];
                                
                            }
                            
                            [inhoud setFont:[UIFont regularFlatFontOfSize:16]];
                            [inhoud setTextColor:[UIColor blackColor]];
                            [inhoud setTextAlignment:NSTextAlignmentLeft];
                            [content addSubview:inhoud];
                            [inhoud setEdittext:[items valueForKey:@"item"]];
                            [inhoud setEdittitle:[items valueForKey:@"title"]];
                            [inhoud setUserInteractionEnabled:editable];
                            [inhoud setDelegate:self];
                            [inhoud setCharacter:character];
                            
                            if (inhoud.character) {
                                
                                
                                [inhoud setKeyboardType:UIKeyboardTypeAlphabet];
                                
                            }
                            else
                            {
                                
                                [inhoud setKeyboardType:UIKeyboardTypeNumberPad];
                                
                                
                                
                                
                            }
                            
                            Vermogen =[[UILabel alloc]initWithFrame:CGRectMake([[items valueForKey:@"width"] floatValue]-62,0,60,40)];
                            [Vermogen setText:[self caclalateVermogen:inhoud.text]];
                            [Vermogen setTextColor:[UIColor blackColor]];
                            [Vermogen setFont:[UIFont systemFontOfSize:16]];
                            [Vermogen setTextAlignment:NSTextAlignmentLeft];
                            [content addSubview:Vermogen];
                            [Vermogen setTag:1];
                        }
                        else
                        {
                            
                            
                            EditTextView *inhoud =[[EditTextView alloc] initWithFrame:CGRectMake(10, 4, [[items valueForKey:@"width"] floatValue], 30)];
                            inhoud.limit = 500;
                            
                            
                            if ([[[set firstObject] valueForKey:@"Waarde"] isKindOfClass:[NSNumber class]]) {
                                
                                [inhoud setText: [NSString stringWithFormat:@"%i", [[[set  firstObject] valueForKey:@"Waarde"] intValue]]];
                                
                            }
                            
                            else
                            {
                                [inhoud setText: [[set  firstObject] valueForKey:@"Waarde"]];
                                
                            }
                            
                            [inhoud setFont:[UIFont regularFlatFontOfSize:16]];
                            [inhoud setTextColor:[UIColor blackColor]];
                            [inhoud setTextAlignment:NSTextAlignmentLeft];
                            [content addSubview:inhoud];
                            [inhoud setEdittext:[items valueForKey:@"item"]];
                            [inhoud setEdittitle:[items valueForKey:@"title"]];
                            [inhoud setUserInteractionEnabled:editable];
                            [inhoud setDelegate:self];
                            [inhoud setCharacter:character];
                            
                            if (inhoud.character) {
                                
                                
                                [inhoud setKeyboardType:UIKeyboardTypeAlphabet];
                                
                            }
                            else
                            {
                                
                                [inhoud setKeyboardType:UIKeyboardTypeNumberPad];
                                
                                
                                
                                
                            }
                            
                            if ([[items valueForKey:@"item"] isEqualToString:@"Bijzonderheid"]||[[items valueForKey:@"item"] isEqualToString:@"InternetOmschrijving"]) {
                                [content setFrame:CGRectMake(insert, 5, [[items valueForKey:@"width"] floatValue], 230)];
                                
                                
                                [inhoud setFrame:CGRectMake(10, 4, [[items valueForKey:@"width"] floatValue], 190)];
                                
                                
                            }
                        }
                        
                    }
                    
                }
            }
        }
    }
}
-(NSString*)caclulateCillinder:(NSString*)string
{
    if ([string length]>0) {
        
        return [NSString stringWithFormat:@"%.1f l", [string floatValue]/1000];
    } else {
        
        
        return @"";
    }
}
-(NSString*)caclalateVermogen:(NSString*)string
{
    
    if ([string length]>0) {
        return [NSString stringWithFormat:@"%.1f pk", [string floatValue]*1.362];
        
    } else {
        
        return @"";
    }
}
@end
