//
//  User.h
//  TwitterClient
//
//  Created by  Michael Friedman on 1/30/17.
//  Copyright © 2017  Michael Friedman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenname;
@property (nonatomic, strong) NSString *profileImageUrl;
@property (nonatomic, strong) NSString *tagline;
@property (nonatomic, strong) NSString *backgroundImageUrl;
@property (nonatomic, strong) NSString *numTweets;
@property (nonatomic, strong) NSString *numFollowing;
@property (nonatomic, strong) NSString *numFollowers;

- (id) initWithDictionary:(NSDictionary *)dictionary;

+ (User *) currentUser;
+ (void) setCurrentUser:(User *)currentUser;

@end
