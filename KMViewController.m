    //
    //  ViewController.m
    //  Calculator
    //
    //  Created by Mark Glagola on 5/14/12.
    //  Copyright (c) 2012 Independent. All rights reserved.
    //
#import "KMViewController.h"
#import "UIFont+FlatUI.h"
#import "NumbersPicker.h"
#import "AppDelegate.h"
#import "Actionbutton.h"
#import "FileManager.h"
@interface KMViewController ()
@end
@implementation KMViewController
@synthesize mainLabel;
@synthesize inside;
@synthesize stringkm;
@synthesize popoverparant;
- (void)viewDidLoad
{
    AppDelegate *appDelegate = [FileManager getDel];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *zin = [[UILabel alloc] initWithFrame:CGRectMake(10,10,(345-20), 40)];
    [zin setBackgroundColor:[UIColor clearColor]];
    [zin setText:@"Kilometerstand op dit moment"];
    [zin setTextColor:[UIColor blackColor]];
    [zin setFont:[UIFont boldFlatFontOfSize:14]];
    [zin setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:zin];
    
    NumbersPicker *agepicker = [[NumbersPicker alloc] initWithFrame:CGRectMake(0, 140, 355, 220)];
    agepicker.delegate = agepicker;
    [agepicker setBackgroundColor:[UIColor whiteColor]];
    agepicker.showsSelectionIndicator = YES;
    agepicker.copyview=self;
    [agepicker setAlpha:1];
    [self.view addSubview:agepicker];
    
    inside = [[UIView alloc] initWithFrame:CGRectMake(20,80,40*7, 40)];
    [inside setBackgroundColor:[UIColor clearColor]];
    [inside.layer setBorderWidth:1];
    [inside.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.view addSubview:inside];
    
    if ([[appDelegate.currentCarDictionary valueForKey:@"Kilometerstand"] isKindOfClass:[NSString class]])
    {
        stringkm =[NSNumber numberWithInteger:[[NSString stringWithFormat:@"000000"] integerValue]];
        
    } else {
        stringkm =[appDelegate.currentCarDictionary valueForKey:@"Kilometerstand"];
    }
    NSInteger missing = 6 -[[stringkm stringValue] length];
    for (int k =0; k < 6; k++) {
        if (k <missing)
        {
            UITextView *shadowlabel = [[UITextView alloc] initWithFrame:CGRectMake((40*k),0,40, 40)];
            [shadowlabel setBackgroundColor:[UIColor clearColor]];
            [shadowlabel setText:@"0"];
            [shadowlabel setTextColor:[UIColor blackColor]];
            [shadowlabel setFont:[UIFont boldFlatFontOfSize:24]];
            [shadowlabel setTextAlignment:NSTextAlignmentCenter];
            [shadowlabel setDelegate:self];
            [shadowlabel setUserInteractionEnabled:YES];
            shadowlabel.keyboardType = UIKeyboardTypeNumberPad;
            shadowlabel.contentInset = UIEdgeInsetsMake(-4,-4,0,0);
            [shadowlabel setEditable:NO];
            [shadowlabel setScrollEnabled:NO];
            [shadowlabel setTag:k+2000];
            [agepicker scrolTo:k row:0];
            [inside addSubview:shadowlabel];
            
            
        }
        else
        {
            NSString *what = [stringkm stringValue];
            NSRange range = NSMakeRange(k-missing, 1);
            UITextView *shadowlabel = [[UITextView alloc] initWithFrame:CGRectMake((40*k),0,40, 40)];
            [shadowlabel setBackgroundColor:[UIColor clearColor]];
            [shadowlabel setText:[what substringWithRange:range]];
            [shadowlabel setTextColor:[UIColor blackColor]];
            [shadowlabel setFont:[UIFont boldFlatFontOfSize:24]];
            [shadowlabel setTextAlignment:NSTextAlignmentCenter];
            [shadowlabel setDelegate:self];
            [shadowlabel setUserInteractionEnabled:YES];
            shadowlabel.keyboardType = UIKeyboardTypeNumberPad;
            shadowlabel.contentInset = UIEdgeInsetsMake(-4,-4,0,0);
            [shadowlabel setTag:k+2000];
            [shadowlabel setEditable:NO];
            [inside addSubview:shadowlabel];
            
            [agepicker scrolTo:k row:[[what substringWithRange:range]integerValue]];
        }
    }
    [inside setFrame:CGRectMake(40,80,40*6, 40)];
    NSArray *profileItem3 =[NSArray arrayWithObjects:NSLocalizedString(@"OK",nil),NSLocalizedString(@"Cancel",nil),nil];
    for (int k =0; k < [profileItem3 count]; k++) {
        if (k ==0) {
            UIButton *btnTwo = [[UIButton alloc] initWithFrame:CGRectMake((340/2)*k,350 , 340/2, 42)];
            [btnTwo.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
            [btnTwo setTitle:[profileItem3 objectAtIndex:k] forState:UIControlStateNormal];
            [btnTwo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btnTwo addTarget:self action:@selector(actionstand:) forControlEvents:UIControlEventTouchUpInside];
            [btnTwo setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1.000]];
            [btnTwo.layer setBorderColor:[UIColor colorWithRed:0.140 green:0.637 blue:0.602 alpha:1.000].CGColor];
            [btnTwo.layer setBorderWidth:1];
            [btnTwo setTag:66+k];
            [self.view addSubview:btnTwo];
        }
        else
        {
            UIButton *btnTwo = [[UIButton alloc] initWithFrame:CGRectMake((340/2)*k,350 , 340/2, 42)];
            [btnTwo.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
            [btnTwo setTitle:[profileItem3 objectAtIndex:k] forState:UIControlStateNormal];
            [btnTwo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btnTwo addTarget:self action:@selector(Cancel:) forControlEvents:UIControlEventTouchUpInside];
            [btnTwo setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1.000]];
            [btnTwo.layer setBorderColor:[UIColor colorWithRed:0.140 green:0.637 blue:0.602 alpha:1.000].CGColor];
            [btnTwo.layer setBorderWidth:1];
            [btnTwo setTag:66+k];
            [self.view addSubview:btnTwo];
        }
    }
    UILabel *shadowlabel = [[UILabel alloc] initWithFrame:CGRectMake((355-70),80,30, 40)];
    [shadowlabel setBackgroundColor:[UIColor clearColor]];
    [shadowlabel setText:@"KM"];
    [shadowlabel setTextColor:[UIColor blackColor]];
    [shadowlabel setFont:[UIFont boldFlatFontOfSize:18]];
    [shadowlabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:shadowlabel];
    
    UIImageView *logos= [[UIImageView alloc] initWithFrame:CGRectMake((345-192)/2,420,192,50)];
    [logos setImage:[UIImage imageNamed:@"logo.png"]];
    logos.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:logos];
    
    UIActivityIndicatorView *indictor =[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0,0, 60, 60)];
    [indictor setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.view addSubview:indictor];
    [indictor setCenter:self.view.center];
    [indictor startAnimating];
    [super viewDidLoad];
        // Do any additional setup after loading the view, typically from a nib.
}
-(void)actionstand:(Actionbutton*)sender
{
    AppDelegate *appDelegate = [FileManager getDel];
    [appDelegate.currentCarDictionary setObject:stringkm forKey:@"Kilometerstand"];
    [FileManager insertKilometerStand:stringkm];
    [popoverparant dismissPopoverAnimated:YES];
}
-(void)Cancel:(UIButton *)sender
{
    [popoverparant dismissPopoverAnimated:YES];
}


