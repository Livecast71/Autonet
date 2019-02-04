//
//  LineButton.m
//  Autonet
//
//  Created by Livecast02 on 10-12-16.
//  Copyright © 2016 Autonet. All rights reserved.
//
#import "LabelButton.h"
@implementation LabelButton
@synthesize AllLines;
@synthesize baseColor;
@synthesize contraColor;
-(void)setItem:(UIColor*)color
{
    baseColor =color;

    [self.layer setCornerRadius:6];
    [self.layer setMasksToBounds:YES];
}


-(void)Action:(LabelButton*)sender
{
  
    for (int k =0; k < [AllLines count]; k++) {
        CAShapeLayer *set=[AllLines objectAtIndex:k];
        [set setFillColor:[[UIColor clearColor] CGColor]];
    }
    [self setBackgroundColor:baseColor];
         //[self setTitleColor:contraColor forState:normal];
    double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        for (int k =0; k < [self.AllLines count]; k++) {
           CAShapeLayer *set=[self.AllLines objectAtIndex:k];
            set.fillColor = [self.baseColor CGColor];
        }
           [self setBackgroundColor:[UIColor clearColor]];
           // [self setTitleColor:baseColor forState:normal];
    });
}
@end
