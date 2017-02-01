//
//  LoginViewController.m
//  TwitterClient
//
//  Created by  Michael Friedman on 1/30/17.
//  Copyright © 2017  Michael Friedman. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"
#import "TweetListViewController.h"

@interface LoginViewController ()


@end

@implementation LoginViewController
- (IBAction)onLogin:(id)sender {

    [[TwitterClient sharedInstance] loginWithCompletion:^(User *user, NSError *error) {
        if (user != nil) {
            // present tweets
            NSLog(@"Welcome, %@", user.name);
            // if we are already logged in, show the tweet list

            [self setBackButtonItem];
            TweetListViewController *tweetsVC = [[TweetListViewController alloc] initWithNibName:@"TweetListViewController" bundle:nil];
            [tweetsVC reloadData];
            [self.navigationController showViewController:tweetsVC sender:nil];

        } else {
            // present error view
        }
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    // if we are already logged in, show the tweet list
    if ([User currentUser]) {
        [self setBackButtonItem];
        TweetListViewController *tweetsVC = [[TweetListViewController alloc] initWithNibName:@"TweetListViewController" bundle:nil];
        [tweetsVC reloadData];
        [self.navigationController showViewController:tweetsVC sender:nil];
    }
}

- (void) setBackButtonItem {
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStyleDone target:self action:@selector(logout)];
    self.navigationItem.backBarButtonItem = back;
}

- (void) logout {
    [[TwitterClient sharedInstance] logout];
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
