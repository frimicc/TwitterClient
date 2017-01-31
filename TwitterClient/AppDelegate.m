//
//  AppDelegate.m
//  TwitterClient
//
//  Created by  Michael Friedman on 1/30/17.
//  Copyright © 2017  Michael Friedman. All rights reserved.
//

#import "AppDelegate.h"
#import "TweetListViewController.h"
#import "LoginViewController.h"
#import "TwitterClient.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    // we need a window as big as the constant (runtime) mainScreen
    CGRect frame = [UIScreen mainScreen].bounds;
    self.window = [[UIWindow alloc] initWithFrame:frame];

    // get login VC
    LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    self.window.rootViewController = loginVC;

    // get primary VC
//    TweetListViewController *viewController = [[TweetListViewController alloc] initWithNibName:@"TweetListViewController" bundle:nil];
//    self.window.rootViewController = viewController;

    // make that window "key", meaning it's the root window, and show it
    [self.window makeKeyAndVisible];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL) application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {

    // get access token (OAuth Part 3 of 3)
    BDBOAuth1Credential *reqToken = [BDBOAuth1Credential credentialWithQueryString:url.query];
    [[TwitterClient sharedInstance] fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:reqToken success:^(BDBOAuth1Credential *accessToken) {

        NSLog(@"Got access token");
        [[TwitterClient sharedInstance].requestSerializer saveAccessToken:accessToken];

        // discover current user
        [[TwitterClient sharedInstance] GET:@"1.1/account/verify_credentials.json" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            // no code
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"current user: %@", responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"Failed to get current user");
        }];

    } failure:^(NSError *error) {
        NSLog(@"Failed to get access token");
    }];

    return YES;
}

@end