- (IBAction)clearPressed:(id)sender
{
    lastKnownValue = 0;
    mainLabel.text = @"0";
    isMainLabelTextTemporary = NO;
    operand = @"";
}
- (BOOL)doesStringContainDecimal:(NSString*) string
{
    NSString *searchForDecimal = @".";
    NSRange range = [mainLabel.text rangeOfString:searchForDecimal];
        //If we find a decimal return YES. Otherwise, NO
    if (range.location != NSNotFound)
        return YES;
    return NO;
}
- (IBAction)numberButtonPressed:(UIButton*)sender
{
    
        //Resets label after calculations are shown from previous operations
    if (isMainLabelTextTemporary)
    {
        mainLabel.text = @"0";
        isMainLabelTextTemporary = NO;
    }
        //Get the string from the button label and main label
    NSString *numString = sender.titleLabel.text;
    NSString *mainLabelString = mainLabel.text;
        //If mainLabel = 0 and does not contain a decimal then remove the 0
    if ([mainLabelString doubleValue] == 0 && [self doesStringContainDecimal:mainLabelString] == NO)
        mainLabelString = @"";
        //Combine the two strings together
    [mainLabel setText:[mainLabelString stringByAppendingFormat:@"%@", numString]];
}
- (IBAction)decimalPressed:(id)sender
{
        //Only add a decimal if the string doesnt already contain one.
    if ([self doesStringContainDecimal:mainLabel.text] == NO)
        mainLabel.text = [mainLabel.text stringByAppendingFormat:@"."];
}
- (void)calculate
{
        //Get the current value on screen
    double currentValue = [mainLabel.text doubleValue];
        // If we already have a value stored and the current # is not 0 , add/subt/mult/divide the values
    if (lastKnownValue != 0 && currentValue != 0)
    {
        if ([operand isEqualToString:@"+"])
            lastKnownValue += currentValue;
        else if ([operand isEqualToString:@"-"])
            lastKnownValue -= currentValue;
        else if ([operand isEqualToString:@"x"])
            lastKnownValue *= currentValue;
        else if ([operand isEqualToString:@"/"])
        {
                //You can't divide by 0!
            if (currentValue == 0)
                [self clearPressed:nil];
            else
                lastKnownValue /= currentValue;
        }
    } else
        lastKnownValue = currentValue;
        //Set the new value to the main label
    mainLabel.text = [NSString stringWithFormat:@"%g",lastKnownValue];
        //Make the main label text temp, so we can erase when the next value is entered
    isMainLabelTextTemporary = YES;
}
- (IBAction)operandPressed:(id)sender
{
        //Calculate from previous operand
    [self calculate];
        //Get the NEW operand from the button pressed
    operand = ((UIButton*)sender).titleLabel.text;
}
- (IBAction)equalsPressed:(id)sender
{
    [self calculate];
        //reset operand;
    operand = @"";
}
@end
