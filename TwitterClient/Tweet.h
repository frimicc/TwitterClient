//
//  Tweet.h
//  TwitterClient
//
//  Created by  Michael Friedman on 1/30/17.
//  Copyright © 2017  Michael Friedman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSString *createdAgo;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSString *retweetFrom;
@property (nonatomic, strong) NSString *tweetId;

- (id) initWithDictionary:(NSDictionary *)dictionary;
+ (NSArray *) tweetsWithArray:(NSArray *)array;

@end
