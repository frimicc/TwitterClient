//
//  ProfileViewController.h
//  TwitterClient
//
//  Created by  Michael Friedman on 2/2/17.
//  Copyright © 2017  Michael Friedman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ProfileViewController : UIViewController

@property (nonatomic, strong) User *model;

- (void) reloadData;

@end
