//
//  Services.h
//  LatestTweetsFromTwitter
//
//  Created by Apple on 8/5/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Services : NSObject

+(void) getLatestTweets:(NSString *)tweetSearchValue
    withCompletionBlock:(void (^)(NSDictionary * latestTweetDetails)) completionBlock;

+(void) getGoogleImage:(NSString *)latestTweetImageWordValue
        withCompletionBlock:(void (^)(NSDictionary * googleImageDictionary)) completionBlock;

@end
