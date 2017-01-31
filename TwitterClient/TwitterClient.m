//
//  TwitterClient.m
//  TwitterClient
//
//  Created by  Michael Friedman on 1/30/17.
//  Copyright © 2017  Michael Friedman. All rights reserved.
//

#import "TwitterClient.h"
#import "SecretConstants.h"

NSString * const kTwitterBaseUrl = @"https://api.twitter.com";

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

@end
