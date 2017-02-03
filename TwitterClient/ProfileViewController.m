//
//  ProfileViewController.m
//  TwitterClient
//
//  Created by  Michael Friedman on 2/2/17.
//  Copyright © 2017  Michael Friedman. All rights reserved.
//

#import "ProfileViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "NavigationManager.h"
#import "TwitterClient.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numTweetsLabel;
@property (weak, nonatomic) IBOutlet UILabel *numFollowingLabel;
@property (weak, nonatomic) IBOutlet UILabel *numFollowersLabel;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self reloadData];

    // This covers up the back button, if we are coming from a tweet list.
    if (self.isMeTab) {
       UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStyleDone target:self action:@selector(logout)];
        self.navigationItem.leftBarButtonItem = back;
    }

    UIBarButtonItem *compose = [[UIBarButtonItem alloc] initWithTitle:@"Compose" style:UIBarButtonItemStyleDone target:self action:@selector(compose)];
    self.navigationItem.rightBarButtonItem = compose;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) reloadData {
    if (self.model) {
        self.nameLabel.text = self.model.name;
        self.screenNameLabel.text = self.model.screenname;
        self.numTweetsLabel.text = self.model.numTweets;
        self.numFollowingLabel.text = self.model.numFollowing;
        self.numFollowersLabel.text = self.model.numFollowers;

        [self.avatarImage setImageWithURL:[NSURL URLWithString:self.model.profileImageUrl]];
        [self.backgroundImage setImageWithURL:[NSURL URLWithString:self.model.backgroundImageUrl]];
    }
}

- (void) logout {
    [[TwitterClient sharedInstance] logout];
    [[NavigationManager shared] logout];
}

- (void) compose {
    [[NavigationManager shared] showComposeVC];
}

@end
