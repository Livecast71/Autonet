    //
    //  LabelView.m
    //  Autonet
    //
    //  Created by Livecast02 on 02-02-17.
    //  Copyright © 2017 Autonet. All rights reserved.
    //
#import "ExtraLabelView.h"
#import "UIFont+FlatUI.h"
#import "FileManager.h"
#import "AppDelegate.h"
#import "ItemListView.h"
#import "OnderdeelView.h"
@implementation ExtraLabelView
@synthesize insert;
@synthesize foldscreen;
@synthesize parantView;
@synthesize veldID;
@synthesize inhoudextra;
@synthesize cilinderinhoud;
@synthesize Vermogen;
@synthesize scrollingSize;
@synthesize limit;
-(void)setItemExtras:(NSString*)titleExtra
{
    insert =200;
    BOOL editable =YES;
    BOOL character=YES;
    NSString* path3 = [[NSBundle mainBundle] pathForResource:@"titles" ofType:@"plist"];
    NSMutableArray* items = [NSMutableArray arrayWithContentsOfFile:path3];
    NSString *query = [NSString stringWithFormat:@"item LIKE [cd]'%@'", titleExtra];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:query];
    NSMutableDictionary *item =  [[[items  filteredArrayUsingPredicate:predicate] firstObject] mutableCopy];
    
    UILabel *colorlabel =[[UILabel alloc]initWithFrame:CGRectMake(190,10,10,30)];
    [colorlabel setBackgroundColor:[UIColor colorWithRed:0.719543 green:0.000000 blue:1.000000 alpha:0.000000]];
    [colorlabel setTag:1];
    [colorlabel setBackgroundColor:[UIColor colorWithRed:0.439289 green:0.764236 blue:0.506794 alpha:1.000000]];
    [self addSubview:colorlabel];
    
    UILabel *titles =[[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width, 30)];
    [titles setText:[item valueForKey:@"title"]];
    [titles setFont:[UIFont regularFlatFontOfSize:16]];
    [titles setTextColor:[UIColor blackColor]];
    [titles setTextAlignment:NSTextAlignmentLeft];
    [self addSubview:titles];
    
    UIView *content =[[UIView alloc] initWithFrame:CGRectMake(insert, 5, 250, 40)];
    [content setBackgroundColor:[UIColor whiteColor]];
    [content.layer setBorderWidth:2];
    [content.layer  setBorderColor:[UIColor lightGrayColor].CGColor];
    [content.layer setCornerRadius:6];
    [self addSubview:content];
    
    if ([titleExtra isEqualToString:@"GarantieMaanden"]||[titleExtra isEqualToString:@"GarantieToelichting"]) {
        
        EditTextView *inhoud =[[EditTextView alloc] initWithFrame:CGRectMake(10, 4,240, 30)];
        
        
        if ([titleExtra isEqualToString:@"GarantieMaanden"])
        {
            
            inhoud.limit = 2;
        }
        else
        {
            
            inhoud.limit = 500;
        }
        
        
        if ([titleExtra isEqualToString:@"GarantieMaanden"]) {
            [inhoud setKeyboardType:UIKeyboardTypeNumberPad];
        }
        else
        {
            [inhoud setKeyboardType:UIKeyboardTypeAlphabet];
        }
        
        if ([[parantView.basepart  valueForKey:titleExtra] isKindOfClass:[NSNumber class]]) {
            
            if ([[[parantView.basepart  valueForKey:titleExtra] stringValue] isEqualToString:@"0"]) {
                
            }
            else
            {
                [inhoud setText:[[parantView.basepart  valueForKey:titleExtra] stringValue]];
                
            }
        }
        else
        {
            [inhoud setText: [[parantView.basepart  valueForKey:titleExtra] stringByReplacingOccurrencesOfString:@"-" withString:@""]];
        }
        [inhoud setFont:[UIFont regularFlatFontOfSize:16]];
        [inhoud setTextColor:[UIColor blackColor]];
        [inhoud setDelegate:self];
        [inhoud setTextAlignment:NSTextAlignmentLeft];
        [content addSubview:inhoud];
        [inhoud setEdittext:[item valueForKey:@"item"]];
        [inhoud setEdittitle:[item valueForKey:@"title"]];
        [inhoud setUserInteractionEnabled:editable];
        [inhoud setCharacter:character];
        
    } else if ([titleExtra isEqualToString:@"TestToelichting"]) {
        
        EditTextView *inhoud =[[EditTextView alloc] initWithFrame:CGRectMake(10, 4,240, 140)];
        inhoud.limit = 500;
        
        [inhoud setText: [[parantView.basepart  valueForKey:titleExtra] stringByReplacingOccurrencesOfString:@"-" withString:@""]];
        [inhoud setFont:[UIFont regularFlatFontOfSize:16]];
        [inhoud setTextColor:[UIColor blackColor]];
        [inhoud setDelegate:self];
        [inhoud setTextAlignment:NSTextAlignmentLeft];
        [content addSubview:inhoud];
        [inhoud setEdittext:[item valueForKey:@"item"]];
        [inhoud setEdittitle:[item valueForKey:@"title"]];
        [inhoud setUserInteractionEnabled:editable];
        [inhoud setCharacter:character];
        
        
        [content setFrame:CGRectMake(insert, 5, 250, 150)];
            //
        
    }
    
    else   if ([titleExtra isEqualToString:@"Artikelnummers"]) {
        
        [content setFrame:CGRectMake(insert, 5, 250, 100)];
        inhoudextra =[[EditTextView alloc] initWithFrame:CGRectMake(10, 4,240, 96)];
        inhoudextra.limit = 500;
        
        if ([[parantView.basepart  valueForKey:titleExtra] count]>0) {
            NSString * result = [[[parantView.basepart valueForKey:@"Artikelnummers"] valueForKey:@"Nummer"] componentsJoinedByString:@", "];
            [inhoudextra setText:result];
        }
        [inhoudextra setFont:[UIFont regularFlatFontOfSize:16]];
        [inhoudextra setTextColor:[UIColor blackColor]];
        [inhoudextra setDelegate:self];
        [inhoudextra setTextAlignment:NSTextAlignmentLeft];
        [inhoudextra.layer setCornerRadius:6];
        [content addSubview:inhoudextra];
        [inhoudextra setUserInteractionEnabled:NO];
        
    } else {
        [content setFrame:CGRectMake(insert, 5, 250, 100)];
        
        inhoudextra =[[EditTextView alloc] initWithFrame:CGRectMake(10, 4,240, 96)];
        [inhoudextra setText: [[parantView.basepart  valueForKey:titleExtra] stringByReplacingOccurrencesOfString:@"-" withString:@""]];
        inhoudextra.limit = 500;
        [inhoudextra setFont:[UIFont regularFlatFontOfSize:16]];
        
        [inhoudextra.layer setCornerRadius:6];
        [inhoudextra setTextColor:[UIColor blackColor]];
        [inhoudextra setKeyboardType:UIKeyboardTypeAlphabet];
        [inhoudextra setDelegate:self];
        [inhoudextra setTextAlignment:NSTextAlignmentLeft];
        [content addSubview:inhoudextra];
        [inhoudextra setEdittext:[item valueForKey:@"item"]];
        [inhoudextra setEdittitle:[item valueForKey:@"title"]];
        [inhoudextra setUserInteractionEnabled:editable];
        [inhoudextra setCharacter:character];
        
        
    }


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
-(void)textFieldEditingChanged:(EditTextView *)textView
{
    AppDelegate *appDelegate = [FileManager getDel];
    if ([textView.edittext isEqualToString:@"GarantieMaanden"]) {
        [textView setKeyboardType:UIKeyboardTypeNumberPad];
    } else {
        [textView setKeyboardType:UIKeyboardTypeAlphabet];
    }
    if ([[parantView.basepart allKeys] containsObject:textView.edittext])
    {
        [parantView.basepart setObject:textView.text forKey:textView.edittext];
        [FileManager insertnew:parantView.basepart];
    } else {
        if ([textView.text length]>0) {
            if (veldID ==0)
            {
                [parantView.basepart setObject:textView.text forKey:textView.edittext];
                [FileManager insertnew:parantView.basepart];
            }
            else
            {
                NSMutableDictionary *Veld =[[NSMutableDictionary alloc] init];
                [Veld setObject:textView.text forKey:@"Waarde"];
                [Veld setObject:[NSNumber numberWithInteger:veldID] forKey:@"VeldId"];
                [FileManager getVelden_voertuig:[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"] add:Veld];
                    // [textView.contentdict setValue:textView.text forKey:textView.edittext];
                    ////////////NSLog(@"%@", textView.contentdict);
            }
        }
    }
    
}
-(void)textViewDidEndEditing:(EditTextView *)textView
{
    AppDelegate *appDelegate = [FileManager getDel];
    

        
        ////NSLog(@"%@", parantView.basepart);
        
        appDelegate.viewcontroller.textcopy.VeldId = veldID;

        if ([textView.edittext isEqualToString:@"GarantieMaanden"]) {
            [textView setKeyboardType:UIKeyboardTypeNumberPad];
            [textView setPos:@"[0-9-]{0,2}"];
        }
        else
        {
            [textView setKeyboardType:UIKeyboardTypeAlphabet];
        }

       [appDelegate.viewcontroller.textcopy ScanClass:textView set:parantView];
        
        if ([[parantView.basepart allKeys] containsObject:textView.edittext])
        {
            
            [parantView.basepart setObject:textView.text forKey:textView.edittext];
            [FileManager insertnew:parantView.basepart];
            
        }
        else
        {
            if ([textView.text length]>0) {
                if (veldID ==0)
                {
                    
                    [parantView.basepart setObject:textView.text forKey:textView.edittext];
                    
                    [FileManager insertnew:parantView.basepart];
                }
                else
                {
                    NSMutableDictionary *Veld =[[NSMutableDictionary alloc] init];
                    [Veld setObject:textView.text forKey:@"Waarde"];
                    [Veld setObject:[NSNumber numberWithInteger:veldID] forKey:@"VeldId"];
                    [FileManager getVelden_voertuig:[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"] add:Veld];
                    
                }
            }
        }
        

    
}
-(void)textViewDidBeginEditing:(EditTextView *)textView
{

        AppDelegate *appDelegate = [FileManager getDel];
        appDelegate.viewcontroller.textcopy.VeldId = veldID;
        ////NSLog(@"%@", parantView.basepart);
        
        [appDelegate.viewcontroller.textcopy ScanClass:textView set:parantView];
            ////////////NSLog(@"Extralebel");
        if ([textView.text isEqualToString:@"-"]) {
            [textView setText:@""];
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
        if ([textView.edittext isEqualToString:@"GarantieMaanden"]) {
            [textView setKeyboardType:UIKeyboardTypeNumberPad];
            
        }
        else
        {
            [textView setKeyboardType:UIKeyboardTypeAlphabet];
            
        }
        
        if ([[appDelegate.currentCarDictionary allKeys] containsObject:textView.edittext])
        {
            NSInteger index = [appDelegate.alleVoertuigenArray indexOfObject:appDelegate.currentCarDictionary];
            NSString *docDir = [FileManager getDir];
            [appDelegate.currentCarDictionary setObject:textView.text forKey:textView.edittext];
            [appDelegate.alleVoertuigenArray replaceObjectAtIndex:index withObject:appDelegate.currentCarDictionary];
            NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/Voertuigen.plist",docDir];
            [appDelegate.alleVoertuigenArray writeToFile:itemFilePath atomically: YES];
            
        }
        else
        {
            if ([textView.text length]>0) {
                if (veldID ==0)
                {
                    [parantView.basepart setObject:textView.text forKey:textView.edittext];
                    [FileManager insertnew:parantView.basepart];
                    
                }
                else
                {
                    NSMutableDictionary *Veld =[[NSMutableDictionary alloc] init];
                    [Veld setObject:textView.text forKey:@"Waarde"];
                    [Veld setObject:[NSNumber numberWithInteger:veldID] forKey:@"VeldId"];
                    [FileManager getVelden_voertuig:[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"] add:Veld];
                        //[textView.contentdict setValue:textView.text forKey:textView.edittext];
                        ////////////NSLog(@"%@", textView.contentdict);
                    
                }
            }
        }
        double delayInSeconds = 0.3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if ([[appDelegate.currentItemDictonary valueForKey:@"CurrentItem"] isKindOfClass:[ItemFold class]]) {
                UIView *copy = [appDelegate.currentItemDictonary valueForKey:@"CurrentItem"];
                float scrollingSize =[[appDelegate.currentItemDictonary valueForKey:@"scrollingSize"] floatValue];
                    ////////////NSLog(@"%f",scrollingSize-100);
                CGRect frame = CGRectMake(copy.frame.origin.x, scrollingSize-80, copy.frame.size.width, copy.frame.size.height);
                [[appDelegate.currentItemDictonary valueForKey:@"Superview"] scrollRectToVisible:frame animated:NO];
                    ////////////NSLog(@"scrollRectToVisible 2:");
            }
            else
            {
                UIView *copy = [appDelegate.currentItemDictonary valueForKey:@"CurrentItem"];
                float scrollingSize =[[appDelegate.currentItemDictonary valueForKey:@"scrollingSize"] floatValue];
                    ////////////NSLog(@"%f",scrollingSize-100);
                CGRect frame = CGRectMake(copy.frame.origin.x, scrollingSize-80, copy.frame.size.width, copy.frame.size.height);
                [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy scrollRectToVisible:frame animated:NO];
                    ////////////NSLog(@"scrollRectToVisible 1:");
            }
        });
   
        ////////////NSLog(@"%@", parantView.basepart);
}
- (BOOL)textViewShouldReturn:(EditTextView *)textView {
    
    AppDelegate *appDelegate = [FileManager getDel];
    if ([textView.edittext isEqualToString:@"GarantieMaanden"]) {
        [textView setKeyboardType:UIKeyboardTypeNumberPad];
    } else {
        [textView setKeyboardType:UIKeyboardTypeAlphabet];
    }
    
    
    if ([[appDelegate.currentCarDictionary allKeys] containsObject:textView.edittext])
    {
        NSInteger index = [appDelegate.alleVoertuigenArray indexOfObject:appDelegate.currentCarDictionary];
        NSString *docDir = [FileManager getDir];
        [appDelegate.currentCarDictionary setObject:textView.text forKey:textView.edittext];
        [appDelegate.alleVoertuigenArray replaceObjectAtIndex:index withObject:appDelegate.currentCarDictionary];
        NSString *itemFilePath = [NSString stringWithFormat:@"%@/Caches/Voertuigen.plist",docDir];
        [appDelegate.alleVoertuigenArray writeToFile:itemFilePath atomically: YES];
        
    } else {
        if ([textView.text length]>0) {
            if (veldID ==0)
            {
                
                [parantView.basepart setObject:textView.text forKey:textView.edittext];
                [FileManager insertnew:parantView.basepart];
                
            }
            else
            {
                
                NSMutableDictionary *Veld =[[NSMutableDictionary alloc] init];
                [Veld setObject:textView.text forKey:@"Waarde"];
                [Veld setObject:[NSNumber numberWithInteger:veldID] forKey:@"VeldId"];
                [FileManager getVelden_voertuig:[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"] add:Veld];
                
                
            }
        }
    }
        ////////////NSLog(@"%@", parantView.basepart);
    
    [textView resignFirstResponder];
    return NO;
}
@end
