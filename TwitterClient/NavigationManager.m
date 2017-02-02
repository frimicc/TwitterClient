//
//  NavigationManager.m
//  TwitterClient
//
//  Created by  Michael Friedman on 2/1/17.
//  Copyright © 2017  Michael Friedman. All rights reserved.
//

#import "NavigationManager.h"
#import "LoginViewController.h"
#import "TweetListViewController.h"
#import "User.h"

@interface NavigationManager ()

@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, assign) BOOL isLoggedIn;

@end

@implementation NavigationManager


- (instancetype)init {
    self = [super init];
    if (self) {
        if ([self checkLoggedInState]) {
            self.navigationController = [[UINavigationController alloc] initWithRootViewController:[self loggedInVC]];
            [self login];
        } else {
            self.navigationController = [[UINavigationController alloc] initWithRootViewController:[self loggedOutVC]];
            [self logout];
        }
    }
    return self;
}

+ (instancetype) shared {
    static NavigationManager *sharedInstance;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NavigationManager alloc] init];
    });

    return sharedInstance;
}

- (UIViewController *) rootViewController {
    return self.navigationController;
}

- (UIViewController *) loggedInVC {
    UITabBarController *tbvc = [[UITabBarController alloc] init];

    TweetListViewController *hvc = [[TweetListViewController alloc] initWithNibName:@"TweetListViewController" bundle:nil];
    hvc.timelineName = @"home";
    TweetListViewController *mvc = [[TweetListViewController alloc] initWithNibName:@"TweetListViewController" bundle:nil];
    mvc.timelineName = @"mentions";

    [tbvc setViewControllers:@[hvc, mvc]];

    [hvc reloadData];
    [mvc reloadData];

    return tbvc;
}

- (UIViewController *) loggedOutVC {
    LoginViewController *vc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    return vc;
}

- (void) login {
    self.isLoggedIn = YES;
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController setViewControllers:@[[self loggedInVC]]];

}

- (void) logout {
    self.isLoggedIn = NO;
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController setViewControllers:@[[self loggedOutVC]]];
}

- (BOOL) checkLoggedInState {
    self.isLoggedIn = NO;
    if ([User currentUser]) {
        self.isLoggedIn = YES;
    }
    return self.isLoggedIn;
}

@end
