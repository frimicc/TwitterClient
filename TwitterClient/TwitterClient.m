//
//  TwitterClient.m
//  TwitterClient
//
//  Created by  Michael Friedman on 1/30/17.
//  Copyright © 2017  Michael Friedman. All rights reserved.
//

#import "TwitterClient.h"
#import "SecretConstants.h"
#import "User.h"
#import "Tweet.h"
#import "NavigationManager.h"

NSString * const kTwitterBaseUrl = @"https://api.twitter.com";

@interface TwitterClient()

@property (nonatomic, strong) void (^loginCompletion)(User *user, NSError *error);

@end

@implementation TwitterClient

+ (TwitterClient *) sharedInstance {
    static TwitterClient *instance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:kTwitterBaseUrl] consumerKey:[SecretConstants getConsumerKey] consumerSecret:[SecretConstants getConsumerSecret]];
        }
    });
    return instance;
}

+ (NSString *) getBaseUrl {
    return kTwitterBaseUrl;
}

- (void) loginWithCompletion:(void (^)(User *user, NSError *error))completion {
    self.loginCompletion = completion;  // save callback for after part 3

    // clear previous login info
    [self.requestSerializer removeAccessToken];

    // get request token (OAuth Part 1 of 3)
    [self fetchRequestTokenWithPath:@"/oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"cptwitterdemo://oauth"] scope:nil success:^(BDBOAuth1Credential *requestToken) {
        NSLog(@"Got request token");

        // get authorization (OAuth Part 2 of 3)
        NSURL *authURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?oauth_token=%@", [TwitterClient getBaseUrl], @"/oauth/authorize", requestToken.token]];
        NSDictionary<NSString *,id> *options = [[NSDictionary alloc] init];
        [[UIApplication sharedApplication] openURL:authURL options:options completionHandler:^(BOOL success) {
            // no code, handler is in AppDelegate:openURL
            NSLog(@"Got auth token");
        }];

    } failure:^(NSError *error) {
        NSLog(@"Failed to get request token");
        self.loginCompletion(nil, error);   // call completion with error message
    }];
}

- (void) openURL:(NSURL *)url {
    // get access token (OAuth Part 3 of 3)
    BDBOAuth1Credential *reqToken = [BDBOAuth1Credential credentialWithQueryString:url.query];
    [self fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:reqToken success:^(BDBOAuth1Credential *accessToken) {

        NSLog(@"Got access token");
        [self.requestSerializer saveAccessToken:accessToken];

        // discover current user
        [self GET:@"1.1/account/verify_credentials.json" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            // no code
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

            User *user = [[User alloc] initWithDictionary:responseObject];
            [User setCurrentUser:user]; // save for next login
            self.loginCompletion(user, nil);   // call completion with user and no error

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"Failed to get current user");
            self.loginCompletion(nil, error);   // call completion with error message
        }];

    } failure:^(NSError *error) {
        NSLog(@"Failed to get access token");
        self.loginCompletion(nil, error);   // call completion with error message
    }];


}

- (void) logout {
    [self deauthorize];
    [User setCurrentUser:nil];
}

- (void) getUserDictionary:(NSString *)screenName vc:(ProfileViewController *)pvc {
    NSString *apiString = [NSString stringWithFormat:@"1.1/users/show.json?screen_name=%@", screenName];
    [self GET:apiString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        // no code
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        User *user = [[User alloc] initWithDictionary:responseObject];
        pvc.model = user;
        pvc.title = pvc.model.name;
        [pvc reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Failed to get user for %@", screenName);
    }];

}

- (void) sendTweet:(NSString *)tweetText {
    NSLog(@"Sending tweet: %@", tweetText);

    NSString *escapedString = [tweetText stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *apiString = [NSString stringWithFormat:@"1.1/statuses/update.json?status=%@", escapedString];

    [self POST:apiString parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        // no code
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Posted!");
        Tweet *newTweet = [[Tweet alloc] initWithDictionary:responseObject];
        [[NavigationManager shared] addTweetToHomeTimeline:newTweet];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Could not update status: %@", error);
    }];

}

// POST https://api.twitter.com/1.1/statuses/retweet/243149503589400576.json
- (void) retweet:(NSString *)tweetId {
    NSLog(@"Retweeting tweet: %@", tweetId);

    NSString *apiString = [NSString stringWithFormat:@"1.1/statuses/retweet/%@.json", tweetId];
    [self POST:apiString parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        // no code
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Retweeted!");
        Tweet *newTweet = [[Tweet alloc] initWithDictionary:responseObject];
        [[NavigationManager shared] addTweetToHomeTimeline:newTweet];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Could not update status: %@", error);
    }];

}

@end
