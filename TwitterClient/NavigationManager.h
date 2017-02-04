//
//  NavigationManager.h
//  TwitterClient
//
//  Created by  Michael Friedman on 2/1/17.
//  Copyright © 2017  Michael Friedman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface NavigationManager : NSObject

+ (instancetype) shared;

- (UIViewController *) rootViewController;

- (void) login;
- (void) logout;
- (void) showUserProfile:(NSString *)screenName;
- (void) showComposeVC;
- (void) showComposeVC:(Tweet *)replyToTweet;
- (void) showHomeTimeline;
- (void) addTweetToHomeTimeline:(Tweet *)tweet;

@end
