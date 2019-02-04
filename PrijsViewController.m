    //
    //  ViewController.m
    //  Calculator
    //
    //  Created by Mark Glagola on 5/14/12.
    //  Copyright (c) 2012 Independent. All rights reserved.
    //
#import "PrijsViewController.h"
#import "AppDelegate.h"
#import "FileManager.h"
#import "UIFont+FlatUI.h"
@interface PrijsViewController ()
@end
@implementation PrijsViewController
@synthesize mainLabel;
@synthesize popoverparant;
@synthesize basepart;
@synthesize basefield;
- (void)viewDidLoad
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIView *back =[[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 60)];
    [back setBackgroundColor:[UIColor blackColor]];
    [back.layer setCornerRadius:6];
    [back.layer setMasksToBounds:YES];
    [self.view addSubview:back];
    mainLabel =[[UILabel alloc] initWithFrame:CGRectMake(20, 10, 280, 60)];
    [mainLabel setTextColor:[UIColor whiteColor]];
    [mainLabel setBackgroundColor:[UIColor blackColor]];
    [mainLabel.layer setCornerRadius:6];
    [mainLabel.layer setMasksToBounds:YES];
    [mainLabel setTextAlignment:NSTextAlignmentRight];
    [self.view addSubview:mainLabel];
    for (int i=1; i<=4; i++) {
        if (i % 5)
        {

            UIButton *click =[[UIButton alloc]initWithFrame:CGRectMake(20+((300/5)+15)*(i-1), 80, 300/5, 300/5)];
            [click setBackgroundColor:[UIColor lightGrayColor]];
            [click setTitle:[NSString stringWithFormat:@"%i",(i-1)] forState:UIControlStateNormal];
            [click addTarget:self action:@selector(numberButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [click.layer setCornerRadius:6];
            [click.titleLabel setFont:[UIFont regularFlatFontOfSize:26]];
            [click.layer setMasksToBounds:YES];
            [self.view addSubview:click];

            UIButton *click2 =[[UIButton alloc]initWithFrame:CGRectMake(20+((300/5)+15)*(i-1), 160, 300/5, 300/5)];
            [click2 setBackgroundColor:[UIColor lightGrayColor]];
            [click2 setTitle:[NSString stringWithFormat:@"%i",(i-1)+4] forState:UIControlStateNormal];
            [click2 addTarget:self action:@selector(numberButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [click2.layer setCornerRadius:6];
            [click2.titleLabel setFont:[UIFont regularFlatFontOfSize:26]];
            [click2.layer setMasksToBounds:YES];
            [self.view addSubview:click2];
            if (((i-1)+8)<10) {

                UIButton *click3 =[[UIButton alloc]initWithFrame:CGRectMake(20+((300/5)+15)*(i-1), 240, 300/5, 300/5)];
                [click3 setBackgroundColor:[UIColor lightGrayColor]];
                [click3 setTitle:[NSString stringWithFormat:@"%i",(i-1)+8] forState:UIControlStateNormal];
                [click3 addTarget:self action:@selector(numberButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [click3.layer setCornerRadius:6];
                [click3.titleLabel setFont:[UIFont regularFlatFontOfSize:26]];
                [click3.layer setMasksToBounds:YES];
                [self.view addSubview:click3];
            }
        }
    }

    UIButton *clear =[[UIButton alloc]initWithFrame:CGRectMake(20+((300/5)+15)*2, 240, (300/2.5)+15, 300/5)];
    [clear setBackgroundColor:[UIColor orangeColor]];
    [clear setTitle:@"Clear" forState:UIControlStateNormal];
    [clear addTarget:self action:@selector(clearPressed:) forControlEvents:UIControlEventTouchUpInside];
    [clear.layer setCornerRadius:6];
    [clear.titleLabel setFont:[UIFont regularFlatFontOfSize:20]];
    [clear.layer setMasksToBounds:YES];
    [self.view addSubview:clear];

    UIButton *send =[[UIButton alloc]initWithFrame:CGRectMake(20, 330, (300/1.5)+10, 300/5)];
    [send setBackgroundColor:[UIColor orangeColor]];
    [send setTitle:@"Opslaan" forState:UIControlStateNormal];
    [send addTarget:self action:@selector(Save:) forControlEvents:UIControlEventTouchUpInside];
    [send.layer setCornerRadius:6];
    [send.titleLabel setFont:[UIFont regularFlatFontOfSize:20]];
    [send.layer setMasksToBounds:YES];
    [self.view addSubview:send];

    UIButton *point =[[UIButton alloc]initWithFrame:CGRectMake(20+((300/1.5)+20), 330, 300/5, 300/5)];
    [point setBackgroundColor:[UIColor redColor]];
    [point setTitle:[NSString stringWithFormat:@"."] forState:UIControlStateNormal];
    [point addTarget:self action:@selector(decimalPressed:) forControlEvents:UIControlEventTouchUpInside];
    [point.layer setCornerRadius:6];
    [point.titleLabel setFont:[UIFont regularFlatFontOfSize:26]];
    [point.layer setMasksToBounds:YES];
    [self.view addSubview:point];
        //192 × 50 pixels
    UIImageView *logos= [[UIImageView alloc] initWithFrame:CGRectMake((300-192)/2,420,192,50)];
    [logos setImage:[UIImage imageNamed:@"logo.png"]];
    logos.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:logos];
    [super viewDidLoad];
        // Do any additional setup after loading the view, typically from a nib.
}

-(void)SavePrices:(UIButton*)sender
{
    AppDelegate *appDelegate = [FileManager getDel];

        // NSInteger index = [appDelegate.alleVoertuigenArray indexOfObject:appDelegate.currentCarDictionary];
        // [appDelegate.currentCarDictionary setValue:[NSNumber numberWithFloat:[[NSString stringWithFormat:@"%.2f",[[mainLabel.text stringByReplacingOccurrencesOfString:@"," withString:@"."] floatValue]] floatValue]] forKey:TextField.edittext];



    [self.basepart setObject:[NSString stringWithFormat:@"%.2f",[[mainLabel.text stringByReplacingOccurrencesOfString:@"," withString:@"."] floatValue]] forKey:@"Prijs"];
    if ([[self.basepart valueForKey:@"OnderdeelId"] integerValue] == 0) {

        [FileManager insertnew:self.basepart];
    } else {
        [FileManager insertnew:self.basepart];
    }
    [popoverparant dismissPopoverAnimated:YES];
    [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
}


-(void)Save:(UIButton*)sender
{
    AppDelegate *appDelegate = [FileManager getDel];

    if (appDelegate.viewcontroller.carView.alpha == 0) {

        if ([mainLabel.text isEqualToString:@"0"]) {

            [self.basepart removeObjectForKey:@"Prijs"];
           // [self.basepart setObject:[NSString stringWithFormat:@"%.2f",[[mainLabel.text stringByReplacingOccurrencesOfString:@"," withString:@"."] floatValue]] forKey:@"Prijs"];
            if ([[self.basepart valueForKey:@"OnderdeelId"] integerValue] == 0) {

                [FileManager insertnew:self.basepart];
            }
            else {
                [FileManager insertnew:self.basepart];
            }
            [popoverparant dismissPopoverAnimated:YES];
            [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];

        }
        else
        {
            [self.basepart setObject:[NSString stringWithFormat:@"%.2f",[[mainLabel.text stringByReplacingOccurrencesOfString:@"," withString:@"."] floatValue]] forKey:@"Prijs"];
            if ([[self.basepart valueForKey:@"OnderdeelId"] integerValue] == 0) {

                [FileManager insertnew:self.basepart];
            }
            else {
                [FileManager insertnew:self.basepart];
            }
            [popoverparant dismissPopoverAnimated:YES];
            [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];

        }
    } else {
        
        NSString *docDir = [FileManager getDir];
        if ([mainLabel.text isEqualToString:@"0"]) {

            NSInteger index = [appDelegate.alleVoertuigenArray indexOfObject:appDelegate.currentCarDictionary];
            [basefield setText:@""];
            [appDelegate.currentCarDictionary removeObjectForKey:basefield.edittext];
            NSLog(@"%@", self.popoverparant);
            [appDelegate.alleVoertuigenArray replaceObjectAtIndex:index withObject:appDelegate.currentCarDictionary];
            NSString *itemFilePathvoer = [NSString stringWithFormat:@"%@/Caches/Voertuigen.plist",docDir];
            [appDelegate.alleVoertuigenArray writeToFile:itemFilePathvoer atomically: YES];

            [popoverparant dismissPopoverAnimated:YES];
            [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];

        }
        else
        {
            NSInteger index = [appDelegate.alleVoertuigenArray indexOfObject:appDelegate.currentCarDictionary];
            [basefield setText:[NSString stringWithFormat:@"%.2f",[[mainLabel.text stringByReplacingOccurrencesOfString:@"," withString:@"."] floatValue]]];
            [appDelegate.currentCarDictionary setValue:[NSString stringWithFormat:@"%.2f",[[mainLabel.text stringByReplacingOccurrencesOfString:@"," withString:@"."] floatValue]] forKey:basefield.edittext];
            NSLog(@"%@", self.popoverparant);
            [appDelegate.alleVoertuigenArray replaceObjectAtIndex:index withObject:appDelegate.currentCarDictionary];
            NSString *itemFilePathvoer = [NSString stringWithFormat:@"%@/Caches/Voertuigen.plist",docDir];
            [appDelegate.alleVoertuigenArray writeToFile:itemFilePathvoer atomically: YES];

            [popoverparant dismissPopoverAnimated:YES];
            [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];

        }
    }
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];

}
- (void)viewDidUnload
{
    [super viewDidUnload];
        // Release any retained subviews of the main view.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}
- (IBAction)clearPressed:(id)sender {
    lastKnownValue = 0;
    mainLabel.text = @"0";
    isMainLabelTextTemporary = NO;
    operand = @"";
}

- (BOOL)doesStringContainDecimal:(NSString*) string {
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
