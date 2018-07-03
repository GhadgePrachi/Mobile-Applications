//
//  ImageDownloader.h
//  LatestTweetsFromTwitter
//
//  Created by Apple on 8/5/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LatestTweetItem.h"

@interface ImageDownloader : NSObject

+(BOOL)imageDownload:(LatestTweetItem *)latestTweet;

@end
