//
//  TweetListViewController.h
//  TwitterClient
//
//  Created by  Michael Friedman on 1/30/17.
//  Copyright © 2017  Michael Friedman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetListViewController : UIViewController

@property (nonatomic, strong) NSString *timelineName;
@property (nonatomic, strong) NSArray *tweets;
- (void) reloadData;

@end
