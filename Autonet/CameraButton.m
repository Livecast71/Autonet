//
//  LineButton.m
//  Autonet
//
//  Created by Livecast02 on 10-12-16.
//  Copyright © 2016 Autonet. All rights reserved.
//
#import "CameraButton.h"
#import "AppDelegate.h"
#import "FileManager.h"
@implementation CameraButton
@synthesize AllLines;
@synthesize baseColor;
@synthesize contraColor;
@synthesize Colorview;
@synthesize currentOnderdeel;
@synthesize currentCollection;
-(void)setItem:(UIColor*)color setImage:(NSString*)imagestring
{
    baseColor =color;

    [self.layer setCornerRadius:6];
    [self.layer setMasksToBounds:YES];
    AllLines =[[NSMutableArray alloc] init];
    Colorview =[[UIView alloc] initWithFrame:CGRectMake(3, 3, self.frame.size.width-6, self.frame.size.height-6)];
    [Colorview setBackgroundColor:baseColor];
    [self addSubview:Colorview];
    Colorview.userInteractionEnabled = NO;
    CALayer *maskLayer2 = [CALayer layer];
    maskLayer2.contents = (id) [UIImage imageNamed:imagestring].CGImage;
    maskLayer2.frame = CGRectMake(10, 6, self.frame.size.width, self.frame.size.height);
    [[Colorview layer] setMask:maskLayer2];                   
}
-(void)setItembig:(UIColor*)color setImage:(NSString*)imagestring
{
    baseColor =color;

    [self.layer setCornerRadius:6];
    [self.layer setMasksToBounds:YES];
    AllLines =[[NSMutableArray alloc] init];
    Colorview =[[UIView alloc] initWithFrame:CGRectMake(3, 3, self.frame.size.width-6, self.frame.size.height-6)];
    [Colorview setBackgroundColor:baseColor];
    [self addSubview:Colorview];
    Colorview.userInteractionEnabled = NO;
    CALayer *maskLayer2 = [CALayer layer];
    maskLayer2.contents = (id) [UIImage imageNamed:imagestring].CGImage;
    maskLayer2.frame = CGRectMake(3, 3, self.frame.size.width-12, self.frame.size.height-12);
    [[Colorview layer] setMask:maskLayer2];                                      
}

-(void)Action:(ImageButton*)sender
{
  
    for (int k =0; k < [AllLines count]; k++) {
        CAShapeLayer *set=[AllLines objectAtIndex:k];
        [set setFillColor:[[UIColor clearColor] CGColor]];
    }
    [Colorview setBackgroundColor:contraColor];
    //[self setTitleColor:contraColor forState:normal];
    double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [FileManager reload];
        for (int k =0; k < [self.AllLines count]; k++) {
           CAShapeLayer *set=[self.AllLines objectAtIndex:k];
            set.fillColor = [self.baseColor CGColor];
        }
        [self.Colorview setBackgroundColor:self.baseColor];
        // [self setTitleColor:baseColor forState:normal];
    });
    }
@end