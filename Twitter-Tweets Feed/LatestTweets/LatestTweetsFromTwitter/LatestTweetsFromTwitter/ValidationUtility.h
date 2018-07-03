//
//  ValidationUtility.h
//  LatestTweetsFromTwitter
//
//  Created by Apple on 8/5/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValidationUtility : NSObject

+ (BOOL)validateUser:(NSString *)userName withPassword:(NSString *)password;

@end
