    //
    //  LabelView.m
    //  Autonet
    //
    //  Created by Livecast02 on 02-02-17.
    //  Copyright © 2017 Autonet. All rights reserved.
    //
#import "FieldLabelView.h"
#import "OnderdeelView.h"
#import "UIFont+FlatUI.h"
#import "FileManager.h"
#import "AppDelegate.h"
#import "ItemListView.h"
#import "OnderdeelView.h"
#import "EditTextField.h"
@implementation FieldLabelView
@synthesize insert;
@synthesize foldscreen;
@synthesize parantView;
@synthesize veldID;
@synthesize cilinderinhoud;
@synthesize vermogen;
@synthesize colorLabel;
@synthesize scrollingSize;
@synthesize title;
@synthesize limit;


-(UILabel*) buildTitle:(NSMutableDictionary*)items

{
    UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(0, 5, self.frame.size.width, 30)];
    [label setText:[items valueForKey:@"Naam"]];
    [label setFont:[UIFont regularFlatFontOfSize:16]];
    [label setTextColor:[UIColor blackColor]];
    [label setTextAlignment:NSTextAlignmentLeft];
    return label;

}

-(UILabel*) buildCilinderinhoud:(EditTextField*)inhoud

{
    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(250-82,0,80,40)];
    [label setText:[self caclulateCillinder:inhoud.text]];
    [label setTextColor:[UIColor blackColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont systemFontOfSize:16]];
    [label setTextAlignment:NSTextAlignmentLeft];
    [label setTag:1];
    return label;

}

-(UILabel*) buildVermogen:(EditTextField*)inhoud

{
    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(250-82,0,80,40)];
    [label setText:[self caclalateVermogen:inhoud.text]];
    [label setTextColor:[UIColor blackColor]];
    [label setFont:[UIFont systemFontOfSize:16]];
    [label setTextAlignment:NSTextAlignmentLeft];
    [label setTag:1];
    return label;

}

-(ItemListView*) buildItemListView

{
    AppDelegate *appDelegate = [FileManager getDel];
    ItemListView *list =[[ItemListView alloc]initWithFrame:CGRectMake(insert, 5, 250, 40)];
    [list setTag:veldID];
    [list setBackgroundColor:[UIColor whiteColor]];
    list.asY =5;
    [list.layer setBorderWidth:2];
    [list.layer  setBorderColor:[UIColor lightGrayColor].CGColor];
    [list.layer setCornerRadius:6];
    [list setParentview:appDelegate.viewcontroller.carView.content];
    [list setParentlabel:self];
    return list;

}

