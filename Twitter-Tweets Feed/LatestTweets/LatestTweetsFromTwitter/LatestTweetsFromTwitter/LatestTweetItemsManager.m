//
//  LatestTweetItemsManager.m
//  LatestTweetsFromTwitter
//
//  Created by Apple on 8/5/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "LatestTweetItemsManager.h"
#import "Services.h"
#import "LatestTweetItem.h"
#import "ActivityIndicator.h"


@implementation LatestTweetItemsManager

static LatestTweetItemsManager *latestTweetManager;

+(LatestTweetItemsManager*)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        latestTweetManager = [[LatestTweetItemsManager alloc] init];
        latestTweetManager.googleImageDictionary = [[NSDictionary alloc]init];
        latestTweetManager.latesttweetDetailsList = [[NSMutableArray alloc] init];
        latestTweetManager.latestTweetsDictionary = [[NSDictionary alloc]init];
        latestTweetManager.activityIndicator = [[ActivityIndicator alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray initWithFrame:CGRectMake(kMainScreenSize.width/2, kMainScreenSize.height/2, ActivityIndicatorWidth, ActivityIndicatorHeight)];

    
    });
    return latestTweetManager;
}

/**********************************************************************************************************
 *  Function            : getlatestTweetTextDetails
 *  Purpose             : making twitter & google image api calls
 *  Parametrs           :
 *  Return Values       : array of custom items with tweet text from twitter api & imageURL from google api
 *********************************************************************************************************/
-(void) getlatestTweetTextDetails:(NSString*) tweetSearchText withCompletionBlock:(void (^)(NSArray *recipeListDetails)) completionBlock
{
    
   //clear the custom objects from the array for previous search query
    [self.latesttweetDetailsList removeAllObjects];
    self.count = 0;
    
    
    //
    /**************************************************/
    
    [self.activityIndicator startActivityIndicator];
    /**************************************************/
    

    
    NSString *tweetSearch =[tweetSearchText stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    //NSLog(@"URL Supported tweet search query : %@",tweetSearch);
        [Services getLatestTweets:tweetSearch withCompletionBlock:^(NSDictionary *latestTweetDetails)
        {
            //1.Twitter API doesn't fetch any results for the search requested by the user.
            NSString * dictionaryCount = [NSString stringWithFormat:@"%lu",[latestTweetDetails count]];
            
            if ([dictionaryCount isEqualToString:@"0"])
            {
                /****Activity Indicator code***********************/
                [self.activityIndicator stopActivityIndicator];
                /**************************************************/

                completionBlock(self.latesttweetDetailsList);
                
            }
           
            //2.1.Twitter API does fetch some results for the search requested by the user.
            if (latestTweetDetails.count > 0)
            {
                self.latestTweetsDictionary = latestTweetDetails;
                
                 for(NSDictionary *currentTwitterTweet in self.latestTweetsDictionary)
                 {
                
              
                    
                    NSString *tweetText = [currentTwitterTweet objectForKey:@"text"];
                    
                    NSString *imageQuery = [self getImageQuery:tweetText];
                     
                    //NSLog(@"Image API Query %@",imageQuery);
                     
                    [Services getGoogleImage:imageQuery withCompletionBlock:^(NSDictionary *imageDictionary)
                     {
                         //NSLog(@"Image Dictionary : %@",imageDictionary);
                         
                         if (imageDictionary != nil)
                         {
                         
                              for(NSDictionary *resultItem in imageDictionary)
                              
                              {
                            
                              self.googleImageDictionary  = resultItem;
                                  
                              LatestTweetItem *currentTweetItem =[[LatestTweetItem alloc]initWithTweetTextDictionary:currentTwitterTweet withGoogleImageDictionary:self.googleImageDictionary];
                                  
                              [self.latesttweetDetailsList addObject:currentTweetItem];
                                  
                              self.count= self.count + 1;
                              
                              break;
                              
                              }
                             if (self.count == self.latestTweetsDictionary.count)
                             {
                                 /****Activity Indicator code***********************/
                                 [self.activityIndicator stopActivityIndicator];
                                 /**************************************************/

                                 //send back the array only when all objects are added successfully
                                 completionBlock(self.latesttweetDetailsList);
                                 
                             }
                            
                        
                         }
                         
                         else
                         {
                             /****Activity Indicator code***********************/
                             [self.activityIndicator stopActivityIndicator];
                             /**************************************************/

                             completionBlock(self.latesttweetDetailsList);
                                                         
                         }
                         
                     }];
                     
                    
                   }
               
                
                
               }
           
        }];
    
}

/******************************************************************************************************
 *  Function            : getImageQuery
 *  Purpose             : setting up user credentials at initial launch
 *  Parametrs           : tweetText from twitter API
 *  Return Values       : string constructed for google api image query dependant on tweetText received
 *****************************************************************************************************/

-(NSString *) getImageQuery:(NSString *) tweetText
{
    NSMutableString * searchValue = [[NSMutableString alloc]init];
    NSString * result = [[NSString alloc]init];
    BOOL hashTagsFound = NO;
    
    NSArray * words = [tweetText componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    for (NSString * word in words)
    {
        //Scenario 1: Get hashtags in tweetText and club them together for google image query
        if ([word length] > 0 && [word characterAtIndex:0] == '#' )
        {
            [searchValue appendString:word];
            [searchValue appendString:@" "];
           
            hashTagsFound = YES;
           
        }
    }
    
    //Scenario 2: No hashtags found in tweetText, just use tweetText itself for google image query
    if (!hashTagsFound)
    {
        
        [searchValue appendString:tweetText];
      
    }
    
    result = [searchValue stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];

    return result;
}

@end
