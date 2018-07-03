//
//  LatestTweetTableViewCell.h
//  LatestTweetsFromTwitter
//
//  Created by Apple on 8/5/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LatestTweetItem.h"

@interface LatestTweetTableViewCell : UITableViewCell

@property UIImage * image;

@property (nonatomic, weak) IBOutlet UILabel *tweetText;
@property (nonatomic, weak) IBOutlet UIImageView *tweetImageView;

-(void) populateCellWithLatestTweetItem: (LatestTweetItem*) latestTweetItem;

@end