-(void)setAirbags:(NSMutableDictionary*)items
{
    [self addSubview:[self buildTitle:items]];
    insert =180;
    ItemListView *catogorie =[self buildItemListView];
    [self addSubview:catogorie];
    NSArray *set =[[NSArray alloc] initWithObjects:@"Afwezig",@"Aanwezig", nil];
    [catogorie setItemYESNOAirbag:set aanwezig:items];
}
-(void)setOpties:(NSMutableDictionary*)items
{

    [self addSubview:[self buildTitle:items]];
    [self addSubview:title];
    insert =180;
    ItemListView *catogorie =[self buildItemListView];
    [self addSubview:catogorie];
    NSArray *set =[[NSArray alloc] initWithObjects:@"Afwezig",@"Aanwezig", nil];
    [catogorie setItemYESNOOpties:set aanwezig:items];
}
-(void)setSchades:(NSMutableDictionary*)items
{

    [self addSubview:[self buildTitle:items]];
    [self addSubview:title];
    insert =180;
    ItemListView *catogorie =[self buildItemListView];
    [self addSubview:catogorie];
    NSArray *set =[[NSArray alloc] initWithObjects:@"Nee",@"Ja", nil];
    [catogorie setItemYESNOSchades:set aanwezig:items];
}
-(void)setGordels:(NSMutableDictionary*)items
{
    [self addSubview:[self buildTitle:items]];
    [self addSubview:title];
    insert =180;
    ItemListView *catogorie =[self buildItemListView];
    [self addSubview:catogorie];
    NSArray *set =[[NSArray alloc] initWithObjects:@"Afwezig",@"Aanwezig", nil];
    [catogorie setItemYESNOGordels:set aanwezig:items];
}
-(void)setItemTeststatussen:(NSMutableDictionary*)items
{
}
-(void)setItemVeld:(NSMutableDictionary*)items
{                   
    AppDelegate *appDelegate = [FileManager getDel];
    NSArray *arraydelen = [FileManager getVeldenOnOnderdeel:[items valueForKey:@"VeldId"] and:[parantView.basepart valueForKey:@"DeelId"]];


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


    //////NSLog(@"items %@",  arraydelen);

    NSString *textcontent =@"";
    NSString *queryit = [NSString stringWithFormat:@"VeldId = %@", [items valueForKey:@"VeldId"]];
    NSPredicate *predicateit = [NSPredicate predicateWithFormat:queryit];
    NSMutableArray *content = [[[parantView.basepart valueForKey:@"VeldWaarden"] filteredArrayUsingPredicate:predicateit] mutableCopy];
    if ([content count]>0) {
        textcontent =[[content firstObject] valueForKey:@"Waarde"];
    } else {
    }
    NSString *format;
    if ([[items valueForKey:@"VeldMaskId"] isKindOfClass:[NSNumber class]]) {
        format  = [[FileManager getMAskVeld:[items valueForKey:@"VeldMaskId"]] valueForKey:@"Mask"];
    }
    title =[[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width, 30)];
    [title setText:[items valueForKey:@"InternetOmschrijving"]];
    [title setFont:[UIFont regularFlatFontOfSize:16]];
    [title setTextColor:[UIColor blackColor]];
    [title setTextAlignment:NSTextAlignmentLeft];
    [self addSubview:title];

    colorLabel =[[UILabel alloc]initWithFrame:CGRectMake(190,10,10,30)];
    [colorLabel setBackgroundColor:[UIColor colorWithRed:0.719543 green:0.000000 blue:1.000000 alpha:0.000000]];
    [self addSubview:colorLabel];
    [colorLabel setTag:1];
    if ([[appDelegate.currentCarDictionary allKeys] containsObject:[items valueForKey:@"InternetOmschrijving"]]) {
        [self setUserInteractionEnabled:NO];
        [colorLabel setBackgroundColor:[UIColor colorWithRed:0.545809 green:0.763733 blue:0.834598 alpha:1.000000]];
    } else {
        if ([@"Versnellingsbakcode" isEqualToString:[items valueForKey:@"InternetOmschrijving"]]||[@"Motorcode" isEqualToString:[items valueForKey:@"InternetOmschrijving"]]) {
            [self setUserInteractionEnabled:NO];
            [colorLabel setBackgroundColor:[UIColor colorWithRed:0.545809 green:0.763733 blue:0.834598 alpha:1.000000]];
        }
        else
        {
            if ([appDelegate.uneditable containsObject:[items valueForKey:@"InternetOmschrijving"]]) {
                [self setUserInteractionEnabled:NO];
                [colorLabel setBackgroundColor:[UIColor colorWithRed:0.545809 green:0.763733 blue:0.834598 alpha:1.000000]];
            }
            else
            {
                [colorLabel setBackgroundColor:[UIColor colorWithRed:0.439289 green:0.764236 blue:0.506794 alpha:1.000000]];
            }
        }
    }
    insert =200;
    if ([[items valueForKey:@"VeldWaarden"] count]>0) {


        ItemListView *catogorie =[[ItemListView alloc]initWithFrame:CGRectMake(insert, 5, 250, 40)];
        catogorie.Veldname = [items valueForKey:@"InternetOmschrijving"];
        [catogorie setTag:veldID];
        [catogorie setBackgroundColor:[UIColor whiteColor]];
        catogorie.asY =5;
        [catogorie.layer setBorderWidth:2];
        [catogorie.layer  setBorderColor:[UIColor lightGrayColor].CGColor];
        [catogorie.layer setCornerRadius:6];
        [catogorie.layer setCornerRadius:4];
        catogorie.VeldId =[[items valueForKey:@"VeldId"] integerValue];
        [catogorie setOnderdeelview:parantView];
        [catogorie setParentlabel:self];
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

        //////NSLog(@"%@", catogorie.search.titleView.text);

        if ([[arraydelen firstObject] valueForKey:@"Waarde"]) {
            NSString *queryit = [NSString stringWithFormat:@"Waarde LIKE [cd]'%@'", [[arraydelen firstObject] valueForKey:@"Waarde"]];
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
        else
        {
        }
        if ([appDelegate.uneditable containsObject:[items valueForKey:@"InternetOmschrijving"]]) {
            [catogorie.search.upDownView setAlpha:0];
        }
        else
        {
        }
    } else {
        if ([[appDelegate.currentCarDictionary allKeys] containsObject:[items valueForKey:@"InternetOmschrijving"]]||[[appDelegate.currentCarDictionary allKeys] containsObject:@"MCode"]) {

            UIView *content =[[UIView alloc] initWithFrame:CGRectMake(insert, 5, 250, 40)];
            [content setBackgroundColor:[UIColor whiteColor]];
            [content.layer setBorderWidth:2];
            [content.layer  setBorderColor:[UIColor lightGrayColor].CGColor];
            [content.layer setCornerRadius:6];
            [self addSubview:content];

            EditTextField *inhoud =[[EditTextField alloc] initWithFrame:CGRectMake(10, 4, 250, 30)];
            inhoud.limit = self.limit;
            inhoud.format = [[FileManager getMAskVeld:[items valueForKey:@"VeldMaskId"]] valueForKey:@"Mask"];
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
            if ([ [items valueForKey:@"InternetOmschrijving"] isEqualToString:@"Tellerstand"]) {
                if ([[appDelegate.currentCarDictionary valueForKey:@"Kilometerstand"] isKindOfClass:[NSNumber class]]) {
                    [inhoud setText: [NSString stringWithFormat:@"%i", [[appDelegate.currentCarDictionary valueForKey:@"Kilometerstand"] intValue]]];
                }
                else
                {
                    [inhoud setText: [appDelegate.currentCarDictionary valueForKey:@"Kilometerstand"]];
                }
                [self setUserInteractionEnabled:NO];
                [colorLabel setBackgroundColor:[UIColor colorWithRed:0.545809 green:0.763733 blue:0.834598 alpha:1.000000]];
            }
            else  if ([ [items valueForKey:@"InternetOmschrijving"] isEqualToString:@"Versnellingsbakcode"]) {
                    //Versnellingsbakcode
                if ([[appDelegate.currentCarDictionary valueForKey:@"VBCode"] isKindOfClass:[NSNumber class]]) {
                    [inhoud setText: [NSString stringWithFormat:@"%i", [[appDelegate.currentCarDictionary valueForKey:@"VBCode"] intValue]]];
                }
                else
                {
                    [inhoud setText: [appDelegate.currentCarDictionary valueForKey:@"VBCode"]];
                }
                [self setUserInteractionEnabled:NO];
                [colorLabel setBackgroundColor:[UIColor colorWithRed:0.545809 green:0.763733 blue:0.834598 alpha:1.000000]];
            }
            else if ([ [items valueForKey:@"InternetOmschrijving"] isEqualToString:@"Motorcode"]) {
                if ([[appDelegate.currentCarDictionary valueForKey:@"MCode"] isKindOfClass:[NSNumber class]]) {
                    [inhoud setText: [NSString stringWithFormat:@"%i", [[appDelegate.currentCarDictionary valueForKey:@"MCode"] intValue]]];
                }
                else
                {
                    [inhoud setText: [appDelegate.currentCarDictionary valueForKey:@"MCode"]];
                }
                [self setUserInteractionEnabled:NO];
                [colorLabel setBackgroundColor:[UIColor colorWithRed:0.545809 green:0.763733 blue:0.834598 alpha:1.000000]];
            }
            else if ([ [items valueForKey:@"InternetOmschrijving"] isEqualToString:@"InternetSoortId"]) {
                if ([[appDelegate.currentCarDictionary valueForKey:@"MCode"] isKindOfClass:[NSNumber class]]) {
                    [inhoud setText: [NSString stringWithFormat:@"%i", [[appDelegate.currentCarDictionary valueForKey:@"MCode"] intValue]]];
                }
                else
                {
                    [inhoud setText: [appDelegate.currentCarDictionary valueForKey:@"MCode"]];
                }
                [self setUserInteractionEnabled:NO];
                [colorLabel setBackgroundColor:[UIColor colorWithRed:0.545809 green:0.763733 blue:0.834598 alpha:1.000000]];
            }
            else if ([[items valueForKey:@"InternetOmschrijving"] isEqualToString:@"Cilinderinhoud"]) {
                if ([[[arraydelen firstObject] valueForKey:@"Waarde"] isKindOfClass:[NSNumber class]]) {
                    [inhoud setText: [NSString stringWithFormat:@"%i", [[[arraydelen  firstObject] valueForKey:@"Waarde"] intValue]]];
                }
                else
                {
                    [inhoud setText: [[arraydelen  firstObject] valueForKey:@"Waarde"]];
                }
                [self setUserInteractionEnabled:NO];
                [colorLabel setBackgroundColor:[UIColor colorWithRed:0.545809 green:0.763733 blue:0.834598 alpha:1.000000]];
                cilinderinhoud =[self buildCilinderinhoud:inhoud];
                [content addSubview:cilinderinhoud];
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textUpdated:) name: UITextFieldTextDidChangeNotification object:inhoud];
            }
            else if ([[items valueForKey:@"InternetOmschrijving"] isEqualToString:@"Vermogen"]) {
                if ([[[arraydelen firstObject] valueForKey:@"Waarde"] isKindOfClass:[NSNumber class]]) {
                    [inhoud setText: [NSString stringWithFormat:@"%i", [[[arraydelen  firstObject] valueForKey:@"Waarde"] intValue]]];
                }
                else
                {
                    [inhoud setText: [[arraydelen  firstObject] valueForKey:@"Waarde"]];
                }
                vermogen = [self buildVermogen:inhoud];
                [content addSubview:vermogen];
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textUpdated:) name: UITextFieldTextDidChangeNotification object:inhoud];
                [vermogen sizeToFit];
                [vermogen setFrame:CGRectMake(220-vermogen.frame.size.width,0,vermogen.frame.size.width,40)];
            }
            else
            {
                if ([[[arraydelen firstObject] valueForKey:@"Waarde"] isKindOfClass:[NSNumber class]]) {
                    [inhoud setText: [NSString stringWithFormat:@"%i", [[[arraydelen  firstObject] valueForKey:@"Waarde"] intValue]]];
                }
                else
                {
                    [inhoud setText: [[arraydelen  firstObject] valueForKey:@"Waarde"]];
                }
            }
        }
        else
        {
            UIView *content =[[UIView alloc] initWithFrame:CGRectMake(insert, 5, 250, 40)];
            [content setBackgroundColor:[UIColor whiteColor]];
            [content.layer setBorderWidth:2];
            [content.layer  setBorderColor:[UIColor lightGrayColor].CGColor];
            [content.layer setCornerRadius:6];
            [content setFrame:CGRectMake(insert, 5, 250, 40)];
            [self addSubview:content];

            EditTextField *inhoud =[[EditTextField alloc] initWithFrame:CGRectMake(10, 4, 250, 30)];


            inhoud.limit = self.limit;
            [inhoud setDelegate:self];
            [inhoud setFont:[UIFont regularFlatFontOfSize:16]];
            [inhoud setTextColor:[UIColor blackColor]];
            [inhoud setTextAlignment:NSTextAlignmentLeft];
            [self setFormat:format text:inhoud];
            [inhoud setReturnKeyType:UIReturnKeyDone];
            [content addSubview:inhoud];
            [inhoud setEdittext:[items valueForKey:@"InternetOmschrijving"]];
            if ([ [items valueForKey:@"InternetOmschrijving"] isEqualToString:@"Tellerstand"]) {
                inhoud.format = [[FileManager getMAskVeld:[items valueForKey:@"VeldMaskId"]] valueForKey:@"Mask"];
                if ([[appDelegate.currentCarDictionary valueForKey:@"Kilometerstand"] isKindOfClass:[NSNumber class]]) {
                    [inhoud setText: [NSString stringWithFormat:@"%i", [[appDelegate.currentCarDictionary valueForKey:@"Kilometerstand"] intValue]]];
                }
                else
                {
                    [inhoud setText: [appDelegate.currentCarDictionary valueForKey:@"Kilometerstand"]];
                }
            }
            else if ([ [items valueForKey:@"InternetOmschrijving"] isEqualToString:@"Motorcode"]) {
                inhoud.format = [[FileManager getMAskVeld:[items valueForKey:@"VeldMaskId"]] valueForKey:@"Mask"];
                if ([[appDelegate.currentCarDictionary valueForKey:@"MCode"] isKindOfClass:[NSNumber class]]) {
                    [inhoud setText: [NSString stringWithFormat:@"%i", [[appDelegate.currentCarDictionary valueForKey:@"MCode"] intValue]]];
                }
                else
                {
                    [inhoud setText: [appDelegate.currentCarDictionary valueForKey:@"MCode"]];
                }
            }
            else if ([ [items valueForKey:@"InternetOmschrijving"] isEqualToString:@"InternetSoortId"]) {
                inhoud.format = [[FileManager getMAskVeld:[items valueForKey:@"VeldMaskId"]] valueForKey:@"Mask"];
                if ([[appDelegate.currentCarDictionary valueForKey:@"MCode"] isKindOfClass:[NSNumber class]]) {
                    [inhoud setText: [NSString stringWithFormat:@"%i", [[appDelegate.currentCarDictionary valueForKey:@"MCode"] intValue]]];
                }
                else
                {
                    [inhoud setText: [appDelegate.currentCarDictionary valueForKey:@"MCode"]];
                }
            }
            else if ([[items valueForKey:@"InternetOmschrijving"]  isEqualToString:@"Vermogen"])
            {
                inhoud.format = [[FileManager getMAskVeld:[items valueForKey:@"VeldMaskId"]] valueForKey:@"Mask"];
                if ([[[arraydelen firstObject] valueForKey:@"Waarde"] isKindOfClass:[NSNumber class]]) {
                    [inhoud setText: [NSString stringWithFormat:@"%i", [[[arraydelen  firstObject] valueForKey:@"Waarde"] intValue]]];
                }
                else
                {
                    [inhoud setText: [[arraydelen  firstObject] valueForKey:@"Waarde"]];
                }
                vermogen = [self buildVermogen:inhoud];
                [content addSubview:vermogen];
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textUpdated:) name: UITextFieldTextDidChangeNotification object:inhoud];
            }
            else if ([[items valueForKey:@"InternetOmschrijving"] isEqualToString:@"Cilinderinhoud"]) {
                inhoud.format = [[FileManager getMAskVeld:[items valueForKey:@"VeldMaskId"]] valueForKey:@"Mask"];
                if ([[[arraydelen firstObject] valueForKey:@"Waarde"] isKindOfClass:[NSNumber class]]) {
                    [inhoud setText: [NSString stringWithFormat:@"%i", [[[arraydelen  firstObject] valueForKey:@"Waarde"] intValue]]];
                }
                else
                {
                    [inhoud setText: [[arraydelen  firstObject] valueForKey:@"Waarde"]];
                }
                cilinderinhoud =[self buildCilinderinhoud:inhoud];
                [content addSubview:cilinderinhoud];
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textUpdated:) name: UITextFieldTextDidChangeNotification object:inhoud];
            }
            else
            {
                inhoud.character = YES;
                inhoud.format = [[FileManager getMAskVeld:[items valueForKey:@"VeldMaskId"]] valueForKey:@"Mask"];
                if ([textcontent length]>0) {
                    [inhoud setText:textcontent];
                }
                else
                {
                    if ([[[arraydelen firstObject] valueForKey:@"Waarde"] isKindOfClass:[NSNumber class]]) {
                        [inhoud setText: [NSString stringWithFormat:@"%i", [[[arraydelen  firstObject] valueForKey:@"Waarde"] intValue]]];
                        inhoud.character = NO;
                    }
                    else
                    {
                        [inhoud setText: [[arraydelen  firstObject] valueForKey:@"Waarde"]];
                        inhoud.character = YES;
                    }
                }
                if ([[arraydelen firstObject] valueForKey:@"Waarde"]) {
                    [inhoud setText:[[arraydelen firstObject] valueForKey:@"Waarde"]];
                }
                else
                {
                }
            }
        }
    }



}
-(void) setFormat:(NSString*)format text:(EditTextField*)inhoud
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
-(void)setItemVeldCar:(NSMutableDictionary*)items
{                   
    AppDelegate *appDelegate = [FileManager getDel];
    NSArray *one =[FileManager getallVeldenValues];

    if ([[items valueForKey:@"LengteMax"] intValue]==0) {

    } else {
    //////NSLog(@"%@", [items valueForKey:@"LengteMax"]);
    //////NSLog(@"%@", [items valueForKey:@"Pos"]);

    }



    NSString *query = [NSString stringWithFormat:@"self like [cd]'%@'", [items valueForKey:@"item"]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:query];
    if ([appDelegate.currentCarDictionary count]>0) {
        veldID = [[items valueForKey:@"VeldId"] integerValue];
        self.tag = [[items valueForKey:@"VeldId"] integerValue];
        BOOL editable =YES;
        if ([[items valueForKey:@"editable"] isEqualToString:@"YES"])
        {
            editable =YES;
        }
        else
        {
            editable =NO;
        }
        BOOL character=YES;
        if ([[items valueForKey:@"char"] isEqualToString:@"YES"])
        {
            character =YES;
        }
        else
        {
            character =NO;
        }
        if ([[appDelegate.currentCarDictionary allKeys] count]>0) {
            insert =200;
            if ([[items valueForKey:@"title_active"] isEqualToString:@"YES"]) {

                title =[self buildTitle:items];
                [title setText:[NSString stringWithFormat:@"%@", [items valueForKey:@"title"]]];
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


                    EditTextField *inhoud =[[EditTextField alloc] initWithFrame:CGRectMake(10, 4, [[items valueForKey:@"width"] floatValue], 30)];
                    inhoud.limit = self.limit;
                    inhoud.format = [[FileManager getMAskVeld:@"1"] valueForKey:@"Mask"];
                    [inhoud setText: [[[FileManager getMerk:[appDelegate.currentCarDictionary valueForKey:@"MerkId"]] firstObject] valueForKey:@"Naam"]];
                    [inhoud setFont:[UIFont regularFlatFontOfSize:16]];
                    [inhoud setTextColor:[UIColor blackColor]];
                    [inhoud setDelegate:self];
                    [inhoud setTextAlignment:NSTextAlignmentLeft];
                    [content addSubview:inhoud];
                    [inhoud setReturnKeyType:UIReturnKeyDone];
                    [inhoud setEdittext:[items valueForKey:@"item"]];
                    [inhoud setEdittitle:[items valueForKey:@"title"]];
                    [inhoud setUserInteractionEnabled:editable];
                    [inhoud setPos:[items valueForKey:@"Pos"]];
                    [inhoud setLengteMax:[NSNumber numberWithInt:[[items valueForKey:@"LengteMax"] intValue]]];
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
                    [content setFrame:CGRectMake(insert, 5, [[items valueForKey:@"width"] floatValue], 40)];


                    title =[[UILabel alloc] initWithFrame:CGRectMake(10, 4, [[items valueForKey:@"width"] floatValue], 30)];
                    [title setText:[[[[[FileManager getModel:[appDelegate.currentCarDictionary valueForKey:@"ModelId"]] firstObject] valueForKey:@"Namen"] valueForKey:@"InternetNaam"] componentsJoinedByString:@","]];
                    [title setFont:[UIFont regularFlatFontOfSize:16]];
                    [title setTextColor:[UIColor blackColor]];
                    [title setTextAlignment:NSTextAlignmentLeft];
                    [content addSubview:title];
                }

                else if ([[items valueForKey:@"item"] isEqualToString:@"InternetSoortId"]||[[items valueForKey:@"item"] isEqualToString:@"InternetPrijsSoort"]||[[items valueForKey:@"item"] isEqualToString:@"KilometerEenheid"]||[[items valueForKey:@"item"] isEqualToString:@"VoertuigSoort"]||[[items valueForKey:@"item"] isEqualToString:@"HerkomstLandId"]) {

                    ItemListView *catogorie =[[ItemListView alloc]initWithFrame:CGRectMake(insert, 5, [[items valueForKey:@"width"] floatValue], 40)];
                    catogorie.Veldname = [items valueForKey:@"item"];
                    [catogorie setBackgroundColor:[UIColor whiteColor]];
                    catogorie.currentDictonary =items;
                    [catogorie setTag:[[items valueForKey:@"VeldId"] integerValue]];
                    catogorie.asY =catogorie.frame.origin.y;
                    [catogorie.layer setBorderWidth:2];
                    [catogorie.layer  setBorderColor:[UIColor lightGrayColor].CGColor];
                    [catogorie.layer setCornerRadius:4];
                    [self addSubview:catogorie];

                    if ([[items valueForKey:@"item"] isEqualToString:@"InternetSoortId"]) {


                        if ([[appDelegate.currentCarDictionary valueForKey:@"IsORAD"] boolValue]) {



                            NSMutableDictionary *copy = [[FileManager getInternetSoorten] mutableCopy];
                            [copy removeObjectForKey:@"1"];
                            [copy removeObjectForKey:@"2"];

                            NSLog(@"YES %@", copy);


                            [catogorie setItemgo:copy];
                            [catogorie setParentview:appDelegate.viewcontroller.carView.content];
                            [catogorie setParentlabel:self];

                        }

                        else
                        {

                               NSLog(@"NO %@", [FileManager getInternetSoorten]);
                            [catogorie setItemgo:[FileManager getInternetSoorten]];
                            [catogorie setParentview:appDelegate.viewcontroller.carView.content];
                            [catogorie setParentlabel:self];

                        }

                    }
                    else if ([[items valueForKey:@"item"] isEqualToString:@"InternetPrijsSoort"]) {

                        catogorie.VeldId =[[items valueForKey:@"VeldId"] integerValue];
                        [catogorie setItemVelden:[FileManager getBTW]];
                        [catogorie setParentview:appDelegate.viewcontroller.carView.content];
                        [catogorie setParentlabel:self];
                        if ([[appDelegate.currentCarDictionary valueForKey:@"InternetPrijsSoort"] isEqualToString:@"-"]) {
                        }
                        else
                        {
                            [catogorie.search.titleView setText:[[[FileManager getBTWOnID:[appDelegate.currentCarDictionary valueForKey:@"InternetPrijsSoort"]] firstObject] valueForKey:@"WaardeLang"]];
                        }
                    }
                    else if ([[items valueForKey:@"item"] isEqualToString:@"KilometerEenheid"]) {

                        [catogorie setItemVelden:[FileManager getAfstand]];
                        [catogorie setParentview:appDelegate.viewcontroller.carView.content];
                        [catogorie setParentlabel:self];
                        if ([[appDelegate.currentCarDictionary valueForKey:@"KilometerEenheid"] isEqualToString:@"-"]) {
                        }
                        else
                        {
                            [catogorie.search.titleView setText:[[[FileManager getAfstandOnID:[appDelegate.currentCarDictionary valueForKey:@"KilometerEenheid"]] firstObject] valueForKey:@"WaardeLang"]];
                        }
                    }
                    else if ([[items valueForKey:@"item"] isEqualToString:@"VoertuigSoort"]) {

                        catogorie.VeldId =[[items valueForKey:@"VeldId"] integerValue];
                        NSArray *copygetVoertuigsoorten = [FileManager getVoertuigsoorten];
                        if ([copygetVoertuigsoorten count]>0) {
                            [catogorie setItemSoorten:copygetVoertuigsoorten];
                        }
                        [catogorie setParentview:appDelegate.viewcontroller.carView.content];
                        [catogorie setParentlabel:self];
                        [catogorie.tableResult setUserInteractionEnabled:NO];
                        [catogorie.search setUserInteractionEnabled:NO];
                    }
                    else if ([[items valueForKey:@"item"] isEqualToString:@"HerkomstLandId"]) {

                        catogorie.VeldId =[[items valueForKey:@"VeldId"] integerValue];
                        [catogorie setItemCountry:[FileManager getLand]];
                        [catogorie setParentview:appDelegate.viewcontroller.carView.content];
                        [catogorie setParentlabel:self];
                        if ([appDelegate.currentCarDictionary valueForKey:@"HerkomstLandId"] == NULL) {
                        }
                        else
                        {
                            [catogorie.search.titleView setText:[[[FileManager getLandID:[appDelegate.currentCarDictionary valueForKey:@"HerkomstLandId"]] firstObject] valueForKey:@"Naam"]];
                        }

                    }
                }

                else if ([[items valueForKey:@"item"] isEqualToString:@"Bijzonderheid"]||[[items valueForKey:@"item"] isEqualToString:@"InternetOmschrijving"]) {
                    [content setFrame:CGRectMake(insert, 5, [[items valueForKey:@"width"] floatValue], 230)];


                    EditTextField *inhoud =[[EditTextField alloc] initWithFrame:CGRectMake(10, 4, [[items valueForKey:@"width"] floatValue], 190)];
                    inhoud.limit = self.limit;
                    [inhoud setFont:[UIFont regularFlatFontOfSize:16]];
                    [inhoud setTextColor:[UIColor blackColor]];
                    [inhoud setTextAlignment:NSTextAlignmentLeft];
                    [inhoud setDelegate:self];
                    [content addSubview:inhoud];
                    [inhoud setEdittext:[items valueForKey:@"item"]];
                    [inhoud setEdittitle:[items valueForKey:@"title"]];
                    [inhoud setUserInteractionEnabled:YES];
                    [inhoud setPos:[items valueForKey:@"Pos"]];
                    [inhoud setLengteMax:[NSNumber numberWithInt:[[items valueForKey:@"LengteMax"] intValue]]];
                    [inhoud setCharacter:character];
                    if (inhoud.character) {
                        [inhoud setKeyboardType:UIKeyboardTypeAlphabet];
                    }
                    else
                    {
                        [inhoud setKeyboardType:UIKeyboardTypeNumberPad];
                    }
                }
                else
                {
                }
                NSArray *arrayextra =  [[one
                                         filteredArrayUsingPredicate:predicate] mutableCopy];

                //////////NSLog(@"%@", arrayextra);
                
                if ([arrayextra count]>0) {

                    ItemListView *catogorie =[[ItemListView alloc]initWithFrame:CGRectMake(insert, 5, [[items valueForKey:@"width"] floatValue], 40)];
                    catogorie.asY =catogorie.frame.origin.y;
                    [catogorie.layer setBorderWidth:2];
                    [catogorie.layer  setBorderColor:[UIColor lightGrayColor].CGColor];
                    [catogorie.layer setCornerRadius:6];
                    [catogorie.layer setCornerRadius:4];

                    if ([[items valueForKey:@"title_active"] isEqualToString:@"YES"]) {
                        if ([[items valueForKey:@"item"] isEqualToString:@"Motortype"]) {
                            catogorie.Veldname = [items valueForKey:@"title"];
                        }
                        else
                        {
                            catogorie.Veldname = [items valueForKey:@"item"];
                        }

                    }
                    else
                    {
                        catogorie.Veldname = [items valueForKey:@"item"];

                    }

                    [catogorie setTag:veldID];
                    [catogorie setBackgroundColor:[UIColor whiteColor]];
                    catogorie.asY =catogorie.frame.origin.y;
                    catogorie.VeldId =[[items valueForKey:@"VeldId"] integerValue];
                    [catogorie setParentview:appDelegate.viewcontroller.carView.content];
                    [catogorie setParentlabel:self];
                    [catogorie setItemListAuto:[[FileManager getVeldenId:[items valueForKey:@"VeldId"]] valueForKey:@"VeldWaarden"]];



                    [self addSubview:catogorie];
                }
                if ( [[self subviews] count]==3) {
                    ItemListView *copylist = (ItemListView*)[[self subviews] lastObject];
                    if ([copylist.Veldname isEqualToString:@"Lengte/Hoogte"]) {

                        //////////NSLog(@"%@", appDelegate.Soort);

                        if ([appDelegate.Soort isEqualToString:@"Bus"]) {
                        }
                        else if ([appDelegate.Soort isEqualToString:@"Bestel"]) {
                        }
                        else
                        {
                            [copylist.search setUserInteractionEnabled:NO];
                            [copylist.search.titleView setText:@""];
                        }
                    }
                }
                NSArray *itemslist =[[NSArray alloc] initWithObjects:@"VraagPrijs", @"Chassisnr",@"KentekenOpgemaakt",@"Inhoud",@"Kleppen",@"BPMBasis",@"Kleur",@"Kleur2",@"Kleur3",@"APKTotDatum",@"Verzekerd",@"LamineerCodes", @"InternetPrijs",@"InternetPrijsExport",@"Gewicht",@"Bouwjaar",@"Bouwmaand",@"Bouwdag",@"Kilometerstand",@"ARNTag",@"Duplicaatnr", @"ControleLetter",@"Meldcode", @"KentekenKaartCode1",@"KentekenKaartCode2",@"KentekenKaartDocumentnummer", @"AldocModel", @"AldocType", @"MCode", @"Cilinderinhoud",@"Vermogen", @"Motornummer", @"Interieurcode", @"VBCode", @"Laknummer voertuig",@"Laknummer voertuig 2",@"Laknummer voertuig 3",@"Wielbouten",@"Locatie", @"AanmaakMedewerker",@"Afstandbediening", @"AfstandbedieningOrigineel",@"SecurityCode", @"SleutelNummer", @"Sleutels", @"RadioCode", @"lpg", nil];
                    //////////NSLog(@"%@", [items valueForKey:@"item"] );
                NSArray *two =  [[itemslist  filteredArrayUsingPredicate:predicate] mutableCopy];
                for (int k =0; k < [two count]; k++) {
                    if ([[items valueForKey:@"item"] isEqualToString:[two objectAtIndex:k]]) {
                        NSString *  querynew = [NSString stringWithFormat:@"(VeldId == %@) and (VeldId > 0)", [items valueForKey:@"VeldId"]];
                        NSPredicate *predicateits = [NSPredicate predicateWithFormat:querynew];
                        NSMutableArray* copyplist = [[[FileManager getVoertuigVeldenOpID] filteredArrayUsingPredicate:predicateits] mutableCopy];



                        if ([ [items valueForKey:@"item"] isEqualToString:@"AldocType"]) {

                            UIView *content =[[UIView alloc] initWithFrame:CGRectMake(insert, 5, [[items valueForKey:@"width"] floatValue], 100)];
                            [content setBackgroundColor:[UIColor whiteColor]];
                            [content.layer setBorderWidth:2];
                            [content.layer  setBorderColor:[UIColor lightGrayColor].CGColor];
                            [content.layer setCornerRadius:6];
                            [self addSubview:content];

                            UITextView *inhoudextra =[[UITextView alloc] initWithFrame:CGRectMake(10, 4, [[items valueForKey:@"width"] floatValue]-10, 92)];
                            [inhoudextra setText: [[appDelegate.currentCarDictionary valueForKey:[two objectAtIndex:k]] stringByReplacingOccurrencesOfString:@"  " withString:@"\n"]];
                            [inhoudextra setFont:[UIFont regularFlatFontOfSize:16]];
                            [inhoudextra setTextColor:[UIColor blackColor]];
                            [inhoudextra setTextAlignment:NSTextAlignmentLeft];
                            [content addSubview:inhoudextra];
                            [inhoudextra setUserInteractionEnabled:editable];


                        }
                        else
                        {

                            UIView *content =[[UIView alloc] initWithFrame:CGRectMake(insert, 5, [[items valueForKey:@"width"] floatValue], 100)];
                            [content setBackgroundColor:[UIColor whiteColor]];
                            [content.layer setBorderWidth:2];
                            [content.layer  setBorderColor:[UIColor lightGrayColor].CGColor];
                            [content.layer setCornerRadius:6];
                            [self addSubview:content];

                            EditTextField *inhoud =[[EditTextField alloc] initWithFrame:CGRectMake(10, 4, [[items valueForKey:@"width"] floatValue]-5, 30)];
                            inhoud.limit = self.limit;
                            [inhoud setFont:[UIFont regularFlatFontOfSize:16]];
                            [inhoud setTextColor:[UIColor blackColor]];
                            [inhoud setTextAlignment:NSTextAlignmentLeft];
                            [inhoud setDelegate:self];
                            [inhoud setEdittext:[items valueForKey:@"item"]];
                            [inhoud setEdittitle:[items valueForKey:@"title"]];
                            [inhoud setUserInteractionEnabled:editable];
                            [inhoud setPos:[items valueForKey:@"Pos"]];

                            NSLog(@"%@", [items valueForKey:@"item"]);
                            NSLog(@"%@", [items valueForKey:@"Pos"]);

                            [inhoud setLengteMax:[NSNumber numberWithInt:[[items valueForKey:@"LengteMax"] intValue]]];
                            [inhoud setDelegate:self];
                            [inhoud setCharacter:character];
                            [content addSubview:inhoud];

                            
                            if ([[items valueForKey:@"item"] isEqualToString:@"AldocModel"]) {
                                [content setFrame:CGRectMake(insert, 5, [[items valueForKey:@"width"] floatValue], 40)];
                                [inhoud setText:[appDelegate.currentCarDictionary valueForKey:[two objectAtIndex:k]]];
                                [self setCaracters:inhoud];
                                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textEditet:) name: UITextFieldTextDidChangeNotification object:inhoud];
                            }
                            else if ([[items valueForKey:@"item"] isEqualToString:@"LamineerCodes"]) {
                                if ([[items valueForKey:@"title"] isEqualToString:@"Lamineercode 1:"]) {
                                    [content setFrame:CGRectMake(insert, 5, [[items valueForKey:@"width"] floatValue], 40)];
                                    if ([[appDelegate.currentCarDictionary valueForKey:[two objectAtIndex:k]] isKindOfClass:[NSArray class]]) {
                                        [inhoud setText:[[appDelegate.currentCarDictionary valueForKey:[two objectAtIndex:k]] firstObject]];
                                    }
                                    else
                                    {
                                    }
                                    [inhoud setEdittext:@"Lamineercode 1:"];
                                    [self setCaracters:inhoud];
                                    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textEditet:) name: UITextFieldTextDidChangeNotification object:inhoud];
                                }
                                else
                                {
                                    [content setFrame:CGRectMake(insert, 5, [[items valueForKey:@"width"] floatValue], 40)];
                                    if ([[appDelegate.currentCarDictionary valueForKey:[two objectAtIndex:k]] isKindOfClass:[NSArray class]]) {
                                        [inhoud setText:[[appDelegate.currentCarDictionary valueForKey:[two objectAtIndex:k]] lastObject]];
                                    }
                                    else
                                    {
                                    }
                                    [inhoud setEdittext:@"Lamineercode 2:"];
                                    [self setCaracters:inhoud];
                                    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textEditet:) name: UITextFieldTextDidChangeNotification object:inhoud];
                                }
                            }
                            else if ([[items valueForKey:@"item"] isEqualToString:@"AanmaakMedewerker"]||[[items valueForKey:@"item"] isEqualToString:@"Sleutels"]|[[items valueForKey:@"item"] isEqualToString:@"RadioCode"]||[[items valueForKey:@"item"] isEqualToString:@"Locatie"]||[[items valueForKey:@"item"] isEqualToString:@"AfstandbedieningOrigineel"]||[[items valueForKey:@"item"] isEqualToString:@"Afstandbediening"]||[[items valueForKey:@"item"] isEqualToString:@"KentekenKaartDocumentnummer"]||[[items valueForKey:@"item"] isEqualToString:@"SecurityCode"]||[[items valueForKey:@"item"] isEqualToString:@"KentekenOpgemaakt"]||[[items valueForKey:@"item"] isEqualToString:@"MCode"]||[[items valueForKey:@"item"] isEqualToString:@"VBCode"]) {

                                [content setFrame:CGRectMake(insert, 5, [[items valueForKey:@"width"] floatValue], 40)];
                                if ([[appDelegate.currentCarDictionary allKeys] containsObject:[two objectAtIndex:k]]) {
                                    if ([[appDelegate.currentCarDictionary valueForKey:[two objectAtIndex:k]] isKindOfClass:[NSString class]]) {
                                        [inhoud setText:[appDelegate.currentCarDictionary valueForKey:[two objectAtIndex:k]]];
                                    }
                                    else
                                    {
                                        [inhoud setText:[NSString stringWithFormat:@"%@",[appDelegate.currentCarDictionary valueForKey:[two objectAtIndex:k]]]];
                                    }
                                }
                                [inhoud setEdittext:[items valueForKey:@"item"]];
                                [inhoud setEdittitle:[items valueForKey:@"title"]];
                                [self setCaracters:inhoud];
                                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textEditet:) name: UITextFieldTextDidChangeNotification object:inhoud];
                            }
                            else if ([[items valueForKey:@"item"] isEqualToString:@"APKTotDatum"]||[[items valueForKey:@"item"] isEqualToString:@"Verzekerd"]) {
                                    //////////NSLog(@"two %@", [two objectAtIndex:k]);
                                NSDateFormatter *formattertoDate = [[NSDateFormatter alloc] init];
                                [formattertoDate setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"nl_NL"]];
                                [formattertoDate setDateFormat:@"yyyy-MM-dd"];
                                NSDateFormatter *formattertoString = [[NSDateFormatter alloc] init];
                                [formattertoString setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"nl_NL"]];
                                [formattertoString setDateFormat:@"dd-MM-yyyy"];
                                [content setFrame:CGRectMake(insert, 5, [[items valueForKey:@"width"] floatValue], 40)];
                                if ([formattertoString stringFromDate:[formattertoDate dateFromString:[[appDelegate.currentCarDictionary valueForKey:[two objectAtIndex:k]] stringByReplacingOccurrencesOfString:@"T00:00:00" withString:@""]]]) {
                                    [inhoud setText:[formattertoString stringFromDate:[formattertoDate dateFromString:[[appDelegate.currentCarDictionary valueForKey:[two objectAtIndex:k]] stringByReplacingOccurrencesOfString:@"T00:00:00" withString:@""]]]];
                                }
                                else
                                {
                                    [inhoud setText:[appDelegate.currentCarDictionary valueForKey:[two objectAtIndex:k]]];
                                }
                                [inhoud setEdittext:[items valueForKey:@"item"]];
                                [inhoud setEdittitle:[items valueForKey:@"title"]];
                                [self setCaracters:inhoud];
                                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textEditet:) name: UITextFieldTextDidChangeNotification object:inhoud];
                            }
                            else if ([ [items valueForKey:@"item"] isEqualToString:@"Vermogen"])
                            {
                                [content setFrame:CGRectMake(insert, 5, [[items valueForKey:@"width"] floatValue], 40)];
                                if ( [[appDelegate.currentCarDictionary valueForKey:[two objectAtIndex:k]] intValue]) {
                                    [inhoud setText: [NSString stringWithFormat:@"%i", [[appDelegate.currentCarDictionary valueForKey:[two objectAtIndex:k]] intValue]]];
                                }
                                else
                                {
                                    if ([copyplist count]>0)
                                    {

                                        ////////NSLog(@"%@", copyplist);
                                        [inhoud setText: [NSString stringWithFormat:@"%@", [[copyplist firstObject] valueForKey:@"Waarde"]]];
                                        inhoud.VeldId =  [[items valueForKey:@"VeldId"] intValue];
                                    }
                                    else
                                    {
                                        inhoud.VeldId =  [[items valueForKey:@"VeldId"] intValue];
                                    }
                                }
                                [inhoud setEdittext:[items valueForKey:@"item"]];
                                [inhoud setEdittitle:[items valueForKey:@"title"]];
                                [self setCaracters:inhoud];
                                vermogen = [self buildVermogen:inhoud];
                                [content addSubview:vermogen];
                                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textUpdated:) name: UITextFieldTextDidChangeNotification object:inhoud];
                                [vermogen sizeToFit];
                                [vermogen setFrame:CGRectMake(220-vermogen.frame.size.width,0,vermogen.frame.size.width,40)];
                            }
                            else if ([ [items valueForKey:@"item"] isEqualToString:@"Cilinderinhoud"])
                            {
                                [content setFrame:CGRectMake(insert, 5, [[items valueForKey:@"width"] floatValue], 40)];
                                if ( [[appDelegate.currentCarDictionary valueForKey:[two objectAtIndex:k]] intValue]) {
                                    [inhoud setText: [NSString stringWithFormat:@"%i", [[appDelegate.currentCarDictionary valueForKey:[two objectAtIndex:k]] intValue]]];
                                }
                                else
                                {
                                    if ([copyplist count]>0)
                                    {
                                        [inhoud setText: [NSString stringWithFormat:@"%@", [[copyplist firstObject] valueForKey:@"Waarde"]]];
                                        inhoud.VeldId =  [[items valueForKey:@"VeldId"] intValue];
                                    }
                                    else
                                    {
                                        inhoud.VeldId =  [[items valueForKey:@"VeldId"] intValue];
                                    }
                                }
                                [self setCaracters:inhoud];
                                cilinderinhoud = [self buildCilinderinhoud:inhoud];
                                [content addSubview:cilinderinhoud];
                                [cilinderinhoud setFrame:CGRectMake(260-cilinderinhoud.frame.size.width,0,cilinderinhoud.frame.size.width,40)];
                                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textUpdated:) name: UITextFieldTextDidChangeNotification object:inhoud];
                            }
                            else if ([[items valueForKey:@"item"] isEqualToString:@"VraagPrijs"]||[[items valueForKey:@"item"] isEqualToString:@"InternetPrijs"]||[[items valueForKey:@"item"] isEqualToString:@"InternetPrijsExport"]||[[items valueForKey:@"item"] isEqualToString:@"BPMBasis"]) {
                                [content setFrame:CGRectMake(insert, 5, [[items valueForKey:@"width"] floatValue], 40)];
                                if ([[appDelegate.currentCarDictionary valueForKey:[two objectAtIndex:k]] isKindOfClass:[NSNumber class]]) {
                                    NSNumberFormatter *formatter = [NSNumberFormatter new];
                                    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
                                    formatter.currencyCode = @"EUR";
                                    formatter.usesGroupingSeparator = YES;
                                    [inhoud setText: [NSString stringWithFormat:@"%@",[formatter stringFromNumber:[appDelegate.currentCarDictionary valueForKey:[two objectAtIndex:k]]]]];

                                    [inhoud setFrame:CGRectMake(20, 4, [[items valueForKey:@"width"] floatValue]-25, 30)];

                                    UILabel *euro =[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 30, 30)];
                                    [euro setText:@"€"];
                                    [euro setFont:[UIFont regularFlatFontOfSize:16]];
                                    [euro setTextColor:[UIColor blackColor]];
                                    [euro setTextAlignment:NSTextAlignmentLeft];
                                    [content addSubview:euro];
                                }
                                else
                                {
                                    [inhoud setText: [appDelegate.currentCarDictionary valueForKey:[two objectAtIndex:k]]];

                                    [inhoud setFrame:CGRectMake(30, 4, [[items valueForKey:@"width"] floatValue]-35, 30)];

                                    UILabel *euro =[[UILabel alloc] initWithFrame:CGRectMake(10, 4, 30, 30)];
                                    [euro setText:@"€"];
                                    [euro setFont:[UIFont regularFlatFontOfSize:16]];
                                    [euro setTextColor:[UIColor blackColor]];
                                    [euro setTextAlignment:NSTextAlignmentLeft];
                                    [content addSubview:euro];
                                }
                                [inhoud setKeyboardType:UIKeyboardTypeNumberPad];
                                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textEditet:) name: UITextFieldTextDidChangeNotification object:inhoud];
                                if ([[items valueForKey:@"item"] isEqualToString:@"VraagPrijs"])
                                {
                                    UILabel *internet =[[UILabel alloc] initWithFrame:CGRectMake(14+insert+[[items valueForKey:@"width"] floatValue], 0, 150, 50)];
                                    [internet setFont:[UIFont regularFlatFontOfSize:16]];
                                    [internet setTextColor:[UIColor blackColor]];
                                    [internet setText:@"Prijs op internet"];
                                    [internet setBackgroundColor:[UIColor clearColor]];
                                    [internet setTextAlignment:NSTextAlignmentLeft];
                                    [self addSubview:internet];


                                    UISwitch *UISwitchOne =[[UISwitch alloc] initWithFrame:CGRectMake(214+insert+[[items valueForKey:@"width"] floatValue], 10, 60, 40)];
                                    [UISwitchOne addTarget:self action:@selector(moveOnintenet:) forControlEvents:(UIControlEventValueChanged | UIControlEventTouchDragInside)];
                                    [UISwitchOne setOnTintColor:[UIColor greenColor]];
                                    UISwitchOne.backgroundColor = [UIColor redColor];
                                    UISwitchOne.layer.cornerRadius = 16.0;
                                    [self addSubview:UISwitchOne];
                                    if ([[appDelegate.currentCarDictionary valueForKey:@"PrijsOnlineTonen"] floatValue]) {
                                        [UISwitchOne setOn:YES];
                                    }
                                    else
                                    {
                                        [UISwitchOne setOn:NO];
                                    }
                                }
                            }
                            else
                            {
                                [content setFrame:CGRectMake(insert, 5, [[items valueForKey:@"width"] floatValue], 40)];




                                if ( [[appDelegate.currentCarDictionary valueForKey:[two objectAtIndex:k]] intValue]) {
                                        //////////NSLog(@"two %@", [two objectAtIndex:k]);
                                    if ([[appDelegate.currentCarDictionary valueForKey:[two objectAtIndex:k]] isKindOfClass:[NSNumber class]]) {
                                        [inhoud setText: [NSString stringWithFormat:@"%i", [[appDelegate.currentCarDictionary valueForKey:[two objectAtIndex:k]] intValue]]];
                                    }
                                    else
                                    {
                                        [inhoud setText: [appDelegate.currentCarDictionary valueForKey:[two objectAtIndex:k]]];
                                    }
                                }
                                else
                                {
                                    [self lakSetting:inhoud array:copyplist ItemVeldCar:items];
                                }

                                inhoud.VeldId =  [[items valueForKey:@"VeldId"] intValue];
                                [inhoud setEdittext:[items valueForKey:@"item"]];
                                [inhoud setEdittitle:[items valueForKey:@"title"]];
                                [inhoud setUserInteractionEnabled:editable];
                                [inhoud setPos:[items valueForKey:@"Pos"]];
                                [inhoud setLengteMax:[NSNumber numberWithInt:[[items valueForKey:@"LengteMax"] intValue]]];;
                                [inhoud setCharacter:character];
                                
                                if (inhoud.character) {
                                    [inhoud setKeyboardType:UIKeyboardTypeAlphabet];
                                }
                                else
                                {
                                    [inhoud setKeyboardType:UIKeyboardTypeNumberPad];
                                }

                            

                                if ([ [items valueForKey:@"item"] isEqualToString:@"AfstandbedieningOrigineel"]) {
                                    [content setFrame:CGRectMake(insert, 5, [[items valueForKey:@"width"] floatValue], 40)];

                                    title =[[UILabel alloc] initWithFrame:CGRectMake(-100, 5, 100, 30)];
                                    [title setText:[NSString stringWithFormat:@"%@", [items valueForKey:@"title"]]];
                                    [title setFont:[UIFont regularFlatFontOfSize:16]];
                                    [title setTextColor:[UIColor blackColor]];
                                    [title setBackgroundColor:[UIColor clearColor]];
                                    [title setTextAlignment:NSTextAlignmentLeft];
                                    [self addSubview:title];
                                }
                                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textEditet:) name: UITextFieldTextDidChangeNotification object:inhoud];



                            }
                        }
                    }
                }
            }
        }
    }
}

