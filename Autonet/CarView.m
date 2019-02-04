    //
    //  LineButton.m
    //  Autonet
    //
    //  Created by Livecast02 on 10-12-16.
    //  Copyright © 2016 Autonet. All rights reserved.
    //
#import "CarView.h"
#import "LineButton.h"
#import "UIFont+FlatUI.h"
#import "AppDelegate.h"
#import "FileManager.h"
#import "FieldLabelView.h"
#import "ItemFold.h"
@implementation CarView
@synthesize AllLines;
@synthesize baseColor;
@synthesize contraColor;
@synthesize kenteken;
@synthesize content;
@synthesize Uploaden;
@synthesize currentheight;
@synthesize ScrollResult;
@synthesize AllItems;

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setItem:baseColor];
    }
    return self;
}


-(void)buildContentItems:(NSArray*)array with:(ItemFold*)contentItems

{

    [contentItems setBackgroundColor:[UIColor clearColor]];
    [ScrollResult addSubview:contentItems];
    contentItems.layer.shadowOffset = CGSizeMake(0, 0);
    contentItems.layer.shadowOpacity = 0;
    contentItems.extraArray =array;


}
-(void)setItem:(UIColor*)color
{
    baseColor =color;
    contraColor =[UIColor clearColor];
    AllLines =[[NSMutableArray alloc] init];
    AllItems =[[NSMutableArray alloc] init];
    [self.layer setCornerRadius:6];
    [self.layer setMasksToBounds:YES];
    content =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [content setBackgroundColor:[UIColor clearColor]];
    [self addSubview:content];

    ScrollResult =[[UIScrollView alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.width,self.frame.size.height)];
    [ScrollResult setCanCancelContentTouches:NO];
    ScrollResult.showsHorizontalScrollIndicator = YES;
    [ScrollResult setBackgroundColor:[UIColor clearColor]];
    ScrollResult.delaysContentTouches=NO;
    ScrollResult.clipsToBounds = YES;
    ScrollResult.scrollEnabled = YES;
    ScrollResult.pagingEnabled = NO;
    ScrollResult.delaysContentTouches=YES;
    [ScrollResult setDelegate:self];
    ScrollResult.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    [content addSubview:ScrollResult];

    NSString *docDir = [FileManager getDir];
    NSString *locatioCat = [NSString stringWithFormat:@"%@/Caches/%@.plist",docDir,@"CarItemsfold"];
    AllLines = [NSMutableArray arrayWithContentsOfFile:locatioCat];                   
    float insert = 0;
    AppDelegate *appDelegate = [FileManager getDel];
    for (int k =0; k <[AllLines count]; k++) {

        float HeigtRule;
        ItemFold *contentItems;
        if ([[[AllLines objectAtIndex:k] valueForKey:@"Title"] isEqualToString:@"Airbags"]) {
           NSMutableArray *array =  [[FileManager getAirbags_voertuig:[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]] mutableCopy];
                ////////////NSLog(@"%@", [[AllLines objectAtIndex:k] valueForKey:@"Fold"]);
            if ([array count] % 2)
            {
               HeigtRule =(([array count]/2)+2)*60;
                contentItems =[[ItemFold alloc] initWithFrame:CGRectMake(0, insert, self.frame.size.width-30, HeigtRule)];
                contentItems.extraArray =array;
                [contentItems setBackgroundColor:[UIColor clearColor]];
                [contentItems ItemFold:[AllLines objectAtIndex:k]];
                contentItems.layer.shadowOffset = CGSizeMake(0, 0);
                contentItems.layer.shadowOpacity = 0;
                insert =insert+HeigtRule+55;
                [ScrollResult addSubview:contentItems];
                [AllItems addObject:contentItems];

                
           }
            else
            {
              HeigtRule =(([array count]/2)+1)*60;
                contentItems =[[ItemFold alloc] initWithFrame:CGRectMake(0, insert, self.frame.size.width-30,  40+HeigtRule)];
                contentItems.extraArray =array;
                [contentItems setBackgroundColor:[UIColor clearColor]];
                [contentItems ItemFold:[AllLines objectAtIndex:k]];
                contentItems.layer.shadowOffset = CGSizeMake(0, 0);
                contentItems.layer.shadowOpacity = 0;
                insert =insert+HeigtRule+55;
                [ScrollResult addSubview:contentItems];
                [AllItems addObject:contentItems];

                                contentItems.sizeit =40+HeigtRule;
            }
        }
        else if ([[[AllLines objectAtIndex:k] valueForKey:@"Title"] isEqualToString:@"Gordelspanners"]) {
           NSMutableArray *array =  [[FileManager getGordelspanners_voertuig:[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]] mutableCopy];
            if ([array count] % 2)
            {
                 HeigtRule =(([array count]/2)+2)*60;
                contentItems =[[ItemFold alloc] initWithFrame:CGRectMake(0, insert, self.frame.size.width-30,   40+HeigtRule)];

                [contentItems setBackgroundColor:[UIColor clearColor]];
                contentItems.extraArray =array;
                [contentItems ItemFold:[AllLines objectAtIndex:k]];
                contentItems.layer.shadowOffset = CGSizeMake(0, 0);
                contentItems.layer.shadowOpacity = 0;
                insert =insert+HeigtRule+55;
                [ScrollResult addSubview:contentItems];
                [AllItems addObject:contentItems];

                                contentItems.sizeit =40+HeigtRule;
           }
            else
            {
                HeigtRule =(([array count]/2)+1)*60;
                contentItems =[[ItemFold alloc] initWithFrame:CGRectMake(0, insert, self.frame.size.width-30,   40+HeigtRule)];

                [contentItems setBackgroundColor:[UIColor clearColor]];
                contentItems.extraArray =array;
                [contentItems ItemFold:[AllLines objectAtIndex:k]];
                contentItems.layer.shadowOffset = CGSizeMake(0, 0);
                contentItems.layer.shadowOpacity = 0;
                insert =insert+HeigtRule+55;
                [ScrollResult addSubview:contentItems];
                [AllItems addObject:contentItems];


                                contentItems.sizeit =40+HeigtRule;
            }
        }
        else if ([[[AllLines objectAtIndex:k] valueForKey:@"Title"] isEqualToString:@"Schades"]) {
           NSMutableArray *array =  [[FileManager getSchades_voertuig:[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]] mutableCopy];
            if ([array count] % 2)
            {
               HeigtRule =(([array count]/2)+2)*60;
                contentItems =[[ItemFold alloc] initWithFrame:CGRectMake(0, insert, self.frame.size.width-30,   40+HeigtRule)];

                [contentItems setBackgroundColor:[UIColor clearColor]];
                contentItems.extraArray =array;
                [contentItems ItemFold:[AllLines objectAtIndex:k]];
                contentItems.layer.shadowOffset = CGSizeMake(0, 0);
                contentItems.layer.shadowOpacity = 0;
                insert =insert+HeigtRule+55;
                [ScrollResult addSubview:contentItems];
                [AllItems addObject:contentItems];

                                contentItems.sizeit =40+HeigtRule*60;
            }
            else
            {
               HeigtRule =(([array count]/2)+1)*60;
               contentItems =[[ItemFold alloc] initWithFrame:CGRectMake(0, insert, self.frame.size.width-30,   40+HeigtRule)];

                [contentItems setBackgroundColor:[UIColor clearColor]];
                contentItems.extraArray =array;
                [contentItems ItemFold:[AllLines objectAtIndex:k]];
                contentItems.layer.shadowOffset = CGSizeMake(0, 0);
                contentItems.layer.shadowOpacity = 0;
                insert =insert+HeigtRule+55;
                [ScrollResult addSubview:contentItems];
                [AllItems addObject:contentItems];

                                contentItems.sizeit =40+HeigtRule;
            }
        }
        else if ([[[AllLines objectAtIndex:k] valueForKey:@"Title"] isEqualToString:@"Opties"]) {
           NSMutableArray *array =  [[FileManager getOpties_voertuig:[appDelegate.currentCarDictionary valueForKey:@"VoertuigId"]] mutableCopy];
            if ([array count] % 2)
            {
              HeigtRule =(([array count]/2)+2)*60;
                contentItems =[[ItemFold alloc] initWithFrame:CGRectMake(0, insert, self.frame.size.width-30,   40+HeigtRule)];
                [contentItems setBackgroundColor:[UIColor clearColor]];
                contentItems.extraArray =array;
                [contentItems ItemFold:[AllLines objectAtIndex:k]];
                contentItems.layer.shadowOffset = CGSizeMake(0, 0);
                contentItems.layer.shadowOpacity = 0;
                insert =insert+HeigtRule+55;
                [ScrollResult addSubview:contentItems];
                [AllItems addObject:contentItems];

                                contentItems.sizeit =40+HeigtRule;
            }
            else
            {
               HeigtRule =(([array count]/2)+1)*60;
                contentItems =[[ItemFold alloc] initWithFrame:CGRectMake(0, insert, self.frame.size.width-30,   40+HeigtRule)];
                [contentItems setBackgroundColor:[UIColor clearColor]];
                contentItems.extraArray =array;contentItems.extraArray =array;
                [contentItems ItemFold:[AllLines objectAtIndex:k]];
                contentItems.layer.shadowOffset = CGSizeMake(0, 0);
                contentItems.layer.shadowOpacity = 0;
                insert =insert+HeigtRule+55;
                [ScrollResult addSubview:contentItems];
                [AllItems addObject:contentItems];

                                contentItems.sizeit =40+HeigtRule;
            }
        }
        else
        {
           contentItems =[[ItemFold alloc] initWithFrame:CGRectMake(0, insert, self.frame.size.width-30,  40+[[[AllLines objectAtIndex:k] valueForKey:@"Height"] floatValue])];
            [contentItems setBackgroundColor:[UIColor clearColor]];
            [ScrollResult addSubview:contentItems];
            [contentItems ItemFold:[AllLines objectAtIndex:k]];
            contentItems.layer.shadowOffset = CGSizeMake(0, 0);
            contentItems.layer.shadowOpacity = 0;
            insert =insert+[[[AllLines objectAtIndex:k] valueForKey:@"Height"] floatValue]+55;
            [AllItems addObject:contentItems];
        }
        [ScrollResult setContentSize:CGSizeMake(content.frame.size.width, insert+140)];
    }
    for (int k =0; k <[AllItems count]; k++) {
    if ([[[AllLines objectAtIndex:k] valueForKey:@"Fold"] boolValue])
    {
           [[AllItems objectAtIndex:k] select:NULL];
       
     }
    else {
          [[AllItems objectAtIndex:k] selectfold:NULL];
    }
    }
}                                      
-(void)move:(LineButton*)sender
{
    if (self.frame.origin.x <0)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.2f];
        [self setFrame:CGRectMake(54, 4, self.frame.size.width, self.frame.size.height)];
        [UIView commitAnimations];
    } else {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.2f];
        [self setFrame:CGRectMake(-920, 4, self.frame.size.width, self.frame.size.height)];
        [UIView commitAnimations];
    }
    [sender setBackgroundColor:contraColor];
    [content setBackgroundColor:contraColor];
        //[self setTitleColor:contraColor forState:normal];
    double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [sender setBackgroundColor:[UIColor whiteColor]];
        [self.content setBackgroundColor:[UIColor whiteColor]];
            // [self setTitleColor:baseColor forState:normal];
    });
}


@end
