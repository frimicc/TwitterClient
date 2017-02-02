//
//  LoginViewController.m
//  TwitterClient
//
//  Created by  Michael Friedman on 1/30/17.
//  Copyright © 2017  Michael Friedman. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"
#import "NavigationManager.h"

@interface LoginViewController ()


@end

@implementation LoginViewController
- (IBAction)onLogin:(id)sender {

    [[TwitterClient sharedInstance] loginWithCompletion:^(User *user, NSError *error) {
        if (user != nil) {

            NSLog(@"Welcome, %@", user.name);
            [[NavigationManager shared] login];

        } else {
            NSLog(@"Could not login: %@", error);
        }
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