-(void) lakSetting:(EditTextField*)inhoud  array:(NSArray*)copyplist ItemVeldCar:(NSMutableDictionary*)items

{
    if ([[items valueForKey:@"item"] isEqualToString:@"Laknummer voertuig"])
    {
        if ([copyplist count]>0)
        {
            [inhoud setText: [NSString stringWithFormat:@"%@", [[copyplist objectAtIndex:0] valueForKey:@"Waarde"]]];
        }
        else
        {
        }
    } else if ([[items valueForKey:@"item"] isEqualToString:@"Laknummer voertuig 2"]) {
        if ([copyplist count]>1)
        {
            [inhoud setText: [NSString stringWithFormat:@"%@", [[copyplist objectAtIndex:1] valueForKey:@"Waarde"]]];
        }
        else
        {
        }
    } else if ([[items valueForKey:@"item"] isEqualToString:@"Laknummer voertuig 3"])
    {
        if ([copyplist count]>2)
        {
            [inhoud setText: [NSString stringWithFormat:@"%@", [[copyplist objectAtIndex:2] valueForKey:@"Waarde"]]];
        }
        else
        {
        }
    } else if (   [[items valueForKey:@"item"] isEqualToString:@"Kleur"]) {
        if ([copyplist count]>0)
        {
            [inhoud setText: [NSString stringWithFormat:@"%@", [[copyplist firstObject] valueForKey:@"Waarde"]]];
        }
        else
        {
        }
    } else if ([[items valueForKey:@"item"] isEqualToString:@"Kleur2"]) {
        if ([copyplist count]>1)
        {
            [inhoud setText: [NSString stringWithFormat:@"%@", [[copyplist objectAtIndex:1] valueForKey:@"Waarde"]]];
        }
        else
        {
        }
    } else if (   [[items valueForKey:@"item"] isEqualToString:@"Kleur3"]) {
        if ([copyplist count]>2)
        {
            [inhoud setText: [NSString stringWithFormat:@"%@", [[copyplist objectAtIndex:2] valueForKey:@"Waarde"]]];
        }
        else
        {
        }
    } else {
        if ([copyplist count])
        {
            [inhoud setText: [NSString stringWithFormat:@"%@", [[copyplist firstObject] valueForKey:@"Waarde"]]];
        }
        else
        {
        }
    }

}

