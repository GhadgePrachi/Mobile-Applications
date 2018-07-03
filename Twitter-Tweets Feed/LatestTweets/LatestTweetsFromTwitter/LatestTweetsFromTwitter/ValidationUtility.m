//
//  ValidationUtility.m
//  LatestTweetsFromTwitter
//
//  Created by Apple on 8/5/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "ValidationUtility.h"
#import "UserDefaultsManager.h"

@implementation ValidationUtility

+ (BOOL)validateUser:(NSString *)userName withPassword:(NSString *)password
{
    if (userName.length==0 || password.length==0)
    {
        return NO;
    }
    
    else if ([userName isEqualToString:[UserDefaultsManager sharedInstance].userName] && [password isEqualToString:[UserDefaultsManager sharedInstance].userPassword])
    {
        return YES;
    }
    
    
    return NO;
}


@end
