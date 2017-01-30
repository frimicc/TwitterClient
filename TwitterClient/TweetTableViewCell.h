//
//  TweetTableViewCell.h
//  TwitterClient
//
//  Created by  Michael Friedman on 1/30/17.
//  Copyright © 2017  Michael Friedman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetTableViewCell : UITableViewCell

// move this into the .m file when we pass in a model so it disappears when something is not retweeted.
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *retweetContainerHeightConstraint;

@end
