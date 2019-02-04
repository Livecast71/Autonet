//
//  EditTextField.m
//  Autonet
//
//  Created by Livecast02 on 08-03-17.
//  Copyright © 2017 Autonet. All rights reserved.
//
#import "EditTextField.h"
@implementation EditTextField
@synthesize indexand;
@synthesize contentdict;
@synthesize edittext;
@synthesize limit;
@synthesize edittitle;
@synthesize character;
@synthesize format;
@synthesize VeldId;
@synthesize pos;
@synthesize LengteMax;
@synthesize RangeMax;


- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {

        limit = 0;
    }
    return self;
}

@end
