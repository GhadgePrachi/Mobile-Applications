//
//  Services.m
//  LatestTweetsFromTwitter
//
//  Created by Apple on 8/5/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "Services.h"
#import "Constants.h"

@implementation Services

/*******************************************************************************
 *  Function            : getLatestTweets
 *  Purpose             : making required connection for twitter api call
 *  Parametrs           :
 *  Return Values       : dictionary formed from JSON response from the api call
 ********************************************************************************/
+(void) getLatestTweets:(NSString *)tweetSearchValue
    withCompletionBlock:(void (^)(NSDictionary * latestTweetDetails)) completionBlock
{
    //twitter api
    //1
    NSMutableString * dataUrl = [[NSMutableString alloc]init];
   
     [dataUrl appendString:twitterTweetBaseURL];
     [dataUrl appendString:twitterTweetQueryKeyword];
     [dataUrl appendString:tweetSearchValue];
     [dataUrl appendString:twitterTweetresultTypeKeyword];
     [dataUrl appendString:twitterTweetresultTypeValue];
     [dataUrl appendString:twitterTweetresultCountKeyword];
     [dataUrl appendString:twitterTweetresultCountValue];
    
     NSURL *url = [NSURL URLWithString:dataUrl];
    
    // 2
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
   
    [request setHTTPMethod:@"GET"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@", @"AAAAAAAAAAAAAAAAAAAAAPiAgwAAAAAAd90bNIfCjJIsJAKcRqIZ3b7dLGY%3DH7XAwuIs1JL4vz1UI2JWvB9YzEj4XHAYi31SQiNBr6yKAywX7w"] forHTTPHeaderField:@"Authorization"];
    
    
    //3
    NSURLSession *session = [NSURLSession sharedSession] ;
    NSURLSessionDataTask *downloadTask = [session dataTaskWithRequest:request
                                          
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        if ([data length] >0 && error == nil)
            
        {
            NSError *requestError;
            
            NSDictionary *JSON =[NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &requestError];
            
            NSDictionary *statuses = [JSON objectForKey:@"statuses"];
            completionBlock(statuses);
            
                                                            
        }
        else if ([data length] == 0 && error == nil)
        {
            
            NSLog(@"Nothing was downloaded.");
            //UIAlerView
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"" message:[NSString stringWithFormat:@"%@",error.localizedDescription]
                                  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alert show];

            
        }
        
        else if (error != nil)
        {
            
            NSLog(@"Error = %@", error);
            //UIAlerView
            UIAlertView *alert = [[UIAlertView alloc]
                                            initWithTitle:@"" message:[NSString stringWithFormat:@"%@",error.localizedDescription]
                                            delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alert show];
            
        }
        
    }];
    
    
    // 4
    [downloadTask resume];
    
}

/*******************************************************************************
 *  Function            : getGoogleImage
 *  Purpose             : making required connection for google api call
 *  Parametrs           : string for image search query
 *  Return Values       : dictionary formed from JSON response from the api call
 ********************************************************************************/
+(void) getGoogleImage:(NSString *)latestTweetImageWordValue withCompletionBlock:(void (^)(NSDictionary * googleImageDictionary)) completionBlock
{
    // 1
    NSMutableString * dataUrl = [[NSMutableString alloc]init];
    [dataUrl appendString:imageBaseURL];
    [dataUrl appendString:imageQueryKeyword];
    [dataUrl appendString:latestTweetImageWordValue];
    
    NSURL *url = [NSURL URLWithString:dataUrl];
    
    // 2
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSession *recipeDetailsSession = [NSURLSession sharedSession] ;
    
    //3
    NSURLSessionDataTask *dataTask = [recipeDetailsSession dataTaskWithRequest:request
                                      
                                                             completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
                                                                 
    if ([data length] >0 && error == nil)
        {
            NSError *requestError;
                                                                     
            NSDictionary *JSON =[NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &requestError];
                                                                     
            NSDictionary * responseData = [JSON objectForKey:@"responseData"];
            
            NSDictionary * results = [responseData objectForKey:@"results"];

            completionBlock(results);
        }
    
    else if ([data length] == 0 && error == nil)
        
        {
            
            NSLog(@"Nothing was downloaded.");
            //UIAlerView
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"" message:[NSString stringWithFormat:@"%@",error.localizedDescription]
                                  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alert show];
            
            
            
        }
                                                                 
        
    else if (error != nil)
        {
            NSLog(@"Error = %@", error);
            //UIAlerView
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"" message:[NSString stringWithFormat:@"%@",error.localizedDescription]
                                  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alert show];
            
            
        }
        
    }];
    
    // 4
    [dataTask resume];
    

}
@end