-(void)setCaracters:(EditTextField*)inhoud

{
    if (inhoud.character) {
        [inhoud setKeyboardType:UIKeyboardTypeAlphabet];
    } else {
        [inhoud setKeyboardType:UIKeyboardTypeNumberPad];
    }
}
-(void)setPrijs:(NSString*)items
{
        //AppDelegate *appDelegate = [FileManager getDel];
    colorLabel =[[UILabel alloc]initWithFrame:CGRectMake(190,10,10,30)];
    [colorLabel setTextAlignment:NSTextAlignmentRight];
    [self addSubview:colorLabel];
    [colorLabel setBackgroundColor:[UIColor colorWithRed:0.439289 green:0.764236 blue:0.506794 alpha:1.000000]];
    insert =200;


    title =[[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width, 30)];
    [title setText:@"Prijs"];
    [title setFont:[UIFont regularFlatFontOfSize:16]];
    [title setTextColor:[UIColor blackColor]];
    [title setTextAlignment:NSTextAlignmentLeft];
    [self addSubview:title];

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

    EditTextField *inhoud =[[EditTextField alloc] initWithFrame:CGRectMake(30, 6, self.frame.size.width-40, 30)];
    inhoud.limit = self.limit;
    inhoud.format = [[FileManager getMAskVeld:@"1"] valueForKey:@"Mask"];
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
    //[inhoud setPos:[items valueForKey:@"Pos"]];
   // [inhoud setLengteMax:[NSNumber numberWithInt:[[items valueForKey:@"LengteMax"] intValue]]];
    
    if ([[parantView.basepart valueForKey:@"Prijs"] isKindOfClass:[NSNumber class]]) {
        if ([[parantView.basepart valueForKey:@"Prijs"] intValue]> 0) {
            [inhoud setText:[[NSString stringWithFormat:@"%.2f", [[parantView.basepart valueForKey:@"Prijs"] floatValue]] stringByReplacingOccurrencesOfString:@"." withString:@","]];
        }
    } else {
        [inhoud setText:[parantView.basepart valueForKey:@"Prijs"]];
    }
        //[inhoud setText:[parantView.basepart valueForKey:@"Prijs"]];
    [content addSubview:inhoud];
}
-(void)textEditet:(UILocalNotification*)textField
{
        //////////NSLog(@"textEditet");
    AppDelegate *appDelegate = [FileManager getDel];
    EditTextField *copyText =(EditTextField*) [textField valueForKey:@"object"];
    if ([copyText.edittext isEqualToString:@"VraagPrijs"]||[copyText.edittext isEqualToString:@"InternetPrijs"]||[copyText.edittext isEqualToString:@"InternetPrijsExport"]) {
    }
    if ([copyText.edittext isEqualToString:@"Kleur2"]) {
        if ([[appDelegate.currentCarDictionary valueForKey:@"Kleur"] length]<1) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Moment" message:@"Vul de 1e kleur eerst in?"
                                                           delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Oké", nil];
            [alert show];
            copyText.text =@"";
            [copyText resignFirstResponder];
        }
        else
        {
        }
    }
    if ([copyText.edittext isEqualToString:@"Kleur3"]) {
        if ([[appDelegate.currentCarDictionary valueForKey:@"Kleur2"] length]<1) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Moment" message:@"Vul de 1e en 2e kleur eerst in."
                                                           delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Oké", nil];
            [alert show];
            copyText.text =@"";
            [copyText resignFirstResponder];
        }
        else
        {
        }
    }
    if ([copyText.edittext isEqualToString:@"Laknummer voertuig 2"]) {
        if ([[appDelegate.currentCarDictionary valueForKey:@"Laknummer voertuig"] length]<1) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Moment" message:@"Vul de 1e Laknummer voertuig eerst in."
                                                           delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Oké", nil];
            [alert show];
            copyText.text =@"";
            [copyText resignFirstResponder];
        }
        else
        {
        }
    }
    if ([copyText.edittext isEqualToString:@"Laknummer voertuig 3"]) {
        if ([[appDelegate.currentCarDictionary valueForKey:@"Laknummer voertuig 2"] length]<1) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Moment" message:@"Vul de 1e en 2e Laknummer voertuig eerst in."
                                                           delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Oké", nil];
            [alert show];
            copyText.text =@"";
            [copyText resignFirstResponder];
        }
        else
        {
        }
    }
    if ([[appDelegate.currentCarDictionary allKeys] containsObject:copyText.edittext])
    {
        if ([@"Kilometerstand" isEqualToString:copyText.edittext])
        {
            NSString *localizedString = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithInteger:[[copyText.text stringByReplacingOccurrencesOfString:@"." withString:@""] integerValue]] numberStyle:NSNumberFormatterDecimalStyle];
            copyText.text =localizedString;
            NSInteger index = [appDelegate.alleVoertuigenArray indexOfObject:appDelegate.currentCarDictionary];
            NSString *docDir = [FileManager getDir];
            [appDelegate.currentCarDictionary setObject:copyText.text forKey:copyText.edittext];
            [appDelegate.alleVoertuigenArray replaceObjectAtIndex:index withObject:appDelegate.currentCarDictionary];
            NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/Voertuigen.plist",docDir];
            [appDelegate.alleVoertuigenArray writeToFile:itemFilePath atomically: YES];
        }
        else
        {
            NSInteger index = [appDelegate.alleVoertuigenArray indexOfObject:appDelegate.currentCarDictionary];
            NSString *docDir = [FileManager getDir];
            [appDelegate.currentCarDictionary setObject:copyText.text forKey:copyText.edittext];
            [appDelegate.alleVoertuigenArray replaceObjectAtIndex:index withObject:appDelegate.currentCarDictionary];
            NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/Voertuigen.plist",docDir];
            [appDelegate.alleVoertuigenArray writeToFile:itemFilePath atomically: YES];
        }
    } else {
        if ([copyText.edittext isEqualToString:@"Prijs"]) {
        }
        else
        {
            if ([copyText.text length]>0) {
                if (veldID>0) {
                    NSMutableDictionary *Veld =[[NSMutableDictionary alloc] init];
                    [Veld setObject:copyText.text forKey:@"Waarde"];
                    [Veld setObject:[NSNumber numberWithInteger:veldID] forKey:@"VeldId"];
                    [FileManager getVelden_voertuig:[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"] add:Veld];
                }
                else
                {
                    [appDelegate.currentCarDictionary setObject:copyText.text forKeyedSubscript:copyText.edittext];
                    NSInteger index = [appDelegate.alleVoertuigenArray indexOfObject:appDelegate.currentCarDictionary];
                    NSString *docDir = [FileManager getDir];
                    [appDelegate.currentCarDictionary setObject:copyText.text forKey:copyText.edittext];
                    [appDelegate.alleVoertuigenArray replaceObjectAtIndex:index withObject:appDelegate.currentCarDictionary];
                    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/Voertuigen.plist",docDir];
                    [appDelegate.alleVoertuigenArray writeToFile:itemFilePath atomically: YES];
                }
            }
            else
            {
                NSInteger index = [appDelegate.alleVoertuigenArray indexOfObject:appDelegate.currentCarDictionary];
                NSString *docDir = [FileManager getDir];
                [appDelegate.currentCarDictionary setObject:copyText.text forKey:copyText.edittext];
                [appDelegate.alleVoertuigenArray replaceObjectAtIndex:index withObject:appDelegate.currentCarDictionary];
                NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/Voertuigen.plist",docDir];
                [appDelegate.alleVoertuigenArray writeToFile:itemFilePath atomically: YES];
            }
        }
    }
}
-(void)textUpdated:(UILocalNotification*)textField
{
    EditTextField *copyText =(EditTextField*) [textField valueForKey:@"object"];
    if ([copyText.edittext isEqualToString:@"Cilinderinhoud"])
    {
        [cilinderinhoud setText:[self caclulateCillinder:copyText.text]];
        [cilinderinhoud sizeToFit];
        [cilinderinhoud setFrame:CGRectMake(220-cilinderinhoud.frame.size.width,0,cilinderinhoud.frame.size.width,40)];
    }
    if ([copyText.edittext isEqualToString:@"Vermogen"])
    {
        [vermogen setText:[self caclalateVermogen:copyText.text]];
        [vermogen sizeToFit];
        [vermogen setFrame:CGRectMake(220-vermogen.frame.size.width,0,vermogen.frame.size.width,40)];
    }
}
- (BOOL)textFieldShouldClear:(EditTextView *)textField;   
{
    return YES;
}
-(BOOL)textField:(EditTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
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
            NSUInteger proposedNewLength = textField.text.length - range.length + string.length;
            if (proposedNewLength > 6)
                return YES;
            return YES;
        }
    }
}
-(void)textFieldDidEndEditing:(EditTextField *)textField
{
}

