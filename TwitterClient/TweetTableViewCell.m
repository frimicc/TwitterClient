//
//  TweetTableViewCell.m
//  TwitterClient
//
//  Created by  Michael Friedman on 1/30/17.
//  Copyright © 2017  Michael Friedman. All rights reserved.
//

#import "TweetTableViewCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface TweetTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *retweetImageView;
@property (weak, nonatomic) IBOutlet UILabel *retweetFrom;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation TweetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void) reloadData {

    if (self.model) {
        self.nameLabel.text = self.model.user.name;
        self.handleLabel.text = self.model.user.screenname;
        self.timestampLabel.text = self.model.createdAgo;

        self.contentLabel.text = self.model.text;
        [self.contentLabel sizeToFit];
        
        [self.profileImageView setImageWithURL:[NSURL URLWithString:self.model.user.profileImageUrl]];
        
        self.retweetFrom.text = self.model.retweetFrom;
        if (self.retweetFrom.text) {
            self.retweetContainerHeightConstraint.constant = 24;
            self.retweetImageView.hidden = NO;
            self.retweetFrom.hidden = NO;
        } else {
            self.retweetContainerHeightConstraint.constant = 0;
            self.retweetImageView.hidden = YES;
            self.retweetFrom.hidden = YES;
        }
        [self setNeedsUpdateConstraints];
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)replyTapped:(id)sender {
}

- (IBAction)retweetTapped:(id)sender {
}

- (IBAction)favoriteTapped:(id)sender {
}

@end
