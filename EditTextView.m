//
//  EditTextField.m
//  Autonet
//
//  Created by Livecast02 on 08-03-17.
//  Copyright © 2017 Autonet. All rights reserved.
//
#import "EditTextView.h"
@implementation EditTextView
@synthesize indexand;
@synthesize limit;
@synthesize edittitle;
@synthesize contentdict;
@synthesize edittext;
@synthesize character;
@synthesize format;
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
