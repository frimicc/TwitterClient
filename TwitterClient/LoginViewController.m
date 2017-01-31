//
//  LoginViewController.m
//  TwitterClient
//
//  Created by  Michael Friedman on 1/30/17.
//  Copyright © 2017  Michael Friedman. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
- (IBAction)onLogin:(id)sender {
    // clear previous login info
    [[TwitterClient sharedInstance].requestSerializer removeAccessToken];
    
    // get request token
    [[TwitterClient sharedInstance] fetchRequestTokenWithPath:@"/oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"cptwitterdemo://oauth"] scope:nil success:^(BDBOAuth1Credential *requestToken) {
        NSLog(@"Got request token");

        NSURL *authURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?oauth_token=%@", [TwitterClient getBaseUrl], @"/oauth/authorize", requestToken.token]];
        NSDictionary<NSString *,id> *options = [[NSDictionary alloc] init];
        [[UIApplication sharedApplication] openURL:authURL options:options completionHandler:^(BOOL success) {
            // code
        }];

    } failure:^(NSError *error) {
        NSLog(@"Failed to get request token");
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
