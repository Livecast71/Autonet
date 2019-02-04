    //
    //  TekstEditView.m
    //  Autonet
    //
    //  Created by Livecast02 on 05-08-18.
    //  Copyright © 2018 Autonet. All rights reserved.
    //
#import "TekstCopyView.h"
#import "UIFont+FlatUI.h"
#import "FileManager.h"
#import "AppDelegate.h"
@implementation TekstCopyView
@synthesize title;
@synthesize inhoud;
@synthesize TextView;
@synthesize TextField;
@synthesize parantView;
@synthesize datePicker;
@synthesize VeldId;
@synthesize copyplist;
@synthesize Veldenit;
@synthesize dayMontheYearPicker;
@synthesize note;
@synthesize cover;
@synthesize cover1;
@synthesize cover2;

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {

        [self setBackgroundColor:[UIColor clearColor]];
        [self builditems];
        [self setAlpha:0];
    }
    return self;
}
-(void)builditems
{
    UIView *textcopy = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width-(self.frame.size.width/2))/2, 100,self.frame.size.width/2, self.frame.size.height/3)];
     textcopy.backgroundColor = [UIColor whiteColor];
    [self addSubview:textcopy];
    textcopy.layer.shadowOffset = CGSizeMake(0, 1);
    textcopy.layer.shadowOpacity = 1;


    title =[[UILabel alloc] initWithFrame:CGRectMake(10, 10, textcopy.frame.size.width-20, 55)];
    [title setFont:[UIFont regularFlatFontOfSize:16]];
    [title setBackgroundColor:[UIColor whiteColor]];
    [title setTextColor:[UIColor blackColor]];
    [title setTextAlignment:NSTextAlignmentLeft];
    [textcopy addSubview:title];
    
    inhoud =[[UITextView alloc] initWithFrame:CGRectMake(10, 70, textcopy.frame.size.width-20, textcopy.frame.size.height-80)];
    [inhoud setDelegate:self];
    [inhoud setFont:[UIFont regularFlatFontOfSize:16]];
    [inhoud setTextColor:[UIColor blackColor]];
    [inhoud setTextAlignment:NSTextAlignmentLeft];
    [inhoud setReturnKeyType:UIReturnKeyDone];
    [inhoud.layer setBorderWidth:1];
    [inhoud.layer  setBorderColor:[UIColor lightGrayColor].CGColor];
    [inhoud.layer setCornerRadius:10];
    [textcopy addSubview:inhoud];

    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(10, 70, textcopy.frame.size.width-20, textcopy.frame.size.height-80)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(updateTextField:)
         forControlEvents:UIControlEventValueChanged];
    [datePicker.layer setBorderWidth:1];
    [datePicker.layer  setBorderColor:[UIColor lightGrayColor].CGColor];
    [datePicker.layer setCornerRadius:10];
    [datePicker setAlpha:0];
    [textcopy addSubview:datePicker];


    dayMontheYearPicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(10, 70, textcopy.frame.size.width-20, textcopy.frame.size.height-80)];
    dayMontheYearPicker.datePickerMode = UIDatePickerModeDate;
    [dayMontheYearPicker addTarget:self action:@selector(updateYearMonthDay:)
                  forControlEvents:UIControlEventValueChanged];
    [dayMontheYearPicker.layer setBorderWidth:1];
    NSDate *max = [[NSDate alloc] init];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    [comps setMonth:1];
    [comps setYear:1950];
    NSDate *min = [[NSCalendar currentCalendar] dateFromComponents:comps];
    [dayMontheYearPicker setMaximumDate:max];
    [dayMontheYearPicker setMinimumDate:min];
    [dayMontheYearPicker.layer  setBorderColor:[UIColor lightGrayColor].CGColor];
    [dayMontheYearPicker.layer setCornerRadius:10];
    [dayMontheYearPicker setAlpha:0];
    [textcopy addSubview:dayMontheYearPicker];

    note =[[UIButton alloc]initWithFrame:CGRectMake(textcopy.frame.size.width-50,10, 40, 40)];
    [note setImage:[UIImage imageNamed:@"gone.png"] forState:UIControlStateNormal];
    [note addTarget:self action:@selector(endEdit:) forControlEvents:UIControlEventTouchUpInside];
    [textcopy addSubview:note];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textViewDidChange:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:inhoud];
}


