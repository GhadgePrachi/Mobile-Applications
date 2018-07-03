//
//  Constants.h
//  LatestTweetsFromTwitter
//
//  Created by Apple on 8/5/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kMainScreenSize [[UIScreen mainScreen] applicationFrame].size

#define kNavBarButtonXValue 40
#define kNavBarButtonYValue 5
#define kNavBarButtonWidth 45
#define kNavBarButtonHeight 40

#define kPopoverwindowXValue (kMainScreenSize.width/2-(kPopoverwindowWidth/2))
#define kPopoverwindowYValue (kMainScreenSize.height/2-(kPopoverwindowHeight/2))
#define kPopoverwindowWidth 250
#define kPopoverwindowHeight 200

#define ActivityIndicatorWidth 24
#define ActivityIndicatorHeight 24

#define kNumberOfItemsToAdd 2

#define kXOrigin 0
#define kYOrigin 0

#define kTableViewHeaderYValue 0
#define kTableViewHeaderWidth kMainScreenSize.width
#define kTableViewHeaderHeight 45

#define kSearchTextFieldWidth (kMainScreenSize.width*3/4)-10
#define kSearchTextFieldHeight 35

#define kGetTweetButtonYValue 0.0
#define kGetTweetButtonXValue (kMainScreenSize.width*3.0/4)-9
#define kGetTweetButtonWidth kMainScreenSize.width*1.0/4)+5
#define kGetTweetButtonHeight 35.0


@interface Constants : NSObject

extern NSString * const imageBaseURL ;
extern NSString * const imageQueryKeyword ;

extern NSString * const Bearer_KEY;
extern NSString * const twitterTweetBaseURL ;
extern NSString * const twitterTweetQueryKeyword ;
extern NSString * const twitterTweetQueryValue ;
extern NSString * const twitterTweetresultTypeKeyword ;
extern NSString * const twitterTweetresultTypeValue ;
extern NSString * const twitterTweetresultCountKeyword ;
extern NSString * const twitterTweetresultCountValue ;

@end
