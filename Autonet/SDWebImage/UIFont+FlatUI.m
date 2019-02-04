//
//  UIFont+FlatUI.m
//  FlatUI
//
//  Created by Jack Flintermann on 5/7/13.
//  Copyright (c) 2013 Jack Flintermann. All rights reserved.
//
#import "UIFont+FlatUI.h"
#import <CoreText/CoreText.h>
#import "NSString+Icons.h"
@implementation UIFont (FlatUI)
+ (void) initialize {
    [super initialize];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *fontNames = @[@"Roboto-Medium", @"Roboto-Bold", @"Roboto-Italic", @"Roboto-Light", @"Roboto-Regular"];
        for (NSString *fontName in fontNames) {
           NSURL * url = [[NSBundle mainBundle] URLForResource:fontName withExtension:@"ttf"];
            if (url) {
               CFErrorRef error;
                CTFontManagerRegisterFontsForURL((__bridge CFURLRef)url, kCTFontManagerScopeNone, &error);
            }
        }
    });
}
+ (UIFont *)lightFlatFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"Roboto-Light" size:size];
}
+ (UIFont *)regularFlatFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"Roboto-Regular" size:size];
}
+ (UIFont *)mediumFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"Roboto-Medium" size:size];
}
+ (UIFont *)boldFlatFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"Roboto-Bold" size:size];
}
+ (UIFont *)italicFlatFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"Roboto-Italic" size:size];
}
+ (UIFont *)iconFontWithSize:(CGFloat)size{
    return [UIFont fontWithName:kFlatUIFontFamilyName size:size];
}
@end
