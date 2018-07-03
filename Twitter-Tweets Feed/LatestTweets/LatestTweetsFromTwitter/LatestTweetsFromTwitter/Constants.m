//
//  Constants.m
//  LatestTweetsFromTwitter
//
//  Created by Apple on 8/5/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "Constants.h"

@implementation Constants

//google api parameters
NSString * const imageBaseURL =  @"https://ajax.googleapis.com/ajax/services/search/images?v=1.0";
NSString * const imageQueryKeyword = @"&q=";

//twitter api parameters
NSString * const Bearer_KEY =  @"AAAAAAAAAAAAAAAAAAAAAPiAgwAAAAAAd90bNIfCjJIsJAKcRqIZ3b7dLGY%3DH7XAwuIs1JL4vz1UI2JWvB9YzEj4XHAYi31SQiNBr6yKAywX7w";
NSString * const twitterTweetBaseURL =  @"https://api.twitter.com/1.1/search/tweets.json?";
NSString * const twitterTweetQueryKeyword = @"q=";
NSString * const twitterTweetQueryValue = @"Football";
NSString * const twitterTweetresultTypeKeyword = @"&result_type=";
NSString * const twitterTweetresultTypeValue = @"popular";
NSString * const twitterTweetresultCountKeyword = @"&count=";
NSString * const twitterTweetresultCountValue = @"50";

@end
