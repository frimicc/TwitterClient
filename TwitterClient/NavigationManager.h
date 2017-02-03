//
//  NavigationManager.h
//  TwitterClient
//
//  Created by  Michael Friedman on 2/1/17.
//  Copyright © 2017  Michael Friedman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NavigationManager : NSObject

+ (instancetype) shared;

- (UIViewController *) rootViewController;

- (void) login;
- (void) logout;
- (void) showUserProfile:(NSString *)screenName;
- (void) showComposeVC;

@end
