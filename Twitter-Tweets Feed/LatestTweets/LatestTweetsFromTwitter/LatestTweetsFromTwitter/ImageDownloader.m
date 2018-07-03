//
//  ImageDownloader.m
//  LatestTweetsFromTwitter
//
//  Created by Apple on 8/5/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "ImageDownloader.h"

@implementation ImageDownloader

+(BOOL)imageDownload:(LatestTweetItem *)latestTweet
{
       NSURL *url=[NSURL URLWithString:latestTweet.latestTweetImageURL];
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        UIImage *image = [UIImage imageWithData:data];
    
    if(image)
    {
        //save image
        NSData *pngData = UIImagePNGRepresentation(image);
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0];
        NSString *filePath = [documentsPath stringByAppendingPathComponent:latestTweet.latestTweetid];
        [pngData writeToFile:filePath atomically:YES];
        return YES;
    }
    else
    {
        return NO;
    }

}

@end
