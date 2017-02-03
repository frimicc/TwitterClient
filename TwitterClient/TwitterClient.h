//
//  TwitterClient.h
//  TwitterClient
//
//  Created by  Michael Friedman on 1/30/17.
//  Copyright © 2017  Michael Friedman. All rights reserved.
//

#import <BDBOAuth1Manager/BDBOAuth1SessionManager.h>
#import "User.h"
#import "Tweet.h"
#import "ProfileViewController.h"

@interface TwitterClient : BDBOAuth1SessionManager

+ (TwitterClient *) sharedInstance;
+ (NSString *) getBaseUrl;
- (void) loginWithCompletion:(void (^)(User *user, NSError *error))completion;
- (void) openURL:(NSURL *)url;
- (void) logout;
- (void) getUserDictionary:(NSString *)screenName vc:(ProfileViewController *)pvc;
- (void) sendTweet:(NSString *)tweetText;
- (void) retweet:(NSString *)tweetId;
- (void) favorite:(NSString *)tweetId;

@end