-(void)textFieldDidBeginEditing:(EditTextField *)textField
{



    AppDelegate *appDelegate = [FileManager getDel];

    NSLog(@"pos %@", textField.edittext);

    if ([textField.edittext isEqualToString:@"VraagPrijs"]||[textField.edittext isEqualToString:@"InternetPrijs"]||[textField.edittext isEqualToString:@"InternetPrijsExport"])
    {

        [appDelegate.viewcontroller EditPricesAction:textField];
    } else {

            //////NSLog(@"textFieldDidBeginEditing");
        appDelegate.viewcontroller.textcopy.VeldId = veldID;

            [appDelegate.viewcontroller.textcopy ScanClass:textField set:parantView];
    }
    


}
- (BOOL)textFieldShouldReturn:(EditTextField *)textField {
        //////////NSLog(@"textFieldShouldReturn");
    return NO;
}
-(void)textFieldDidEndEditing:(EditTextField *)textField reason:(UITextFieldDidEndEditingReason)reason
{
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
-(BOOL)textFieldShouldBeginEditing:(EditTextField *)textField {                   
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(EditTextField *)textField {
    [self endEditing:YES];
    return YES;
}
-(void)moveOnintenet:(UISwitch*)sender
{
    AppDelegate *appDelegate = [FileManager getDel];
    if (sender.isOn) {
        [appDelegate.currentCarDictionary setObject:[NSNumber numberWithFloat:YES] forKey:@"PrijsOnlineTonen"];
    } else {
        [appDelegate.currentCarDictionary setObject:[NSNumber numberWithFloat:NO] forKey:@"PrijsOnlineTonen"];
    }
}
@end
