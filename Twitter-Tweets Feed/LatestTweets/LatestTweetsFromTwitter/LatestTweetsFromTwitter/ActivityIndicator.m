//
//  ActivityIndicator.m
//  LatestTweetsFromTwitter
//
//  Created by Apple on 8/6/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "ActivityIndicator.h"
#import "AppDelegate.h"

@implementation ActivityIndicator

- (id)initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyle)style initWithFrame:(CGRect)frame
{
    self = [super initWithActivityIndicatorStyle:style];
    if (self) {
        self.frame = frame;
    }
    return self;
    
}

-(void)startActivityIndicator
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    UIWindow *window = delegate.window;
    
    [self startAnimating];
    
    [window addSubview: self];
}

-(void)stopActivityIndicator
{
    [self stopAnimating];
    [self removeFromSuperview];
}


@end
