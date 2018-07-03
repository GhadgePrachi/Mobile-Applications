//
//  LatestTweetsTableViewController.m
//  LatestTweetsFromTwitter
//
//  Created by Apple on 8/5/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "LatestTweetsTableViewController.h"
#import "LatestTweetTableViewCell.h"
#import "LoginViewController.h"
#import "UserDefaultsManager.h"
#import "Constants.h"
#import "PopOverViewController.h"
#import "LatestTweetItem.h"
#import "LatestTweetItemsManager.h"
#import "ActivityIndicator.h"
#import "ImageDownloader.h"
#import "SearchBoxView.h"

@interface LatestTweetsTableViewController ()

@property (nonatomic, strong) PopOverViewController *customPopoverController;
@property (nonatomic, strong) SearchBoxView *searchBoxView;
@property (nonatomic, strong) ActivityIndicator *activityIndicator;
@property(strong,nonatomic)UIVisualEffectView *blurView;
@property (strong,nonatomic)NSArray *latestTweetItems;
@property BOOL leftNavButtonClicked;

@end

@implementation LatestTweetsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    [self displayLogInScreen];
   
    [self settingNavBarButtons];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UserDefaultsManager * userDefaultsManager = [UserDefaultsManager sharedInstance];
    if ([userDefaultsManager isLoggedIn])
    {
        if (self.latestTweetItems.count ==0)
        {
            
            [self twitterAPICallWithActivityIndicator:twitterTweetQueryValue];//make twitter api call
            
           
        }
        
    }
    
    //add more items
    numberOfItemsToDisplay = kNumberOfItemsToAdd+3;
    
}

/*******************************************************************************
 *  Function            : twitterAPICallWithActivityIndicator
 *  Purpose             : making api calls with activity indicator
 *  Parametrs           :
 *  Return Values       :
 ********************************************************************************/
-(void)twitterAPICallWithActivityIndicator:(NSString *)tweetSearch
{
     //1.Set number of items to be displayed for initial display
    numberOfItemsToDisplay = kNumberOfItemsToAdd+3;
    
    //2.API call
    
    LatestTweetItemsManager *tweeItemsListManager = [LatestTweetItemsManager sharedInstance];
    

    NSString *searchValue;
    if ([self.searchBoxView.searchTextField.text length]==0) {
        searchValue = twitterTweetQueryValue;
        
    }
    else
    {
        searchValue = [self.searchBoxView.searchTextField text];
    }
   // NSLog(@"Making API Calls");
    [tweeItemsListManager getlatestTweetTextDetails:searchValue withCompletionBlock:^(NSArray *tweetListDetails)
    {
        //NSLog(@"Latest Tweet Items Array : %@",tweetListDetails);
        self.latestTweetItems = tweetListDetails;
        
        if (self.latestTweetItems ==nil || self.latestTweetItems.count==0)
        {
        
            
            //UIAlerView
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"" message:[NSString stringWithFormat:@"No results found"]
                                  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alert show];
            
            
        }
        else {
         //NSLog(@"Reloading table view");
         dispatch_async(dispatch_get_main_queue(), ^ {
          [self.tableView reloadData];
             
            
         });
        }
        
        
     }
    ];

   
}

/*******************************************************************************
 *  Function            : displayLogInScreen
 *  Purpose             : Displaying the login screen if user is not logged in
 *  Parametrs           :
 *  Return Values       :
 ********************************************************************************/
-(void)displayLogInScreen
{
    UserDefaultsManager * userDefaultsManager = [UserDefaultsManager sharedInstance];
    if (![userDefaultsManager isLoggedIn])
    {
        
        LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        loginViewController.modalPresentationStyle = UIModalTransitionStyleCrossDissolve;
        
        [self presentViewController:loginViewController animated:YES completion:nil];
    }
    
}

/*******************************************************************************
 *  Function            : settingNavBarButtons
 *  Purpose             : Setting up NAV bar details
 *  Parametrs           :
 *  Return Values       :
 ********************************************************************************/
