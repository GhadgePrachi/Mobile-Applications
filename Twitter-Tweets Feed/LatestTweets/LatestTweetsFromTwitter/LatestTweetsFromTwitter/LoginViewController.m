//
//  LoginViewController.m
//  LatestTweetsFromTwitter
//
//  Created by Apple on 8/5/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#import "LoginViewController.h"
#import "UserDefaultsManager.h"
#import "ValidationUtility.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logInButtonPressed:(id)sender
{
    BOOL isValidUser =  [ValidationUtility validateUser:self.userName.text withPassword:self.password.text];
    
    if (isValidUser)
    {
        [[UserDefaultsManager sharedInstance]setIsLoggedIn:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
        
        
    }
    
    else
    {
        // Display this message for invalid details entered by the user
        UIAlertView *invalidInputAlert = [[UIAlertView alloc]
                                          initWithTitle:@"Login Failed" message:[NSString stringWithFormat:@"Incorrect details"]
                                          delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [invalidInputAlert show];
        
        
    }
    

}




@end