-(void)updateYearMonthDay:(UIDatePicker*)sender
{

    NSLog(@"%@", TextField.edittext);

    if ([TextField.edittext isEqualToString:@"Bouwjaar"]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"nl_NL"]];
        [formatter setDateFormat:@"yyyy"];
        [inhoud setText:[formatter stringFromDate:sender.date]];
        [TextField setText:[formatter stringFromDate:sender.date]];
    } else if ([TextField.edittext isEqualToString:@"Bouwmaand"]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"nl_NL"]];
        [formatter setDateFormat:@"MM"];
        [inhoud setText:[formatter stringFromDate:sender.date]];
        [TextField setText:[formatter stringFromDate:sender.date]];
    } else if ([TextField.edittext isEqualToString:@"Bouwdag"]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"nl_NL"]];
        [formatter setDateFormat:@"dd"];
        [inhoud setText:[formatter stringFromDate:sender.date]];
        [TextField setText:[formatter stringFromDate:sender.date]];
    }
}
-(void)updateTextField:(UIDatePicker*)sender
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"nl_NL"]];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    [inhoud setText:[formatter stringFromDate:sender.date]];
    [TextField setText:[formatter stringFromDate:sender.date]];
}
-(void)endEdit:(UIButton*)sender
{
    AppDelegate *appDelegate = [FileManager getDel];


    if ([inhoud.text length]>0&&[inhoud.textColor isEqual:[UIColor redColor]]) {
        NSLog(@"kan niet");
    } else {
        if (appDelegate.viewcontroller.collectionOnderdelenView.alpha == 0 && appDelegate.viewcontroller.carView.alpha == 1) {
            if (TextView) {
                NSString *docDir = [FileManager getDir];
                [TextView setText:inhoud.text];
                NSInteger index = [appDelegate.alleVoertuigenArray indexOfObject:appDelegate.currentCarDictionary];
                [appDelegate.currentCarDictionary setValue:inhoud.text forKey:TextView.edittext];
                [appDelegate.alleVoertuigenArray replaceObjectAtIndex:index withObject:appDelegate.currentCarDictionary];
                NSString *itemFilePathvoer = [NSString stringWithFormat:@"%@/Caches/Voertuigen.plist",docDir];
                [appDelegate.alleVoertuigenArray writeToFile:itemFilePathvoer atomically: YES];
            }
            else
            {
                if ([TextField.edittext isEqualToString:@"Lamineercode 1:"]||[TextField.edittext isEqualToString:@"Lamineercode 2:"])
                {
                    if ([TextField.edittext isEqualToString:@"Lamineercode 1:"])
                    {
                        if ([[appDelegate.currentCarDictionary valueForKey:@"LamineerCodes"] isKindOfClass:[NSArray class]]) {
                            NSMutableArray *LamineerArray = [[NSMutableArray alloc] initWithArray:[appDelegate.currentCarDictionary valueForKey:@"LamineerCodes"]];
                            if ([LamineerArray count] ==0) {
                                if ([inhoud.text length]>0) {
                                    [LamineerArray addObject:inhoud.text];
                                    [appDelegate.currentCarDictionary setObject:LamineerArray forKey:@"LamineerCodes"];
                                }
                            }
                            if ([LamineerArray count] ==1) {
                                if ([inhoud.text length]>0) {
                                    [LamineerArray replaceObjectAtIndex:0 withObject:inhoud.text];
                                    [appDelegate.currentCarDictionary setObject:LamineerArray forKey:@"LamineerCodes"];
                                }
                            }
                            if ([LamineerArray count] ==2) {
                                if ([inhoud.text length]>0) {
                                    [LamineerArray replaceObjectAtIndex:0 withObject:inhoud.text];
                                    [appDelegate.currentCarDictionary setObject:LamineerArray forKey:@"LamineerCodes"];
                                }
                            }
                            else
                            {
                            }
                            NSString *docDir = [FileManager getDir];
                            NSInteger index = [appDelegate.alleVoertuigenArray indexOfObject:appDelegate.currentCarDictionary];
                            [appDelegate.alleVoertuigenArray replaceObjectAtIndex:index withObject:appDelegate.currentCarDictionary];
                            NSString *itemFilePathvoer = [NSString stringWithFormat:@"%@/Caches/Voertuigen.plist",docDir];
                            [appDelegate.alleVoertuigenArray writeToFile:itemFilePathvoer atomically: YES];
                            [TextField setText: inhoud.text];
                        }
                    }
                    else if ([TextField.edittext isEqualToString:@"Lamineercode 2:"])
                    {
                        if ([[appDelegate.currentCarDictionary valueForKey:@"LamineerCodes"] isKindOfClass:[NSArray class]]) {
                            NSMutableArray *LamineerArray = [[NSMutableArray alloc] initWithArray:[appDelegate.currentCarDictionary valueForKey:@"LamineerCodes"]];
                            if ([LamineerArray count] ==0) {
                            }
                            if ([LamineerArray count] ==1) {
                                if ([inhoud.text length]>0) {
                                    [LamineerArray addObject:inhoud.text];
                                    [appDelegate.currentCarDictionary setObject:LamineerArray forKey:@"LamineerCodes"];
                                }
                            }
                            if ([LamineerArray count] ==2) {
                                if ([inhoud.text length]>0) {
                                    [LamineerArray replaceObjectAtIndex:1 withObject:inhoud.text];
                                    [appDelegate.currentCarDictionary setObject:LamineerArray forKey:@"LamineerCodes"];
                                }
                            }
                            else
                            {
                            }
                            NSString *docDir = [FileManager getDir];
                            NSInteger index = [appDelegate.alleVoertuigenArray indexOfObject:appDelegate.currentCarDictionary];
                            [appDelegate.alleVoertuigenArray replaceObjectAtIndex:index withObject:appDelegate.currentCarDictionary];
                            NSString *itemFilePathvoer = [NSString stringWithFormat:@"%@/Caches/Voertuigen.plist",docDir];
                            [appDelegate.alleVoertuigenArray writeToFile:itemFilePathvoer atomically: YES];
                            [TextField setText: inhoud.text];
                        }
                    }
                    else
                    {
                    }
                }
                else
                {
                    if ([TextField.edittext isEqualToString:@"Cilinderinhoud"])
                    {
                        UILabel *cilinderinhoud =[[[TextField superview] subviews] lastObject];
                        [cilinderinhoud setText:[self caclulateCillinder:inhoud.text]];
                        [cilinderinhoud sizeToFit];
                        [cilinderinhoud setFrame:CGRectMake(220-cilinderinhoud.frame.size.width,0,cilinderinhoud.frame.size.width,40)];
                    }
                    if ([TextField.edittext isEqualToString:@"Vermogen"])
                    {
                        UILabel *Vermogen =[[[TextField superview] subviews] lastObject];
                        [Vermogen setText:[self caclalateVermogen:inhoud.text]];
                        [Vermogen sizeToFit];
                        [Vermogen setFrame:CGRectMake(220-Vermogen.frame.size.width,0,Vermogen.frame.size.width,40)];
                    }
                    if (TextField.VeldId&&TextField.VeldId>0) {
                        [self insertVeld:TextField.VeldId];
                    }
                    else
                    {

                            NSString *docDir = [FileManager getDir];
                            [TextField setText:inhoud.text];
                            NSInteger index = [appDelegate.alleVoertuigenArray indexOfObject:appDelegate.currentCarDictionary];
                            [appDelegate.currentCarDictionary setValue:inhoud.text forKey:TextField.edittext];
                            [appDelegate.alleVoertuigenArray replaceObjectAtIndex:index withObject:appDelegate.currentCarDictionary];
                            NSString *itemFilePathvoer = [NSString stringWithFormat:@"%@/Caches/Voertuigen.plist",docDir];
                            [appDelegate.alleVoertuigenArray writeToFile:itemFilePathvoer atomically: YES];
                            inhoud.text = @"";

                    }
                }
            }
        }
        else
        {
            if (TextView) {
                if (VeldId >0) {
                    NSMutableDictionary *Veld =[[NSMutableDictionary alloc] init];
                    [Veld setObject:inhoud.text forKey:@"Waarde"];
                    [Veld setObject:[NSNumber numberWithInteger:VeldId] forKey:@"VeldId"];

                    if ([[parantView.basepart allKeys] containsObject:@"Velden"]) {

                        NSMutableArray *copyvelden = [[parantView.basepart valueForKey:@"Velden"] mutableCopy];


                        if ([[copyvelden valueForKey:@"VeldId"] containsObject:[NSNumber numberWithInteger:VeldId]]) {
                            [copyvelden replaceObjectAtIndex:[[copyvelden valueForKey:@"VeldId"] indexOfObject:[NSNumber numberWithInteger:VeldId]] withObject:Veld];
                        }
                        else
                        {
                            [copyvelden addObject:Veld];
                        }
                        [parantView.basepart setObject:copyvelden forKey:@"Velden"];
                        [FileManager insertnew:parantView.basepart];

                    }
                    else{


                        NSMutableArray *copyvelden = [[NSMutableArray alloc] init];
                        [copyvelden addObject:Veld];
                        [parantView.basepart setObject:copyvelden forKey:@"Velden"];
                        [FileManager insertnew:parantView.basepart];



                    }
                }
                else {
                    [parantView.basepart setObject:inhoud.text forKey:TextView.edittext];
                    [FileManager insertnew:parantView.basepart];
                }

            }
            if (TextField) {
                if (VeldId >0) {


                    NSMutableDictionary *Veld =[[NSMutableDictionary alloc] init];
                    [Veld setObject:inhoud.text forKey:@"Waarde"];
                    [Veld setObject:[NSNumber numberWithInteger:VeldId] forKey:@"VeldId"];


                    if ([[parantView.basepart allKeys] containsObject:@"Velden"]) {

                        NSMutableArray *copyvelden = [[parantView.basepart valueForKey:@"Velden"] mutableCopy];
                        if ([[copyvelden valueForKey:@"VeldId"] containsObject:[NSNumber numberWithInteger:VeldId]]) {
                            [copyvelden replaceObjectAtIndex:[[copyvelden valueForKey:@"VeldId"] indexOfObject:[NSNumber numberWithInteger:VeldId]] withObject:Veld];
                        }
                        else
                        {
                            [copyvelden addObject:Veld];
                        }
                        [parantView.basepart setObject:copyvelden forKey:@"Velden"];
                        [FileManager insertnew:parantView.basepart];

                    }else
                    {
                        NSMutableArray *copyvelden = [[NSMutableArray alloc] init];
                        [copyvelden addObject:Veld];
                        [parantView.basepart setObject:copyvelden forKey:@"Velden"];
                        [FileManager insertnew:parantView.basepart];


                    }


                }
                else {
                    [parantView.basepart setObject:inhoud.text forKey:TextField.edittext];
                    [FileManager insertnew:parantView.basepart];
                }


            }
        }

        inhoud.text = @"";
        [self setAlpha:0];
        [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];


    }
}
-(void)insertVeld:(NSInteger)VeldId
{
    AppDelegate *appDelegate = [FileManager getDel];
    NSString *docDir = [FileManager getDir];
    Veldenit = [[FileManager getVoertuigVeldenOpID] mutableCopy];
    NSString *  querynew = [NSString stringWithFormat:@"(VeldId == %ld) and (VeldId > 0)", (long)VeldId];
    NSPredicate *predicateits = [NSPredicate predicateWithFormat:querynew];
    copyplist = [[Veldenit filteredArrayUsingPredicate:predicateits] mutableCopy];

    if ([copyplist count]==0) {
        NSMutableDictionary *copydict =[[NSMutableDictionary alloc] init];
        if ([inhoud.text length]>0) {
            [copydict setObject:[NSNumber numberWithInteger:VeldId] forKey:@"VeldId"];
            [copydict setObject:inhoud.text forKey:@"Waarde"];
            [Veldenit addObject:copydict];
            NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"Velden", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
            [Veldenit writeToFile:itemFilePath atomically: YES];
        }
        else
        {
        }
    } else {
        if (VeldId==24)
        {

                ////////NSLog(@"%@", Veldenit);
            if ([TextField.edittext isEqualToString:@"Kleur"])
            {
                if ([copyplist count]==1) {
                    NSMutableDictionary *copydict =[copyplist objectAtIndex:0];
                    NSInteger index = [Veldenit indexOfObject:copydict];
                    if ([inhoud.text length] >0) {
                        [copydict setObject:inhoud.text forKey:@"Waarde"];
                        [Veldenit replaceObjectAtIndex:index withObject:copydict];
                    }
                    else
                    {
                        [Veldenit removeObjectAtIndex:index];
                    }
                    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"Velden", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
                    [Veldenit writeToFile:itemFilePath atomically: YES];
                }

                if ([copyplist count]==2) {
                    NSMutableDictionary *copydict =[copyplist objectAtIndex:0];
                    NSInteger index = [Veldenit indexOfObject:copydict];
                    if ([inhoud.text length] >0) {
                        [copydict setObject:inhoud.text forKey:@"Waarde"];
                        [Veldenit replaceObjectAtIndex:index withObject:copydict];
                    }
                    else
                    {
                        [Veldenit removeObjectAtIndex:index];
                    }
                    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"Velden", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
                    [Veldenit writeToFile:itemFilePath atomically: YES];
                }
                else if ([copyplist count]==3) {
                    NSMutableDictionary *copydict =[copyplist objectAtIndex:0];
                    NSInteger index = [Veldenit indexOfObject:copydict];
                    if ([inhoud.text length] >0) {
                        [copydict setObject:inhoud.text forKey:@"Waarde"];
                        [Veldenit replaceObjectAtIndex:index withObject:copydict];
                    }
                    else
                    {
                        [Veldenit removeObjectAtIndex:index];
                    }
                    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"Velden", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
                    [Veldenit writeToFile:itemFilePath atomically: YES];
                }
                else
                {
                    NSMutableDictionary *copydict =[[NSMutableDictionary alloc] init];
                    [copydict setObject:[NSNumber numberWithInteger:VeldId] forKey:@"VeldId"];
                    [copydict setObject:inhoud.text forKey:@"Waarde"];
                    [Veldenit addObject:copydict];
                    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"Velden", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
                    [Veldenit writeToFile:itemFilePath atomically: YES];
                }
            }
            else if ([TextField.edittext isEqualToString:@"Kleur2"])
            {
                if ([copyplist count]==2) {
                    NSMutableDictionary *copydict =[copyplist objectAtIndex:1];
                    NSInteger index = [Veldenit indexOfObject:copydict];
                    if ([inhoud.text length] >0) {
                        [copydict setObject:inhoud.text forKey:@"Waarde"];
                        [Veldenit replaceObjectAtIndex:index withObject:copydict];
                    }
                    else
                    {
                        [Veldenit removeObjectAtIndex:index];
                    }
                    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"Velden", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
                    [Veldenit writeToFile:itemFilePath atomically: YES];
                }
                else if ([copyplist count]==3) {
                    NSMutableDictionary *copydict =[copyplist objectAtIndex:1];
                    NSInteger index = [Veldenit indexOfObject:copydict];
                    if ([inhoud.text length] >0) {
                        [copydict setObject:inhoud.text forKey:@"Waarde"];
                        [Veldenit replaceObjectAtIndex:index withObject:copydict];
                    }
                    else
                    {
                        [Veldenit removeObjectAtIndex:index];
                    }
                    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"Velden", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
                    [Veldenit writeToFile:itemFilePath atomically: YES];
                }
                else
                {
                    NSMutableDictionary *copydict =[[NSMutableDictionary alloc] init];
                    [copydict setObject:[NSNumber numberWithInteger:VeldId] forKey:@"VeldId"];
                    [copydict setObject:inhoud.text forKey:@"Waarde"];
                    [Veldenit addObject:copydict];
                    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"Velden", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
                    [Veldenit writeToFile:itemFilePath atomically: YES];
                }
            }
            else if ([TextField.edittext isEqualToString:@"Kleur3"])
            {
                if ([copyplist count]==3) {
                    NSMutableDictionary *copydict =[copyplist objectAtIndex:2];
                    NSInteger index = [Veldenit indexOfObject:copydict];
                    if ([inhoud.text length] >0) {
                        [copydict setObject:inhoud.text forKey:@"Waarde"];
                        [Veldenit replaceObjectAtIndex:index withObject:copydict];
                    }
                    else
                    {
                        [Veldenit removeObjectAtIndex:index];
                    }
                    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"Velden", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
                    [Veldenit writeToFile:itemFilePath atomically: YES];
                }
                else
                {
                    NSMutableDictionary *copydict =[[NSMutableDictionary alloc] init];
                    [copydict setObject:[NSNumber numberWithInteger:VeldId] forKey:@"VeldId"];
                    [copydict setObject:inhoud.text forKey:@"Waarde"];
                    [Veldenit addObject:copydict];
                    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"Velden", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
                    [Veldenit writeToFile:itemFilePath atomically: YES];
                }
            }
        }
        else if (VeldId ==137)
        {
            if ([TextField.edittext isEqualToString:@"Laknummer voertuig"])
            {
                if ([copyplist count]==2) {
                    NSMutableDictionary *copydict =[copyplist objectAtIndex:0];
                    NSInteger index = [Veldenit indexOfObject:copydict];
                    if ([inhoud.text length] >0) {
                        [copydict setObject:inhoud.text forKey:@"Waarde"];
                        [Veldenit replaceObjectAtIndex:index withObject:copydict];
                    }
                    else
                    {
                        [Veldenit removeObjectAtIndex:index];
                    }
                    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"Velden", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
                    [Veldenit writeToFile:itemFilePath atomically: YES];
                }
                else if ([copyplist count]==3) {
                    NSMutableDictionary *copydict =[copyplist objectAtIndex:0];
                    NSInteger index = [Veldenit indexOfObject:copydict];
                    if ([inhoud.text length] >0) {
                        [copydict setObject:inhoud.text forKey:@"Waarde"];
                        [Veldenit replaceObjectAtIndex:index withObject:copydict];
                    }
                    else
                    {
                        [Veldenit removeObjectAtIndex:index];
                    }
                    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"Velden", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
                    [Veldenit writeToFile:itemFilePath atomically: YES];
                }
                else
                {
                    NSMutableDictionary *copydict =[[NSMutableDictionary alloc] init];
                    [copydict setObject:[NSNumber numberWithInteger:VeldId] forKey:@"VeldId"];
                    [copydict setObject:inhoud.text forKey:@"Waarde"];
                    [Veldenit addObject:copydict];
                    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"Velden", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
                    [Veldenit writeToFile:itemFilePath atomically: YES];
                }
            }
            else if ([TextField.edittext isEqualToString:@"Laknummer voertuig 2"])
            {
                if ([copyplist count]==2) {
                    NSMutableDictionary *copydict =[copyplist objectAtIndex:1];
                    NSInteger index = [Veldenit indexOfObject:copydict];
                    if ([inhoud.text length] >0) {
                        [copydict setObject:inhoud.text forKey:@"Waarde"];
                        [Veldenit replaceObjectAtIndex:index withObject:copydict];
                    }
                    else
                    {
                        [Veldenit removeObjectAtIndex:index];
                    }
                    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"Velden", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
                    [Veldenit writeToFile:itemFilePath atomically: YES];
                }
                else if ([copyplist count]==3) {
                    NSMutableDictionary *copydict =[copyplist objectAtIndex:1];
                    NSInteger index = [Veldenit indexOfObject:copydict];
                    if ([inhoud.text length] >0) {
                        [copydict setObject:inhoud.text forKey:@"Waarde"];
                        [Veldenit replaceObjectAtIndex:index withObject:copydict];
                    }
                    else
                    {
                        [Veldenit removeObjectAtIndex:index];
                    }
                    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"Velden", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
                    [Veldenit writeToFile:itemFilePath atomically: YES];
                }
                else
                {
                    NSMutableDictionary *copydict =[[NSMutableDictionary alloc] init];
                    [copydict setObject:[NSNumber numberWithInteger:VeldId] forKey:@"VeldId"];
                    [copydict setObject:inhoud.text forKey:@"Waarde"];
                    [Veldenit addObject:copydict];
                    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"Velden", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
                    [Veldenit writeToFile:itemFilePath atomically: YES];
                }
            }
            else if ([TextField.edittext isEqualToString:@"Laknummer voertuig 3"])
            {
                if ([copyplist count]==3) {
                        ////////////NSLog(@"4 %@", copyplist);
                    NSMutableDictionary *copydict =[copyplist objectAtIndex:2];
                        ////////////NSLog(@"4 %@", copydict);
                    NSInteger index = [Veldenit indexOfObject:copydict];
                    if ([inhoud.text length] >0) {
                        [copydict setObject:inhoud.text forKey:@"Waarde"];
                        [Veldenit replaceObjectAtIndex:index withObject:copydict];
                    }
                    else
                    {
                        [Veldenit removeObjectAtIndex:index];
                    }
                    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"Velden", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
                    [Veldenit writeToFile:itemFilePath atomically: YES];
                }
                else
                {
                    NSMutableDictionary *copydict =[[NSMutableDictionary alloc] init];
                    [copydict setObject:[NSNumber numberWithInteger:VeldId] forKey:@"VeldId"];
                    [copydict setObject:inhoud.text forKey:@"Waarde"];
                    [Veldenit addObject:copydict];
                    NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"Velden", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
                    [Veldenit writeToFile:itemFilePath atomically: YES];
                }
            }
        }
        else
        {
            if ([copyplist count]==1) {
                NSMutableDictionary *copydict =[copyplist firstObject];
                NSInteger index = [Veldenit indexOfObject:copydict];
                if ([inhoud.text length] >0) {
                    [copydict setObject:inhoud.text forKey:@"Waarde"];
                    [Veldenit replaceObjectAtIndex:index withObject:copydict];
                }
                else
                {
                    [Veldenit removeObjectAtIndex:index];
                }
                NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/%@_%@.plist",docDir,@"Velden", [appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]];
                [Veldenit writeToFile:itemFilePath atomically: YES];
            }
            else
            {
            }
        }
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
-(NSString*)caclulateCillinder:(NSString*)string
{
    if ([string length]>0) {
        
        return [NSString stringWithFormat:@"%.1f l", [string floatValue]/1000];
    } else {
        return @"";
    }
}                   
-(void)ScanClass:(NSObject*)clasless set:(OnderdeelView*)parant;
{

    inhoud.textColor = [UIColor blackColor];
    [dayMontheYearPicker setAlpha:0];

    [cover setAlpha:0];
    [cover1 setAlpha:0];
    [cover2 setAlpha:0];
    [datePicker setAlpha:0];
    [inhoud setAlpha:1];
    [self setAlpha:1];
    [title setText:@""];
    TextView = NULL;
    TextField = NULL;
    parantView = parant;
    if ([clasless isKindOfClass:[UITextField class]]) {
        TextField = (EditTextField*)clasless;
        if (TextField.pos) {

        }
    else {

        TextField.pos = @"[a-zA-Z0-9-]{1,25}";

    }

        if ([TextField.LengteMax intValue] > 0) {

            TextField.limit = [TextField.LengteMax intValue];
        }

        NSDictionary* copyVeld = [[FileManager getVeldenId:[NSString stringWithFormat:@"%li", (long)TextField.VeldId]] firstObject];

        if ([[copyVeld valueForKey:@"RangeMax"] intValue] > 0) {

            TextField.RangeMax = [NSNumber numberWithInt:[[copyVeld valueForKey:@"RangeMax"] intValue]];

                //////////NSLog(@"%@", TextField.RangeMax);
        }

        if ([[copyVeld valueForKey:@"LengteMax"] intValue] > 0) {

            TextField.limit = [[copyVeld valueForKey:@"LengteMax"] intValue];
        }
        else
        {

        }


        if ([TextField.edittext isEqualToString:@"Verzekerd"]||[TextField.edittext isEqualToString:@"APKTotDatum"]) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"nl_NL"]];
            [formatter setDateFormat:@"dd-MM-yyyy"];
            if ([TextField.edittext length] == 10) {
                [datePicker setDate:[formatter dateFromString:TextField.edittext]];
            }
            if (TextField.limit == 0||TextField.limit ==  500) {

                TextField.limit = 500;
                    ////////////NSLog(@"%li", (long)TextField.limit);

                if (TextField.edittitle) {

                    title.text =  [[NSString stringWithFormat:@"%@:", TextField.edittitle] stringByReplacingOccurrencesOfString:@"::" withString:@":"];
                }
                else
                {
                    title.text =  [[NSString stringWithFormat:@"%@:", TextField.edittext] stringByReplacingOccurrencesOfString:@"::" withString:@":"];
                }
            }
            else
            {

                    ////////////NSLog(@"%li", (long)TextField.limit);
                if (TextField.edittitle) {

                    title.text =  [NSString stringWithFormat:@"%@ (beperkt tot %li karakters):", TextField.edittitle, (long)TextField.limit];
                }
                else
                {
                    title.text =  [NSString stringWithFormat:@"%@ (beperkt tot %li karakters):", TextField.edittext, (long)TextField.limit];
                }
            }

            inhoud.text = TextField.text;
            [inhoud setAlpha:0];
            [inhoud setKeyboardType:TextField.keyboardType];
            [inhoud setReturnKeyType:UIReturnKeyDone];
            [datePicker setAlpha:1];
        }
        else if ([TextField.edittext isEqualToString:@"Bouwjaar"]) {

            [cover setAlpha:1];



            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"nl_NL"]];
            [formatter setDateFormat:@"yyyy"];
            [dayMontheYearPicker setAlpha:1];
            [TextField setText:[formatter stringFromDate:dayMontheYearPicker.date]];

        }
        else if ([TextField.edittext isEqualToString:@"Bouwmaand"]) {


            [cover setAlpha:1];
            [cover1 setAlpha:0];
            [cover2 setAlpha:1];

            AppDelegate *appDelegate = [FileManager getDel];

            NSDateComponents *comps = [[NSDateComponents alloc] init];
            if ([appDelegate.currentCarDictionary valueForKey:@"Bouwjaar"]) {


                inhoud.text = [[appDelegate.currentCarDictionary valueForKey:@"Bouwjaar"] stringValue];

                [comps setYear:[[appDelegate.currentCarDictionary valueForKey:@"Bouwjaar"] integerValue]];

            }
            else
            {
                [comps setYear:2018];

            }
            if ([appDelegate.currentCarDictionary valueForKey:@"Bouwdag"]) {
                

                inhoud.text = [NSString stringWithFormat:@"%@", [appDelegate.currentCarDictionary valueForKey:@"Bouwdag"]];

                [comps setDay:[[appDelegate.currentCarDictionary valueForKey:@"Bouwdag"] integerValue]];

                NSLog(@"%@", [appDelegate.currentCarDictionary valueForKey:@"Bouwdag"]);

            }
            else{

                [comps setDay:1];

            }
            if ([appDelegate.currentCarDictionary valueForKey:@"Bouwmaand"]) {

                inhoud.text = [NSString stringWithFormat:@"%@", [appDelegate.currentCarDictionary valueForKey:@"Bouwmaand"]];

                [comps setMonth:[[appDelegate.currentCarDictionary valueForKey:@"Bouwmaand"] integerValue]];


            }
            else
            {

                [comps setMonth:1];

            }

            NSDate *min = [[NSCalendar currentCalendar] dateFromComponents:comps];

            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"nl_NL"]];
            [formatter setDateFormat:@"MM"];
            [dayMontheYearPicker setAlpha:1];
            [dayMontheYearPicker setDate:min];
            [TextField setText:[formatter stringFromDate:dayMontheYearPicker.date]];

        }
        else if ([TextField.edittext isEqualToString:@"Bouwdag"]) {


            [cover setAlpha:1];
            [cover1 setAlpha:1];
            [cover2 setAlpha:0];

            AppDelegate *appDelegate = [FileManager getDel];

            inhoud.text = [[appDelegate.currentCarDictionary valueForKey:@"Bouwjaar"] stringValue];

            NSDateComponents *comps = [[NSDateComponents alloc] init];
            if ([appDelegate.currentCarDictionary valueForKey:@"Bouwjaar"]) {


                [comps setYear:[[appDelegate.currentCarDictionary valueForKey:@"Bouwjaar"] integerValue]];

            }
            else
            {
                   [comps setYear:2018];

            }
            if ([appDelegate.currentCarDictionary valueForKey:@"Bouwdag"]) {

                inhoud.text = [NSString stringWithFormat:@"%@", [appDelegate.currentCarDictionary valueForKey:@"Bouwdag"]];

                [comps setDay:[[appDelegate.currentCarDictionary valueForKey:@"Bouwdag"] integerValue]];

            }
            else{

                 [comps setDay:1];

            }
            if ([appDelegate.currentCarDictionary valueForKey:@"Bouwmaand"]) {

                  //inhoud.text = [NSString stringWithFormat:@"%@", [appDelegate.currentCarDictionary valueForKey:@"Bouwmaand"]];;

                [comps setMonth:[[appDelegate.currentCarDictionary valueForKey:@"Bouwmaand"] integerValue]];


            }
            else
            {

                 [comps setMonth:1];
                
            }

            NSDate *min = [[NSCalendar currentCalendar] dateFromComponents:comps];

            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"nl_NL"]];
            [formatter setDateFormat:@"dd"];
            [dayMontheYearPicker setAlpha:1];
            [dayMontheYearPicker setDate:min];
            [TextField setText:[formatter stringFromDate:dayMontheYearPicker.date]];

        }
        else if ([TextField.edittext isEqualToString:@"VraagPrijs"]||[TextField.edittext isEqualToString:@"InternetPrijs"]||[TextField.edittext isEqualToString:@"InternetPrijsExport"]) {
            AppDelegate *appDelegate = [FileManager getDel];
            if (TextField.limit == 0||TextField.limit ==  500) {

                TextField.limit = 500;
                    ////////////NSLog(@"%li", (long)TextView.limit);
                if (TextField.edittitle) {
                    title.text =  [[NSString stringWithFormat:@"%@:", TextField.edittitle] stringByReplacingOccurrencesOfString:@"::" withString:@":"];
                }
                else
                {
                    title.text =  [[NSString stringWithFormat:@"%@:", TextField.edittext] stringByReplacingOccurrencesOfString:@"::" withString:@":"];
                }
            }
            else
            {
                    ////////////NSLog(@"%li", (long)TextView.limit);
                if (TextField.edittitle) {
                    title.text =  [NSString stringWithFormat:@"%@ (beperkt tot %li karakters):", TextField.edittitle, (long)TextField.limit];
                }
                else
                {
                    title.text =  [NSString stringWithFormat:@"%@ (beperkt tot %li karakters):", TextField.edittext, (long)TextField.limit];
                }
            }

            NSNumberFormatter *formatter = [NSNumberFormatter new];
            formatter.numberStyle = NSNumberFormatterCurrencyStyle;
            formatter.currencyCode = @"EUR";
            formatter.usesGroupingSeparator = YES;
            if ([appDelegate.currentCarDictionary valueForKey:TextField.edittext]) {

                inhoud.text = [NSString stringWithFormat:@"%@",[appDelegate.currentCarDictionary valueForKey:TextField.edittext]];
            }
        }
        else
        {
            if (TextField.limit == 0||TextField.limit ==  500) {

                TextField.limit = 500;
                    ////////////NSLog(@"%li", (long)TextView.limit);
                if (TextField.edittitle) {
                    title.text =  [[NSString stringWithFormat:@"%@:", TextField.edittitle] stringByReplacingOccurrencesOfString:@"::" withString:@":"];
                }
                else
                {
                    title.text =  [[NSString stringWithFormat:@"%@:", TextField.edittext] stringByReplacingOccurrencesOfString:@"::" withString:@":"];
                }
            }
            else
            {

                    ////////////NSLog(@"%li", (long)TextView.limit);
                if (TextField.edittitle) {
                    title.text =  [NSString stringWithFormat:@"%@ (beperkt tot %li karakters):", TextField.edittitle, (long)TextField.limit];
                }
                else
                {
                    title.text =  [NSString stringWithFormat:@"%@ (beperkt tot %li karakters):", TextField.edittext, (long)TextField.limit];
                }
            }
            inhoud.text = [TextField.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
            [inhoud setKeyboardType:TextField.keyboardType];
            [inhoud setReturnKeyType:UIReturnKeyDone];
            
        }
    } else if ([clasless isKindOfClass:[UITextView class]]) {
        TextView = (EditTextView*) clasless;

            NSLog(@"%@", TextView.pos);
            ////////////NSLog(@"%@ %@", TextView.edittext, TextView.edittitle);

        if (TextView.limit == 0||TextView.limit ==  500) {

            TextView.limit = 500;
                ////////////NSLog(@"%li", (long)TextView.limit);
            if (TextView.edittitle) {
                title.text =  [[NSString stringWithFormat:@"%@:", TextView.edittitle] stringByReplacingOccurrencesOfString:@"::" withString:@":"];
            }
            else
            {
                title.text =  [[NSString stringWithFormat:@"%@:", TextView.edittext] stringByReplacingOccurrencesOfString:@"::" withString:@":"];
            }
        }
        else
        {
                ////////////NSLog(@"%li", (long)TextView.limit);
            if (TextView.edittitle) {
                title.text =  [NSString stringWithFormat:@"%@ (beperkt tot %li karakters):", TextView.edittitle, (long)TextView.limit];
            }
            else
            {
                title.text =  [NSString stringWithFormat:@"%@ (beperkt tot %li karakters):", TextView.edittext, (long)TextView.limit];
            }
        }


        inhoud.text = [TextView.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
        [inhoud setKeyboardType:TextView.keyboardType];
        [inhoud setReturnKeyType:UIReturnKeyDone];
    }
    double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.self->inhoud becomeFirstResponder];
    });
}


