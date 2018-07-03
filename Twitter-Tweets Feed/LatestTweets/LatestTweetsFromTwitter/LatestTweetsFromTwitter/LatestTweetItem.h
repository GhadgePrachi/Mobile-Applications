//
//  LatestTweetItem.h
//  LatestTweetsFromTwitter
//
//  Created by Apple on 8/5/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LatestTweetItem : NSObject

@property (nonatomic,strong) NSString* latestTweetImageURL;
@property (nonatomic,strong) NSString* latestTweetText;
@property (nonatomic,strong) NSString* latestTweetid;


-(instancetype)initWithTweetTextDictionary: (NSDictionary*) latestTweetDictionary
               withGoogleImageDictionary: (NSDictionary*) googleImageDictionary;

@end