-(void)settingNavBarButtons
{
    self.title = @"Latest Tweets";
    
    
    //Setting Left Nav Bar Button
    
    UIButton* leftNavButton=[[UIButton alloc]initWithFrame:CGRectMake(kNavBarButtonXValue,kNavBarButtonYValue,kNavBarButtonWidth, kNavBarButtonHeight)];
    
    [leftNavButton setImage:[UIImage imageNamed:@"settingsIcon.png"] forState:UIControlStateNormal];
    
    [leftNavButton addTarget:self action:@selector(onLeftNavButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * leftNavBarButton=[[UIBarButtonItem alloc]initWithCustomView:leftNavButton];
    
    self.navigationItem.leftBarButtonItem=leftNavBarButton;
    
    self.leftNavButtonClicked=YES;
    
    //
    self.searchBoxView = [[[NSBundle mainBundle] loadNibNamed:@"SearchBoxView" owner:self options:nil] objectAtIndex:0];
        
    [self.searchBoxView.getTweetButton addTarget:self action:@selector(getTweetButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

/***********************************************************************************************************
 *  Function            : getTweetButtonClicked
 *  Purpose             : Get latest tweet results for the user entered text query
 *  Parametrs           :
 *  Return Values       :
 **********************************************************************************************************/
-(void)getTweetButtonClicked
{
    if ([self.searchBoxView.searchTextField.text length]==0)
    {
        //UIAlerView
        UIAlertView *blankInputAlert = [[UIAlertView alloc]
                                          initWithTitle:@"Alert: " message:[NSString stringWithFormat:@"Please enter some text"]
                                          delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [blankInputAlert show];
    }
   
    else
    {
        [self twitterAPICallWithActivityIndicator:[self.searchBoxView.searchTextField text]];//make twitter api call
    }
}

/***********************************************************************************************************
 *  Function            : onLeftNavButtonClicked
 *  Purpose             : Toggling of pop over window - making pop over window appear and disappear on click
 *  Parametrs           :
 *  Return Values       :
 **********************************************************************************************************/
-(void)onLeftNavButtonClicked
{
    
    if (self.customPopoverController==nil)
    {
        
        self.customPopoverController = [[PopOverViewController alloc] initWithNibName:@"PopOverViewController" bundle:nil];
        
        
    }
    
    self.customPopoverController.view.frame = CGRectMake(0, kPopoverwindowYValue, kPopoverwindowWidth, kPopoverwindowHeight);
    
    if (self.leftNavButtonClicked)
    {
        self.view.userInteractionEnabled = NO;
        self.leftNavButtonClicked = NO;
        
        [self createBlurEffectOnMainView];
        [self addPopOverWindow];
        
        
    }
    else
    {
        [self removePopOverWindowAndBlurrEffect];
        
    }
    
    
}


/***********************************************************************************************************
 *  Function            : removePopOverWindowAndBlurrEffect
 *  Purpose             : Removing pop over window and blurr effect on background
 *  Parametrs           :
 *  Return Values       :
 **********************************************************************************************************/
-(void)removePopOverWindowAndBlurrEffect
{
    self.leftNavButtonClicked=YES;
    self.view.userInteractionEnabled = YES;
    self.tableView.scrollEnabled = YES;
    [self.customPopoverController.view removeFromSuperview];
    [self.blurView removeFromSuperview];
    

}

/***********************************************************************************************************
 *  Function            : createBlurEffectOnMainView
 *  Purpose             : Create blurr effect on background on appearance of pop over window
 *  Parametrs           :
 *  Return Values       :
 **********************************************************************************************************/
-(void)createBlurEffectOnMainView
{
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    self.blurView.frame = self.view.bounds;
    [self.view addSubview:self.blurView];
   
    
}

/***********************************************************************************************************
 *  Function            : addPopOverWindow
 *  Purpose             : Add pop over window to the view
 *  Parametrs           :
 *  Return Values       :
 **********************************************************************************************************/
-(void)addPopOverWindow
{
    
    //Adding pop over window
    [self.blurView addSubview:self.customPopoverController.view];
  
    [UIView transitionWithView:self.customPopoverController.view
                      duration:0.2
                       options:UIViewAnimationOptionCurveLinear //any animation
                    animations:^ {
                        
                        self.customPopoverController.view.alpha = 1;
                        
                        //making popover window transition from left to right
                        self.customPopoverController.view.frame =  CGRectMake(self.blurView.bounds.size.width/2 -kPopoverwindowWidth/2, self.blurView.bounds.size.height/2 - kPopoverwindowWidth/2, kPopoverwindowWidth, kPopoverwindowHeight);
                                           }
                    completion:nil];
    
    //Scenario 1: User clicks logout button
    [self.customPopoverController.logOutButton addTarget:self action:@selector(logOutButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //Scenario 2 : If user clicks on the blurr view
    
    UITapGestureRecognizer *tapOnVideoRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removePopOverWindowAndBlurrEffect)];
    self.tableView.scrollEnabled = NO;
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:tapOnVideoRecognizer];
    
    
}

/***********************************************************************************************************
 *  Function            : logOutButtonClicked
 *  Purpose             : Logout the user from the application
 *  Parametrs           :
 *  Return Values       :
 **********************************************************************************************************/
-(void) logOutButtonClicked
{
    
    //1.Remove blurr effect
    [self removePopOverWindowAndBlurrEffect];
    

    //2.Make login screen appear
    LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    loginViewController.modalPresentationStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:loginViewController animated:YES completion:nil];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.latestTweetItems count]< 5) {
        return 1;
    }
    else{
    if (numberOfItemsToDisplay == [self.latestTweetItems count])
    {
        return 1;
    }
    return 2;
    }
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0)
    {
        if ([self.latestTweetItems count]< 5) {
            return self.latestTweetItems.count;
        }
        else{
        return numberOfItemsToDisplay;
        }
    }
    else
    {
        return 1;
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Configure the cell...
    
    if (indexPath.section == 0)
    {
        LatestTweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tweetCell"];
        
        LatestTweetItem * latestTweetItem = [self.latestTweetItems objectAtIndex:indexPath.row];
        [cell populateCellWithLatestTweetItem:latestTweetItem];
        
        return cell;
       
    }
    
    if (indexPath.section == 1)
    {
        UITableViewCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"Load More Items"];
        cell.textLabel.textColor = [UIColor colorWithRed:0.196f green:0.3098f blue:0.52f alpha:1.f];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:20.f];
        return cell;
    }
    
    return nil;
    
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //if load more is selected
    if (indexPath.section == 1)
    {
        NSUInteger i, totalNumberOfItems = [self.latestTweetItems count];
        
        NSUInteger newNumberOfItemsToDisplay = MIN(totalNumberOfItems, numberOfItemsToDisplay + kNumberOfItemsToAdd);
        
        NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
        
        for (i=numberOfItemsToDisplay; i<newNumberOfItemsToDisplay; i++)
        {
            [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
        
        numberOfItemsToDisplay = newNumberOfItemsToDisplay;
        
        
        [self.tableView beginUpdates];
        
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
        
        //last time loading shouldn't display load more option
        if (numberOfItemsToDisplay == totalNumberOfItems)
        {
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationTop];
            
        }
        [self.tableView endUpdates];
        
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        
    }
    
}



-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(kXOrigin, kYOrigin, kTableViewHeaderWidth, kTableViewHeaderHeight)];
    tableHeaderView.backgroundColor =[UIColor whiteColor];
    
    if (section == 0)
    {
        
        tableHeaderView = self.searchBoxView;
        
    }
    return tableHeaderView;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kTableViewHeaderHeight;
}



@end
