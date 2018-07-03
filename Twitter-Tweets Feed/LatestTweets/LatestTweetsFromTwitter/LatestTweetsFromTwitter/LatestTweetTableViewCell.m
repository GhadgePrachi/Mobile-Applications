//
//  LatestTweetTableViewCell.m
//  LatestTweetsFromTwitter
//
//  Created by Apple on 8/5/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "LatestTweetTableViewCell.h"
#import "ImageDownloader.h"

@implementation LatestTweetTableViewCell

/*******************************************************************************
 *  Function            : populateCellWithLatestTweetItem
 *  Purpose             : Populating custom cell with custom items info
 *  Parametrs           : Custom tweet Item
 *  Return Values       :
 ********************************************************************************/
-(void) populateCellWithLatestTweetItem: (LatestTweetItem*) latestTweetItem

{
    if (latestTweetItem.latestTweetText) {
        
    self.tweetText.text = latestTweetItem.latestTweetText;
    }
    else{
        self.tweetText.text = @"No records found";
    }
    
    //lazy loading of image of the image
   
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
    bool imageExist = [ImageDownloader imageDownload:latestTweetItem];
  
        if (imageExist)
        {
           
    //read the image
    
    dispatch_async(dispatch_get_main_queue(), ^{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:latestTweetItem.latestTweetid];
    NSData *pngDataRead = [NSData dataWithContentsOfFile:filePath];
    UIImage *image = [UIImage imageWithData:pngDataRead];
    
    self.tweetImageView.image = image;
     });
      
        }
        else
        {
            //Scenario: Load default image when google api result is not a valid resource
            self.tweetImageView.image = [UIImage imageNamed:@"twitterIcon29@2X.png"];
        }
    });
  
    
}

@end
