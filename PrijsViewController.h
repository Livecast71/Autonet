//
//  PrijsViewController.h
//  Autonet
//
//  Created by Livecast02 on 09-03-17.
//  Copyright © 2017 Autonet. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "EditTextField.h"
@interface PrijsViewController : UIViewController
{
IBOutlet UILabel *mainLabel;
//Stores the last known value before an operand is pressed
double lastKnownValue;
NSString *operand;
BOOL isMainLabelTextTemporary;
}
@property (nonatomic, strong)  UILabel *mainLabel;
@property (nonatomic, strong)  UIPopoverController *popoverparant;
@property (nonatomic, strong)  NSMutableDictionary *basepart;
@property (nonatomic, strong)  EditTextField *basefield;

- (IBAction)clearPressed:(UIButton*)sender;
- (IBAction)numberButtonPressed:(UIButton*)sender;
- (IBAction)decimalPressed:(UIButton*)sender;
- (IBAction)operandPressed:(UIButton*)sender;
- (IBAction)equalsPressed:(UIButton*)sender;
@end
