//
//  LatestTweetItem.m
//  LatestTweetsFromTwitter
//
//  Created by Apple on 8/5/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "LatestTweetItem.h"

@implementation LatestTweetItem

/*************************************************************************************************************************
 *  Function            : initWithTweetTextDictionary: withGoogleImageDictionary:
 *  Purpose             : Initializes the custom tweet Item with googleImageDictionary and twitterDictionary from api calls
 *  Parametrs           :
 *  Return Values       :
 ************************************************************************************************************************/
-(instancetype)initWithTweetTextDictionary: (NSDictionary*) latestTweetDictionary withGoogleImageDictionary: (NSDictionary*) googleImageDictionary
{
    self = [super init];
    if (self) {
        
        self.latestTweetText = [latestTweetDictionary objectForKey:@"text"];
        self.latestTweetImageURL = [googleImageDictionary objectForKey:@"url"];
        self.latestTweetid = [latestTweetDictionary objectForKey:@"id_str"];
        }
    
    return self;
    
}


@end
