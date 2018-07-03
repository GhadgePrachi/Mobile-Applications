//
//  LatestTweetItemsManager.h
//  LatestTweetsFromTwitter
//
//  Created by Apple on 8/5/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LatestTweetItem.h"
#import "ActivityIndicator.h"
#import "Constants.h"

@interface LatestTweetItemsManager : NSObject

@property (strong,nonatomic)NSMutableArray *latesttweetDetailsList;
@property(strong,nonatomic)NSDictionary *latestTweetsDictionary;
@property(strong,nonatomic)NSDictionary *googleImageDictionary;
@property(strong,nonatomic)ActivityIndicator *activityIndicator;
@property int count;


+(LatestTweetItemsManager *)sharedInstance;
-(void) getlatestTweetTextDetails:(NSString*) tweetSearchText withCompletionBlock:(void (^)(NSArray *recipeListDetails)) completionBlock;

@end
