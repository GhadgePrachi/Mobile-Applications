//
//  SearchBoxView.h
//  LatestTweetsFromTwitter
//
//  Created by Apple on 8/7/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchBoxView : UIView

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIButton *getTweetButton;

@end
