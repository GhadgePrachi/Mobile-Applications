//
//  ActivityIndicator.h
//  LatestTweetsFromTwitter
//
//  Created by Apple on 8/6/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityIndicator : UIActivityIndicatorView

- (id)initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyle)style initWithFrame:(CGRect)frame;
-(void)startActivityIndicator;
-(void)stopActivityIndicator;

@end
