//
//  NumberPicker.m
//  BellyBuddy
//
//  Created by Livecast on 21-01-14.
//  Copyright (c) 2014 Livecast. All rights reserved.
//
#import "NumbersPicker.h"
#import "AppDelegate.h"
#import "KMViewController.h"
@implementation NumbersPicker
@synthesize ageArray;
@synthesize numberlabel;
@synthesize numberlabel2;
@synthesize parant;
@synthesize value;
@synthesize content;
@synthesize one;
@synthesize copyview;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        ageArray =[[NSMutableArray alloc]init];
          for (int k =0; k <10; k++) {
  
              [ageArray addObject:[NSString stringWithFormat:@"%i",k]];
          }
        for (int k =8; k >=0; k--) {
           [ageArray addObject:[NSString stringWithFormat:@"%i",k]];
        }
    }
    return self;
}
-(void)scrolTo:(NSInteger)component row:(NSInteger)row
{
    [self selectRow:row inComponent:component animated:NO];
}
#pragma mark UIPickerViewDataSource methods
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
        UITextView *picker = (UITextView *)[copyview.view viewWithTag:component+2000];
    [picker setText:[ageArray objectAtIndex:row]];
    if ([picker.text length] > 1) {
        picker.text = [picker.text substringFromIndex:1];
    }
    NSMutableString *string = [NSMutableString string];
    for (int k =0; k <[copyview.inside.subviews count]; k++) {
        [string appendString:[[copyview.inside.subviews objectAtIndex:k] text]];
       
         
    }
    copyview.stringkm =[NSNumber numberWithInteger:[[NSString stringWithFormat:@"%@", string] integerValue]];;
}
- (NSString*)pickerView:(UIPickerView*)pv titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [content objectAtIndex:row];
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UITextView *retval = (id)view;
    if (!retval) {
        retval= [[UITextView alloc] initWithFrame:CGRectMake(40*component, 0.0f, 40, 70)];
    }
    retval.text = NSLocalizedString([ageArray objectAtIndex:row],nil);
    [retval setFont:[UIFont systemFontOfSize:20]];
    [retval sizeToFit];
    retval.backgroundColor = [UIColor clearColor];
    return retval;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    CGFloat componentWidth;
    componentWidth = 40;	// first column size is wider to hold names
    return componentWidth;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pv
{
    return 6;
}
- (NSInteger)pickerView:(UIPickerView*)pv numberOfRowsInComponent:(NSInteger)component
{
     return [ageArray count];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
@end
