//
//  UserDefaultsManager.h
//  LatestTweetsFromTwitter
//
//  Created by Apple on 8/5/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//
#import <Foundation/Foundation.h>
#define kuserName @"userName"
#define kpassword @"password"
#define kinitialLaunch @"initialLAunch"
#define kloggedIn @"loggedIn"

@interface UserDefaultsManager : NSObject

@property (strong,nonatomic)NSString *userName;
@property (strong,nonatomic)NSString *userPassword;
@property (nonatomic) BOOL intialLaunch;
@property (nonatomic)BOOL isLoggedIn;

+ (UserDefaultsManager *)sharedInstance;

@end
