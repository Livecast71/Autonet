//
//  ItemSwitch.m
//  Autonet
//
//  Created by Livecast02 on 21-06-17.
//  Copyright © 2017 Autonet. All rights reserved.
//
#import "ItemSwitch.h"
#import "AppDelegate.h"
#import "UIFont+FlatUI.h"
#import "FileManager.h"
@implementation ItemSwitch
@synthesize internet;
@synthesize Switcher;
-(void)setitems:(NSString*)text
{
    internet =[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 35)];
    [internet setFont:[UIFont regularFlatFontOfSize:16]];
    [internet setTextColor:[UIColor blackColor]];
    [internet setText:text];
    [internet setBackgroundColor:[UIColor clearColor]];
    [internet setTextAlignment:NSTextAlignmentRight];
    [self addSubview:internet];

    Switcher =[[UISwitch alloc] initWithFrame:CGRectMake(100, 0, 60, 40)];
    [Switcher addTarget:self action:@selector(selectRemove:) forControlEvents:(UIControlEventValueChanged | UIControlEventTouchDragInside)];
    [Switcher setOnTintColor:[UIColor redColor]];
    Switcher.backgroundColor = [UIColor greenColor];
    Switcher.layer.cornerRadius = 16.0;
    Switcher.transform = CGAffineTransformMakeScale(0.8, 0.8);
    [Switcher setOn:NO];
    [self addSubview:Switcher];
}
-(void)selectRemove:(UISwitch*)sender
{
    AppDelegate *appDelegate = [FileManager getDel];
    if (sender.isOn) {
       
         [appDelegate.viewcontroller.removeView.SelectedItems addObject:[NSNumber numberWithInteger:(long)sender.tag]];
         [internet setText:@"Afwezig"];
    } else {
       
         [appDelegate.viewcontroller.removeView.SelectedItems removeObject:[NSNumber numberWithInteger:(long)sender.tag]];
               [internet setText:@"Aanwezig"];
     
    }
    if ([appDelegate.viewcontroller.removeView.SelectedItems count]>0) {
        [appDelegate.viewcontroller.removeView setAlpha:1];
        [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy setFrame:CGRectMake(appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy.frame.origin.x, 48, appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy.frame.size.width, 636-40)];
       
     }
    else {
        [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy setFrame:CGRectMake(appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy.frame.origin.x, 48, appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy.frame.size.width, 636)];
        [appDelegate.viewcontroller.collectionOnderdelenView.collectionViewCopy reloadData];
        [appDelegate.viewcontroller.removeView setAlpha:0];
    }
}
@end
