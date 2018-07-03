//
//  UserDefaultsManager.m
//  LatestTweetsFromTwitter
//
//  Created by Apple on 8/5/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//


#import "UserDefaultsManager.h"

@implementation UserDefaultsManager

static UserDefaultsManager* userDefaultsManager = nil;

+(UserDefaultsManager*)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        userDefaultsManager = [[UserDefaultsManager alloc] init];
        
        
    });
    return userDefaultsManager;
}

/**setter getter for userName***/
-(void)setUserName:(NSString *)userName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:userName forKey:kuserName];
    [defaults synchronize];
    
}

- (NSString *)userName
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kuserName];
}

/**setter getter for userPassword***/
-(void)setUserPassword:(NSString *)userPassword
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:userPassword forKey:kpassword];
    [defaults synchronize];
}

- (NSString *)userPassword
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kpassword];
}


/**setter getter for isLoggedIn***/

-(void)setIsLoggedIn:(BOOL)isLoggedIn
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:isLoggedIn forKey:kloggedIn];
    [defaults synchronize];
}


-(BOOL)isLoggedIn
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:kloggedIn];
}

/**setter getter for Intial Launching***/
-(void)setIntialLaunch:(BOOL)intialLaunch
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:kinitialLaunch];
    [defaults synchronize];
    
    intialLaunch = YES;
}

- (BOOL)initialLaunch
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kinitialLaunch];
}



@end

