//
//  ImageScrollView.h
//  Autonet
//
//  Created by Livecast02 on 08-03-17.
//  Copyright © 2017 Autonet. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "UICollectionImage.h"
@interface ImageScrollView : UIView
-(void)setimages:(NSMutableArray*)sender setOnline:(NSMutableArray*)internet;
-(void) setImagesEmpty;
@property (nonatomic, retain) UICollectionImage *imageView;
@end