- (void)textViewDidChange:(UITextView *)textView
{

        ////NSLog(@"%@", TextField.RangeMax);


    if ([inhoud.text intValue]<=[TextField.RangeMax intValue]|| [TextField.RangeMax intValue] == 0|| TextField.RangeMax == NULL) {

        [note setAlpha:1];
        [inhoud setTextColor:[UIColor blackColor]];
    } else {
        if (inhoud.text.length ==0) {

            [note setAlpha:1];
        }
        else
        {
            [note setAlpha:0];

        }

        [inhoud setTextColor:[UIColor redColor]];

    }

  if (TextField) {

    if ([TextField.pos isEqualToString:@"0"]) {
    } else {

        NSPredicate *TestResult = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", TextField.pos];


        if ([TestResult evaluateWithObject:inhoud.text] == YES)

        {
            [note setAlpha:1];
        
            [inhoud setTextColor:[UIColor blackColor]];
        }
        else
        {
            if (inhoud.text.length ==0) {

                [note setAlpha:1];
            }
            else
            {
                [note setAlpha:0];

            }
            [inhoud setTextColor:[UIColor redColor]];

        }

    }

  }


    if (TextView) {

           NSLog(@"TestResult %@", TextView.edittext);

        if ([TextView.edittext isEqualToString:@"GarantieMaanden"]){

        NSPredicate *TestResult = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", TextView.pos];

            NSLog(@"TestResult %@", TestResult);


        if ([TestResult evaluateWithObject:inhoud.text] == YES)

        {
            [note setAlpha:1];

            [inhoud setTextColor:[UIColor blackColor]];
        }
        else
        {
            if (inhoud.text.length ==0) {

                [note setAlpha:1];
            }
            else
            {
                [note setAlpha:0];

            }
            [inhoud setTextColor:[UIColor redColor]];

        }

            if ([inhoud.text length]>=0) {

                [TextView setText:inhoud.text];

            }

    } else
        {

        if ([inhoud.text length]>=0) {

            [TextView setText:inhoud.text];
            
        }
    }


    }

    if (TextField) {
        if ([inhoud.text length]>=0) {

            [TextField setText:inhoud.text];

        }
    }

    if ([TextField.edittext isEqualToString:@"Cilinderinhoud"])
    {

        UILabel *cilinderinhoud =[[[TextField superview] subviews] lastObject];
        [cilinderinhoud setText:[self caclulateCillinder:inhoud.text]];
        [cilinderinhoud sizeToFit];
        [cilinderinhoud setFrame:CGRectMake(220-cilinderinhoud.frame.size.width,0,cilinderinhoud.frame.size.width,40)];
    }
    if ([TextField.edittext isEqualToString:@"Vermogen"])
    {
        UILabel *Vermogen =[[[TextField superview] subviews] lastObject];
        [Vermogen setText:[self caclalateVermogen:inhoud.text]];
        [Vermogen sizeToFit];
        [Vermogen setFrame:CGRectMake(220-Vermogen.frame.size.width,0,Vermogen.frame.size.width,40)];

    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{




    AppDelegate *appDelegate = [FileManager getDel];
    if ([text isEqualToString:@"\n"]) {
        [self endEdit:NULL];
        return YES;
    } else {
        if (appDelegate.viewcontroller.collectionOnderdelenView.alpha == 0 && appDelegate.viewcontroller.carView.alpha == 1) {
            if (TextView) {

                if (TextView.text.length>0) {

                    return TextView.text.length + (text.length - range.length) <= TextView.limit;

                }
                else
                {

                    return YES;
                }
            }
            else
            {
                if (TextField.character) {
                    if (TextField.text.length>0) {

                        if ([TextField.edittext isEqualToString:@"VraagPrijs"]||[TextField.edittext isEqualToString:@"InternetPrijs"]||[TextField.edittext isEqualToString:@"InternetPrijsExport"]) {

                            NSArray *array = [inhoud.text componentsSeparatedByString:@"."];

                            NSString *words1 =[array firstObject];
                            NSString *words2 =[array firstObject];

                            if ((unsigned long)[inhoud.text rangeOfString:@"."].location <= TextField.limit-1) {

                                    ////////NSLog(@"location %lu", (unsigned long)[inhoud.text rangeOfString:@"."].location);

                                if (words2.length >=2) {
                                    return words1.length + (text.length - range.length) <= TextField.limit+2;
                                }
                                else{
                                    return YES;
                                }
                                

                            }
                            else

                            {

                            }

                            if ([array count]>1) {



                                if (words2.length >=2 && words1.length >=TextField.limit) {
                                    return words1.length + (text.length - range.length) <= TextField.limit+2;
                                }
                                else{
                                    return words1.length + (text.length - range.length) <= TextField.limit;
                                }
                            }
                            else
                            {
                                return inhoud.text.length + (text.length - range.length) <= TextField.limit;
                            }
                        }
                        else
                        {
                            return TextField.text.length + (text.length - range.length) <= TextField.limit;

                        }
                    }
                    else{

                        return YES;

                    }
                }
                else
                {

                    NSUInteger lengthOfString = text.length;
                    for (NSInteger index = 0; index < lengthOfString; index++) {
                        unichar character = [text characterAtIndex:index];
                        if ((character < 48) && (character != 46)) return NO;
                            // 48 unichar for 0, and 46 unichar for point
                        if (character > 57) return NO;
                            // 57 unichar for 9
                    }
                    NSUInteger proposedNewLength = inhoud.text.length - range.length + text.length;
                    if (proposedNewLength > 6)
                        return TextField.text.length + (text.length - range.length) <= TextField.limit;
                    return TextField.text.length + (text.length - range.length) <= TextField.limit;
                }
            }
            
            
        }
        else
        {
            if (TextView) {

                if (TextView.text.length>0) {

                    return TextView.text.length + (text.length - range.length) <= TextView.limit;
                }
                else
                {

                    return YES;
                }
            }
            if (TextField) {
                if ([TextField.format isEqualToString:@"MCT"]||[TextField.format isEqualToString:@"MCU"]) {

                    if (TextView.text.length>0) {

                        return TextField.text.length + (text.length - range.length) <= TextField.limit;

                    }else{

                        return YES;
                    }
                }
                else
                {

                    NSUInteger lengthOfString = text.length;
                    for (NSInteger index = 0; index < lengthOfString; index++) {
                        unichar character = [text characterAtIndex:index];
                        if ((character < 48) && (character != 46)) return NO;
                        if (character > 57) return NO;
                    }
                    NSUInteger proposedNewLength = inhoud.text.length - range.length + text.length;
                    if (proposedNewLength > 6)
                        return TextField.text.length + (text.length - range.length) <= TextField.limit;
                    return TextField.text.length + (text.length - range.length) <= TextField.limit;
                }
            }
            else
            {
                return YES;
            }
        }
    }
    

}

@end
