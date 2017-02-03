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
#import "ProfileViewController.h"
#import "ComposeViewController.h"
#import "User.h"
#import "TwitterClient.h"

@interface NavigationManager ()

@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, weak) UITabBarController *tabController;
@property (nonatomic, weak) TweetListViewController *homeTimelineVC;

@property (nonatomic, assign) BOOL isLoggedIn;

@end

@implementation NavigationManager


- (instancetype)init {
    self = [super init];
    if (self) {
        if ([self checkLoggedInState]) {
            self.navigationController = [[UINavigationController alloc] initWithRootViewController:[self loggedInVC]];
            [self.navigationController setNavigationBarHidden:YES]; // hide this bar so the child bar can show
            [self login];
        } else {
            self.navigationController = [[UINavigationController alloc] initWithRootViewController:[self loggedOutVC]];
            [self.navigationController setNavigationBarHidden:YES];
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
    self.homeTimelineVC = hvc;  // for updating later automatically
    UINavigationController *nhvc = [[UINavigationController alloc] initWithRootViewController:hvc];

    TweetListViewController *mvc = [[TweetListViewController alloc] initWithNibName:@"TweetListViewController" bundle:nil];
    mvc.timelineName = @"mentions";
    UINavigationController *nmvc = [[UINavigationController alloc] initWithRootViewController:mvc];

    ProfileViewController *pvc = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
    pvc.model = [User currentUser];
    pvc.title = @"Me";
    pvc.isMeTab = YES;
    UINavigationController *npvc = [[UINavigationController alloc] initWithRootViewController:pvc];

    [tbvc setViewControllers:@[nhvc, nmvc, npvc]];
    self.tabController = tbvc;

    [hvc reloadData];
    [mvc reloadData];
    [pvc reloadData];

    return tbvc;
}

- (UIViewController *) loggedOutVC {
    LoginViewController *vc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    return vc;
}

- (void) login {
    self.isLoggedIn = YES;
    [self.navigationController setViewControllers:@[[self loggedInVC]]];

}

- (void) logout {
    self.isLoggedIn = NO;
    [self.navigationController setViewControllers:@[[self loggedOutVC]]];
}

- (BOOL) checkLoggedInState {
    self.isLoggedIn = NO;
    if ([User currentUser]) {
        self.isLoggedIn = YES;
    }
    return self.isLoggedIn;
}

- (void) showUserProfile:(NSString *)screenName {
    ProfileViewController *pvc = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
    [[TwitterClient sharedInstance] getUserDictionary:screenName vc:pvc];
    pvc.isMeTab = NO;
    UINavigationController *tweetListNavController = [self.tabController selectedViewController];
    [tweetListNavController pushViewController:pvc animated:YES];
}

- (void) showComposeVC {
    ComposeViewController *cvc = [[ComposeViewController alloc] initWithNibName:@"ComposeViewController" bundle:nil];
    cvc.model = [User currentUser];
    UINavigationController *localNavController = [self.tabController selectedViewController];
    [localNavController pushViewController:cvc animated:YES];
}

- (void) addTweetToHomeTimeline:(Tweet *)tweet {
    [self.homeTimelineVC addTweet:tweet];
    [self.tabController showViewController:self.homeTimelineVC sender:nil];
}


@end
