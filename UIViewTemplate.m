//
//  UIViewTemplate.m
//  Autonet
//
//  Created by Livecast02 on 27-07-17.
//  Copyright © 2017 Autonet. All rights reserved.
//
#import "UIViewTemplate.h"
@implementation UIViewTemplate
@synthesize getlist;
@synthesize Moment;
@synthesize Interval;
@synthesize startnumber;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
           // Initialization code
        ;
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    float setX=0;
    float setY= 0;
    UIColor *color = [self colorFromHexString:@"0000ff"];
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGFloat components[3];
    [self getRGBComponents:components forColor:color];
    CGFloat red[4] = {components[0], components[1], components[2], 1};
    CGContextSetStrokeColor(c, red);
    CGContextBeginPath(c);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 2); // for size
    for (int k=0 ; k<[getlist count]; k++) {
   
        float pijn = [[[getlist objectAtIndex:k]  valueForKey:@"Waarde"] floatValue];
        CGContextMoveToPoint(c,  setX, setY);
        float setXcopy=200*k;
        float setYcopy=500-pijn;
        CGContextAddLineToPoint(c,  setXcopy, setYcopy);

        UILabel *lblRef = [[UILabel alloc] initWithFrame:CGRectMake(setXcopy, setYcopy, 20, 20)];
        lblRef.text =[[[getlist objectAtIndex:k]  valueForKey:@"Waarde"] stringValue];
        [lblRef setFont:[UIFont systemFontOfSize:8]];
        [lblRef setTextAlignment:NSTextAlignmentCenter];
        [lblRef  setTextColor:[UIColor whiteColor]];
        lblRef.backgroundColor = color;
        [self addSubview:lblRef];
        
        [lblRef.layer setCornerRadius:10];
        [lblRef.layer setMasksToBounds:YES];
        [lblRef setCenter:CGPointMake(setXcopy, setYcopy)];
        CGContextSetLineJoin(UIGraphicsGetCurrentContext(), kCGLineJoinRound);
        setX =setXcopy;
        setY =setYcopy;
        CGContextStrokePath(c);
    }
}
- (void)getRGBComponents:(CGFloat [3])components forColor:(UIColor *)color {
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char resultingPixel[4];
    CGContextRef context = CGBitmapContextCreate(&resultingPixel,
                                                 1,
                                                 1,
                                                 8,
                                                 4,
                                                 rgbColorSpace,
                                                 kCGImageAlphaNoneSkipLast);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(rgbColorSpace);
    for (int component = 0; component < 3; component++) {
        components[component] = resultingPixel[component] / 255.0f;
    }
}
- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:0]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}
@end
