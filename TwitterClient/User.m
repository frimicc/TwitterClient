//
//  User.m
//  TwitterClient
//
//  Created by  Michael Friedman on 1/30/17.
//  Copyright © 2017  Michael Friedman. All rights reserved.
//

#import "User.h"

@interface User ()

@property (nonatomic, strong) NSDictionary *dictionary;

@end

@implementation User

NSString * const defaultsUserKey = @"currentUserData";

- (id) initWithDictionary:(NSDictionary *)dictionary {

    self = [super init];
    if (self) {
        self.dictionary = dictionary; // for JSON later
        self.name = dictionary[@"name"];
        self.screenname = dictionary[@"screen_name"];
        self.profileImageUrl = dictionary[@"profile_image_url_https"];
        self.tagline = dictionary[@"description"];

    }
    return self;
}

// store the current user as a global static variable in this namespace
// with custom getter & setter & storing in user defaults
static User *_currentUser = nil;

+ (User *) currentUser {
    if (!_currentUser) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

        // have to get back JSON and decode, turn back into User object
        NSData *userData = [defaults objectForKey:defaultsUserKey];
        if (userData) {
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:userData options:0 error:NULL];
            _currentUser = [[User alloc] initWithDictionary:dictionary];
        }
    }
    return _currentUser;
}

+ (void) setCurrentUser:(User *)currentUser {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    if (currentUser != nil) {
        // have to store as Encoder-capable object, such as JSON
        NSData *userData = [NSJSONSerialization dataWithJSONObject:currentUser.dictionary options:0 error:NULL];
        [defaults setObject:userData forKey:defaultsUserKey];
    } else {
        [defaults setObject:nil forKey:defaultsUserKey];
    }
    _currentUser = currentUser; // keep or wipe out for later

    [defaults synchronize];
}

@end
