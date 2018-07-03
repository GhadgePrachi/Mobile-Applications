Project Name : LatestTweetsFromTwitter

Target-Platform : ===== IPHONE / IOS Version 8.4 =====

How to run  : Run the project in XCode from ProjectFile
               For Logging in, use the following credentials(#HardCoded)
                Username:prachighadge2014@gmail.com
                Password:Tweets#2015  

Update log : The focus on these updates was on UI and feature enhancements.

			1."Load More Items" feature to add additional new items to view.
			2.Taking input for the user to select the topic for querying the latest tweets. So now user can search for a topic and get tweets.
			3.Added launch screen.
			   
				
Submodules   : 1.Appdelegate
					Has AppDelegate File- includes setting up of the username and password.
					
			   2.Constants
			        Has all the constants for api call and number constants defined.
					
			   3.ActivityIndicator
			        Has ActivityIndicator File to show the activity indicator while data is getting fetched from the API.
					
			   4.Utility
			        Has ValidateUser File to validate user credentials.
					 
			   5.DataManager
			        Has LatestTweetItemsManager File which make the call to the api and filters the data as per the requirement.
					 
			   6.WebServices
			       Has Services File  for setting up the connections to twitter and google API.
					
			   7.DataModels
			       Has Custom LatestTweetItem - consisting of tweetText and tweetImage.
				   
			   8.Views
			       Has CustomTableViewCell File and Search Box View File and basic view files for the project-Main.storyboard and LauchScreen.xib.
				   
			   9.Controllers
			       Has LoginViewController - Login Screen
				   Has LatestTweetsTableViewController - Displays the tweetText and tweetImage in each cell.
				                                       - Uses LatestTweetItemsManager instance to make api call and populate the cells with the data.
				   Has PopOverViewController - onClick of left navigation bar button to provide logout option for the user.
				   
			   10.Resources
			       Has Image folder with all the images used in the project. 
				   
				   
