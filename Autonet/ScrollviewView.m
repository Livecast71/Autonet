//
//  LineButton.m
//  Autonet
//
//  Created by Livecast02 on 10-12-16.
//  Copyright © 2016 Autonet. All rights reserved.
//
#import "ScrollviewView.h"
@implementation ScrollviewView
@synthesize AllLines;
@synthesize baseColor;
@synthesize contraColor;
-(void)setItem:(UIColor*)color
{
    baseColor =color;
    AllLines =[[NSMutableArray alloc] init];
    UIBezierPath *linePathTop = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0,self.frame.size.width, 1)];
    //shape layer for the line
    CAShapeLayer *linetop = [CAShapeLayer layer];
    linetop.path = [linePathTop CGPath];
    linetop.fillColor = [color CGColor];
    linetop.frame = CGRectMake(0, 0, self.frame.size.width,1);
    [self.layer addSublayer:linetop];
    [AllLines addObject:linetop];
    UIBezierPath *linePathBottum = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0,self.frame.size.width, 1)];
    //shape layer for the line
    CAShapeLayer *linebottum = [CAShapeLayer layer];
    linebottum.path = [linePathBottum CGPath];
    linebottum.fillColor = [color CGColor];
    linebottum.frame = CGRectMake(0, self.frame.size.height-1, self.frame.size.width,1);
    [self.layer addSublayer:linebottum];
        [AllLines addObject:linebottum];
        [self createCorner:@"LeftTop" colorit:color];
        [self createCorner:@"righTop" colorit:color];
    UIBezierPath *linePathLeft= [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 1,self.frame.size.height)];
    //shape layer for the line
    CAShapeLayer *lineLeft = [CAShapeLayer layer];
    lineLeft.path = [linePathLeft CGPath];
    lineLeft.fillColor = [color CGColor];
    lineLeft.frame = CGRectMake(0, 0, 1,self.frame.size.height);
    [self.layer addSublayer:lineLeft];
      [AllLines addObject:lineLeft];
    UIBezierPath *linePathRight= [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 1,self.frame.size.height)];
    //shape layer for the line
    CAShapeLayer *lineRight = [CAShapeLayer layer];
    lineRight.path = [linePathRight CGPath];
    lineRight.fillColor = [color CGColor];
    lineRight.frame = CGRectMake(self.frame.size.width-1, 0, 1,self.frame.size.height);
    [self.layer addSublayer:lineRight];
         [AllLines addObject:lineRight];
    [self createCorner:@"LeftBottum" colorit:color];
    [self createCorner:@"righBottum" colorit:color];
}
-(void)createCorner:(NSString*)set colorit:(UIColor*)color
{
    if ([set isEqualToString:@"LeftTop"]) {
    UIBezierPath *linePathCornerTop = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0,10, 2)];
    //shape layer for the line
    CAShapeLayer *lineCorner = [CAShapeLayer layer];
    lineCorner.path = [linePathCornerTop CGPath];
    lineCorner.fillColor = [color CGColor];
    lineCorner.frame = CGRectMake(0, 0, 10,2);
    [self.layer addSublayer:lineCorner];
    UIBezierPath *linePathCornerleft = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0,2, 10)];
    //shape layer for the line
    CAShapeLayer *lineCornerLeft = [CAShapeLayer layer];
    lineCornerLeft.path = [linePathCornerleft CGPath];
    lineCornerLeft.fillColor = [color CGColor];
    lineCornerLeft.frame = CGRectMake(0, 0, 2,10);
    [self.layer addSublayer:lineCornerLeft];
    } else if ([set isEqualToString:@"righTop"]) {
        UIBezierPath *linePathCornerTop = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0,10, 2)];
        //shape layer for the line
        CAShapeLayer *lineCorner = [CAShapeLayer layer];
        lineCorner.path = [linePathCornerTop CGPath];
        lineCorner.fillColor = [color CGColor];
        lineCorner.frame = CGRectMake(self.frame.size.width-10, 0, 10,2);
        [self.layer addSublayer:lineCorner];
        UIBezierPath *linePathCornerleft = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0,2, 10)];
        //shape layer for the line
        CAShapeLayer *lineCornerLeft = [CAShapeLayer layer];
        lineCornerLeft.path = [linePathCornerleft CGPath];
        lineCornerLeft.fillColor = [color CGColor];
        lineCornerLeft.frame = CGRectMake(self.frame.size.width-2, 0, 2,10);
        [self.layer addSublayer:lineCornerLeft];
    } else if ([set isEqualToString:@"righBottum"]) {
        UIBezierPath *linePathCornerTop = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0,10, 2)];
        //shape layer for the line
        CAShapeLayer *lineCorner = [CAShapeLayer layer];
        lineCorner.path = [linePathCornerTop CGPath];
        lineCorner.fillColor = [color CGColor];
        lineCorner.frame = CGRectMake(self.frame.size.width-10, self.frame.size.height-2, 10,2);
        [self.layer addSublayer:lineCorner];
        UIBezierPath *linePathCornerleft = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0,2, 10)];
        //shape layer for the line
        CAShapeLayer *lineCornerLeft = [CAShapeLayer layer];
        lineCornerLeft.path = [linePathCornerleft CGPath];
        lineCornerLeft.fillColor = [color CGColor];
        lineCornerLeft.frame = CGRectMake(self.frame.size.width-2, self.frame.size.height-10, 2,10);
        [self.layer addSublayer:lineCornerLeft];
    } else if ([set isEqualToString:@"LeftBottum"]) {
        UIBezierPath *linePathCornerTop = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0,10, 2)];
        //shape layer for the line
        CAShapeLayer *lineCorner = [CAShapeLayer layer];
        lineCorner.path = [linePathCornerTop CGPath];
        lineCorner.fillColor = [color CGColor];
        lineCorner.frame = CGRectMake(0, self.frame.size.height-2, 10,2);
        [self.layer addSublayer:lineCorner];
        UIBezierPath *linePathCornerleft = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0,2, 10)];
        //shape layer for the line
        CAShapeLayer *lineCornerLeft = [CAShapeLayer layer];
        lineCornerLeft.path = [linePathCornerleft CGPath];
        lineCornerLeft.fillColor = [color CGColor];
        lineCornerLeft.frame = CGRectMake(0, self.frame.size.height-10, 2,10);
        [self.layer addSublayer:lineCornerLeft];
    }
}
@end
